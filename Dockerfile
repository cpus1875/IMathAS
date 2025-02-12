FROM php:7.4-apache

# 安装必要的 PHP 扩展和依赖
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo_mysql mbstring gettext zip curl opcache

# 启用 Apache mod_rewrite
RUN a2enmod rewrite

# 设置工作目录
WORKDIR /var/www/html

# 克隆 IMathAS 源代码
RUN git clone https://github.com/dlippman/imathas.git .

# 暴露端口
EXPOSE 80

# 启动 Apache
CMD ["apache2-foreground"]
