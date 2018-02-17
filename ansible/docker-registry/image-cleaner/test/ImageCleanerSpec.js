"use strict";

const chai = require('chai');
const assert = chai.assert;
const _ = require('lodash');

const index = require('../index.js');

describe('ImageCleanerSpec', function () {

    describe('Argument parsing', function () {

        const sampleConfig = {
            maxImageNumber: 20,
            safePeriodDays: 5,
            domain: 'docker.domain.com',
            dryRun: false,
            port: 5000,
        };

        it('> Argument parsing should modify configuration', () => {

            const config = _.cloneDeep(sampleConfig);

            index.processArgsAndGetConfig(["-d"], config);
            assert.equal(config.dryRun, true);

            index.processArgsAndGetConfig(["-m", "12"], config);
            assert.equal(config.maxImageNumber, 12);

            index.processArgsAndGetConfig(["-s", "25"], config);
            assert.equal(config.safePeriodDays, 25);

            index.processArgsAndGetConfig(["-e", "domain.com:1234"], config);
            assert.equal(config.domain, "domain.com");
            assert.equal(config.port, 1234);

        });

    });

    describe('Tag sorting', function () {

        this.timeout(2000);

        const tagsToKeepSample = [
            "20170924145641-186ef38",
            "20170924151140-186ef38",
            "20170924151208-186ef38",
            "20170924151236-186ef38",
            "20170925145547-186ef38",
            "20170925145615-186ef38",
            "20170925145642-186ef38",
            "20170925151141-186ef38",
            "20170925151209-186ef38",
            "20170925151237-186ef38",
            "20170926145548-186ef38",
        ];

        const tagsToDeleteSample = [
            "20170919145616-186ef38",
            "20170917145643-186ef38",
            "20170912151142-186ef38",
            "20170911151210-186ef38",
            "20170910151238-186ef38",
            "20170909145549-186ef38",
            "20170908145617-186ef38",
            "20170907145644-186ef38",
            "20170906151143-186ef38",
            "20170905151211-186ef38"
        ];

        const safePeriodSample = new Date('2017-09-21T03:24:00');

        it('> Selection of tags to delete based on dates should be correct', () => {

            let selectedTags = index.selectTagsToDelete(tagsToKeepSample.concat(tagsToDeleteSample),
                "imageName", safePeriodSample, 5);

            assert.lengthOf(selectedTags, 10);
            assert.deepEqual(selectedTags, tagsToDeleteSample);

            selectedTags = index.selectTagsToDelete(tagsToKeepSample,
                "imageName", safePeriodSample, 5);

            assert.lengthOf(selectedTags, 0);
            assert.deepEqual(selectedTags, []);

        });

        it('> Selection of tags to delete should return empty array if number of image is < than specified number', () => {

            const selectedTags = index.selectTagsToDelete(tagsToDeleteSample,
                "imageName", safePeriodSample, 50);

            assert.lengthOf(selectedTags, 0);

        });

        it('> Selection of tags to delete should leave enough images in tag list', () => {

            const selectedTags = index.selectTagsToDelete(tagsToDeleteSample,
                "imageName", safePeriodSample, 2);

            assert.lengthOf(selectedTags, 8);
            assert.deepEqual(selectedTags, tagsToDeleteSample.slice(0, 8));

        });

    });

});


