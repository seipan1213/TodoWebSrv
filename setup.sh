
#!/bin/sh

# ローカル用環境ファイル
cp ./myapp/.env.local ./myapp/.env

# ログファイル用書き込み権限変更
chmod -R 777 ./myapp/storage

# Dockerイメージビルド
docker-compose build --no-cache
# npmの導入
docker-compose run --rm --no-deps node npm ci
# Dockerコンテナ起動
docker-compose up -d
# Dockerイメージビルド後のコンテナ内での処理
docker-compose run --rm --no-deps app composer install
docker-compose run --rm --no-deps app php artisan key:generate

# 管理画面系初回処理
#docker-compose run --rm --no-deps app php artisan vendor:publish --provider="Encore\Admin\AdminServiceProvider"
#docker-compose run --rm --no-deps app composer dump-autoload

#docker-compose run --rm app php artisan admin:install
#docker-compose run --rm app php artisan migrate --seed
#docker-compose run --rm app php artisan storage:link