# 버킷 생성
resource "aws_s3_bucket" "cccr2_upload" {
  bucket        = "aws-cccr2-nyeong-upload" # 버킷 이름
  force_destroy = true                      # 버킷 지울 때 객체도 같이 지워짐

  tags = {
    Name = "aws-cccr2-nyeong-upload"
  }
}

# 퍼블릭 액세스 차단 설정
resource "aws_s3_bucket_public_access_block" "cccr2_upload_block" {
  bucket = aws_s3_bucket.cccr2_upload.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 접근을 위한 역할 생성
resource "aws_iam_role" "cccr2_role_web" {
  name        = "cccr2-role-web"
  description = "upload image"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# 역할에 지정될 정책 연결
resource "aws_iam_role_policy_attachment" "cccr2_s3_policy_attach" {
  role       = aws_iam_role.cccr2_role_web.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# 역할에 대한 프로파일 생성
resource "aws_iam_instance_profile" "cccr2_instance_profile_web" {
  name = "cccr2.instance.profile-web"
  role = aws_iam_role.cccr2_role_web.name
}