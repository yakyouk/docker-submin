FROM debian:jessie
MAINTAINER thaim <thaim24@gmail.com>

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
       unzip \
       python \
       subversion \
       python-subversion \
       apache2 \
       libapache2-svn \
       sendmail \
       curl \
       sqlite3 \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN curl --insecure -fSL "https://github.com/mjholtkamp/submin/archive/master.zip" -o master.zip \
    && unzip master.zip -d /opt/ \
    && rm master.zip \
    && cd /opt/submin-master \
    && python setup.py install \
    && cd / \
    && rm -rf /opt/submin-master

RUN usermod -u 1000 www-data

COPY docker-entrypoint.sh /

EXPOSE 80
ENTRYPOINT ["/docker-entrypoint.sh"]

#CMD ["submin"]
