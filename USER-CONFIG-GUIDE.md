# IGV Studio User Configuration Guide

This guide explains how to customize IGV Studio behavior by placing configuration files in your Fusion-mounted data links.

## Quick Start

1. Create a file named `igv-config.json` in your data link bucket
2. Add your custom IGV configuration (see examples below)
3. Launch IGV Studio - your config will be automatically loaded

## Configuration File Locations

IGV Studio scans for configuration files in this priority order:

```
/workspace/data/your-bucket/
├── igv-config.json          # Recommended filename
├── igvConfig.json           # Alternative
├── igv.json                 # Alternative
├── .igv-config.json         # Hidden config
└── config/
    └── igv.json             # In config subdirectory
```

## Configuration Schema

### Basic Structure

```json
{
  "tracks": [/* track definitions */],
  "genomes": [/* custom genome definitions */],
  "locus": "chr1:1000000-2000000",
  "reference": {"id": "genome-id"},
  "showChromosomeWidget": true
}
```

### Track Configuration

#### Alignment Track (BAM/CRAM)
```json
{
  "name": "Sample Alignments",
  "url": "/workspace/data/my-project/sample.bam",
  "indexURL": "/workspace/data/my-project/sample.bam.bai",
  "type": "alignment",
  "height": 300,
  "coverageThreshold": 0.2,
  "alignmentShading": "strand",
  "colorBy": "strand"
}
```

#### Variant Track (VCF)
```json
{
  "name": "Variants",
  "url": "/workspace/data/my-project/variants.vcf.gz",
  "indexURL": "/workspace/data/my-project/variants.vcf.gz.tbi",
  "type": "variant",
  "displayMode": "EXPANDED",
  "height": 200,
  "homvarColor": "rgb(17,248,254)",
  "hetvarColor": "rgb(34,12,253)"
}
```

#### Coverage Track (BigWig)
```json
{
  "name": "RNA-seq Coverage",
  "url": "/workspace/data/my-project/coverage.bw",
  "type": "wig",
  "color": "rgb(255, 0, 0)",
  "height": 150,
  "min": 0,
  "max": 100,
  "autoscale": false
}
```

#### Annotation Track (BED/GFF)
```json
{
  "name": "Gene Annotations",
  "url": "/workspace/data/my-project/genes.gtf",
  "type": "annotation",
  "height": 100,
  "expandedRowHeight": 15,
  "squishedRowHeight": 8,
  "displayMode": "EXPANDED",
  "color": "rgb(0, 100, 0)"
}
```

#### Segmentation Track
```json
{
  "name": "Copy Number",
  "url": "/workspace/data/my-project/segments.seg",
  "type": "seg",
  "height": 150,
  "isLog": true,
  "displayMode": "EXPANDED"
}
```

### Custom Genome Configuration

```json
{
  "genomes": [
    {
      "id": "my-genome-v1",
      "name": "My Custom Genome v1.0",
      "fastaURL": "/workspace/data/reference/genome.fa",
      "indexURL": "/workspace/data/reference/genome.fa.fai",
      "cytobandURL": "/workspace/data/reference/cytobands.txt",
      "aliasURL": "/workspace/data/reference/aliases.txt",
      "tracks": [
        {
          "name": "Genes",
          "url": "/workspace/data/reference/genes.gtf",
          "type": "annotation",
          "order": 1000000,
          "indexed": false
        }
      ]
    }
  ]
}
```

### IGV Browser Settings

```json
{
  "locus": "chr1:1000000-2000000",
  "reference": {
    "id": "hg38"
  },
  "showChromosomeWidget": true,
  "showSVGButton": false,
  "showTrackLabelButton": true,
  "showCursorTrackingGuide": true,
  "showCenterGuide": false
}
```

## Advanced Examples

### Multi-Sample Project Configuration

