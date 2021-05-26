$fld = "C:\temp\"
New-Item -Path $fld -ItemType Directory
cd $fld 
$uri = "https://raw.githubusercontent.com/nprashiyer/TestRepo/main/script.ps1"
Invoke-WebRequest -Uri $uri -OutFile "Customize.ps1"
.\Customize.ps1
