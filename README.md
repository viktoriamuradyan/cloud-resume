# Cloud Resume Challenge  

This project is part of the **[Cloud Resume Challenge](https://cloudresumechallenge.dev/)**, where I build and deploy a resume as a cloud-based static website while learning cloud technologies.  

## 🚀 Project Overview  

This repository tracks my progress as I complete the Cloud Resume Challenge step by step, implementing both frontend and backend components using AWS services.  

---

## ✅ Completed Chunks  

### 🏗️ **Chunk 1: Building the Frontend**  
✔ **HTML & CSS** – Created a structured and styled resume.  
✔ **Static Hosting** – Deployed as an **Amazon S3 static website**.  
✔ **HTTPS & Custom Domain** – Secured with **CloudFront** and linked to a **custom domain** via **Route 53**.  

---

### ⚙️ **Chunk 2: Building the API**  
📌 **Database (DynamoDB)** – A NoSQL database stores and updates the **visitor count**.  
📌 **API (API Gateway + Lambda)** – A serverless API is built to handle visitor count updates, ensuring secure and efficient communication with DynamoDB.  
📌 **Python (boto3)** – The Lambda function is written in **Python**, using the **boto3** library to interact with AWS services.  

---

### 🔗 **Chunk 3: Frontend / Backend Integration**  
📌 **JavaScript (AJAX / Fetch API)** – JavaScript is used to fetch visitor count data from the API and display it on the resume site.  
📌 **Live Data Display** – The visitor counter dynamically updates on the homepage.  

---

## 🔜 Next Steps  

- [ ] **Infrastructure as Code (IaC) with Terraform**  
- [ ] **GitHub Actions for CI/CD automation**  
- [ ] **Additional optimizations & testing**  
 
## 🌍 Live Demo  

Check out my live resume: [https://viktoriamuradyan.com](https://viktoriamuradyan.com)

