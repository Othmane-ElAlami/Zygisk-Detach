$ErrorActionPreference = "Stop"

Write-Host "Reading update.json..."
$updateJson = Get-Content -Raw "update.json" | ConvertFrom-Json
$zipUrl = $updateJson.zipUrl

$tempZip = "Upstream-Release.zip"
$extractDir = "Extracted"

$moduleName = "Module"
$moduleVersion = "v1.0"
if (Test-Path "module\module.prop") {
    $propContent = Get-Content "module\module.prop"
    $nameLine = $propContent | Where-Object { $_ -match "^name=" }
    if ($nameLine) {
        $moduleName = $nameLine.Split("=")[1].Trim() -replace '\s+', ''
    }
    $verLine = $propContent | Where-Object { $_ -match "^version=" }
    if ($verLine) {
        $moduleVersion = $verLine.Split("=")[1].Trim()
    }
}
$outZip = "$moduleName-$moduleVersion.zip"

Write-Host "Downloading upstream release from $zipUrl ..."
Invoke-WebRequest -Uri $zipUrl -OutFile $tempZip

Write-Host "Extracting..."
if (Test-Path $extractDir) { Remove-Item -Recurse -Force $extractDir }
Expand-Archive -Path $tempZip -DestinationPath $extractDir -Force

Write-Host "Applying local module changes..."
Copy-Item -Path "module\*" -Destination $extractDir\ -Recurse -Force

Write-Host "Normalizing line endings to LF..."
$textFiles = Get-ChildItem -Path $extractDir -Recurse -File | Where-Object {
    $_.Extension -match "\.(sh|prop|txt|md)$" -or $_.Name -match "^(update-binary|updater-script)$"
}
foreach ($file in $textFiles) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    if ($bytes -contains 13) {
        $bytes = $bytes | Where-Object { $_ -ne 13 }
        [System.IO.File]::WriteAllBytes($file.FullName, [byte[]]$bytes)
    }
}

Write-Host "Creating final flashable ZIP: $outZip ..."
if (Test-Path $outZip) { Remove-Item -Force $outZip }
Compress-Archive -Path "$extractDir\*" -DestinationPath $outZip -Force

Write-Host "Cleaning up..."
Remove-Item -Force $tempZip
Remove-Item -Recurse -Force $extractDir

Write-Host "Done! Generated $outZip"
