#!/bin/bash

vgaMonitor='DP-2-3'
dviMonitor='DP-2-2'
notebookMonitor='eDP-1'

vgaMonitorModeName='DELL_P2210f'
vgaMonitorMode="\"$vgaMonitorModeName\""'  132.75  1680 1776 1952 2224  1050 1053 1059 1086 -hsync +vsync'

if [ -n "`xrandr --listactivemonitors | grep "$vgaMonitor"`" ]; then
	vgaMonCon=1
	xrandr --newmode $vgaMonitorMode
	xrandr --addmode "$vgaMonitor" "$vgaMonitorModeName"
	xrandr --output "$vgaMonitor" --mode "$vgaMonitorModeName"
else
	vgaMonCon=0
fi

if [ -n "`xrandr --listactivemonitors | grep "$dviMonitor"`" ]; then
	dviMonCon=1
else
	dviMonCon=0
fi

if [ -n "`xrandr --listactivemonitors | grep "$notebookMonitor"`" ]; then
	nbMonCon=1
else
	nbMonCon=0
fi

if [ $vgaMonCon -eq 1 ] && [ $dviMonCon -eq 1 ] && [ $nbMonCon -eq 1 ]; then
	xrandr --output "$notebookMonitor" --right-of "$dviMonitor"
	xrandr --output "$dviMonitor" --right-of "$vgaMonitor" --primary
	xrandr --output "$vgaMonitor" --left-of "$dviMonitor"
elif [ $vgaMonCon -eq 1 ] && [ $dviMonCon -eq 1 ] && [ $nbMonCon -eq 0 ]; then
	xrandr --output "$dviMonitor" --right-of "$vgaMonitor" --primary
	xrandr --output "$vgaMonitor" --left-of "$dviMonitor"
elif [ $vgaMonCon -eq 0 ] && [ $dviMonCon -eq 1 ] && [ $nbMonCon -eq 1 ]; then
	xrandr --output "$notebookMonitor" --right-of "$dviMonitor"
	xrandr --output "$dviMonitor" --primary
elif [ $vgaMonCon -eq 1 ] && [ $dviMonCon -eq 0 ] && [ $nbMonCon -eq 1 ]; then
	xrandr --output "$notebookMonitor" --right-of "$vgaMonitor"
	xrandr --output "$vgaMonitor" --primary	
fi
