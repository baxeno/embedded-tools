#!/bin/bash

set -e # Exit script if any statement returns a non-true value.
set -u # Exit script if using an uninitialized variable.

company="ACME"
product="Explosive Tennis Balls"

figlet -w 60 -k -c "${company}"
figlet -- ----------
figlet -w 60 -c -f slant "${product}"

