#!/bin/bash
# jf config add academy --url='http://academy-artifactory' --user='admin' --password='Admin1234!' --interactive=false --overwrite=true 
# jf config show
# jf config use academy
jf rt ping

export JFROG_CLI_LOG_LEVEL="DEBUG" 


setup(){ 
    printf "\n ------------------------------------------------------------  "
    printf "\n  ----------------    REPO Setup for LAB-2  ----------------  "
    printf "\n ------------------------------------------------------------  \n"
    create-remote-repos
    create-local-repos
    create-virtual-repos
}
create-remote-repos(){
    # Create new REMOTE repo and refer https://jfrog.com/help/r/jfrog-rest-apis/create-multiple-repositories
    printf "\n\n 1. Creating REMOTE repositories \n"
    reposData="[ { \"key\": \"jftd114-lab2-npm-remote\", \"packageType\": \"npm\", \"rclass\": \"remote\", \"url\": \"https://registry.npmjs.org\", \"xrayIndex\": true} ]"

    repoResponse=$(jf rt curl -XPUT /api/v2/repositories/batch --header 'Content-Type: application/json' --data "$reposData")
    printf "Remote Repositories created:\n $repoResponse \n\n"
}
create-local-repos(){
    # Create new LOCAL repo and refer https://jfrog.com/help/r/jfrog-rest-apis/create-multiple-repositories
    printf "\n\n 2. Creating LOCAL repositories \n"
    reposData="[ {\"key\": \"jftd114-lab2-npm-local\", \"packageType\": \"npm\", \"rclass\": \"local\", \"xrayIndex\": true }  ]"

    repoResponse=$(jf rt curl -XPUT /api/v2/repositories/batch --header 'Content-Type: application/json' --data "$reposData")
    printf "LOCAL Repositories created:\n $repoResponse \n\n"
}

create-virtual-repos(){
    # Create new virtual repos
    printf "\n\n 3. Creating VIRTUAL repositories \n"

    reposData="[ { \"key\": \"jftd114-lab2-npm-virtual\", \"packageType\": \"npm\", \"rclass\": \"virtual\", \"description\": \"The virtual repository public description\", \"defaultDeploymentRepo\": \"jftd114-lab2-npm-local\", \"repositories\": [ \"jftd114-lab2-npm-local\", \"jftd114-lab2-npm-remote\"], \"xrayIndex\": true }]"

    repoResponse=$(jf rt curl -XPUT /api/v2/repositories/batch --header 'Content-Type: application/json' --data "$reposData")
    printf "VIRTUAL Repository created:\n $repoResponse \n\n"
}

setup


printf "\n ------------------------------------------------------------  "