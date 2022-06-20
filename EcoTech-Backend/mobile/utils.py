from server.settings import (
    AWS_S3_BUCKET_NAME,
    AWS_SECRET_ACCESS_KEY,
    AWS_SECRET_ACCESS_KEY_ID,
)
import boto3


session = boto3.Session(
    aws_access_key_id=AWS_SECRET_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
)

s3 = session.resource("s3")


def upload_image_to_s3(image, name, extension):
    object = s3.Object(AWS_S3_BUCKET_NAME, name + "." + extension)
    object.put(Body=(image))
