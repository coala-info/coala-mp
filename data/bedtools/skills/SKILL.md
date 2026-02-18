---
name: bedtools
description: Report overlaps between two feature files.
homepage: https://bedtools.readthedocs.io/
---

# bedtools

## Overview

bedtools is a versatile suite of command-line utilities designed for high-performance genomic analysis. It treats genomic features as sets of intervals, allowing users to compare different datasets—such as ChIP-seq peaks, gene annotations, or SNPs—to find overlaps, calculate coverage, or identify nearest neighbors. It is optimized for speed and memory efficiency, particularly when working with sorted data, and is designed to be used within UNIX pipelines to create complex bioinformatic workflows.

## Core Concepts and Best Practices

### Coordinate Systems
* **BED format**: Uses 0-based, half-open coordinates. The start is 0-based and the end is 1-based. Length = end - start.
* **GFF/VCF formats**: Use 1-based coordinates. bedtools automatically adjusts these to 0-based internally for consistent arithmetic.
* **Chromosome Naming**: Ensure chromosome names match exactly between files (e.g., 'chr1' vs '1' will result in no overlaps).

### Memory Management (A vs B)
* For most tools comparing two files (`-a` and `-b`), the **B file is loaded into memory**.
* **Expert Tip**: Always set the smaller file as the B file to minimize memory consumption. The A file is processed line-by-line.

### Performance Optimization
* **Use Sorted Data**: Use the `-sorted` option whenever possible. This drastically reduces memory usage and increases speed for large datasets.
* **Genome Files**: When using `-sorted` or tools like `slop` and `complement`, provide a genome file (`-g`) containing chromosome sizes.
* **Piping**: Use `stdin` and `stdout` to chain commands without writing intermediate files. Use `-a stdin` to accept input from a pipe.

## Common CLI Patterns

### Intersecting Features
Find overlaps between two sets of genomic features:
```bash
# Basic intersection
bedtools intersect -a reads.bed -b genes.bed

# Report entries in A that do NOT overlap B (like grep -v)
bedtools intersect -a reads.bed -b genes.bed -v

# Count the number of overlaps in B for each interval in A
bedtools intersect -a genes.bed -b repeats.bed -c

# Require 50% reciprocal overlap (useful for structural variants)
bedtools intersect -a sv.bed -b dups.bed -f 0.50 -r
```

### Merging and Cleaning
Collapse overlapping or nearby intervals into a single record:
```bash
# Merge overlapping intervals
bedtools merge -i input.bed

# Merge intervals within 1000bp of each other
bedtools merge -i input.bed -d 1000

# Count how many original features were merged into the new interval
bedtools merge -i input.bed -c 1 -o count
```

### Proximity and Coverage
Find the nearest feature or calculate depth:
```bash
# Find the closest gene to each SNP
bedtools closest -a snps.bed -b genes.bed

# Calculate coverage of BAM alignments over exons
bedtools coverage -a exons.bed -b reads.bam

# Calculate per-base genome coverage (BedGraph format)
bedtools genomecov -i features.bed -g hg38.chrom.sizes -bg
```

### Sequence Manipulation
Extract or mask sequences using genomic coordinates:
```bash
# Extract FASTA sequences from intervals
bedtools getfasta -fi genome.fa -bed regions.bed -fo output.fa

# Mask a genome FASTA using a BED file
bedtools maskfasta -fi genome.fa -bed repeats.bed -fo masked_genome.fa
```

## Advanced Workflows

### RNA-seq and Spliced Alignments
When working with BAM files or BED12 files containing "blocks" (exons), use the `-split` option. This ensures bedtools ignores the "N" CIGAR operations (introns) and only calculates overlaps with the actual exons.

### Strand-Specific Analysis
Use the `-s` flag to force overlaps to occur on the same strand, or `-S` to force overlaps on the opposite strand.

### Creating Windows
Generate tiling windows across the genome for binned analysis:
```bash
# Create 10kb windows across the genome
bedtools makewindows -g hg38.chrom.sizes -w 10000
```

## Reference documentation
- [Overview](./references/bedtools_readthedocs_io_en_latest_content_overview.html.md)
- [General Usage and Formats](./references/bedtools_readthedocs_io_en_latest_content_general-usage.html.md)
- [Example Usage](./references/bedtools_readthedocs_io_en_latest_content_example-usage.html.md)
- [Advanced Usage](./references/bedtools_readthedocs_io_en_latest_content_advanced-usage.html.md)