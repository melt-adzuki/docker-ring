FROM ubuntu:20.04

LABEL Name=ring \
      Version=1.0 \
      Description="The Ring Programming Language"

ARG username=ring

ENV DEBIAN_FRONTEND noninteractive

RUN echo keyboard-configuration keyboard-configuration/layout select 'English (US)' | debconf-set-selections && \
    echo keyboard-configuration keyboard-configuration/layoutcode select 'us' | debconf-set-selections

RUN apt-get update && apt-get install -y --no-install-recommends wget unzip sudo ca-certificates tzdata

RUN adduser --disabled-password --gecos "" ${username} && \
    echo "${username}:${username}" | chpasswd && \
    echo "${username} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/${username} && \
    chmod 0440 /etc/sudoers.d/${username}

WORKDIR /tmp
RUN wget -q https://versaweb.dl.sourceforge.net/project/ring-lang/Ring%201.16/Fayed_Ring_1.16_Ubuntu.zip
RUN unzip Fayed_Ring_1.16_Ubuntu.zip ring/* -d /home/${username}/

WORKDIR /home/${username}/ring/language/src
RUN sed -i -e "s/sudo apt-get install/sudo apt-get install -y/g" ./installdep.sh
RUN ./installdep.sh

WORKDIR /home/${username}/ring/bin
RUN ./install.sh

RUN rm -r /tmp/Fayed_Ring_1.16_Ubuntu.zip && apt-get clean
ENV DEBIAN_FRONTEND newt

WORKDIR /home/${username}
RUN chown -R ${username}:${username} ./ring/
USER ${username}

CMD ringpm run ringnotepad
