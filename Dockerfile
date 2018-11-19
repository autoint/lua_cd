FROM ubuntu:artful
WORKDIR /luademo/src
LABEL maintainer="Niroshan Rajadurai ncr _at_ moat . blog"
ENV lua_verision  master

# install essential packages for building other packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
		curl \
		wget \
		build-essential \
		make \
		gcc \
		mingw-w64 \
		libreadline-dev \
		ca-certificates \
		unzip \
		libssl-dev \
		git \
		sudo \
--no-install-recommends && rm -r /var/lib/apt/lists/*

RUN mkdir /opt/work
WORKDIR /opt/work

RUN git clone https://github.com/nirocr/lua_demo.git

WORKDIR /opt/work/lua_demo

RUN test -f makefile && grep -v "# -pedantic" makefile > makefile2 && mv makefile2 makefile

RUN make
