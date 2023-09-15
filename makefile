start:
	aws ec2 start-instances --instance-id i-07539f75f94b10c9e
	aws ec2 start-instances --instance-id i-0a1e83924e3f488e5
	aws ec2 start-instances --instance-id i-01925d6ae694f4d7d

stop:
	aws ec2 stop-instances --instance-id i-07539f75f94b10c9e
	aws ec2 stop-instances --instance-id i-0a1e83924e3f488e5
	aws ec2 stop-instances --instance-id i-01925d6ae694f4d7d

github: 
	git add .
	git commit -m "add setup-maven.yaml to configure maven server"
	git push origin main

tplan:
	terraform plan
tapply:
	terraform apply
tdes:
	terraform destroy 

login:
	ssh -i /Users/dhanushdinesh/Downloads/DevOpsProjectKey.pem ubuntu@54.158.9.67

jen:
	ssh -i /Users/dhanushdinesh/Downloads/DevOpsProjectKey.pem ubuntu@54.196.158.177
	#523aea3a7f43428680c837a69acb6c97

mvn:
	ssh -i /Users/dhanushdinesh/Downloads/DevOpsProjectKey.pem ubuntu@34.226.198.246

.PHONY: github, start, stop, login, tplan, tapply, tdes, jen, mvn