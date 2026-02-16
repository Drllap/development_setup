#!/bin/bash

export CONAN_REVISIONS_ENABLED=1

function conan_connect {
    conan user pallp -p $NORBIT_GITLAB_BASIC_TOKEN -r gitlab-conan-project
    conan user pallp -p $NORBIT_GITLAB_BASIC_TOKEN -r gitlab
}

