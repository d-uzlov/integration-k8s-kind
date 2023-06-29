#!/bin/bash

echo running "$0"

parent_path=$( cd "$(dirname "$0")" ; pwd -P ) || exit

if [ -z "$1" ]; then echo 1st arg 'nsm_version' is missing; exit 1; fi
if [ -z "$2" ]; then echo 2nd arg 'result_folder' is missing; exit 1; fi

nsm_version=$1
result_folder=$2
qps_list=${3:-1000000}
duration=${4:-60s}
connections=${5:-1}
iterations=${6:-3}

echo nsm_version: "$nsm_version"
echo result_folder: "$result_folder"
echo qps_list: "$qps_list"
echo duration: "$duration"
echo connections: "$connections"
echo iterations: "$iterations"

echo =====================================
echo setup NSM prerequisites
"$parent_path/nsm_prerequisites_setup.sh" > "$result_folder/nsm_prerequisites_setup.log" 2>&1 || exit

echo =====================================
echo run vl3 test
"$parent_path/run_test_suite.sh" \
    vl3 \
    "$result_folder" \
    "$iterations" \
    "http://nginx.my-vl3-network:80" \
    "$parent_path/../use-cases/vl3/deploy.sh" \
    "$parent_path/../use-cases/vl3/clear.sh" \
    "$nsm_version" \
    "$qps_list" \
    "$duration" \
    "$connections" \
    "$parent_path/nsm_deploy_setup.sh" \
    "$parent_path/nsm_deploy_cleanup.sh" \
    || exit

echo =====================================
echo run k2wireguard2k test
"$parent_path/run_test_suite.sh" \
    k2wireguard2k \
    "$result_folder" \
    "$iterations" \
    "http://172.16.1.2:80" \
    "$parent_path/../use-cases/k2wireguard2k/deploy.sh" \
    "$parent_path/../use-cases/k2wireguard2k/clear.sh" \
    "$nsm_version" \
    "$qps_list" \
    "$duration" \
    "$connections" \
    "$parent_path/nsm_deploy_setup.sh" \
    "$parent_path/nsm_deploy_cleanup.sh" \
    || exit

echo =====================================
echo cleanup NSM prerequisites
"$parent_path/nsm_prerequisites_cleanup.sh" > "$result_folder/nsm_prerequisites_cleanup.log" 2>&1

true
