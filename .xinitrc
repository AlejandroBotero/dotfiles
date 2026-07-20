#!/bin/sh

if [ -f ~/.xprofile ]; then
  . ~/.xprofile
fi

exec i3
