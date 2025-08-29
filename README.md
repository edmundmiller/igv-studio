# IGV Web App Studio for Seqera Platform

A containerized [IGV (Integrative Genomics Viewer)](https://igv.org/) web application designed to run as a Seqera Platform Studio environment. This allows users to visualize and analyze genomic data directly within their Seqera workspace.

## Features

- **Full IGV Web App**: Complete genomics visualization capabilities
- **CORS Support**: Properly configured to access external genomic data sources
- **Range Requests**: Supports indexed files (BAM, VCF, etc.) for efficient data loading  
- **Seqera Integration**: Built on Seqera's Studio framework with dynamic port handling
- **Local Testing**: Includes docker-compose setup for development

## Quick Start

### Deploy to Seqera Platform

1. Build and push the Docker image:
```bash
docker build -t your-registry/igv-studio:latest .
docker push your-registry/igv-studio:latest
```

2. In Seqera Platform, create a new Studio with:
   - **Image**: `your-registry/igv-studio:latest`
   - **Tool**: Web Application
   - **Description**: IGV Genomics Viewer

3. Launch the Studio and access IGV webapp through the provided URL

### Local Development

1. Clone this repository
2. Start the local environment:
```bash
docker-compose up --build
```
3. Open http://localhost:8080 in your browser

## Supported Data Formats

IGV webapp supports a wide range of genomic file formats:

### Sequence Data
- FASTA (.fa, .fasta)
- 2bit (.2bit)

### Alignment Data  
- BAM (.bam) + index (.bai)
- SAM (.sam)
- CRAM (.cram) + index (.crai)

### Variant Data
- VCF (.vcf, .vcf.gz) + index (.tbi)
- BCF (.bcf)

### Annotation Data
- BED (.bed)
- GFF (.gff, .gff3) 
- GTF (.gtf)
- BigBed (.bb)

### Coverage Data
- BigWig (.bw, .bigwig)
- Wiggle (.wig)
- TDF (.tdf)

## Data Loading Options

### 1. Local Files
- Use "Local File" button in IGV to upload files from your computer
- Supports drag-and-drop functionality
- Files are processed entirely in the browser (no server upload)

### 2. URL-based Loading
- Load data directly from web URLs
- Requires CORS-enabled servers for cross-origin access
- Supports cloud storage (AWS S3, Google Cloud Storage, etc.)

### 3. Sample Data
IGV includes built-in sample datasets for testing:
- Human genome (hg38, hg19)
- Mouse genome (mm10)
- Various annotation tracks

## CORS Configuration

For loading data from external servers, ensure CORS headers are properly configured:

### Required Headers
```
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: GET, HEAD, OPTIONS
Access-Control-Allow-Headers: Range, Content-Type
Access-Control-Expose-Headers: Content-Length, Content-Range, Content-Type
```

### Example nginx Configuration
```nginx
location ~* \.(bam|bai|vcf|bed|gff|bigwig|bw)$ {
    add_header 'Access-Control-Allow-Origin' '*';
    add_header 'Access-Control-Allow-Methods' 'GET, HEAD, OPTIONS';
    add_header 'Access-Control-Expose-Headers' 'Content-Length, Content-Range';
    add_header 'Accept-Ranges' 'bytes';
}
```

### Cloud Storage Examples

#### AWS S3
Configure bucket CORS policy:
```json
[
    {
        "AllowedHeaders": ["*"],
        "AllowedMethods": ["GET", "HEAD"],
        "AllowedOrigins": ["*"],
        "ExposeHeaders": ["Content-Length", "Content-Range"]
    }
]
```

#### Google Cloud Storage
```bash
gsutil cors set cors-config.json gs://your-bucket-name
```

## Architecture

### Container Structure
```
/opt/igv-webapp/          # IGV webapp static files
/etc/nginx/               # nginx configuration
/usr/local/bin/start.sh   # Startup script with dynamic port handling
```

### Startup Process
1. `connect-client` initializes Seqera integration
2. `start.sh` configures nginx with dynamic port (`CONNECT_TOOL_PORT`)
3. nginx serves IGV webapp on the assigned port
4. Studio URL routes to the IGV interface

### Security Features
- CORS headers for cross-origin data access
- Content security headers (X-Frame-Options, etc.)
- No server-side data storage (client-side only processing)

## Customization

### Custom IGV Configuration
To customize the IGV webapp configuration, modify the Dockerfile to include your config files:

```dockerfile
# Copy custom IGV configuration
COPY igvConfig.js /opt/igv-webapp/js/igvConfig.js
```

### Additional Genomic Tools
Extend the container to include additional bioinformatics tools:

```dockerfile
# Install samtools, bcftools, etc.
RUN apt-get update && apt-get install -y samtools bcftools tabix
```

### Custom Data Sources
Pre-configure data sources by modifying the IGV webapp configuration:

```javascript
// Custom genome and track definitions
var customGenomes = {
    "mygenome": {
        "id": "mygenome",
        "name": "My Custom Genome",
        "fastaURL": "https://myserver.com/genome.fa",
        "indexURL": "https://myserver.com/genome.fa.fai"
    }
};
```

## Troubleshooting

### Common Issues

#### IGV Not Loading
- Check browser console for JavaScript errors
- Verify nginx is running: `docker-compose logs`
- Confirm port mapping in docker-compose.yml

#### Data Loading Fails
- Verify CORS headers on your data server
- Check file permissions and accessibility
- Ensure index files are available for large datasets

#### Studio Connection Issues
- Confirm `CONNECT_TOOL_PORT` environment variable is set
- Check Seqera Platform network connectivity
- Verify image registry access

### Debug Mode
Enable debug logging by modifying `start.sh`:
```bash
# Add debug output
set -x
nginx -T  # Test and dump configuration
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Test locally with docker-compose
4. Submit a pull request

## License

This project builds on several open-source components:
- [IGV.js](https://github.com/igvteam/igv.js) - MIT License
- [IGV-webapp](https://github.com/igvteam/igv-webapp) - MIT License
- nginx - BSD-2-Clause License

## Support

For issues related to:
- **IGV functionality**: [IGV Support Forum](https://groups.google.com/forum/#!forum/igv-help)
- **Seqera Platform**: [Seqera Documentation](https://docs.seqera.io/)
- **This container**: Open an issue in this repository

## Related Resources

- [IGV User Guide](https://igv.org/doc/webapp/)
- [Seqera Studios Documentation](https://docs.seqera.io/platform/latest/studios/)
- [IGV.js API Documentation](https://github.com/igvteam/igv.js/wiki)
- [Genomic File Formats Guide](https://genome.ucsc.edu/FAQ/FAQformat.html)