# Illumina allocation to samplesheet
Helper script to transform an allocation sheet into a samplesheet

## Info
This repo contains a single script which is mainly for internal usage.
Therefore it is not very well documented.
But if you want to reuse it, feel free to do it (MIT License).

## Usage
```
perl allocation_to_samplesheet.pl <allocation.csv> <barcode.csv> [header.csv] >samplesheet.csv
```
You can find barcode and header files as well as an example allocation and samplesheet in the [data](data) folder.

## Important notes
Some things you should keep in mind:
 - The first line of the allocation sheet is discarded so the second line should have the barcode IDs for the columns (see [data/example_allocation.csv](example_allocation))
 - The plates are expected to be 12x8 in size with column headers above and row header to the left (if the size is different the source code has to be altered)
 - The four plates are expected to start in the upper left corner (with one empty line above) and two per row, no space between them except headers
 - IDs may not contain newlines (have to be replaced before calling the perl script)
 - IDs should not contain whitespace (has to be removed before or after calling the perl script)
