
ssh bururu
```bash
for f in database/migrations/*car_pool*.php; do php artisan migrate --force --path="$f"; done
```
