# Etapa 1: Build do frontend (React no Laravel)
FROM node:18 AS build-frontend

WORKDIR /app

COPY package*.json  ./

RUN npm install

COPY ./ ./

RUN npm run build


# Etapa 2: Configuração do Laravel com PHP 8.3
FROM php:8.3.15-fpm-alpine3.21 AS build-backend

# Instalar dependências do sistema necessárias para o Laravel
RUN apk update && apk add --no-cache \
    bash \
    libpng-dev \
    libzip-dev \
    oniguruma-dev \
    curl \
    zip \
    unzip \
    git \
    nginx \
    && docker-php-ext-install \
    pdo_mysql \
    mbstring \
    zip \
    bcmath \
    opcache 
   

# Instalar o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

COPY ./ ./

# RUN php artisan config:cache
# RUN php artisan route:cache
# RUN php artisan view:cache
# RUN php artisan storage:link

# Copiar arquivos do Laravel e instalar dependências
RUN composer install --optimize-autoloader --no-dev

COPY --from=build-frontend /app/public ./public

# Copiar o arquivo de configuração do Nginx
COPY docker/config/nginx.conf /etc/nginx/nginx.conf

# Configurar permissões
RUN chown -R www-data:www-data ./storage
RUN chmod -R 775 ./storage

EXPOSE 80

CMD ["sh", "-c", "php artisan migrate & php-fpm & nginx -g 'daemon off;'"]
