cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - bedtobam
label: bedtools_bedtobam
doc: "Converts feature records to BAM format.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: bed12
    type:
      - 'null'
      - boolean
    doc: The BED file is in BED12 format. The BAM CIGAR string will reflect BED 
      "blocks".
    inputBinding:
      position: 101
      prefix: -bed12
  - id: genome_file
    type: File
    doc: Genome file
    inputBinding:
      position: 101
      prefix: -g
  - id: input_file
    type: File
    doc: Input BED, GFF, or VCF file
    inputBinding:
      position: 101
      prefix: -i
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: Set the mapping quality for the BAM records.
    default: 255
    inputBinding:
      position: 101
      prefix: -mapq
  - id: uncompressed_bam
    type:
      - 'null'
      - boolean
    doc: Write uncompressed BAM output. Default writes compressed BAM.
    inputBinding:
      position: 101
      prefix: -ubam
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_bedtobam.out
