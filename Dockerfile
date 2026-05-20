FROM php:8.2-fpm

WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    curl \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev

# Install PHP extensions
RUN docker-php-ext-install \
    pdo_mysql \
    bcmath \
    mbstring \
    exif \
    pcntl \
    zip

# Latest release
COPY --from=composer/composer:latest-bin /composer /usr/bin/composer

# Copy the composer files 
COPY composer.json composer.lock ./

# Install the dependencies
RUN composer install --no-dev --no-scripts --no-autoloader

# Copy the application code to container
COPY . .

# Give permissions
RUN chmod -R 777 storage bootstrap/cache

# Run as non-root
USER www-data

# Expose port 8000 to run in local env
EXPOSE 8000

CMD [ "php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]