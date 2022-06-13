
function Write-Menu ($items, $prompt,[switch] $returnitem) {
    if (!$items) { Throw 'Must provide an object.' }
    $continue = $true
    Write-Host ''
    while ($continue){
        $items.GetEnumerator() | sort -Property Name  | ForEach-Object{
            Write-Host $_.key `. $_.value
        }
        write-host "x . Exit"
        Write-Host ''
        $answer = Read-Host $prompt
        if ($answer -in $items.keys) {
            if ($returnitem -eq $true){                 
                $items.GetEnumerator()|ForEach-Object{
                   if (($_.Name -eq $answer) -or  ($_.Name -eq [int]$answer)){
                        return $_.Value  
                   }
                }           
            }else{  return $answer }
            $continue = $false
        } elseif ($answer -eq 'x') {
            Break Script
        } else {
            Write-Host 'Not an option!' -ForegroundColor Red
            Write-Host ''
        }
    } 
}

function Write-SmallMenu ($prompt) {
    $continue = $true
    Write-Host ''
    while ($continue){
        $answer = Read-Host $prompt
        if ($answer -eq 'y') {
            return $true
            $continue = $false
        } elseif ($answer -eq 'n') {
            return $false
            $continue = $false
        } elseif ($answer -eq 'x') {
            Break Script
        } else {
            Write-Host 'Not an option!' -ForegroundColor Red
            Write-Host ''
        }
    } 
}
