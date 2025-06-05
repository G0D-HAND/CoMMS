# Use official PHP image with Apache
FROM php:8.1-apache

# Install system dependencies and PHP extensions for Flarum
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    && docker-php-ext-install pdo pdo_mysql zip mbstring xml curl gd

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory to Apache root
WORKDIR /var/www/html

# Copy your Flarum app files to the container
COPY . .

# Set permissions for storage and cache directories
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]