```json
{
  "tracks": [
    {
      "name": "Sample 1 - Alignments",
      "url": "/workspace/data/project-a/sample1.bam",
      "indexURL": "/workspace/data/project-a/sample1.bam.bai",
      "type": "alignment",
      "height": 200,
      "color": "rgb(150, 150, 255)"
    },
    {
      "name": "Sample 2 - Alignments", 
      "url": "/workspace/data/project-a/sample2.bam",
      "indexURL": "/workspace/data/project-a/sample2.bam.bai",
      "type": "alignment",
      "height": 200,
      "color": "rgb(255, 150, 150)"
    },
    {
      "name": "Combined Variants",
      "url": "/workspace/data/project-a/combined.vcf.gz",
      "indexURL": "/workspace/data/project-a/combined.vcf.gz.tbi",
      "type": "variant",
      "displayMode": "SQUISHED",
      "height": 100
    }
  ],
  "locus": "chr17:41000000-42000000",
  "reference": {
    "id": "hg38"
  }
}
```

### RNA-seq Analysis Configuration

```json
{
  "tracks": [
    {
      "name": "RNA-seq - Forward Strand",
      "url": "/workspace/data/rnaseq/forward.bw",
      "type": "wig",
      "color": "rgb(255, 0, 0)",
      "height": 120,
      "min": 0,
      "max": 50
    },
    {
      "name": "RNA-seq - Reverse Strand", 
      "url": "/workspace/data/rnaseq/reverse.bw",
      "type": "wig",
      "color": "rgb(0, 0, 255)",
      "height": 120,
      "min": -50,
      "max": 0
    },
    {
      "name": "Splice Junctions",
      "url": "/workspace/data/rnaseq/junctions.bed",
      "type": "annotation",
      "height": 60,
      "color": "rgb(150, 0, 150)"
    }
  ],
  "locus": "chr1:1000000-1100000"
}
```

### Cancer Genomics Configuration

```json
{
  "tracks": [
    {
      "name": "Tumor Sample",
      "url": "/workspace/data/cancer/tumor.bam",
      "indexURL": "/workspace/data/cancer/tumor.bam.bai", 
      "type": "alignment",
      "height": 300
    },
    {
      "name": "Normal Sample",
      "url": "/workspace/data/cancer/normal.bam",
      "indexURL": "/workspace/data/cancer/normal.bam.bai",
      "type": "alignment", 
      "height": 300
    },
    {
      "name": "Somatic Variants",
      "url": "/workspace/data/cancer/somatic.vcf.gz",
      "indexURL": "/workspace/data/cancer/somatic.vcf.gz.tbi",
      "type": "variant",
      "displayMode": "EXPANDED"
    },
    {
      "name": "Copy Number",
      "url": "/workspace/data/cancer/segments.seg",
      "type": "seg", 
      "height": 150,
      "isLog": true
    },
    {
      "name": "Mutations",
      "url": "/workspace/data/cancer/mutations.maf",
      "type": "mut",
      "height": 100
    }
  ]
}
```

## Best Practices

### File Paths
- Always use absolute paths starting with `/workspace/data/`
- Ensure index files are in the same directory as data files
- Use consistent naming conventions

### Performance
- Set appropriate height values (100-300px typically)
- Use `autoscale: false` for BigWig tracks when you know the data range
- Consider `displayMode: "SQUISHED"` for dense annotation tracks

### Organization
- Group related tracks together in the configuration
- Use descriptive track names that include sample/condition info
- Set meaningful colors to distinguish track types

### Validation
- Validate your JSON syntax before deploying
- Test with small genomic regions first
- Check IGV console logs for configuration errors

## Troubleshooting

### Configuration Not Loading
1. Check JSON syntax with a validator
2. Verify file is named correctly (`igv-config.json`)
3. Ensure file permissions allow reading
4. Check Studio startup logs for error messages

### Tracks Not Displaying
1. Verify file paths are correct and accessible
2. Check that index files exist for indexed formats
3. Confirm file formats are supported by IGV
4. Try loading files manually first to test accessibility

### Performance Issues
1. Reduce track heights
2. Use appropriate display modes (SQUISHED for dense data)
3. Set explicit min/max values for coverage tracks
4. Consider subsampling very large datasets

## Integration with Auto-Discovery

User configurations are merged with auto-discovered tracks:
- User-defined tracks appear in a "User Defined Tracks" group
- Auto-discovered tracks are organized by data link source
- User configs can override default IGV settings (locus, reference, etc.)
- Both systems work together seamlessly

For questions or issues, consult the main README.md or IGV documentation.