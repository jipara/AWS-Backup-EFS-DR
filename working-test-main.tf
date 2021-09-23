terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.59.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"


  # assume_role {
  #   role_arn = var.assume_role_arn
  #   external_id = var.external_id
  # }
}




resource "aws_backup_vault" "vault-souce" {
  name        = "testing-with-tf"
  kms_key_arn = "arn:aws:kms:us-east-1:888888888:key/mrk-82d874865c0148ea97a64635767c08ca"
}

resource "aws_backup_plan" "EFS-to-DR" {
  name = "EFS-to-DR"

  rule {
    rule_name         = "tf_efs_backup_rule"
    target_vault_name = "EFS-Backup"
    schedule          = "cron(0 12 * * ? *)"
    copy_action {
      destination_vault_arn = "arn:aws:backup:us-west-1:88888888888:backup-vault:efs-backup-destination"
    }
  }
}
resource "aws_backup_selection" "example" {
  iam_role_arn = "arn:aws:iam::9999999999999:role/aws-service-role/backup.amazonaws.com/AWSServiceRoleForBackup"
  name         = "AWSServiceRoleForBackup"
  plan_id      = aws_backup_plan.EFS-to-DR.id

  resources = [
    "arn:aws:elasticfilesystem:us-east-1:9999:file-system/fs-463b39f2"
  ]
}

