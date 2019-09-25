FROM ubuntu:latest
WORKDIR /luademo/src
LABEL maintainer="Niroshan R nirocr _at_ gmail . com"
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
