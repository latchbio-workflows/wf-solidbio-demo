# DO NOT CHANGE
FROM 812206152185.dkr.ecr.us-west-2.amazonaws.com/latch-base:fe0b-main
# FROM 812206152185.dkr.ecr.us-west-2.amazonaws.com/latch-base-cuda:fe0b-main
# Use this base image for workflows that have GPU tasks, this provides GPU drivers and libraries

WORKDIR /tmp/docker-build/work/

SHELL [ \
    "/usr/bin/env", "bash", \
    "-o", "errexit", \
    "-o", "pipefail", \
    "-o", "nounset", \
    "-o", "verbose", \
    "-o", "errtrace", \
    "-O", "inherit_errexit", \
    "-O", "shift_verbose", \
    "-c" \
]
ENV TZ='Etc/UTC'
ENV LANG='en_US.UTF-8'

ARG DEBIAN_FRONTEND=noninteractive

# Can include install commands here
RUN pip install pandas

# Latch SDK
# DO NOT REMOVE
RUN pip install latch==2.55.2
RUN mkdir /opt/latch

# Copy workflow data (use .dockerignore to skip files)
COPY . /root/

# Latch workflow registration metadata
# DO NOT CHANGE
ARG tag

# DO NOT CHANGE
ENV FLYTE_INTERNAL_IMAGE $tag

WORKDIR /root
