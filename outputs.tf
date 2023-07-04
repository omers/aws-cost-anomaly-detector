output "sns_arn" {
  value = aws_sns_topic.cost_anomaly_updates.arn
}