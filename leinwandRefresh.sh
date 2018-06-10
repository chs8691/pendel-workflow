#!/bin/bash
username=$(grep -Po "(?<=^host-username ).*" credentials)
refreshcode=$(grep -Po "(?<=^refreshcode ).*" credentials)
chromium-browser http://earls5.menkent.uberspace.de/pendel/leinwand/?refreshcode=$refreshcode

