#!/bin/bash


SHELL_FOLDER=$(dirname $(readlink -f "$0"))
ip=$(ip -4 route get 8.8.8.8 2>/dev/null | head -1 | awk '{print $7}')



find  $SHELL_FOLDER/.. -type f -name *.conf -o -name *.yml -exec sed -i "s#127.0.0.1#$ip#g" {} \;
