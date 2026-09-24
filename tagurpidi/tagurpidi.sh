#!/bin/bash
# Skript väljastab oma lähtekoodi tagurpidi

cat "$0" | tac | rev
