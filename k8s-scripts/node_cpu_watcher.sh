#!/bin/bash
#
# This one-liner outputs the busiest k8s nodes by cpu.

watch 'kubectl top nodes | sort -r -k 4'