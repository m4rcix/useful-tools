#!/bin/bash

#
# Switch to workspace left, right, up, or down from current for
# workspaces arranged in `$num_rows' rows and `$num_cols'
# columns. Wraps around within the current row for left and right and
# within the current column for up and down.
#
# Usage: switch-workspace (left|right|up|down)
#

# Configuration
num_rows=2 ;
num_cols=2 ;

# Workspaces are numbered 0 .. $num_rows*$num_cols-1.

current=$( wmctrl -d | grep "*" | cut -d ' ' -f 1 ) ;

row=$(( $current / $num_cols )) ;
col=$(( $current % $num_cols )) ;

case $1 in
  left)
    col=$(( ( $col + $num_cols - 1 ) % $num_cols )) ;
  ;;
  right)
    col=$(( ( $col + 1 ) % $num_cols )) ;
  ;;
  up)
    row=$(( ( $row + $num_rows - 1 ) % $num_rows )) ;
  ;;
  down)
    row=$(( ( $row + 1 ) % $num_rows )) ;
  ;;
esac ;

wmctrl -s $(( $row * $num_cols + $col )) ;