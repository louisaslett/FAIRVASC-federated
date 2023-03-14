FROM ghcr.io/graalvm/graalvm-ce:ol8-java17-22.3.1-b1

LABEL org.opencontainers.image.source=https://github.com/louisaslett/FAIRVASC-federated

RUN gu install nodejs \
    && curl -s -S --fail --location --max-redirs 3 https://repo1.maven.org/maven2/org/apache/jena/jena-fuseki-server/4.4.0/jena-fuseki-server-4.4.0.jar --output jena-fuseki-server-4.4.0.jar \
    && adduser -M fuseki

USER fuseki

EXPOSE 3030

ENTRYPOINT ["java", "-jar", "jena-fuseki-server-4.4.0.jar"]
CMD []
