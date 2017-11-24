const request = require('request-promise');

const config = {
    openidConnectPath: '/realms/master/protocol/openid-connect/token',
    evaluatePath: '/admin/realms/library-poc/clients/e47e0f0d-2932-4d7f-8533-1f7eac9305cf/authz/resource-server/policy/evaluate',
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

// helper.getRealms(config).then((auth) => {
//     console.log(auth)
// });

const payload = {
    "resources": [{
        "name": "library_a",
        "uri": "/library-a",
        "type": "library-api:library",
        "owner": {"id": "e47e0f0d-2932-4d7f-8533-1f7eac9305cf", "name": "library_api_client"},
        "_id": "6ae3b27b-4b43-413b-b5f9-81d79a89a189",
        "scopes": ["Edit"]
    }],
    "context": {"attributes": {}},
    "roleIds": ["library_admin"],
    "clientId": "e47e0f0d-2932-4d7f-8533-1f7eac9305cf",
    "userId": "2c594d05-6ecb-4f86-9df8-ca9933aec6ba",
    "entitlements": false
};

helper.evaluate(config, payload);

module.exports = helper;