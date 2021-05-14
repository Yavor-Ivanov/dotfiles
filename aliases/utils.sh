#!/bin/bash

random_unilateral() {
    bc -l <<< "scale=2; $RANDOM/32767"
}

unicode_unescape() {
    full_string="$@"
    full_string="$(echo "$full_string" | sed -E "s/(u[0-9a-fA-F]{4})/\\\\\1/g" | sed -E "s/\\\+/\\\/g")"
    perl -CSD -pe 's/\\u(\X{4})/chr(oct("0x$1"))/ge' <<< "$full_string"
}
