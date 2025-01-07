docker build -t app-laravel .

docker run -d --name aplicacao-laravel -p 8090:80 app-laravel

docker exec -it aplicacao-laravel sh