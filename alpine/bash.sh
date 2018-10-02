#!/bin/sh

uid=$(id -u)
if [[ $uid -ne 0 ]]; then
   exec /bin/sh
fi