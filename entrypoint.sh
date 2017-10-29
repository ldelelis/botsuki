#!/usr/bin/env sh

cp config-sample.yaml config.yaml
sed -i 's/tsample/'"$TOKEN"'/; s/psample/'"$PREFIX"'/; s/rsample/'"$TROLE"'/' config.yaml
./botsuki.rb
