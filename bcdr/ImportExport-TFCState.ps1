param(
    [Parameter(Mandatory=$true)]
    [string]$action,

    [Parameter(Mandatory=$true)]
    [string]$fileName

)

#Define the storage account detail where the Terraform State files will be exported.
$storageAccountName = "werttfyu6867tuyh"
$saResourceGroup = "tfbackup"
$containerName = "tfbackup"


Try{
    Write-Host "Checking the storage account" -ForegroundColor Green
    $storageAccount = Get-AzStorageAccount -ResourceGroupName $saResourceGroup -Name $storageAccountName
    Write-Host "Setting the storage context" -ForegroundColor Green
    $storageCtx = $storageAccount.Context
} Catch {
    Write-Host "ERROR: Unable to find/access Storage Account." -ForegroundColor Red
    Write-Host "Terraform State Backup Not Taken. Please check manually" -ForegroundColor Red
}

IF ($action -eq 'Upload'){
    Write-Host "Uploading the state file to storage account" -ForegroundColor Green
    $uploadStateFile = Set-AzStorageBlobContent -Container $containerName -File $fileName -Context $storageCtx -Force
    IF(!$uploadStateFile){
        Write-Host "ERROR: Failed to export latest Terraform State File to the Storage Account" -ForegroundColor Red
        Write-Host "Please re-run the pipeline or try uploading manually" -ForegroundColor Red
    }

} ELSEIF ($action -eq 'Download'){
    Write-Host "Downloading the state file from storage account" -ForegroundColor Green
    $dowloadStateFile = Get-AzStorageBlobContent -Container $containerName -Blob $fileName -Destination $fileName -Context $storageCtx
    IF(!$dowloadStateFile ){
        Write-Host "ERROR: Failed to import latest Terraform State File from the Storage Account" -ForegroundColor Red
        Write-Host "Please confirm if the file exists in the storage and re-run the pipeline again" -ForegroundColor Red
    }

} ELSE {
    Write-Host "Incorrect Action Chosen" -ForegroundColor Red
}