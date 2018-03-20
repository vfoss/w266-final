#!/bin/sh
sudo apt install transmission-cli
mkdir -p data
cd data

#From https://meta.wikimedia.org/wiki/Data_dump_torrents
wget http://itorrents.org/torrent/D567CE8E2EC4792A99197FB61DEAEBD70ADD97C0.torrent

tmpfile=$(mktemp)
chmod a+x $tmpfile
echo "killall transmission-cli" > $tmpfile

transmission-cli -f $tmpfile -w . D567CE8E2EC4792A99197FB61DEAEBD70ADD97C0.torrent

bunzip2 -v enwiki-20170820-pages-articles.xml.bz2
