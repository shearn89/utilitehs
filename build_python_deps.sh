#!/bin/bash

if [[ -z $1 ]]
then
  echo "Must provide package list"
  exit 1
fi

if ! [[ -f $1 ]]
then
  echo "Argument is not a file"
  exit 1
fi

infile=$1

while read pkg
do
  echo "Checking ${pkg}..."
  if [[ -z $(find . -name "python-${pkg}-[0-9]*.rpm") ]]
  then
    echo "file not found, creating..."
    fpm -s python -t rpm $pkg
  else
    echo "file found, adding dependencies..."
    rpm -qRp python-${pkg}*.rpm | grep python | awk {'print $1'} | cut -b 8- >> $infile
    sort -u -o $infile $infile
  fi
done < $infile
