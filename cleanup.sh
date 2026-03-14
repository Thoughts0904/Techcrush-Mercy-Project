#!/bin/bash
RESOURCE_GROUP="MyResourceGroup"

echo "Revoking access and deleting resources..."

# 1. Delete the AD Groups (This revokes the roles automatically)
az ad group delete --group "WebAdmins"
az ad group delete --group "DBAdmins"

# 2. Delete the Resource Group (This deletes the VNet and Subnets)
az group delete --name $RESOURCE_GROUP --yes --no-wait

echo "Cleanup initiated successfully."