#!/usr/bin/env sh

cp config-sample.yaml config.yaml
sed -i 's/tsample/'"$TOKEN"'/; s/psample/'"$PREFIX"'/' config.yaml
./botsuki.rb
