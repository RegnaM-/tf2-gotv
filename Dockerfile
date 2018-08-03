FROM ubuntu:16.04
MAINTAINER Max Gonzih <gonzih at gmail dot com>

ENV USER tf2
ENV HOME /home/$USER
ENV SERVER $HOME/hlserver

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install lib32gcc1 curl net-tools lib32stdc++6 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && useradd $USER \
    && mkdir $HOME \
    && chown $USER:$USER $HOME \
    && mkdir $SERVER

ADD ./tf2_ds.txt $SERVER/tf2_ds.txt
ADD ./update.sh $SERVER/update.sh
ADD ./tf2.sh $SERVER/tf2.sh

RUN chown -R $USER:$USER $SERVER

USER $USER
RUN curl http://media.steampowered.com/client/steamcmd_linux.tar.gz | tar -C $SERVER -xvz \
 && $SERVER/update.sh

WORKDIR /home/$USER/hlserver
CMD ["./tf2.sh"]
