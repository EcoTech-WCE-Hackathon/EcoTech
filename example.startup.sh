export AWS_SECRET_ACCESS_KEY=
export AWS_SECRET_ACCESS_KEY_ID=
export DJANGO_SECRET_KEY=
export AWS_S3_BUCKET_NAME=
export PROD=

python manage.py makemigrations
python manage.py migrate
python manage.py runserver