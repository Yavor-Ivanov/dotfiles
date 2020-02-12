#!/bin/bash

tunnel_server=tunnel.yavor-ivanov.net
requested_subdomain="$1"

subdomain_switch=""
if [ ! -z "$requested_subdomain" ]; then
	subdomain_switch="-s $requested_subdomain"
fi

lt $subdomain_switch -h "http://$tunnel_server"
