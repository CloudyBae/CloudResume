# Welcome to my Cloud Resume ☁️🙋‍ 
# Visit the website at https://yjbae.com


# Explanation of creation: 
I first created the backend infrastructure on AWS with Terraform. Using Infrastructure-as-Code is much more efficient instead of building the backend on the AWS console.
![Screenshot_01](https://user-images.githubusercontent.com/109190196/229940541-424e6458-ee4d-49b4-b7cb-a3e01526579d.jpg)

Within my Terraform code I bootstrapped my EC2 instances created by my Auto Scaling Group. Within my user data is a bash script that installs Apache, the efs utils, and WordPress. From there I migrated my WordPress files to be held in EFS and migrated the data from MariaDB into AWS RDS (MySQL Engine). 

With the use of AWS Certificate Manager, I created a new validated certificate. I also created new DNS records (A & CNAME) to make WordPress use my own custom domain. Then I implemented HTTPS protocol with my valid SSL certificate.  
![Screenshot_5](https://user-images.githubusercontent.com/109190196/230819125-5887927a-329d-46d3-af15-5317165e8927.jpg)

# The section below source code is available here: github.com/yoojin93/CloudResume_Frontend
Once my barebones WordPress site was up and running, it was time to design! Before I started to design, I created a Jenkins pipeline with a webhook that would push my github repo files into an S3 bucket whenever change was detected in my repo. With the use of the AWS CLI, the only files that were uploaded to the S3 buckets were any new or modified files. Any files that were the same and already stored in my S3 bucket did not get uploaded to save space and costs. I used the plugin "Simply Static" to generate a static version of my wordpress site which got automatically pushed to my github repo.
![Screenshot_22](https://user-images.githubusercontent.com/109190196/232249159-d70f1e81-9e27-4594-8ffb-9787d009a2f9.jpg)
![Screenshot_11](https://user-images.githubusercontent.com/109190196/232249162-5b6704db-177f-4b40-ba3b-593e9304ab91.jpg)

With the use of Elementor, I designed and updated my website. Anytime I updated my website, I generated a new static version of my site. My first website design was okay, but it didn't feel like "me", so I tore my site down and rebuilt it with more personality.
1st version:
![Screenshot_12](https://user-images.githubusercontent.com/109190196/232249377-b2a77377-0d5c-480b-8858-5bb7c53147ab.jpg)
2nd version:
![Screenshot_13](https://user-images.githubusercontent.com/109190196/232249408-11d480a7-f9a8-48a5-8af0-f4cd2d3eca50.jpg)


