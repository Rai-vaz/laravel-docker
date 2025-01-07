# Etapa 2: Configuração do Laravel com PHP 8.3
FROM php:8.3.15-fpm-alpine3.21 AS build-backend

WORKDIR /app

# Instalar dependências do sistema necessárias para o Laravel
RUN apk add --no-cache \
    bash \
    libpng-dev \
    libzip-dev \
    oniguruma-dev \
    curl \
    zip \
    unzip \
    git \
    && docker-php-ext-install \
    pdo_mysql \
    mbstring \
    zip \
    bcmath \
    opcache

# Instalar o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app

COPY . /app

# RUN php artisan config:cache
# RUN php artisan route:cache
# RUN php artisan view:cache
# RUN php artisan storage:link

# Copiar arquivos do Laravel e instalar dependências
RUN composer install --optimize-autoloader --no-dev

# Etapa 1: Build do frontend (React no Laravel)
FROM node:18

RUN npm install

RUN npm run build


# Etapa 3: Preparação do servidor com Nginx
FROM nginx:stable-alpine AS production

# Copiar arquivos do Laravel
COPY --from=build-backend /app /usr/share/nginx/html/app

# Copiar o arquivo de configuração do Nginx
COPY docker/config/nginx.conf /etc/nginx/nginx.conf

# Configurar permissões
# RUN chown -R www-data:www-data /app/storage /app/bootstrap/cache

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
