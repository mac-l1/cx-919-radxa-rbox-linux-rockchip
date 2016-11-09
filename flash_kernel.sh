#!/bin/bash
set -x 

sudo upgrade_tool di -k `pwd`/kernel.img
sudo upgrade_tool rd
