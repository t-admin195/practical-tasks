#!/bin/bash
#run an echo-server on port 1234
socat TCP-LISTEN:1234,reuseaddr,fork EXEC:/bin/cat

