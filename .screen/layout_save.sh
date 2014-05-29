#!/usr/bin/env bash

name=$(screen -X layout number && screen -Q lastmsg|cut -d' ' -f5-|cut -d'(' -f2|cut -d ')' -f1)
screen -X layout save $name
screen -X echo "current layout was saved to $name"
