#!/bin/bash
# Get Monier Williams downloadable dictionary
if [ ! -f mwall.txt ]; then
    if [ ! -d xml ]; then
        if [ ! -f mwxml.zip ]; then
        curl -O https://www.sanskrit-lexicon.uni-koeln.de/scans/MWScan/2020/downloads/mwxml.zip
        fi
        unzip mwxml.zip
    fi
    # Extract all non-spurious words
    grep -v '\<ls>L.</ls>' xml/mw.xml | grep '\<ls>' | perl -lne 'print "$1" if m|.*key1>(.*)\<\/key1.*|' | sort | uniq > mwall.txt
fi
if [ ! -f mw.txt -o data/aux.txt -nt mw.txt ]; then
    perl -lne 'print $1 if /(.*?)\s+\#/' data/aux.txt > mwaux.txt
    perl -lpe 'y/KGCJWQTDPBwqRYNMSzfFxX/kgcjwqtdpbtdnnnnssrrrr/; s/A/aa/g; s/I/ii/g; s/U/uu/g; s/E/ai/g' mwall.txt mwaux.txt | sort | uniq > mw.txt
fi
scripts/prove.pl $@
