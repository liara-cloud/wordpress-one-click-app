FROM wordpress:5-php7.2-apache

RUN curl -fsSL 'https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz' -o ioncube.tar.gz \
  && mkdir -p /tmp/ioncube \
  && tar -xvvzf ioncube.tar.gz \
  && mv ioncube/ioncube_loader_lin_7.2.so `php-config --extension-dir` \
  && rm -Rf ioncube.tar.gz ioncube \
  && docker-php-ext-enable ioncube_loader_lin_7.2 \
  && apt-get update && apt-get install -y --no-install-recommends libxml2-dev libxml2 libicu57 \
  && docker-php-ext-install soap

ENV PHP_INI_CONFIG=""

COPY wrapper-entrypoint.sh /usr/local/bin/

CMD ["/usr/local/bin/wrapper-entrypoint.sh"]
