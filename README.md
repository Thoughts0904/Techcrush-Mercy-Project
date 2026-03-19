Project 4: Automated Azure Infrastructure & IAM Governance
Overview
This project demonstrates the automated deployment of a secure, multi-tier cloud environment in Microsoft Azure. The primary focus is on Infrastructure as Code (IaC), Network Segmentation, and Identity & Access Management (IAM) using Role-Based Access Control (RBAC).
Project Objectives
  Automation: Deploying resources using Bash scripts (az CLI) and GitHub Actions.
  Security: Implementing a 3-tier VNet architecture with isolated subnets.
  Governance: Managing access through Azure AD (Entra ID) Groups and scoped RBAC roles.
  Sustainability: Automating resource cleanup to manage cloud costs.
Technical Architecture
1. Network Design
The core of the infrastructure is the TechCrushVnet, segmented into two logical tiers:
 Web Subnet (10.0.1.0/24): Designated for public-facing web services.
 Database Subnet (10.0.2.0/24): A high-security zone for backend data, isolated from direct public internet access.
2. Identity & Access Management (RBAC)
Following the Principle of Least Privilege, access is managed via Security Groups:
 WebAdmins: Authorized for web-tier management.
 DBAdmins: Assigned the Reader role, scoped strictly to the DB Subnet to prevent unauthorized lateral movement across the network.
Script Breakdown
deploy.sh — The Infrastructure Builder
This script automates the creation of the Resource Group, Virtual Network, Subnets, and Security Groups. It uses Command Substitution to dynamically retrieve Object IDs for role assignments.
cleanup.sh — The Resource Janitor
A cost-management tool that performs a complete decommissioning of the environment.
  Uses the --no-wait flag for asynchronous deletion.
  Uses the --yes flag to bypass manual confirmation prompts.
.github/workflows/main.yml — The CI/CD Orchestrator
This workflow implements Continuous Integration by triggering a deployment check on every git push.
 Environment: Runs on a temporary ubuntu-latest virtual runner.
 Security: Utilizes GitHub Secrets (AZURE_CREDENTIALS) to securely authenticate with the Azure API without exposing sensitive keys in the source code.
Key Challenges & Resolutions
Challenge 1: Tenant Permission Restrictions
Observation: The GitHub Actions "Service Principal" was blocked from performing automated role assignments.
Resolution: Identified that the University tenant policy restricts Microsoft.Authorization/roleAssignments/write permissions. Resolved by using a Hybrid Deployment approach—verifying the code logic in GitHub while validating the security permissions manually in the Azure Portal.
 Challenge 2: Authentication Security
Observation: Basic password authentication was insufficient for pushing local script changes to the remote GitHub repository.
Resolution: Implemented Personal Access Tokens (PAT) to establish a secure, encrypted connection between the Azure Cloud Shell environment and GitHub, bypassing traditional credential vulnerabilities.
Challenge 3: Resource Cost Management
Observation: Leaving a 3-tier cloud architecture running 24/7 would quickly deplete the student credit quota.
 Resolution: Developed a comprehensive cleanup.sh script for a "zero-footprint" exit and utilized Azure’s Auto-shutdown feature to ensure resources are deallocated during non-working hours.
How to Run
Clone the Repository:
git clone https://github.com/[Your-Username]/[Repo-Name].git
Make Scripts Executable:
chmod +x deploy.sh cleanup.sh
Execute Deployment:
./deploy.sh
