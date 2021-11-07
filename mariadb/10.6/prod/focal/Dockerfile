FROM mariadb:10.6.0-focal

ENV PATH=/root/bin:$PATH

RUN true \
    && mkdir /home/mysql \
    && chown mysql:mysql /home/mysql

COPY _common/prod/focal/profile.d/ /etc/profile.d/