FROM php:8.1-apache

# 启用 Apache mod_rewrite
RUN a2enmod rewrite

# 安装 PHP 扩展
RUN docker-php-ext-install pdo pdo_mysql gettext

# 安装 GD 扩展
RUN apt-get update && \
    apt-get install -y libfreetype6-dev libjpeg-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# 安装 Zip 扩展
RUN apt-get install -y libzip-dev zip \
    && docker-php-ext-install zip

# 移除不必要的软件包
RUN apt-get purge -y javascript-common

# 设置工作目录
WORKDIR /var/www/html

# 克隆 IMathAS 源代码
COPY . /var/www/html

# 暴露端口
EXPOSE 80

# 启动 Apache
CMD ["apache2-foreground"]
