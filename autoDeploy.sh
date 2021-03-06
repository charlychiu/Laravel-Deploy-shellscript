git clone $1 $2

cd $2

# Install/update composer dependecies
composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev

cp .env.example .env

# config setting to production usage
sed -i "" 's/APP_ENV=local/APP_ENV=production/g' .env
sed -i "" 's/APP_DEBUG=true/APP_DEBUG=false/g' .env
sed -i "" 's/DB_DATABASE=homestead/DB_DATABASE='$3'/g' .env
sed -i "" 's/DB_USERNAME=homestead/DB_USERNAME='$4'/g' .env
sed -i "" 's/DB_PASSWORD=secret/DB_PASSWORD='$5'/g' .env

# generate application key
php artisan key:generate

# Run database migrations
php artisan migrate --force --seed

# Install node modules
npm install

# Build assets using Laravel Mix
npm run production