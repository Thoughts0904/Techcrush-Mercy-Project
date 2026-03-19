#!/bin/bash

# 1. Variables
RESOURCE_GROUP="MyResourceGroup"
LOCATION="westus"
VNET_NAME="TechCrushVnet"

echo "Starting deployment for Project 4..."

# 2. Create Resource Group 
az group create --name $RESOURCE_GROUP --location $LOCATION

# 3. Create VNet and Web Subnet
az network vnet create \
  --name $VNET_NAME \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --address-prefix 10.0.0.0/16 \
  --subnet-name WebSubnet \
  --subnet-prefix 10.0.1.0/24

# 4. Create DB Subnet
az network vnet subnet create \
  --address-prefix 10.0.2.0/24 \
  --name DBSubnet \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $VNET_NAME

# 5. Create AD Groups
az ad group create --display-name "WebAdmins" --mail-nickname "WebAdmins"
az ad group create --display-name "DBAdmins" --mail-nickname "DBAdmins"

# 6. Role Assignment (Task 3)
echo "Assigning Reader role to DBAdmins..."
#DB_ID=$(az network vnet subnet show --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --name DBSubnet --query id --output tsv)
#GROUP_ID=$(az ad group show --group "DBAdmins" --query id --output tsv)

HEAD
#az role assignment create --assignee $GROUP_ID --role "Reader" --scope $DB_ID

# az role assignment create --assignee $GROUP_ID --role "Reader" --scope $DB_ID
05984976b1379cfa3305449d06919fff32fd75f0

# 7. Add current user as a test user (Task 4)
#MY_ID=$(az ad signed-in-user show --query id --output tsv)
#az ad group member add --group "WebAdmins" --member-id $MY_ID

echo "Deployment Complete! Validate using: az role assignment list --scope $DB_ID --output table"
