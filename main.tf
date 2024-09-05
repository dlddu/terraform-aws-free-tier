variable "account_alias" {
  type = string
}

resource "aws_iam_account_alias" "this" {
  account_alias = var.account_alias
}

variable "budget_description" {
  type = string
}

variable "monthly_cost_limit_in_usd" {
  type    = number
  default = 0.6
}

variable "subscriber_email_address" {
  type = string
}

resource "aws_budgets_budget" "this" {
  name              = var.budget_description
  budget_type       = "COST"
  limit_amount      = var.monthly_cost_limit_in_usd
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2024-01-01_00:00"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [var.subscriber_email_address]
  }
}
