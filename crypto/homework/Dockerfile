FROM sagemath/sagemath:latest

USER root

RUN apt-get update && \
        apt-get -y upgrade && \
        apt-get install -y \
                xinetd \
                iproute2

COPY --chown=root:sage ./build/start.sh /home/sage/start.sh
COPY --chown=root:sage ./src/problem.sage /home/sage/problem.sage
COPY --chown=root:sage ./src/elliptic_curve.py /home/sage/elliptic_curve.py
COPY --chown=root:sage ./src/secret.py /home/sage/secret.py
COPY --chown=root:root ./build/ctf.conf /etc/xinetd.d/ctf

WORKDIR /home/sage

RUN chmod 555 ./start.sh && \
    chmod 444 /etc/xinetd.d/ctf

USER sage
EXPOSE 27182

CMD ["xinetd", "-dontfork", "-f","/etc/xinetd.d/ctf"]
