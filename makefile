github: 
	git add .
	git commit -m "Added a helm deployment jenkins file "
	git push origin main

start:
	aws ec2 start-instances --instance-id i-07539f75f94b10c9e
	aws ec2 start-instances --instance-id i-0a1e83924e3f488e5
#aws ec2 start-instances --instance-id i-01925d6ae694f4d7d

stop:
#Maven
	aws ec2 stop-instances --instance-id i-07539f75f94b10c9e 
#Jenkins
	aws ec2 stop-instances --instance-id i-0a1e83924e3f488e5
#Ansible
	aws ec2 stop-instances --instance-id i-01925d6ae694f4d7d

tplan:
	terraform plan
tapply:
	terraform apply
tdes:
	terraform destroy 

ans:
	ssh -i /Users/dhanushdinesh/Downloads/DevOpsProjectKey.pem ubuntu@54.152.59.165

jen:
	ssh -i /Users/dhanushdinesh/Downloads/DevOpsProjectKey.pem ubuntu@107.20.125.33
	#523aea3a7f43428680c837a69acb6c97

mvn:
	ssh -i /Users/dhanushdinesh/Downloads/DevOpsProjectKey.pem ubuntu@34.207.135.149

.PHONY: github, start, stop, ans, tplan, tapply, tdes, jen, mvn