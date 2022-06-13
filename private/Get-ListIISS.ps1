function Get-ListIIS() {
    Param()

    $sites = @{0='GLOBAL'}
    (Get-IISSite)| ForEach-Object { $sites[$_.Id.tostring()] = $_.Name.tostring() }

    return $sites;
}