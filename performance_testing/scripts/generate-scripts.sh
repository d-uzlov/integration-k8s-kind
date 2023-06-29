#!/bin/bash

parent_path=$( cd "$(dirname "$0")" ; pwd -P ) || exit

if [ -z "$1" ]; then echo 1st arg 'source_folder' is missing; exit 1; fi

source_folder=$1

result_folder="$parent_path"/gen

function generate_suites() {
    # gotestmd "$source_folder"/examples "$result_folder" --bash --match /interdomain/loadbalancer
    # gotestmd "$source_folder"/examples "$result_folder" --bash --match /interdomain/dns
    # gotestmd "$source_folder"/examples "$result_folder" --bash --match /spire/cluster1
    # gotestmd "$source_folder"/examples "$result_folder" --bash --match /spire/cluster2
    # gotestmd "$source_folder"/examples "$result_folder" --bash --match /interdomain/spiffe_federation
    # gotestmd "$source_folder"/examples "$result_folder" --bash --match /interdomain/nsm

    gotestmd "$source_folder"/examples "$result_folder" --bash --match loadbalancer
    gotestmd "$source_folder"/examples "$result_folder" --bash --match dns
    gotestmd "$source_folder"/examples "$result_folder" --bash --match cluster1
    gotestmd "$source_folder"/examples "$result_folder" --bash --match cluster2
    gotestmd "$source_folder"/examples "$result_folder" --bash --match spiffe_federation
    gotestmd "$source_folder"/examples "$result_folder" --bash --match nsm
}

rm -r "$result_folder"

(generate_suites) || exit
