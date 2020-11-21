ARG THE_PHP_VERSION

FROM wordpress:5.5-php${THE_PHP_VERSION}-apache

ARG THE_PHP_VERSION

RUN curl -fsSL 'https://www.sourceguardian.com/loaders/download/loaders.linux-x86_64.tar.gz' -o sourceguardian.tar.gz \
  && mkdir -p /tmp/sourceguardian \
  && tar -xvvzf sourceguardian.tar.gz -C /tmp/sourceguardian \
  && mv /tmp/sourceguardian/ixed.${THE_PHP_VERSION}.lin `php-config --extension-dir` \
  && rm -Rf sourceguardian.tar.gz /tmp/sourceguardian \
  && docker-php-ext-enable ixed.${THE_PHP_VERSION}.lin \
  && curl -fsSL 'https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz' -o ioncube.tar.gz \
  && tar -xvvzf ioncube.tar.gz -C /tmp \
  && mv /tmp/ioncube/ioncube_loader_lin_${THE_PHP_VERSION}.so `php-config --extension-dir` \
  && rm -Rf ioncube.tar.gz /tmp/ioncube \
  && docker-php-ext-enable ioncube_loader_lin_${THE_PHP_VERSION} \
  && apt-get update && apt-get install -y --no-install-recommends vim nano git curl wget zip unzip libxml2-dev libxml2 libicu63 \
  && docker-php-ext-install soap \
  && pecl install redis && docker-php-ext-enable redis \
  && ln -sf /run/liara_php.ini /usr/local/etc/php/conf.d/liara_php.ini \
  && echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf \
  && a2enconf servername

ENV PHP_INI_CONFIG=""

COPY wrapper-entrypoint.sh /usr/local/bin/

CMD ["/usr/local/bin/wrapper-entrypoint.sh"]
