FROM alpine:latest

LABEL maintainer="almeidass.leonardo@gmail.com"

ARG JMETER_VERSION="5.4.1"
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN ${JMETER_HOME}/bin
ENV JMETER_PLUGINS ${JMETER_HOME}/lib/ext
ENV JMETER_DOWNLOAD_URL https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_PLUGINS_DOWNLOAD_URL https://jmeter-plugins.org/files/packages

ARG TZ="America/Sao_Paulo"
ENV TZ ${TZ}
RUN apk update \
    && apk upgrade \
    && apk add ca-certificates \
    && update-ca-certificates \
    && apk add --update openjdk8-jre tzdata curl unzip bash \
    && apk add --no-cache nss \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /tmp/dependencies  \
    && curl -L --silent ${JMETER_DOWNLOAD_URL} > /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz \
    && curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/jpgc-casutg-2.9.zip > /tmp/dependencies/jpgc-casutg-2.9.zip \
    && curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/bzm-random-csv-0.7.zip > /tmp/dependencies/bzm-random-csv-0.7.zip \
    && mkdir -p /opt \
    && tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt \
    && unzip /tmp/dependencies/jpgc-casutg-2.9.zip -d ${JMETER_HOME} \
    && unzip /tmp/dependencies/bzm-random-csv-0.7.zip -d ${JMETER_HOME} \
    && rm -rf /tmp/dependencies

ENV PATH $PATH:$JMETER_BIN

# Entrypoint has same signature as "jmeter" command
COPY entrypoint.sh /

WORKDIR	${JMETER_HOME}

ENTRYPOINT ["/entrypoint.sh"]