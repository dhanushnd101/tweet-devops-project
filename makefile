start:
	aws ec2 start-instances --instance-id 

stop:
	aws ec2 stop-instances --instance-id

github: 
	git add .
	git commit -m "removing the unwanted files"
#git push origin main

tplan:
	terraform plan
tapply:
	terraform apply
tdes:
	terraform destroy 

login:
	ssh -i /Users/dhanushdinesh/Downloads/DevOpsProjectKey.pem ec2-user@54.197.211.18

.PHONY: github, start, stop, login, tplan, tapply, tdes