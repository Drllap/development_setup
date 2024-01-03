#!/bin/bash

function conan_connect {
    conannor user pallp -p $NORBIT_GITLAB_BASIC_TOKEN -r gitlab-conan-project
    conannor user pallp -p $NORBIT_GITLAB_BASIC_TOKEN -r gitlab
}

