# Biggle Small Files :: A File Splitter PowerShell Script repo

## Overview

This PowerShell script takes a large file and breaks it down into smaller pieces, each being under 4GB. It adds a number to each split file’s name to keep everything organized. The script is handy when you need to deal with large files that exceed size limits imposed by filesystems or certain software.

## Features

- Splits files into parts that are under 4GB each.
- Automatically numbers each split file so they’re easy to find and follow.
- Works efficiently on large datasets.
- Saves all split files to a folder you specify (defaults to `C:\` if you don’t specify anything).

## Requirements

- **Windows** with PowerShell (version 5.1 or later).
- You need enough disk space to store the split files.
- Make sure you have read and write permissions for the file you’re splitting and the folder you're saving to.

## How It Works

1. The script reads the input file piece by piece.
2. It writes each piece to a new file, making sure no file exceeds 4GB.
3. The output files will be named like this: `originalfilename_part1`, `originalfilename_part2`, and so on.

## How to Use It

1. Download the script or clone the repository.
2. Open **PowerShell** and navigate to where the script is located.
3. Use this syntax to run the script:

   ```powershell
   .\FileSplitter.ps1 -FilePath "C:\path\to\your\file.ext" -OutputDirectory "C:\path\to\output\directory"

    -FilePath: Path to the file you want to split.
    -OutputDirectory: Where you want the split files to go. If you don't say where, it defaults to C:\.

## Output

The script will produce files named like this:

originalfilename_part1.ext
originalfilename_part2.ext
...

## Error Handling

    If something goes wrong (like the file can’t be found or there’s not enough space), the script will throw an error message.
    Make sure the file you want to split is accessible and that there’s enough space where you're saving the split files.

## License

This script is licensed under the MIT License. See the LICENSE file for more details.
Contributing

If you’ve got ideas on how to improve this script or notice a bug, feel free to submit an issue or open a pull request.
