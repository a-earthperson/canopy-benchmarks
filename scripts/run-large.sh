#!/bin/bash

ACPP_VISIBILITY_MASK=ocl ACPP_DEBUG_LEVEL=0 ACPP_ADAPTIVITY_LEVEL=2 ACPP_ALLOCATION_TRACKING=1 \
/home/earthperson/projects/openpra-monorepo/packages/engine/scram-node/cmake-build-release/targets/scram-cli/scram-cli \
--verbosity 7 \
--probability \
--limit-order 999999999 \
--monte-carlo \
--pdag \
$2 \
../../../../fixtures/models/$1 2>&1 | tee -a | grep -e "sampled_bits_per_event:" \
-e "num_layers:" \
-e "\[p05, mean, p95\]" \
-e "Calculated probability" \
-e "<gates>" \
-e "<basic-events>" \
-e "Total # of gates:" \
-e "Total # of variables:" \
-e "<sum-of-products"


#| sed -n 's/.*:: \(\[[0-9., eE+\-]*\]\)[[:space:]]*$/\1/p' | sed 's/^\[\(.*\)\]$/\1/' | tr -d "[:blank:]"