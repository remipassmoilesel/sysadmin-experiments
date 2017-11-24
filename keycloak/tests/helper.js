const kc = require('keycloak-admin-client');

module.exports = {

    connect: (settings) => {
        kc(settings)
            .then((client) => {
                client.realms.find()
                    .then((realms) => {
                        console.log('realms', realms);
                    });
            })
            .catch((err) => {
                console.log('Error', err);
            });
    },

    evaluate: (settings) => {

    },


};