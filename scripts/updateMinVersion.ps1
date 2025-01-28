param (
    [Parameter(Mandatory=$true)][string]$path
)
$xml = [xml](Get-Content -Path $path)
$currentVersion = $xml.Project.PropertyGroup.Version 
$splitedVersion = $currentVersion -split "\."
$currentMinorVersion = [int]$splitedVersion[$splitedVersion.length - 1]
$updatedMinorVersion = $currentMinorVersion + 1
$splitedVersion[$splitedVersion.length - 1] = $updatedMinorVersion
$updatedVersion = $splitedVersion | Join-String -Separator '.'
$xml.Project.PropertyGroup.Version = $updatedVersion
$xml.Save($path)
#DotnetBump/DotnetBump/DotnetBump.csproj
