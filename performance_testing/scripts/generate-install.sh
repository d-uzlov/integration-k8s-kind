#!/bin/bash

function install_gotestmd() {
    git clone https://github.com/networkservicemesh/gotestmd.git || exit
    cd gotestmd

    PR_ID=41
    BRANCHNAME=generate-bash
    git fetch origin "pull/$PR_ID/head:$BRANCHNAME" || exit

    git checkout "$BRANCHNAME" || exit

    go install . || exit
    cd ..
    rm -rf gotestmd
}

(install_gotestmd) || exit
