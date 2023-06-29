#!/bin/bash

parent_path=$( cd "$(dirname "$0")" ; pwd -P ) || exit

function nsm_prerequisites_setup() {
    "$parent_path"/gen/interdomain/loadbalancer/suite.sh setup || exit
    "$parent_path"/gen/interdomain/dns/suite.sh setup || exit
    "$parent_path"/gen/spire/cluster1/suite.sh setup || exit
    "$parent_path"/gen/spire/cluster2/suite.sh setup || exit
    "$parent_path"/gen/interdomain/spiffe_federation/suite.sh setup || exit
}

(nsm_prerequisites_setup) || exit
