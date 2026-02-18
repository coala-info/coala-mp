cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - multicov
label: bedtools_multicov
doc: "Counts sequence coverage for multiple bams at specific loci.\n\nTool homepage:
  https://bedtools.readthedocs.io/"
inputs:
  - id: bams
    type:
      type: array
      items: File
    doc: The bam files.
    inputBinding:
      position: 101
      prefix: -bams
  - id: bed
    type: File
    doc: The bed file.
    inputBinding:
      position: 101
      prefix: -bed
  - id: include_duplicates
    type:
      - 'null'
      - boolean
    doc: Include duplicate reads. Default counts non-duplicates only
    inputBinding:
      position: 101
      prefix: -D
  - id: include_failed_qc
    type:
      - 'null'
      - boolean
    doc: Include failed-QC reads. Default counts pass-QC reads only
    inputBinding:
      position: 101
      prefix: -F
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality allowed.
    default: 0
    inputBinding:
      position: 101
      prefix: -q
  - id: opposite_strand
    type:
      - 'null'
      - boolean
    doc: Require different strandedness. That is, only report hits in B that 
      overlap A on the opposite strand.
    inputBinding:
      position: 101
      prefix: -S
  - id: overlap_fraction
    type:
      - 'null'
      - float
    doc: Minimum overlap required as a fraction of each -bed record.
    default: '1E-9'
    inputBinding:
      position: 101
      prefix: -f
  - id: proper_pairs_only
    type:
      - 'null'
      - boolean
    doc: Only count proper pairs. Default counts all alignments with MAPQ > -q 
      argument, regardless of the BAM FLAG field.
    inputBinding:
      position: 101
      prefix: -p
  - id: reciprocal_overlap
    type:
      - 'null'
      - boolean
    doc: Require that the fraction overlap be reciprocal for each -bed and B.
    inputBinding:
      position: 101
      prefix: -r
  - id: same_strand
    type:
      - 'null'
      - boolean
    doc: Require same strandedness. That is, only report hits in B that overlap 
      A on the same strand.
    inputBinding:
      position: 101
      prefix: -s
  - id: split
    type:
      - 'null'
      - boolean
    doc: Treat "split" BAM or BED12 entries as distinct BED intervals.
    inputBinding:
      position: 101
      prefix: -split
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_multicov.out
