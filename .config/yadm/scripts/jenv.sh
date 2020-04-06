#!/bin/sh

if ! command -v jenv > /dev/null 2>&1; then
    brew install jenv
fi

jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-12.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-13.jdk/Contents/Home

jenv enable-plugin export