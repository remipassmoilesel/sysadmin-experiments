const request = require('request-promise');

const config = {
    url: '/realms/master/protocol/openid-connect/token',
    baseUrl: 'http://172.17.0.3:8080/auth',
    username: 'admin',
    password: 'admin',
    grant_type: 'password',
    client_id: 'admin-cli'
};

const helper = {

    settings: {},

    getToken: (settings) => {

        const options = {
            method: 'POST',
            uri: settings.baseUrl + settings.url,
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

    evaluate: (settings) => {

    },

};

helper.getRealms(config).then((auth) => {
    console.log(auth)
});

module.exports = helper;