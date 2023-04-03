FROM mariadb:10.11.0-jammy

ENV PATH=/root/bin:$PATH

RUN true \
    && mkdir /home/mysql \
    && chown mysql:mysql /home/mysql

COPY _common/prod/focal/profile.d/ /etc/profile.d/