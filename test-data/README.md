# Test Data Directory

This directory can contain genomic data files for testing IGV webapp functionality.

## Supported File Types

IGV webapp supports many genomic file formats including:

- **Alignment files**: BAM, SAM, CRAM
- **Variant files**: VCF, BCF  
- **Annotation files**: BED, GFF, GTF
- **Sequence files**: FASTA, 2bit
- **Coverage files**: BigWig, TDF
- **Index files**: BAI, TBI, CSI

## Example Usage

1. Place your genomic data files in this directory
2. Start the IGV studio with docker-compose
3. In IGV webapp, use "Local File" option to load files from your browser
4. Or use "URL" option to load files from web servers with proper CORS configuration

## Sample Data Sources

For testing, you can download sample data from:
- IGV sample data: https://data.broadinstitute.org/igvdata/
- ENCODE project: https://www.encodeproject.org/
- 1000 Genomes: https://www.internationalgenome.org/