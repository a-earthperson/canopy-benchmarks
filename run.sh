#!/bin/bash

echo "PDAG MONTE CARLO"
ACPP_VISIBILITY_MASK=cuda ACPP_DEBUG_LEVEL=0 ACPP_ADAPTIVITY_LEVEL=2 ACPP_ALLOCATION_TRACKING=1 \
/home/earthperson/projects/openpra-monorepo/packages/engine/scram-node/cmake-build-release/targets/scram-cli/scram-cli \
--verbosity 7 \
--pdag \
--monte-carlo \
--probability \
--num-trials 1 \
--batch-size 1024 \
--sample-size 1 \
"../../../../fixtures/models/generic-openpsa-models/models/Aralia/$1" 2>&1 | tee -a | grep -e "num_nodes" -e "num_layers" -e "tally" -e "Total # of gates:" -e "Total # of variables:"

echo "BDD LIMIT ORDER 10"
/home/earthperson/projects/openpra-monorepo/packages/engine/scram-node/cmake-build-release/targets/scram-cli/scram-cli \
--verbosity 7 \
--probability \
--bdd \
--limit-order 10 \
../../../../fixtures/models/generic-openpsa-models/models/Aralia/$1 2>&1 | tee -a | grep -e "<sum-of-products" -e "Total # of gates:" -e "Total # of variables:"

echo "MOCUS/MCUB NNF"
/home/earthperson/projects/openpra-monorepo/packages/engine/scram-node/cmake-build-release/targets/scram-cli/scram-cli \
--verbosity 7 \
--mocus \
--mcub \
--preprocessor \
../../../../fixtures/models/generic-openpsa-models/models/Aralia/$1 2>&1 | tee -a | grep -e "<sum-of-products" -e "Total # of gates:" -e "Total # of variables:"
