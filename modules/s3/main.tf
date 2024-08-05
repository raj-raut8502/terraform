resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.my_bucket.id}/*"
    }
  ]
}
EOF
}
