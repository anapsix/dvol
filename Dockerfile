FROM        alpine:3.3

WORKDIR     /app
ADD         setup.py README.md /app/
ADD         voluminous/* /app/voluminous/

# Last build date - this can be updated whenever there are security updates so
# that everything is rebuilt
#ENV         security_updates_as_of 2016-01-04

# Install security updates and required packages
RUN         apk upgrade --update && \
            apk add openssl openssl-dev ca-certificates curl yaml yaml-dev python python-dev py-pip libffi libffi-dev g++ tar && \
            pip install twisted service_identity pycrypto pyrsistent pyyaml==3.10 && \
            pip install docker-py && \
            python setup.py install && \
            apk del openssl-dev ca-certificates curl yaml-dev python-dev libffi-dev g++ tar

CMD         ["dvol-docker-plugin"]
VOLUME      ["/var/lib/dvol"]
