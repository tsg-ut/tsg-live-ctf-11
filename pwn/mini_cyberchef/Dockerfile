FROM amd64/ubuntu:22.04


RUN apt-get update && \
        apt-get -y upgrade && \
        apt-get install -y \
                xinetd \
                iproute2

RUN groupadd -r user && useradd -r -g user user

COPY --chown=root:user ./build/start.sh /home/user/start.sh
COPY --chown=root:user ./build/flag /home/user/flag
COPY --chown=root:user ./dist/mini_cyberchef /home/user/mini_cyberchef
COPY --chown=root:root ./build/ctf.conf /etc/xinetd.d/ctf

WORKDIR /home/user

RUN chmod 444 ./flag && \
    chmod 555 ./mini_cyberchef && \
    chmod 555 ./start.sh && \
    chmod 444 /etc/xinetd.d/ctf

USER user
EXPOSE 30005

CMD ["xinetd", "-dontfork", "-f","/etc/xinetd.d/ctf"]
