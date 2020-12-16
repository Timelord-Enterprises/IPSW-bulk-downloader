#!/bin/bash
# Ask the user for Released version of iOS
#©copyright Jan Vancoppenolle, Timelord Enterprises
# A tool to bulk download user defined versions of iOS, iPadOS and tvOS
#change to desktop and create a download folder
cd Desktop
mkdir IPSW_Downloads
cd IPSW_Downloads
echo -e ""
echo -e ""
#Ask server for available IPSW files
#
#layout
set -e
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m' # No Color
#
#layout
# Ask the user for Released version of iOS
echo -e "${YELLOW}      What iOS version has been released?${NC}"
#
read VersionNumber
#Ask server for available IPSW files
echo -e ""
echo -e "${RED}      Querying server for available iOS $VersionNumber downloads...${NC}"
echo -e ""
curl http://ax.phobos.apple.com.edgesuite.net/WebObjects/MZStore.woa/wa/com.apple.jingle.appserver.client.MZITunesClientCheck/version | grep ipsw | grep $VersionNumber | sort -u | sed 's/<string>//g' | sed 's/<\/string>//g' | grep -v protected | awk '{$1=$1}1' >IPSW.txt
#
# Wget is not installed by default on certain operating systems Like macOS --> Use cURL instead
# wget -i IPSW.txt
echo -e ""
echo -e "${RED} Query complete,this download will be a 100GB+${NC}"
echo -e "${GREEN} Parsing...${NC}"
echo -e ""
echo -e "${RED}      Downloading all $VersionNumber IPSW...${NC}"
echo -e ""
#
#option to have a progress bar instead of data
#xargs -n 1 curl -O --progress-bar < IPSW.txt
#Download from file
xargs -n 1 curl -O <IPSW.txt
#
echo -e "${GREEN}      Download complete!${NC}"
echo -e "${RED}      Thanks for using IPSW downloader${NC}"
#
exit 

test


