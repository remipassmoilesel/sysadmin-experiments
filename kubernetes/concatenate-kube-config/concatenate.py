#!/usr/bin/env python2.7

import argparse
import subprocess
import yaml
from argparse import RawTextHelpFormatter
from shutil import copyfile
from os.path import expanduser

##----------------------------------------------------------
##
## Utility used to generate and pull kubectl configurations
## from remote servers, and to merge them in a single kubectl
## configuration
##
## Warning: very few input checks, and works only on Linux !
##
##----------------------------------------------------------

PGRM_DESC = '''
Utility to fetch kubernetes configurations and merge them in a single kube file.

Usage:      Fetch configurations and concatenate them:   $ ./generate-kub-config.py
            Concatenate only:                            $ ./generate-kub-config.py -c
'''

# Configurations to merge in a new kubeconfig.
# If specified as a value, the address of k8s server
# will be changed. Only the first cluster is changed.
CONFIGURATIONS_TO_MERGE = {
    "file1": "",
    "file2": "",
    "file3": "https://127.0.0.1:16001"}

# The directory where are stored configurations
CONFIG_DIR = "kubectl-config"

# The final path of merged configurations
FINAL_CONFIG_PATH = CONFIG_DIR + "/merged-config.yml"

# Location of home kubeconfig
HOME_DIR = expanduser("~")
KUBECONFIG_LOCATION = HOME_DIR + '/.kube/config'


class Colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    ENDC = '\033[0m'


def log(line="", color=Colors.OKBLUE):
    print(color + line + Colors.ENDC)


def concatenateConfigurations():
    log("==================================")
    log("Assembling fetched configurations.")
    log("==================================")

    # Create a configuration object
    finalConfig = {}
    finalConfig['apiVersion'] = 'v1'
    finalConfig['clusters'] = []
    finalConfig['contexts'] = []
    finalConfig['current-context'] = ""
    finalConfig['kind'] = "Config"
    finalConfig['preferences'] = {}
    finalConfig['users'] = []

    # Iterate fetched configurations
    for fileName, address in CONFIGURATIONS_TO_MERGE.items():
        configPath = CONFIG_DIR + "/" + fileName

        log("Load and concatenate file: " + configPath)

        # read file
        try:
            with open(configPath, 'r') as f:
                conf = yaml.load(f)

                # Add clusters to final config. If a replacement address if specified,
                # replace the cluster address
                if address:
                    conf['clusters'][0]['cluster']['server'] = address

                    finalConfig['clusters'] += conf['clusters']
                else:
                    finalConfig['clusters'] += conf['clusters']

                # Add contexts to final config
                finalConfig['contexts'] += conf['contexts']

                # Set current context if needed
                if not finalConfig['current-context']:
                    finalConfig['current-context'] = conf['current-context']

                # Add users to final config
                finalConfig['users'] += conf['users']
        except:
            log("Error while reading configuration !", Colors.FAIL)

    # Write final configuration
    with open(FINAL_CONFIG_PATH, 'w') as f:
        yaml.dump(finalConfig, f, explicit_start=True)


def replaceConfiguration():
    resp = ""
    while resp != "y" and resp != "n":
        print("")
        resp = raw_input(
            Colors.WARNING + 'Do you want to copy merged configuration at ' + KUBECONFIG_LOCATION + ' [y/n] ? ' + Colors.ENDC)
        print("")

    if resp == "y":
        copyfile(KUBECONFIG_LOCATION, KUBECONFIG_LOCATION + ".bak")
        copyfile(FINAL_CONFIG_PATH, KUBECONFIG_LOCATION)
        log("Configuration changed, old one saved at " + KUBECONFIG_LOCATION + ".bak", color=Colors.WARNING)
    else:
        log("Configuration not changed")


if __name__ == "__main__":

    # parse arguments
    parser = argparse.ArgumentParser(description=PGRM_DESC, formatter_class=RawTextHelpFormatter)

    parser.add_argument(action="store_true",
                        help="concatenate only present files")

    knownArgs = parser.parse_args()

    # concatenate configurations
    concatenateConfigurations()

    # Ask for configuration replacing
    replaceConfiguration()

    exit(0)
