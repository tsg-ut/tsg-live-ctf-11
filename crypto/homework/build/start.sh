#!/bin/sh

cd /home/sage
timeout --foreground -s 9 60s stdbuf -i0 -o0 -e0 sage problem.sage
