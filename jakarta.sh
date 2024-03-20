#!/bin/bash
# Copyright 2024 Piotr Morgwai Kotarbinski, Licensed under the Apache License, Version 2.0
if [[ -n "$(git status --porcelain)" ]]; then
	echo "repository not clean, exiting..." >&2;
	exit 1;
fi;

cd servlet-scopes;
releaseMessage="$( git log -1 --oneline --pretty=%B )";
if ! grep -E '^release [[:digit:]]+\.[[:digit:]]+-javax' <<< "${releaseMessage}" >/dev/null; then
	echo "HEAD is not a javax release commit" >&2 ;
	exit 1 ;
fi;
jakartaVersion="$( <<< "${releaseMessage}" sed -e 's#release ##' -e 's#javax#jakarta#' )";
cd ..;

sed -E -e 's#(\t*).*<!--jakarta:(.*)-->#\1\2#' \
	-e 's#(.*)javax(.*)<!--jakarta-->#\1jakarta\2#' \
	<pom.xml >pom.jakarta.xml &&
mv pom.jakarta.xml pom.xml &&

cd servlet-scopes &&
git checkout "v${jakartaVersion}" &&
cd .. &&
find src/main -name '*.java' | while read file; do
  sed -e 's#javax.servlet#jakarta.servlet#g' \
    -e 's#javax.websocket#jakarta.websocket#g' \
    -e 's#javax.annotation#jakarta.annotation#g' \
    -e 's#org.eclipse.jetty.websocket.javax#org.eclipse.jetty.websocket.jakarta#g' \
    -e 's#JavaxWebSocket#JakartaWebSocket#g' \
    <"${file}" >"${file}.jakarta" &&
  mv "${file}.jakarta" "${file}";
done &&
find src/test/java/pl/morgwai/base/servlet/guice/scopes/connectionproxy/tyrus -name '*.java' | while read file; do
  sed -e 's#javax.servlet#jakarta.servlet#g' \
    -e 's#javax.websocket#jakarta.websocket#g' \
    -e 's#javax.annotation#jakarta.annotation#g' \
    -e 's#org.eclipse.jetty.websocket.javax#org.eclipse.jetty.websocket.jakarta#g' \
    -e 's#JavaxWebSocket#JakartaWebSocket#g' \
    <"${file}" >"${file}.jakarta" &&
  mv "${file}.jakarta" "${file}";
done
