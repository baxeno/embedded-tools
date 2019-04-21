FROM fedora:29
LABEL maintainer="Bruno Thomsen <bruno.thomsen@gmail.com>"

ARG IMAGE_VERSION=0.0.0
ARG IMAGE_NAME=unspecified
ARG BUILD_DATE=unspecified
ARG GIT_COMMIT=unspecified
ARG GIT_REMOTE=unspecified

LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name=$IMAGE_NAME
LABEL org.label-schema.description="CI build and development environment for embedded Linux products"
LABEL org.label-schema.vcs-url=$GIT_REMOTE
LABEL org.label-schema.vcs-ref=$GIT_COMMIT
LABEL org.label-schema.vendor="Baxeno Technologies"
LABEL org.label-schema.version=$IMAGE_VERSION

# ptxdist 2018.12.0 requires python2
RUN dnf install -y \
    autoconf \
    automake \
    bc \
    bison \
    bison-devel \
    bzip2 \
    cmake \
    dialog \
    figlet \
    file \
    findutils \
    flex \
    flex-devel \
    gcc \
    gcc-c++ \
    gettext \
    git \
    java \
    libcurl-devel \
    libtool \
    libxslt \
    make \
    nano \
    ncurses-devel \
    openssl-devel \
    patch \
    perl-XML-Parser \
    procps-ng \
    python2 \
    python3-Cython \
    python3-devel \
    python3-matplotlib \
    python3-mock \
    python3-nose \
    python3-requests \
    python3-pycryptodomex \
    python3-pyOpenSSL \
    python3-PyYAML \
    qt5-qtbase-devel \
    qt5-qtserialport-devel \
    ShellCheck \
    strace \
    sphinx \
    sqlite-devel \
    texinfo \
    tree \
    unzip \
    vim-common \
    wget \
    which \
    xz \
    zip \
      && \
    dnf clean all

# ptxdist 2018.12.0 for OSELAS.Toolchain() 2018.12.0
# hadolint ignore=DL3003
RUN git clone git://git.pengutronix.de/git/ptxdist.git \
      && \
    cd ptxdist \
      && \
    git checkout ptxdist-2018.12.0 \
      && \
    ./autogen.sh \
      && \
    ./configure \
      && \
    make \
      && \
    make install \
      && \
    make clean \
      && \
    git checkout ptxdist-2019.04.0 \
      && \
    ./autogen.sh \
      && \
    ./configure \
      && \
    make \
      && \
    make install \
      && \
    make clean \
      && \
    cd .. \
      && \
    rm -rf ptxdist

# Setup developer user with default Fedora first user UID/GID.
# IDs will normally be overridden by entrypoint script.
RUN groupadd -r developer --gid=1000 \
      && \
    useradd -m --no-log-init --uid=1000 --home-dir=/home/developer --shell=/bin/bash -r -g developer developer \
      && \
    mkdir -p /home/developer/git \
      && \
    mkdir -p /home/developer/.gradle \
      && \
    mkdir -p /home/developer/.m2 \
      && \
    chown -R developer.developer /home/developer

# hadolint ignore=DL3003
RUN git clone -b master https://github.com/ncopa/su-exec.git \
      && \
    cd su-exec \
      && \
    make \
      && \
    cp su-exec /usr/bin/ \
      && \
    cd .. \
      && \
    rm -rf su-exec

RUN echo 'export PS1="[\e[1;34m\]DOCKER\[\e[0;37m\]][\u@\h \W]$ "' >> /home/developer/.bash_profile

ENV TERM xterm-256color
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
