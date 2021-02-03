FROM alpine:3.13

COPY requirements.txt requirements.txt
RUN apk add --no-cache --update bash python3 py3-pip openjdk11-jre && \
    python3 -m pip install --upgrade --ignore-installed --no-cache-dir -r requirements.txt

COPY docs /docs
RUN adduser --uid 2004 --disabled-password --gecos "" docker
COPY target/universal/stage/ /workdir/
RUN chmod +x /workdir/bin/codacy-bandit
USER docker
WORKDIR /workdir
ENTRYPOINT ["bin/codacy-bandit"]
