#!/bin/bash
mkdir /znc-data/configs
cp /tmp/znc.conf /znc-data/configs/
cp /tmp/znc.pem /znc-data/
znc -f -d /znc-data
