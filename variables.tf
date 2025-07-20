variable "aws_region" {
  description = "AWS region to deploy resources"
  type = string
  default = "eu-north-1"
}
variable "bucket_prefix" {
  description = "Prefix foe unique s3 bucket name"
  type = string
  default = "shishant"
}
variable "iam_user_name" {
  description = "IAM user name for s3 bucket name"
  type = string
  default = "s3-backup-user"
}
variable "backup_schedule" {
  description = "Cron expression for daily bakups"
  type = string
  default = "0 2 * * *" # Daily at 2 am 
}