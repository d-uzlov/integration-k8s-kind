#!/bin/bash

parent_path=$( cd "$(dirname "$0")" ; pwd -P ) || exit

function nsm_prerequisites_cleanup() {
    "$parent_path"/gen/interdomain/spiffe_federation/suite.sh cleanup
    "$parent_path"/gen/spire/cluster2/suite.sh cleanup
    "$parent_path"/gen/spire/cluster1/suite.sh cleanup
    "$parent_path"/gen/interdomain/dns/suite.sh cleanup
    "$parent_path"/gen/interdomain/loadbalancer/suite.sh cleanup

    true
}

(nsm_prerequisites_cleanup) || exit
