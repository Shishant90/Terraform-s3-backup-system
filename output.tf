output "bucket_name" {
  value = aws_s3_bucket.backup_bucket.bucket
}
output "iam_user_name" {
  value = aws_iam_user.backup_user.name
}
output "access_key" {
  value = aws_iam_user.backup_user.name
}
output "secret_key" {
  value = aws_iam_access_key.backup_access_key.secret
  sensitive = true
}