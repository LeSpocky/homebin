#!/bin/bash
set -o pipefail

if qdbus6 org.kde.LogoutPrompt /LogoutPrompt | grep -q promptAll
then
    qdbus6 org.kde.LogoutPrompt /LogoutPrompt promptAll
else
    qdbus6 org.kde.LogoutPrompt /LogoutPrompt promptShutDown
fi
