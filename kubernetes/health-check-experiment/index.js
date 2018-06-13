const http = require('http');

const MAIN_PORT = 80;
const HEALTH_CHECK_PORT = 8888;
const SET_UNHEALTHY_PORT = 9999;
const UNHEALTHY_STATE_TIME = 10000; // millisec
const KILL_SIGNAL = 'SIGTERM'; // sec

const IS_HANDLING_KILL_SIGNAL_IN_HEALTH_CHECK = process.env.HANDLE_KILL_SIGNAL || 'true';
const DO_LOG = process.env.DO_LOG || 'false';

const log = (msg) => {
    if(DO_LOG === 'true'){
        console.log(`[${new Date()}] ${msg}`)
    }
};

let appStatusCode = 200;
let appResponse = process.env;

// ########################
// MAIN SERVER
// ########################

http.createServer((req, res) => {

    log(`Serving request from: ${req.connection.remoteAddress} code=${appStatusCode}`);

    res.setHeader('Content-Type', 'text/json');
    res.statusCode = appStatusCode;
    res.write(JSON.stringify(appResponse, null, 4));
    res.end();

}).listen(MAIN_PORT);


// ########################
// HEALTH CHECK
// ########################

let healthResponse = {status: 'healthy', handlingSigKillInHealthCheck: IS_HANDLING_KILL_SIGNAL_IN_HEALTH_CHECK};
http.createServer((req, res) => {

    log(`Serving health check for: ${req.connection.remoteAddress}`);

    // if application is unhealthy, health check will be unhealthy
    if(IS_HANDLING_KILL_SIGNAL_IN_HEALTH_CHECK === 'true'){

        res.setHeader('Content-Type', 'text/json');
        res.statusCode = appStatusCode;
        res.write(JSON.stringify(healthResponse, null, 4));
        res.end();

    }

    // if application is unhealthy, health check will be healthy
    else {

        res.setHeader('Content-Type', 'text/json');
        res.statusCode = 200;
        res.write(JSON.stringify(healthResponse, null, 4));
        res.end();

    }

}).listen(HEALTH_CHECK_PORT);

// ########################
// KILL ROUTE
// ########################

http.createServer((req, res) => {

    log(`Set app unealthy after request from: ${req.connection.remoteAddress}`);

    const jsonResp = {oldStatus: appStatusCode, newStatus: undefined};

    appStatusCode = 500;
    appResponse = {error: "Server error", handlingSigKillInHealthCheck: IS_HANDLING_KILL_SIGNAL_IN_HEALTH_CHECK};
    healthResponse = {status: 'unhealthy', handlingSigKillInHealthCheck: IS_HANDLING_KILL_SIGNAL_IN_HEALTH_CHECK};

    jsonResp.newStatus = appStatusCode;

    res.setHeader('Content-Type', 'text/json');
    res.statusCode = 200;
    res.write(JSON.stringify(jsonResp, null, 4));
    res.end();

    // send kill signal
    process.kill(process.pid, KILL_SIGNAL);

}).listen(SET_UNHEALTHY_PORT);

// listen for kill signal then exit after a little time
const setAppUnealthy = () => {
    log(`Application is now unealthy but will leave after ${UNHEALTHY_STATE_TIME}s`);

    setTimeout(() => {
        process.exit(1);
    }, UNHEALTHY_STATE_TIME);
};
process.on(KILL_SIGNAL, setAppUnealthy);

// ########################
// BEGIN START LOG
// ########################

log(`Is application handling kill signal in health check: ${IS_HANDLING_KILL_SIGNAL_IN_HEALTH_CHECK}`);
log(`Serving on port: ${MAIN_PORT}`);
log(`Health check on port: ${HEALTH_CHECK_PORT}`);
log(`Set app unealthy with port: ${SET_UNHEALTHY_PORT}`);

// list status codes
// console.log(`Available status codes: ${http.STATUS_CODES}`);

