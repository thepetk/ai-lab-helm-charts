#!/bin/bash

ROOTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# pull and convert resources from ai-lab-app
bash $ROOTDIR/scripts/convert-gitops-template.sh