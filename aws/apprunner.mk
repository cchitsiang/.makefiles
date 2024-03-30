get-apprunner-service:
	aws apprunner describe-service --region ap-southeast-1 --service-arn arn:aws:apprunner:ap-southeast-1:${AWS_ACCOUNT_ID}:service/$(SERVICE_NAME)