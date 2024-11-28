# Function to split the file into parts with error handling
function Split-LargeFile {
    param (
        [string]$inputFile,   # Path to the input file
        [int]$maxSizeGB       # Maximum size for each chunk in GB
    )
    
    # Error handling for file existence
    if (-not (Test-Path $inputFile)) {
        Write-Host "Error: The file '$inputFile' does not exist."
        return
    }
    
    try {
        # Convert max size to bytes
        $maxSize = $maxSizeGB * 1GB
        
        # Get the total size of the file
        $fileSize = (Get-Item $inputFile).length
        
        # Open the file for reading
        $reader = [System.IO.File]::OpenRead($inputFile)
        
        # Calculate the number of chunks
        $numChunks = [math]::Ceiling($fileSize / $maxSize)
        
        # Split the file into smaller parts
        for ($i = 0; $i -lt $numChunks; $i++) {
            # Set the output chunk file name
            $chunkName = "$inputFile.part$i"
            
            # Check available space before writing a chunk
            $freeSpace = (Get-PSDrive -Name C).Free
            if ($freeSpace -lt $maxSize) {
                Write-Host "Error: Not enough disk space to write the chunk '$chunkName'."
                return
            }
            
            # Create a stream to write the chunk
            $writer = [System.IO.File]::OpenWrite($chunkName)
            
            # Read and write the chunk data
            $buffer = New-Object byte[] $maxSize
            $bytesRead = $reader.Read($buffer, 0, $maxSize)
            
            # Write the buffer to the chunk file
            $writer.Write($buffer, 0, $bytesRead)
            
            # Close the chunk file writer
            $writer.Close()
            Write-Host "Created $chunkName"
        }

        # Close the file reader
        $reader.Close()
    }
    catch {
        Write-Host "Error: An exception occurred - $_"
    }
}

# Example usage
$inputFile = Read-Host "Enter the full path of the file to split"
$maxSizeGB = Read-Host "Enter the maximum size per chunk in GB" | ForEach-Object { [int]$_ }

Split-LargeFile -inputFile $inputFile -maxSizeGB $maxSizeGB
