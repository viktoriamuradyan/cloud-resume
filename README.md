# Cloud Resume Challenge

This repository documents my progress on the Cloud Resume Challenge. The goal is to build a cloud-hosted resume with a visitor counter, using AWS services, Python, and infrastructure as code with Terraform.

---

## Chunk 1: Building the Front End ✅ Done

In this part, I focused on building and deploying my cloud-hosted resume.

### Steps completed:

- **HTML Resume**: Created a fully web-ready resume in HTML.  
- **CSS Styling**: Added basic styling to make the resume visually appealing.  
- **Deployed to S3**: Uploaded HTML and CSS files to an Amazon S3 bucket configured for static website hosting.  
- **Enabled HTTPS**: Configured CloudFront for HTTPS access to the site.  
- **Custom Domain**: Pointed `www.viktoriamuradyan.com` to the CloudFront distribution using Route 53.

**Result:**  
My resume is live and accessible at [www.viktoriamuradyan.com](https://www.viktoriamuradyan.com).

---

## Chunk 2: Building the API ✅ Done

This chunk focused on the backend “visitor counter” API and database.

### Steps completed:

- **Database (DynamoDB)**: Created a table to store the visitor count.  
- **API (API Gateway + Lambda)**: Built a serverless API using AWS API Gateway and Lambda to handle visitor count requests.  
- **Python Lambda**: Wrote Python code using the `boto3` library to interact with DynamoDB.  
- **Source Control (GitHub)**: Stored backend code in a dedicated GitHub repository for version control.

**Result:**  
Visitor counter API is ready to be connected to the front end.

---

## Chunk 3: Front-end / Back-end Integration ✅ Done

This chunk integrated the front-end resume site with the backend API.

### Steps completed:

- **JavaScript Integration**: Added JS code to the HTML resume to fetch visitor count from the API.  
- **Visitor Counter Display**: Successfully shows the number of visitors on the homepage.  
- **Basic Tests**: Wrote simple tests for Python code to ensure the API works correctly.

**Result:**  
Front end and backend are connected, and the visitor counter works.

---

## Chunk 4: Automation / CI ⚙️ In Progress

This chunk focuses on automation and infrastructure as code.

### Steps completed:

- **Infrastructure as Code (Terraform)**:  
  - Defined AWS resources (S3, CloudFront, DynamoDB, Lambda, API Gateway) using Terraform.  
  - Automated deployment of resources via Terraform scripts.  
  

### Steps remaining:

- **CI/CD for Backend**: Configure GitHub Actions to run Python tests and deploy Lambda/API updates automatically.  
- **CI/CD for Frontend**: Configure GitHub Actions to automatically deploy updates to the S3 bucket and invalidate CloudFront cache when frontend code changes.  

**Result:**  
Terraform infrastructure is ready. CI/CD pipelines are yet to be implemented.

---

## Summary

**Completed:**  

- Front-end creation and deployment (HTML/CSS, S3, CloudFront, custom domain)  
- Backend API (Lambda, API Gateway, DynamoDB)  
- Front-end / Back-end integration (visitor counter)  
- Infrastructure as code setup with Terraform  

**Remaining:**  

- Full CI/CD pipelines for frontend and backend deployments  

---

**Live Resume:** [www.viktoriamuradyan.com](https://www.viktoriamuradyan.com)
