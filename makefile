start:
	aws ec2 start-instances --instance-id 

stop:
	aws ec2 stop-instances --instance-id

github: 
	git add .
	git commit -m "added VPC, subnets, gw, rout-table"
	git push origin main

tplan:
	terraform plan
tapply:
	terraform apply
tdes:
	terraform destroy 

login:
	ssh -i /Users/dhanushdinesh/Downloads/DevOpsProjectKey.pem ec2-user@54.227.9.234

.PHONY: github, start, stop, login, tplan, tapply, tdes