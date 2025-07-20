resource "random_id" "suffix" {
  byte_length = 4
}

#create s3 bucket using terraform registry-style clean syntax
resource "aws_s3_bucket" "backup_bucket" {
  bucket = "${var.bucket_prefix}-backup-${random_id.suffix.hex}"
  force_destroy = true

  tags={
    Name = "Daily S3 backup"
    Environment = "Production"
  }
}
#IAM user for backup access 
resource "aws_iam_user" "backup_user" {
  name = var.iam_user_name
  tags = {
    Project = "S3 Backup"
  }
}
resource "aws_iam_policy" "backup_policy" {
  name   = "S3BackupPolicy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
         "${aws_s3_bucket.backup_bucket.arn}",
          "${aws_s3_bucket.backup_bucket.arn}/*"
        ]
      }
    ]
  })
}

#Attach policy to IAM user
resource "aws_iam_user_policy_attachment" "backup_user_attach" {
  user = aws_iam_user.backup_user.name
  policy_arn = aws_iam_policy.backup_policy.arn
}
#Access keys for the backup user
resource "aws_iam_access_key" "backup_access_key" {
  user = aws_iam_user.backup_user.name
}