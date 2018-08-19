
const got = require('got');
const config = require('./config');

console.log('Using config: ' + JSON.stringify(config, null, 2));

const printResponse = (resp) => {
  const fullResp = {
    status: resp.statusCode,
    body: resp.body,
  };
  console.log(JSON.stringify(fullResp, null, 2));
}

const getUser = async () => {
  console.log('User: ');

  const url = config.baseUrl + '/users?username=' + config.username
  const user = await got(url, {
    headers: {
      'Private-Token': config.accessToken
    },
    json: true,
  });

  printResponse(user);
}

const listUserProjects = async () => {
  console.log('List of projects: ');

  const url = config.baseUrl + '/users/' + config.userId + '/projects'
  const projects = await got(url, {
    headers: {
      'Private-Token': config.accessToken
    },
    json: true,
  });

  printResponse(projects);
}

const listMergeRequests = async () => {
  console.log('List of merge requests: ');

  const url = config.baseUrl + '/projects/' + config.projectId + '/merge_requests'
  const mergeRequests = await got(url, {
    headers: {
      'Private-Token': config.accessToken
    },
    json: true,
  });

  printResponse(mergeRequests);
}

const createMergeRequest = async () => {
  console.log('Creating merge request: ');

  // POST /projects/:id/merge_requests
  const sourceBranch = 'master';
  const targetBranch = 'env/preprod';
  const title = "Update of " + targetBranch + " " + new Date()
  const description = "MR description"

  const payload = {
                    // id: config.projectId,
                    source_branch: sourceBranch,
                    target_branch: targetBranch,
                    title,
                    description,
                    // squash: true, // non safe option
                  };

  console.log("Payload: " + JSON.stringify(payload, null, 2));

  const url = config.baseUrl + '/projects/' + config.projectId + '/merge_requests'
  const mergeRequests = await got(url, {
    method: 'POST',
    headers: {
      'Private-Token': config.accessToken
    },
    body: payload,
    json: true,
    throwHttpErrors: false,
  });

  printResponse(mergeRequests);
}

const acceptMergeRequest= async (mergeRequestIid) => {
  console.log('Accepting merge request: ');

  const payload = {
                      id: config.projectId,
                      iid: mergeRequestIid,
                      merge_when_pipeline_succeeds: true
                  }

  console.log("Payload: " + JSON.stringify(payload, null, 2));

  // PUT /projects/:id/merge_requests/:merge_request_iid/merge
  const url = config.baseUrl + '/projects/' + config.projectId + '/merge_requests/' + mergeRequestIid + '/merge'
  const response = await got(url, {
    method: 'PUT',
    headers: {
      'Private-Token': config.accessToken
    },
    body: payload,
    json: true,
    throwHttpErrors: false,
  });

  printResponse(response);
}

const main = async () => {
  if (process.argv[2] === 'list-projects') {
    await listUserProjects();
  } else if (process.argv[2] === 'get-user') {
    await getUser();
  } else if (process.argv[2] === 'list-mr') {
    await listMergeRequests();
  } else if (process.argv[2] === 'create-mr') {
    await createMergeRequest();
  } else if (process.argv[2] === 'accept-mr') {
    await acceptMergeRequest(process.argv[3]);
  } else {
    throw new Error('You must provide a command');
  }
}

(async () => {
  try {
    await main();
  } catch (e) {
    console.error(e)
    process.exit(1)
  }
})();