# Save this as JSONlike.ps1 and run it from your repo root
# Example usage:
#   pwsh .\JSONlike.ps1

function Get-RepoStructure($path) {
    $structure = @{}

    # Get subdirectories
    Get-ChildItem -Path $path -Directory | ForEach-Object {
        $structure[$_.Name] = Get-RepoStructure($_.FullName)
    }

    # Get files
    Get-ChildItem -Path $path -File | ForEach-Object {
        $structure[$_.Name] = $null
    }

    return $structure
}

# Get current repo path
$rootPath = Get-Location

# Build structure recursively
$repoStructure = Get-RepoStructure $rootPath

# Convert to JSON with indentation for readability
$json = $repoStructure | ConvertTo-Json -Depth 100

# Output to file
$outFile = "repo_structure.json"
$json | Out-File -FilePath $outFile -Encoding utf8

Write-Host "✅ Repository structure exported to $outFile"
