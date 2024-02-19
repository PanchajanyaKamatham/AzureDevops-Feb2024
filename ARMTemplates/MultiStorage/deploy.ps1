#Login-AzAccount

New-AzResourceGroup -Name "arm-group" -Location "eastus"

New-AzResourceGroupDeployment -ResourceGroupName "arm-group" -TemplateFile ./storage.template.json -TemplateParameterFile ./storage.parameters.json -Verbose