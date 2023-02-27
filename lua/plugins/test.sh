#!/bin/bash

mv $1 `echo $1|sed 's/_//g'`
