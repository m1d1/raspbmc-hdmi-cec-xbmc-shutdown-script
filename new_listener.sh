#!/bin/bash
pgrep cec-client | xargs kill
pgrep cec_listener | xargs kill
/usr/local/bin/cec_listener.sh


