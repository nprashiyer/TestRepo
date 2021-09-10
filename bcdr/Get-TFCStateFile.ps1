param(
    [Parameter(Mandatory=$true)]
    [string]$tfcOrganization,

    [Parameter(Mandatory=$true)]
    [string]$workspaceName,

    [Parameter(Mandatory=$true)]
    [string]$TOKEN
)

#Set the headers for API requests
$bearer = "Bearer " + $TOKEN
$headers = @{
    'Authorization' = $bearer
    'Content-Type' = 'application/vnd.api+json'
}


# This function returns the workspace ID from workspace name
function Get-WorkspaceId {
    param(
        [Parameter(Mandatory)]
        [string]$WSName        
    )

    $uri = "https://app.terraform.io/api/v2/organizations/" + $tfcOrganization + "/workspaces/" + $WSName
    Try{
        Write-Host "Retrieving the Workspace ID of Workspace $WSName" -ForegroundColor Green
        $currentWS = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
        Write-Host "Success: Retrieved the workspace ID" -ForegroundColor Green
        return $currentWS.data.id
    } Catch {
        Write-Host "ERROR: Provided workspace Name or organization name is incorrect or doesnt exist. Please Check" -ForegroundColor Red
        Write-Host $_.ErrorDetails -ForegroundColor Red
    }
    
}


# Download the latest state version
$wsID = Get-WorkspaceId -WSName $workspaceName

Try {
    $uri = "https://app.terraform.io/api/v2/workspaces/"+ $wsID + "/current-state-version"
    Write-Host "`nDownloading the latest state version of Workspace $workspaceName" -ForegroundColor Green
    $currentState = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
    Write-Host "Success: Downloaded the workspace ID" -ForegroundColor Green
    $downloadUrl = $currentState.data.attributes.'hosted-state-download-url'
    $outfileName = $workspaceName + ".tfstate"
    $download = Invoke-WebRequest -Uri $downloadUrl -OutFile $outfileName

} Catch {
    Write-Host "ERROR: Failed to download the state version file. Please Check" -ForegroundColor Red
    Write-Host $_.ErrorDetails -ForegroundColor Red

}
