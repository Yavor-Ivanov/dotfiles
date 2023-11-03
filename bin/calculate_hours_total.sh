#!/bin/bash

# Takes all lines that have ## Xh where X is a number and calculates the total for all of them.
# This is useful for writing up estimations where you write:
#
#     1. Task one ## 2h
#     2. Task two ## 0.5h
#
# And want to have a total at the end.
grep ".*##" | sed 's/.*## //g' | sed 's/h/ + /g' | xargs | sed 's/ \+$//g' | bc -l
