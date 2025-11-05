# Config - Artifactory info
export JF_HOST="academy-artifactory" JFROG_RT_USER="admin" JFROG_CLI_LOG_LEVEL="DEBUG"
export JF_RT_URL="http://${JF_HOST}"

printf "JF_RT_URL: $JF_RT_URL \n JFROG_RT_USER: $JFROG_RT_USER \n JFROG_CLI_LOG_LEVEL: $JFROG_CLI_LOG_LEVEL \n "

export RT_REPO_VIRTUAL="jftd114-lab2-npm-virtual" 

printf "JF_RT_URL: $JF_RT_URL \n JFROG_RT_USER: $JFROG_RT_USER \n JFROG_CLI_LOG_LEVEL: $JFROG_CLI_LOG_LEVEL \n "

jf npmc --repo-resolve ${RT_REPO_VIRTUAL} --repo-deploy ${RT_REPO_VIRTUAL}