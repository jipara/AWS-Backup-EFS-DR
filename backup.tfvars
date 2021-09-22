vault_name = "efs-backup-1"
vault_kms_key_arn = "arn:aws:kms:us-east-1:776141728174:key/63593a03-80bc-406e-9bff-9fc4ef2c8d22"
tags = {
    name = "eks-with-terraform"
    environment = "prod"
  }
plan_name = "efs-with-terraform"
rule_name = "efs-with-terraform"
rule_schedule = "cron(0 * * * ? *)"
rule_start_window = "60"
rule_completion_window = "120"
rule_copy_action_destination_vault_arn = "arn:aws:backups:us-west-1:718499835735:backup-vault:efs-backup-destination"
selection_resources = ["arn:aws:elasticfilesystem:us-west-1:776141728174:file-system/fs-463b39f2"]
