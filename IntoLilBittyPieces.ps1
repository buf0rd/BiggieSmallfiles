# the variable farm
$sourceFile = "C:\path\to\your\largefile.ext" # Full path to the file you want to split
$outputFolder = "C:\" # Output folder for pieces
$splitSize = 4GB # Size limit for each split file (4GB)

# does the file even exist
if (-Not (Test-Path $sourceFile)) {
    Write-Host "Source file not found!"
    exit
}

# file size && name
$fileSize = (Get-Item $sourceFile).Length
$baseFileName = [System.IO.Path]::GetFileNameWithoutExtension($sourceFile)
$fileExtension = [System.IO.Path]::GetExtension($sourceFile)

# Calculate split
$numberOfParts = [math]::Ceiling($fileSize / $splitSize)
# Open the source file 
$fileStream = [System.IO.File]::OpenRead($sourceFile)
$bufferSize = 1MB                               # Buffer size for reading (adjust as needed)
$buffer = New-Object byte[] $bufferSize         # Buffer to hold the file data

# Cook'n
for ($i = 0; $i -lt $numberOfParts; $i++) {
    $outputFileName = "{0}\{1}_part{2}{3}" -f $outputFolder, $baseFileName, ($i + 1), $fileExtension
    $outputStream = [System.IO.File]::Create($outputFileName)
    
    $totalBytesWritten = 0
    while ($totalBytesWritten -lt $splitSize -and $bytesRead = $fileStream.Read($buffer, 0, $buffer.Length)) {
        $outputStream.Write($buffer, 0, $bytesRead)
        $totalBytesWritten += $bytesRead
    }
    
    # Close the current part's stream
    $outputStream.Close()
    Write-Host "Created part: $outputFileName"
}

# Close the source file stream
$fileStream.Close()
Write-Host "The original file has been split into lil bitty pieces. Maybe I should make a script to assemble it all... and name it One_Piece?"

##IntoLilBittyPieces
