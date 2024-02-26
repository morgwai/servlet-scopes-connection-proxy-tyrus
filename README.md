# Tyrus connection proxy for Servlet and Websocket Guice Scopes

An extension for [servlet-scopes](https://github.com/morgwai/servlet-scopes) lib, that provides unified, websocket API compliant access to clustered websocket connections and properties: [getOpenSessions()](https://javadoc.io/static/jakarta.websocket/jakarta.websocket-api/2.0.0/jakarta/websocket/Session.html#getOpenSessions--) will return the sum of both local and remote connections from other nodes (ie sum of Sets returned by [TyrusSession.getOpenSessions()](https://eclipse-ee4j.github.io/tyrus-project.github.io/apidocs/latest20x/org/glassfish/tyrus/core/TyrusSession.html#getOpenSessions()) and [TyrusSession.getRemoteSessions](https://eclipse-ee4j.github.io/tyrus-project.github.io/apidocs/latest20x/org/glassfish/tyrus/core/TyrusSession.html#getRemoteSessions())), while [getUserProperties()](https://javadoc.io/static/jakarta.websocket/jakarta.websocket-api/2.0.0/jakarta/websocket/Session.html#getUserProperties--) will return [TyrusSession.getDistributedProperties()](https://eclipse-ee4j.github.io/tyrus-project.github.io/apidocs/latest20x/org/glassfish/tyrus/core/TyrusSession.html#getDistributedProperties()). This means that **all stored properties should be `Serializable`** or else nothing will be transferred between nodes.<br/>
Copyright 2024 Piotr Morgwai Kotarbinski, Licensed under the Apache License, Version 2.0<br/>
<br/>
**latest release: 15.0**<br/>
[javax flavor](https://search.maven.org/artifact/pl.morgwai.base/servlet-scopes-connection-proxy-tyrus/15.0-javax/jar)
([javadoc](https://javadoc.io/doc/pl.morgwai.base/servlet-scopes-connection-proxy-tyrus/15.0-javax))<br/>
[jakarta flavor](https://search.maven.org/artifact/pl.morgwai.base/servlet-scopes-connection-proxy-tyrus/15.0-jakarta/jar)
([javadoc](https://javadoc.io/doc/pl.morgwai.base/servlet-scopes-connection-proxy-tyrus/15.0-jakarta))



## USAGE

Simply add [servlet-scopes-connection-proxy-tyrus.jar](https://search.maven.org/artifact/pl.morgwai.base/servlet-scopes-connection-proxy-tyrus/) to your runtime classpath and everything will happen automagically thanks to the SPI mechanism.<br>
Note: the **major** version of the jar should match the one of `servlet-scopes`.
