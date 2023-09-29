terraform {
  backend "s3" {
    bucket         = "my-test-bucket-augustine"
    key            = "terraform-state-files/terraform-state"
    region         = "eu-west-3"
    dynamodb_table = "terraform-lock"
  }
}
