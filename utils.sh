#! /bin/bash

AUTOSSH_POLL=5
function get_open_port()
{
	return $(awk 'BEGIN { srand(); do r = rand()*32000; while ( r < 20000 ); printf("%d\n",r)  }' < /dev/null)
}
