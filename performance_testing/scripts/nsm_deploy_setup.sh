#!/bin/bash

parent_path=$( cd "$(dirname "$0")" ; pwd -P ) || exit

"$parent_path"/gen/interdomain/nsm/suite.sh setup
