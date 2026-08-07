
Clear-Host
Write-Host "=== MONITOR DOCKER DESDE WINDOWS ===" -ForegroundColor Cyan

$containers = @("app", "mysql", "redis")
$check = [char]0x2713

foreach ($c in $containers) {
    $fullName = "laravel-$c"
    $status = docker inspect -f "{{.State.Running}}" $fullName 2>$null
    if ($status -eq "true") {
        Write-Host "[ ] $c - RUNNING$check" -ForegroundColor Green
    } else {
        Write-Host "[ ] $c - STOPPED" -ForegroundColor Red
    }
}

$cpu = docker stats laravel-app --no-stream --format "{{.CPUPerc}}"
$mem = docker stats laravel-app --no-stream --format "{{.MemUsage}}"
Write-Host "CPU app: $cpu" -ForegroundColor Yellow
Write-Host "Memoria app: $mem" -ForegroundColor Yellow
Write-Host "---"

