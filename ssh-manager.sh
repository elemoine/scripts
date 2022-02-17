#!/usr/bin/env bash

readonly PROGNAME=$(basename $0)
readonly ARGS="$@"

usage() {
    local exitcode=$1
    cat <<- EOF
Usage: ${PROGNAME} options

OPTIONS:
    -e <env>        the environment (dev, staging, sandbox, prod)
    -c              ssh to the gaeapp container
    -h              help
EOF
    exit $exitcode
}

get_instance() {
    local project=$1;
    local service=$2;
    local instance_object=$(gcloud app instances list --project ${project} --service ${service} --format json | jq -r '.[-1]')
    echo "${instance_object}"
}

do_ssh() {
    local env=$1
    local ssh_to_container=$2

    local project;
    local service;
    case "${env}" in
        prod)
            project="promising-life-217513"
            service="manager"
            ;;
        sandbox)
            project="heroic-dolphin-250709"
            service="manager-staging"
            ;;
        staging)
            project="alma-staging-2021-06"
            service="default"
            ;;
        dev)
            project="alma-dev-b122e"
            service="manager-dev"
            ;;
    esac

    local extra_flags;
    if [[ ${ssh_to_container} == "1" ]]
    then
        extra_flags="--container gaeapp"
    fi

    local instance_object=$(get_instance ${project} ${service})
    local instance=$(echo ${instance_object} | jq -r '.instance.id')
    local version=$(echo ${instance_object} | jq -r '.version')

    gcloud app instances ssh --project ${project} --service ${service} --version ${version} ${extra_flags} ${instance}
}

main() {
    local env="prod"
    local ssh_to_container="0"
    while getopts ":e:c" opt
    do
        case "${opt}" in
            e)
                env=${OPTARG}
                ;;
            c)
                ssh_to_container="1"
                ;;
            \?)
                usage 1
                ;;
        esac
    done

    do_ssh ${env} ${ssh_to_container}
}

main ${ARGS}
