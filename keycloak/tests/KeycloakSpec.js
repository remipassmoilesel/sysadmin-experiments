const helper = require('./helper');
const chai = require('chai');
const assert = require('chai').assert;

describe('Keycloak test', () => {

    const settings = {
        baseUrl: 'http://172.17.0.3:8080/auth',
        username: 'admin',
        password: 'admin',
        grant_type: 'password',
        client_id: 'admin-cli'
    };

    it('test should fail', () => {

        helper.connect(settings);
    })

});