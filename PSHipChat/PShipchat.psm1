#Requires -Version 2.0

# Public functions
@( Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" ) | ForEach-Object {
    . $_.FullName
}

# Private functions
@( Get-ChildItem -Path "$PSScriptRoot\Private\*.ps1" ) | ForEach-Object {
    . $_.FullName
}