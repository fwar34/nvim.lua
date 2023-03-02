#!/bin/bash

# ls|grep -v test|xargs -I{} ./test.sh {}

mv $1 `echo $1|sed 's/group/gp/g'`
