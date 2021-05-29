From php:7.4.0-apache

# Install PHP Extenstion
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
  install-php-extensions bcmath ctype curl dom gd hash iconv intl mbstring openssl pdo_mysql simplexml soap xsl zip sockets

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=2.0.14

# Enable apache modules
RUN a2enmod filter.load headers.load include.load log_forensic.load log_debug.load mime_magic.load negotiation.load proxy.load \
 proxy_fcgi.load proxy_http.load proxy_wstunnel.load rewrite.load setenvif.load \
  slotmem_shm.load socache_dbm.load socache_shmcb.load unique_id.load userdir.load \
  ssl.load status.load expires.load dir.load deflate.load autoindex.load authz_user.load authz_host.load \
   authz_groupfile.load authz_core.load authn_file.load authn_core.load auth_basic.load alias.load actions.load \
   access_compat.load cgi.load access_compat.load

# Copy custom php.ini file
COPY php.ini /usr/local/etc/php/

# Copy custom apache configuration file in site-available and enable it.
COPY magento.conf /etc/apache2/sites-available/
RUN a2dissite 000-default.conf && a2ensite magento.conf && a2enmod rewrite
RUN apachectl -t

# Creat new user called magento you can give any name, and add into www-data group.
RUN useradd magento -s /bin/bash -d /var/www/html/ && \
    usermod -a -G www-data magento && chown magento:www-data /var/www/html/
