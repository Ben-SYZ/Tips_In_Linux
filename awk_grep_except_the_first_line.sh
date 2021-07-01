#!/bin/sh
var="$*"
lsof -i|awk -v pattern="$var" '
NR==1 {print $0};
NR>=1 && $0 ~ pattern {print $0}'

# <script src="https://gist.github.com/BenSYZ/a643b3ce05d65cfe8e6437f38bf59ae5.js"></script>
