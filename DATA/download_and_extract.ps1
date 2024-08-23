# Array of years and corresponding links
$links = @{
    "2021" = @{
        "count" = @("https://www.cbs.gov.il/he/publications/DocLib1/2015/PUF/%D7%AA%D7%97%D7%91%D7%95%D7%A8%D7%94/puf_2021.zip")
        "accidents" = @("https://www.cbs.gov.il/he/publications/DocLib1/2015/PUF/%D7%A7%D7%91%D7%A6%D7%99%D7%9D%20%D7%9C%D7%94%D7%95%D7%A8%D7%93%D7%94%20-%20%D7%AA%D7%90%D7%95%D7%A0%D7%95%D7%AA%20%D7%9E%D7%A7%D7%95%D7%A6%D7%A8%202021.zip")
    }
    "2020" = @{
        "count" = @("https://www.cbs.gov.il/he/publications/DocLib1/2015/PUF/%D7%AA%D7%97%D7%91%D7%95%D7%A8%D7%94/puf_2020.zip")
        "accidents" = @("https://www.cbs.gov.il/he/publications/DocLib1/2015/PUF/%D7%A7%D7%91%D7%A6%D7%99%D7%9D%20%D7%9C%D7%94%D7%95%D7%A8%D7%93%D7%94%20-%20%D7%AA%D7%90%D7%95%D7%A0%D7%95%D7%AA%20%D7%9E%D7%A7%D7%95%D7%A6%D7%A8%202020.zip")
    }
    "2018" = @{
        "count" = @("https://www.cbs.gov.il/he/publications/DocLib1/2015/PUF/%D7%AA%D7%97%D7%91%D7%95%D7%A8%D7%94/puf_2018.zip")
        "accidents" = @("https://www.cbs.gov.il/he/publications/DocLib1/2015/PUF/%D7%A7%D7%91%D7%A6%D7%99%D7%9D%20%D7%9C%D7%94%D7%95%D7%A8%D7%93%D7%94%20-%20%D7%AA%D7%90%D7%95%D7%A0%D7%95%D7%AA%20%D7%9E%D7%A7%D7%95%D7%A6%D7%A8%202018.zip")
    }
    "2017" = @{
        "count" = @("https://www.cbs.gov.il/he/publications/DocLib1/2015/PUF/%D7%AA%D7%97%D7%91%D7%95%D7%A8%D7%94/puf_2017.zip")
        "accidents" = @("https://www.cbs.gov.il/he/publications/DocLib1/2015/PUF/%D7%A7%D7%91%D7%A6%D7%99%D7%9D%20%D7%9C%D7%94%D7%95%D7%A8%D7%93%D7%94%20-%20%D7%AA%D7%90%D7%95%D7%A0%D7%95%D7%AA%20%D7%9E%D7%A7%D7%95%D7%A6%D7%A8%202017.zip")
    }
    "2016" = @{
        "count" = @("https://www.cbs.gov.il/he/publications/DocLib1/2015/PUF/%D7%AA%D7%97%D7%91%D7%95%D7%A8%D7%94/puf2016.zip")
        "accidents" = @("https://www.cbs.gov.il/he/publications/DocLib1/2015/PUF/%D7%A7%D7%91%D7%A6%D7%99%D7%9D%20%D7%9C%D7%94%D7%95%D7%A8%D7%93%D7%94%20-%20%D7%AA%D7%90%D7%95%D7%A0%D7%95%D7%AA%20%D7%9E%D7%A7%D7%95%D7%A6%D7%A8%202016.zip")
    }
    "2015" = @{
        "count" = @("https://www.cbs.gov.il/he/publications/DocLib1/2015/PUF/%D7%AA%D7%97%D7%91%D7%95%D7%A8%D7%94/puf2015.zip")
        "accidents" = @("https://www.cbs.gov.il/he/publications/DocLib1/2015/PUF/%D7%A7%D7%91%D7%A6%D7%99%D7%9D%20%D7%9C%D7%94%D7%95%D7%A8%D7%93%D7%94%20-%20%D7%AA%D7%90%D7%95%D7%A0%D7%95%D7%AA%20%D7%9E%D7%A7%D7%95%D7%A6%D7%A8%202015.zip")
    }
    "2014" = @{
        "count" = @("https://www.cbs.gov.il/he/publications/DocLib1/2015/PUF/%D7%AA%D7%97%D7%91%D7%95%D7%A8%D7%94/puf2014.zip")
        "accidents" = @("https://www.cbs.gov.il/he/publications/DocLib1/2015/PUF/%D7%A7%D7%91%D7%A6%D7%99%D7%9D%20%D7%9C%D7%94%D7%95%D7%A8%D7%93%D7%94%20-%20%D7%AA%D7%90%D7%95%D7%A0%D7%95%D7%AA%20%D7%9E%D7%A7%D7%95%D7%A6%D7%A8%202014.zip")
    }
}

# Loop through each year and process only those with both count and accidents links
foreach ($year in $links.Keys) {
    if ($links[$year]["count"].Length -gt 0 -and $links[$year]["accidents"].Length -gt 0) {
        # Create a directory for the year
        New-Item -Path $year -ItemType Directory -Force
        
        # Create subfolders for count and accidents
        New-Item -Path "$year\count" -ItemType Directory -Force
        New-Item -Path "$year\accidents" -ItemType Directory -Force

        # Process count links
        foreach ($url in $links[$year]["count"]) {
            $file_name = [System.IO.Path]::GetFileName($url)
            $file_path = "$year\count\$file_name"
            Invoke-WebRequest -Uri $url -OutFile $file_path

            # Check if the file is non-zero in size
            if ((Get-Item $file_path).length -gt 0) {
                # Extract if it's a zip file
                if ($file_name.EndsWith(".zip")) {
                    try {
                        Expand-Archive -Path $file_path -DestinationPath "$year\count"
                        # Remove-Item $file_path
                    } catch {
                        Write-Host "Failed to extract $file_name in $year\count"
                    }
                }
            } else {
                Write-Host "Downloaded file $file_name in $year\count is empty or corrupt."
            }
        }

        # Process accidents links
        foreach ($url in $links[$year]["accidents"]) {
            $file_name = [System.IO.Path]::GetFileName($url)
            $file_path = "$year\accidents\$file_name"
            Invoke-WebRequest -Uri $url -OutFile $file_path

            # Check if the file is non-zero in size
            if ((Get-Item $file_path).length -gt 0) {
                # Extract if it's a zip file
                if ($file_name.EndsWith(".zip")) {
                    try {
                        Expand-Archive -Path $file_path -DestinationPath "$year\accidents"
                       # Remove-Item $file_path
                    } catch {
                        Write-Host "Failed to extract $file_name in $year\accidents"
                    }
                }
            } else {
                Write-Host "Downloaded file $file_name in $year\accidents is empty or corrupt."
            }
        }
    }
}

Write-Host "Download and extraction completed."
