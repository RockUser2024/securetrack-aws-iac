resource "aws_ecr_repository" "php_repo" {
  name = "securetrack-php-repo"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "securetrack-php-repo"
  }
}

