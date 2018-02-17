#!/usr/bin/env node

"use strict";

const {execSync} = require('child_process');
const {wait, run} = require('f-promise');
const {tagToDate, request} = require('./utils.js');

const log = (message) => {
    console.log(`[${new Date()}] [image-cleaner] ${message}`)
};

// ==================================
// DEFAULT CONFIGURATION
// ==================================

// ignore cert verification for https requests
process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

const config = {
    maxImageNumber: 20,
    safePeriodDays: 5,
    domain: 'docker.domain.com',
    dryRun: false,
    port: 5000,
};

// ==================================
// ARGUMENT PARSING
// ==================================

const args = process.argv;

const processArgsAndGetConfig = (args, config) => {

    const mFlag = "-m";
    const sFlag = "-s";
    const eFlag = "-e";
    const dFlag = "-d";
    const hFlag = "-h";

    // display help and exit if asked
    if (args.includes(hFlag)) {
        log("Image cleaner script");
        log("Example: ./image-cleaner.sh -e domain:port -m 20 -s 7");
        process.exit(0);
    }

    log("Start image cleaning");

    // parse arguments
    if (args.includes(dFlag)) {
        log(`Dry run mode: Operations will not be performed`);
        config.dryRun = true;
    }

    if (args.includes(mFlag)) {
        config.maxImageNumber = args[args.indexOf(mFlag) + 1];
        log(`Using maxImageNumber: ${config.maxImageNumber}`);
    }

    if (args.includes(sFlag)) {
        config.safePeriodDays = args[args.indexOf(sFlag) + 1];
        log(`Using safePeriodDays: ${config.safePeriodDays}`);
    }

    if (args.includes(eFlag)) {
        const endpoint = args[args.indexOf(eFlag) + 1].split(":");
        config.domain = endpoint[0];
        config.port = endpoint[1];
        log(`Using endpoint: ${config.domain}:${config.port}`);
    }
};

processArgsAndGetConfig(args, config);

/**
 * Return a list of available tags for a given image name
 * @param imageName
 * @returns {Promise.<T>}
 */
const getTagList = (imageName) => {

    let reqRslt = wait(request(config, 'GET', `/v2/${imageName}/tags/list`));

    let tagList = JSON.parse(reqRslt.content).tags;

    // no tags found
    if (!tagList || !tagList.length) {
        tagList = [];
    }

    tagList.sort();

    return Promise.resolve(tagList);

};

/**
 * Return a image hash for a given image name and tag
 * @param imageName
 * @param tag
 * @returns {*}
 */
const getImageHash = (imageName, tag) => {

    const reqRslt = wait(request(config, 'HEAD', `/v2/${imageName}/manifests/${tag}`,
        {'Accept': 'application/vnd.docker.distribution.manifest.v2+json'}));

    const imageHash = reqRslt.headers['docker-content-digest'];

    if (!imageHash) {
        return Promise.reject(new Error(`Image hash is invlaid`));
    }

    return Promise.resolve(imageHash);
};

/**
 * Mark an image as deleted
 * @param imageName
 * @param tag
 * @returns {*}
 */
const deleteImage = (imageName, tag) => {

    let imageHash;
    try {
        imageHash = wait(getImageHash(imageName, tag));
    } catch (error) {
        log(`Error while retrieving image hash: ${error.message} ${error.stack}`);
        return Promise.reject(e);
    }

    // dry run, just show request and wait a little
    if (config.dryRun) {

        log(`Dry run: Deletion request: DELETE /v2/${imageName}/manifests/${imageHash}`);

        return new Promise((resolve) => {
            setTimeout(() => {
                resolve();
            }, 500);
        });
    }

    // delete image
    else {
        return wait(request(config, 'DELETE', `/v2/${imageName}/manifests/${imageHash}`));
    }

};

/**
 * Return a list of tag which should deleted
 * @param tagList
 */
const selectTagsToDelete = (tagList, imageName, safePeriod, maxImageNumber) => {

    if (tagList.length < maxImageNumber) {
        return [];
    }

    const rslt = [];
    tagList.forEach((tag) => {

        // process only tags matching 20170912151936.428081594
        if (!tag.match("^[0-9]{14}.*")) {
            log(`Ignoring tag '${tag}', not matching timestamp pattern`);
            return;
        }

        // keep maxNumberImages
        const restNumberOfImage = tagList.length - rslt.length;
        if (restNumberOfImage <= maxImageNumber) {
            return;
        }

        // parse date
        const imageDate = tagToDate(tag);

        // image is out of safe period, it should be deleted
        if (imageDate < safePeriod) {
            rslt.push(tag);
        }

        // image is in safe period, it should NOT be deleted
        else {
            log(`Ignoring ${tag} for image ${imageName}, image is in safe period`);
        }

    });

    return rslt;

};

/**
 * Ask for tags associated with an image name and delete old images
 * @param imageName
 */
const cleanTagsForImages = (imageName) => {
    log(`Cleaning images '${imageName}'`);

    const tagList = wait(getTagList(imageName));

    if (!tagList.length) {
        log(`No tags found for image '${imageName}'`);
        return Promise.resolve();
    }

    // define a period which
    const safePeriod = new Date();
    safePeriod.setUTCDate(safePeriod.getUTCDate() - config.safePeriodDays);

    const tagsToDelete = selectTagsToDelete(tagList, imageName, safePeriod, config.maxImageNumber);

    tagsToDelete.forEach((tag) => {
        log(`Deleting image with tag: ${imageName} ${tag}`);
        try {
            wait(deleteImage(imageName, tag));
        } catch (error) {
            log(`Error while deleting image: ${error.message} \n${error.stack}`)
        }
    });

    return Promise.resolve();

};

/**
 * Return a list of available image names
 * @returns {Promise.<T>}
 */
const getImageList = () => {
    const reqRslt = wait(request(config, 'GET', '/v2/_catalog'));
    const imageList = JSON.parse(reqRslt.content)["repositories"];
    return Promise.resolve(imageList);
};


// ==========================
// START CLEANING
// ==========================

const main = () => {
    run(() => {

        // get list of images
        let imageList;
        try {
            imageList = wait(getImageList());
        } catch (error) {
            log(`Error while getting image list: ${error}`);
            log(error.stack);
            process.exit(1);
        }

        // mark outdated images as deleted
        imageList.forEach((imageName) => {
            try {
                wait(cleanTagsForImages(imageName));
            } catch (error) {
                log(`Error while cleaning images: ${error.message} ${error.stack}`);
            }
        });

        // call garbage collector
        try {
            log("Launching Docker registry garbage collector");
            const dryRun = config.dryRun ? '--dry-run' : '';
            execSync(`docker exec registry /bin/sh -c '/bin/registry garbage-collect ${dryRun} /etc/docker/registry/garbage-collect.yml'`);
        } catch (error) {
            log(`Error while running garbage collector: ${error.message} ${error.stack}`);
        }

    });
};

// only run if script is launched, and not imported
if (require.main === module) {
    main();
}

module.exports = {
    selectTagsToDelete,
    processArgsAndGetConfig
};
