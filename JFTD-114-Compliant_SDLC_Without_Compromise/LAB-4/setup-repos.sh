#!/bin/bash
# jf config add academy --url='http://academy-artifactory' --user='admin' --password='Admin1234!' --interactive=false --overwrite=true 
# jf config show
jf rt ping

export JFROG_CLI_LOG_LEVEL="DEBUG" 

setup(){ 
    printf "\n ------------------------------------------------------------  "
    printf "\n  ----------------    REPO Setup for LAB-4  ----------------  "
    printf "\n ------------------------------------------------------------  \n"
    create-local-repos
}

create-local-repos(){
    # Create new LOCAL repo and refer https://jfrog.com/help/r/jfrog-rest-apis/create-multiple-repositories
    printf "\n\n 2. Creating LOCAL repositories \n"
    reposData="[ {\"key\": \"jftd114-lab4-generic-local\", \"packageType\": \"generic\", \"rclass\": \"local\", \"xrayIndex\": true }  ]"

    repoResponse=$(jf rt curl -XPUT /api/v2/repositories/batch --header 'Content-Type: application/json' --data "$reposData")
    printf "LOCAL Repositories created:\n $repoResponse \n\n"
}

verify(){
    printf "\n -------------------------------------------------------------  "
    printf "\n ----------------------  LAB-4: Verify  ----------------------  "
    printf "\n -------------------------------------------------------------  \n"
    load-config
    printf "\n\n 1. Verifying Remote Repositories \n"  # ref: https://jfrog.com/help/r/jfrog-rest-apis/get-repository-configuration-v2
    repoStatus=$(jf rt curl -XGET /api/v2/repositories/jftd114-lab4-generic-local --head --silent -o /dev/null -w "%{http_code}")

    if [[ "$repoStatus" -ne 200 ]]; then
        printf "Error: Remote Repository jftd114-lab4-generic-local not found or inaccessible. Status: $repoStatus \n"
        exit 1
    else
        printf "Success: Remote Repository jftd114-lab4-generic-local is accessible. Status: $repoStatus \n"
    fi
}


# Check for 1 argument
if [ $# -ne 1 ]; then
  printf "    ./setup-repos.sh <setup | verify> "
fi
# -z option with $1, if the first argument is NULL. Set to default
if  [[ -z "$1" ]] ; then # check for null
    printf "User action is NULL, setting to default setup"
    arg='SETUP'
fi

# -n string - True if the string length is non-zero.
if [[ -n $arg ]] ; then
    arg_len=${#arg}
    # uppercase the argument
    arg=$(printf ${arg} | tr [a-z] [A-Z] | xargs)
    printf "User Action: ${arg}, and arg length: ${arg_len}"
    
    if [[ ("SETUP" == "${arg}") || ("RUN" == "${arg}") ]] ; then   # start
       setup
    elif [[ "VERIFY" == "${arg}" ]] ; then   # Minikube
        verify 
    else
        printf "Error: Invalid argument. Use 'setup | verify"
        exit 1
    fi
fi

printf "\n ------------------------------------------------------------  "
