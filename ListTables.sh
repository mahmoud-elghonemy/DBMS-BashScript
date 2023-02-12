#!/bin/bash

# description: List Tables    
    echo "Tables names: "
    ls -p | grep -v !*.Mdata | grep -v /