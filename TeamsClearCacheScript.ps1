$process = Get-Process -Name "Teams" -ErrorAction SilentlyContinue;
$processFilePath;

Write-Host 'Microsoft Teams cache cleaner script started';

if($null -ne $process){
    $processFilePath = $process[0].MainModule.FileName
    Write-Host 'Microsoft Teams proccess detected';

    Write-Host 'Attempting to stop Microsoft Teams';
    Stop-Process -InputObject $process -Force

    Start-Sleep 2
    if($process.HasExited){
        Write-Host 'Microsoft Teams exited';
    }else{
        Read-Host 'Script encountered problem during Microsoft Teams exiting. Please exit Microsoft Teams manually and try again';
        exit;
    }
}

Write-Host "Clearing Microsoft Teams Cache" -ForegroundColor Yellow

Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\application cache\cache" -ErrorAction SilentlyContinue | Remove-Item -Confirm:$false -Recurse
Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\blob_storage" -ErrorAction SilentlyContinue | Remove-Item -Confirm:$false -Recurse
Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\databases" -ErrorAction SilentlyContinue | Remove-Item -Confirm:$false -Recurse
Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\cache" -ErrorAction SilentlyContinue | Remove-Item -Confirm:$false -Recurse
Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\gpucache" -ErrorAction SilentlyContinue | Remove-Item -Confirm:$false -Recurse
Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\Indexeddb" -ErrorAction SilentlyContinue | Remove-Item -Confirm:$false -Recurse
Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\Local Storage" -ErrorAction SilentlyContinue | Remove-Item -Confirm:$false -Recurse 
Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\tmp" -ErrorAction SilentlyContinue | Remove-Item -Confirm:$false -Recurse

Write-Host "Clear Complete" -ForegroundColor Green

if($null -ne $processFilePath){
    Write-Host "Starting Microsoft Teams..." -ForegroundColor Green
    $cmd = & $processFilePath
    PowerShell.exe -windowstyle hidden { $cmd }  
}

Write-Host "That's all! Enjoy!" -ForegroundColor Green

Read-Host