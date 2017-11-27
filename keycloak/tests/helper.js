const request = require('request-promise');

const helper = {

    settings: {},

    getToken: (settings) => {

        const options = {
            method: 'POST',
            uri: settings.baseUrl + settings.openidConnectPath,
            form: settings,
            json: true
        };

        return request(options).then((data) => {
            return data.access_token;
        });
    },

    getAuth: (settings) => {
        return helper.getToken(settings).then((accessToken) => {
            // console.log(arguments);
            return {
                bearer: accessToken
            };
        });
    },

    getRealms: (settings) => {
        return helper.getAuth(settings).then((auth) => {
            const options = {
                uri: `${settings.baseUrl}/admin/realms`,
                auth: auth,
                json: true
            };
            return request(options);
        });
    },

    evaluate: (settings, payload) => {

        return helper.getAuth(settings).then((auth) => {

            const options = {
                method: 'POST',
                uri: settings.baseUrl + settings.evaluatePath,
                auth: auth,
                body: payload,
                json: true
            };

            console.log(options);

            return request(options);
        });

    },

};

module.exports = helper;