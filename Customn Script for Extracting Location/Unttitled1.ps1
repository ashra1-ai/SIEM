# Define the XML filter to capture failed RDP events from Windows Event Viewer
$XMLFilter = @'
<QueryList> 
   <Query Id="0" Path="Security">
         <Select Path="Security">
              *[System[(EventID='4625')]]
          </Select>
    </Query>
</QueryList> 
'@

# Define the log file path and API key
$LOGFILE_PATH = "C:\Logs\FailedRDP.log"
$API_KEY = "$($Your_API_key)"

# Ensure the log file exists or create it
if (-Not (Test-Path $LOGFILE_PATH)) {
    Write-Host "Log file not found. Creating log file at $LOGFILE_PATH..." -ForegroundColor Green
    New-Item -ItemType File -Path $LOGFILE_PATH -Force | Out-Null
} else {
    Write-Host "Log file found at $LOGFILE_PATH. Ready to append logs." -ForegroundColor Cyan
}

# Start monitoring events in a continuous loop
Write-Host "Starting to monitor failed RDP login events..." -ForegroundColor Green
while ($true) {
    Start-Sleep -Seconds 1 # Pause to reduce event processing overhead

    # Retrieve failed RDP login events
    $events = Get-WinEvent -FilterXml $XMLFilter -ErrorAction SilentlyContinue

    # Skip loop iteration if no events found
    if (!$events) {
        Write-Host "No failed login events detected. Retrying..." -ForegroundColor Yellow
        continue
    }

    # Process each event
    foreach ($event in $events) {
        # Extract the source IP address from the event properties
        $sourceIp = $event.properties[19].Value
        if ([string]::IsNullOrWhiteSpace($sourceIp)) {
            Write-Host "Event without source IP address found. Skipping..." -ForegroundColor Gray
            continue
        }

        # Extract additional event details
        $timestamp = $event.TimeCreated.ToString("yyyy-MM-dd HH:mm:ss")
        $destinationHost = $event.MachineName
        $username = $event.properties[5].Value
        $sourceHost = $event.properties[11].Value

        # Check if the log entry already exists
        if (Get-Content -Path $LOGFILE_PATH -ErrorAction SilentlyContinue | Select-String -Quiet $timestamp) {
            Write-Host "Duplicate event detected. Skipping..." -ForegroundColor Gray
            continue
        }

        # Pause briefly to handle API rate limits
        Start-Sleep -Seconds 1

        # Make a request to the geolocation API
        $API_ENDPOINT = "https://api.ipgeolocation.io/ipgeo?apiKey=$($API_KEY)&ip=$($sourceIp)"
        try {
            Write-Host "Querying geolocation API for IP: $sourceIp..." -ForegroundColor Cyan
            $response = Invoke-WebRequest -UseBasicParsing -Uri $API_ENDPOINT -ErrorAction Stop
            $responseData = $response.Content | ConvertFrom-Json
        } catch {
            Write-Host "API request failed for IP: $sourceIp. Skipping this event." -ForegroundColor Red
            continue
        }

        # Extract geolocation data with fallbacks for missing fields
        $latitude = $responseData.latitude
        $longitude = $responseData.longitude
        $state = if ([string]::IsNullOrWhiteSpace($responseData.state_prov)) { "null" } else { $responseData.state_prov }
        $country = if ([string]::IsNullOrWhiteSpace($responseData.country_name)) { "null" } else { $responseData.country_name }

        # Create a log entry string
        $logEntry = "latitude:$latitude,longitude:$longitude,destinationhost:$destinationHost,username:$username,sourcehost:$sourceIp,state:$state,country:$country,label:$country - $sourceIp,timestamp:$timestamp"

        # Write the log entry to the file
        try {
            $logEntry | Out-File -FilePath $LOGFILE_PATH -Append -Encoding utf8
            Write-Host "Log entry written: $logEntry" -ForegroundColor Green
        } catch {
            Write-Host "Failed to write log entry to file. Skipping this event." -ForegroundColor Red
        }
    }
}
