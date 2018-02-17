"use strict";

const https = require('https');

/**
 * Utility used for requests
 * @param url
 * @returns {Promise}
 */
const request = function (config, method, req, headers) {
    return new Promise((resolve, reject) => {

        const options = {
            host: config.domain,
            port: config.port,
            path: req,
            method: method,
            headers: headers
        };

        // log(`Executing request: ${JSON.stringify(options)}`);

        // const request = https.request(url, (response) => {
        const request = https.request(options, (response) => {
            const body = [];
            response.on('data', (chunk) => body.push(chunk));
            response.on('end', () => {

                // handle http errors
                if (response.statusCode < 200 || response.statusCode > 299) {
                    reject(new Error(`Request failed: ${response.statusCode} body=${body}`));
                }

                resolve({
                    content: body.join(''),
                    headers: response.headers
                });
            });
        });

        // handle connection errors of the request
        request.on('error', (err) => reject(err));

        request.end();
    });
};


/**
 * Parse a docker tag (timestamp) and create a date object
 * @param tag
 * @returns {Date}
 */
const tagToDate = (tag) => {
    const imageDate = new Date();
    imageDate.setFullYear(parseInt(tag.substring(0, 4)));
    imageDate.setUTCMonth(parseInt(tag.substring(4, 6)) - 1);
    imageDate.setUTCDate(parseInt(tag.substring(6, 8)));
    imageDate.setUTCHours(parseInt(tag.substring(8, 10)));
    imageDate.setUTCMinutes(parseInt(tag.substring(10, 12)));
    imageDate.setUTCSeconds(parseInt(tag.substring(12, 14)));
    return imageDate;
};

module.exports = {
    tagToDate, request
};