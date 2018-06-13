const http = require('http');
const fs = require('fs');

// ##################################
// OPTIONS AND HELPERS
// ##################################

const options = {
    port: process.env.PORT || 80,
    htmlTemplatePath: '/server/template.html',
    serverRoot: '/server/',
};

const template = fs.readFileSync(options.htmlTemplatePath).toString();

const templateAndSend = (title, content, res) => {
    res.writeHead(200, {'Content-Type': 'text/html'});
    const templated = template.replace('{{ title }}', title).replace('{{ content }}', content);
    res.write(templated);
    res.end();
};

// ##################################
// ROUTE HANDLERS
// ##################################

const getIndex = (req, res) => {
    templateAndSend(
        'Index',
        `
        <p>
        Each time you visit these pages, you will create files. Depending on which type of Kubernetes volume it is,
        files will be persisted or not.
        </p>
        
        <p><a href='/container-dir'>/container-dir:</a> Read and write in a container directory. If you kill the container, 
        files will be lost.</p>
        <p><a href='/empty-dir'>/empty-dir:</a> Read and write in an empty dir. If you kill the container, files will be kept. 
        But if you delete the pod, files will be lost.</p>
        <p><a href='/host-path'>/host-path:</a> Read and write in a volume created on host. If you kill the container, files will be kept. 
        If you destroy deployment, files will be kept.</p>
        `,
        res);
};

const getServerFiles = (req, res) => {
    const serverFiles = fs.readdirSync(options.serverRoot).map((path) => {
        return `<li>${path}</li>`;
    }).join('\n');

    templateAndSend(
        'Server files',
        `
        <ol>
            ${serverFiles}
        </ol>
        `,
        res);
};

const logThenGetLogs = (baseDir, title, req, res) => {
    const clientIp = req.connection.remoteAddress;
    const date = new Date();
    const logName = `${clientIp}_${date}_${date.getTime()}.log`;
    fs.writeFileSync(`${baseDir}/${logName}`, '');

    const logs = fs.readdirSync(baseDir).map((path) => {
        return `<li>${path}</li>`;
    }).join('\n');

    templateAndSend(
        title,
        `
        <ol>
            ${logs}
        </ol>
        `,
        res);
};

// ##################################
// PROCESS SIGNAL HANDLERS
// ##################################

const handleSignal = (signal) => {
    console.log(`Received ${signal}`);
    process.exit(0);
};

process.on('SIGINT', handleSignal);
process.on('SIGTERM', handleSignal);

// ##################################
// HTTP SERVER
// ##################################

console.log('Starting server with options: ' + JSON.stringify(options));

const handleRequest = (req, res) => {
    switch (req.url) {
        case '/':
            getIndex(req, res);
            break;
        case '/server-files':
            getServerFiles(req, res);
            break;
        case '/container-dir':
            logThenGetLogs('/container-dir', 'Logs in container directory', req, res);
            break;
        case '/empty-dir':
            logThenGetLogs('/empty-dir', 'Logs in empty directory volume', req, res);
            break;
        case '/host-path':
            logThenGetLogs('/host-path', 'Logs in host path volume', req, res);
            break;
        default:
            console.log('Unhandled route: ' + req.url);
            res.send(500);
    }
};

http.createServer((req, res) => {
    console.log('Handling request: ' + req.url);
    try {
        handleRequest(req, res)
    } catch (e) {
        console.error(e);
        res.writeHead(500, {'Content-Type': 'text/plain'});
        res.write(e.stack);
        res.end();
    }
}).listen(options.port);

