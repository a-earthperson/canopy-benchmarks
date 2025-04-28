#!/bin/bash

echo "bdd-10: "
/home/earthperson/projects/openpra-monorepo/packages/engine/scram-node/cmake-build-release/targets/scram-cli/scram-cli \
--verbosity 7 \
--probability \
--bdd \
--limit-order 20 \
../../../../fixtures/models/generic-openpsa-models/models/Aralia/$1 2>&1 | tee -a | grep -e "<sum-of-products" &

echo "rea-20: "
/home/earthperson/projects/openpra-monorepo/packages/engine/scram-node/cmake-build-release/targets/scram-cli/scram-cli \
--verbosity 7 \
--probability \
--bdd \
--rare-event \
--limit-order 20 \
../../../../fixtures/models/generic-openpsa-models/models/Aralia/$1 2>&1 | tee -a | grep -e "<sum-of-products" &

echo "mcub-20: "
/home/earthperson/projects/openpra-monorepo/packages/engine/scram-node/cmake-build-release/targets/scram-cli/scram-cli \
--verbosity 7 \
--probability \
--bdd \
--mcub \
--limit-order 20 \
../../../../fixtures/models/generic-openpsa-models/models/Aralia/$1 2>&1 | tee -a | grep -e "<sum-of-products" &

echo "bdd-20: "
/home/earthperson/projects/openpra-monorepo/packages/engine/scram-node/cmake-build-release/targets/scram-cli/scram-cli \
--verbosity 7 \
--probability \
--bdd \
--limit-order 999999999 \
../../../../fixtures/models/generic-openpsa-models/models/Aralia/$1 2>&1 | tee -a | grep -e "<sum-of-products" &

wait
#/home/earthperson/projects/openpra-monorepo/packages/engine/scram-node/cmake-build-release/targets/scram-cli/scram-cli \
#--verbosity 7 \
#--probability \
#--bdd \
#--limit-order 20 \
#../../../../fixtures/models/generic-openpsa-models/models/Aralia/$1 2>&1 | tee -a | grep -e "<sum-of-products" -e "Total # of gates:" -e "Total # of variables:"
