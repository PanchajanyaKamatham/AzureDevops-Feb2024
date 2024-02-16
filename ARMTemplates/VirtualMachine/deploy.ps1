#Login-AzAccount

New-AzResourceGroup -Name "arm-group" -Location "eastus"

New-AzResourceGroupDeployment -ResourceGroupName "arm-group" -TemplateFile ./template.json -TemplateParameterFile ./parameters.json -Verbose