# Eviter une étape de build en fonction du nom du job

    scripts:
      - "if [[ $CI_JOB == deploy_* ]]; then exit 0; else mvn $MAVEN_CLI_OPTS command; fi"
    