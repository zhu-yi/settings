#!/bin/bash

DEBUG=0
RESET="\033[0m"
DIM="\033[2m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"

function info()   { echo -e "INFO:  $@"; }
function infon()  { echo -en "INFO:  $@"; }
function warn()   { echo -e ${YELLOW}"WARN:  $@"${RESET} >&2; }
function error()  { echo -e ${RED}"ERROR: $@"${RESET} >&2; }
function debug()  { [[ $DEBUG -eq 1 ]] && echo -e ${DIM}"DEBUG: $@"${RESET}; }
function red()    { echo -e ${RED}"$@"${RESET}; }
function green()  { echo -e ${GREEN}"$@"${RESET}; }
function yellow() { echo -e ${YELLOW}"$@"${RESET}; }
#function result() { ([[ $? -eq 0 ]] && green "succeed") || (red "failed"); }

