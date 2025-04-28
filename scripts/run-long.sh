#!/bin/bash

stdbuf -o L /deployments/coder/volumes/earthperson/projects/openpra-monorepo/node_modules/.bin/scram-cli \
--verbosity 7 \
--probability \
--bdd \
--limit-order 20 \
../../../../fixtures/models/generic-openpsa-models/models/Aralia/$1