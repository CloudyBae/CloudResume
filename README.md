# Welcome to my Cloud Resume ☁️🙋‍ 
# Visit the website at https://yjbae.com


# Explanation of creation: 
I first created the backend infrastructure on AWS with Terraform. Using Infrastructure-as-Code is much more efficient instead of building the backend on the AWS console.
![Screenshot_01](https://user-images.githubusercontent.com/109190196/229940541-424e6458-ee4d-49b4-b7cb-a3e01526579d.jpg)

Within my Terraform code I bootstrapped my EC2 instances created by my Auto Scaling Group. Within my user data is a bash script that installs Nginx, the efs utils, and WordPress. From there I configred my WordPress files to be held in EFS and the data to be help in AWS RDS with a MySQL engine.  
