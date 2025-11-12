# Run from PowerShell, not CMD
Get-ChildItem -Recurse | ForEach-Object {
    $relativePath = $_.FullName.Substring((Get-Location).Path.Length + 1)
    if ($_.PSIsContainer) {
        "📁 $relativePath"
    } else {
        "  $relativePath"
    }
} | Out-File repo_structure.txt -Encoding utf8
