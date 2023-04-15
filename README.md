# Welcome to my Cloud Resume ☁️🙋‍ 
# Visit the website at https://yjbae.com


# Explanation of creation: 
I first created the backend infrastructure on AWS with Terraform. Using Infrastructure-as-Code is much more efficient instead of building the backend on the AWS console.
![Screenshot_01](https://user-images.githubusercontent.com/109190196/229940541-424e6458-ee4d-49b4-b7cb-a3e01526579d.jpg)

Within my Terraform code I bootstrapped my EC2 instances created by my Auto Scaling Group. Within my user data is a bash script that installs Apache, the efs utils, and WordPress. From there I migrated my WordPress files to be held in EFS and migrated the data from MariaDB into AWS RDS (MySQL Engine). 

With the use of AWS Certificate Manager, I created a new validated certificate. I also created new DNS records (A & CNAME) to make WordPress use my own custom domain. Then I implemented HTTPS protocol with my valid SSL certificate.  
![Screenshot_5](https://user-images.githubusercontent.com/109190196/230819125-5887927a-329d-46d3-af15-5317165e8927.jpg)

# The section below source code is available here: https://github.com/yoojin93/CloudResume_Frontend
Once my barebones WordPress site was up and running, it was time to design! Before I started to design, I created a Jenkins pipeline with a webhook that would push my github repo files into an S3 bucket whenever change was detected in my repo. With the use of the AWS CLI, the only files that were uploaded to the S3 buckets were any new or modified files. Any files that were the same and already stored in my S3 bucket did not get uploaded to save space and costs. I used the plugin "Simply Static" to generate a static version of my wordpress site which got automatically pushed to my github repo.
![Screenshot_22](https://user-images.githubusercontent.com/109190196/232249159-d70f1e81-9e27-4594-8ffb-9787d009a2f9.jpg)
![Screenshot_11](https://user-images.githubusercontent.com/109190196/232249162-5b6704db-177f-4b40-ba3b-593e9304ab91.jpg)

With the use of Elementor, I designed and updated my website. Anytime I updated my website, I generated a new static version of my site. My first website design was okay, but it didn't feel like "me", so I tore my site down and rebuilt it with more personality.

1st version:
![Screenshot_12](https://user-images.githubusercontent.com/109190196/232249377-b2a77377-0d5c-480b-8858-5bb7c53147ab.jpg)
2nd version:
![Screenshot_13](https://user-images.githubusercontent.com/109190196/232249408-11d480a7-f9a8-48a5-8af0-f4cd2d3eca50.jpg)

# The section below source code is available here: https://github.com/yoojin93/website-visitor-counter
After my site was complete from a design perspective, I needed to do the last part of the challenge, implementing a website counter. I used DynamoDB, API Gateway, and Lambda for the backend of this website counter. With the use of Terraform, I provisioned the needed AWS resources by code. 
![Screenshot_1](https://user-images.githubusercontent.com/109190196/232249656-5ecbc7f8-d0df-4331-9ee8-874a37158292.jpg)

I implemented a GitHub Actions pipeline to automatically test my API & lambda function with the use of PyTest.
![Screenshot_10](https://user-images.githubusercontent.com/109190196/232249720-1831b3cd-11f4-47c1-8548-2cf65241d313.jpg)

With the use of the WordPress plugin "WPCode Lite", I inserted a JavaScript code into the footer of my WordPress's HTML code.
![Screenshot_8](https://user-images.githubusercontent.com/109190196/232249757-f05a6875-b89e-40a2-a6b6-0fc6f29ea5ec.jpg)

By using "console.log(data);" in my JavaScript code, I was able to use my web browsers developers tool to ensure that the JSON data was being received properly.  
![Screenshot_23](https://user-images.githubusercontent.com/109190196/232249863-a2ff0540-45ce-4927-8c19-d8b97c8de27e.jpg)

I checked my DynamoDB table to see if it was working as intended with the viewer count matching both in the table & the website.
![Screenshot_9](https://user-images.githubusercontent.com/109190196/232249931-7af63cbd-cd17-4b4b-81b7-9c0011be7676.jpg)

I utilized Postman to test my REST API and website to ensure everything was working properly before completely opening my website to the public.
![Screenshot_14](https://user-images.githubusercontent.com/109190196/232250419-2922da72-ce74-4b5c-8de9-beb1db8b93df.jpg)

# Now my website it up and running and open to the public: https://yjbae.com
