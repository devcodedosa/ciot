#!/bin/sh

WSL_EXPORT_PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

export PATH=$WSL_EXPORT_PATH

echo "Set WSL PATH & build OpenWRT full....."
make all
echo "OpenWRT full build done....."
