resource "aws_s3_bucket" "augustine-bucket" {
  bucket = "my-test-bucket-augustine"

  tags = {
    Name        = "my-test-bucket-augustine"

  }
}