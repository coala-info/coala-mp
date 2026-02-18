cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - bamtobed
label: bedtools_bamtobed
doc: "Converts BAM alignments to BED6 or BEDPE format.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: bed12
    type:
      - 'null'
      - boolean
    doc: Write "blocked" BED format (aka "BED12"). Forces -split.
    inputBinding:
      position: 101
      prefix: -bed12
  - id: bedpe
    type:
      - 'null'
      - boolean
    doc: Write BEDPE format. Requires BAM to be grouped or sorted by query.
    inputBinding:
      position: 101
      prefix: -bedpe
  - id: cigar
    type:
      - 'null'
      - boolean
    doc: Add the CIGAR string to the BED entry as a 7th column.
    inputBinding:
      position: 101
      prefix: -cigar
  - id: color
    type:
      - 'null'
      - string
    doc: An R,G,B string for the color used with BED12 format.
    default: 255,0,0
    inputBinding:
      position: 101
      prefix: -color
  - id: edit_distance_score
    type:
      - 'null'
      - boolean
    doc: Use BAM edit distance (NM tag) for BED score.
    inputBinding:
      position: 101
      prefix: -ed
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: -i
  - id: mate1
    type:
      - 'null'
      - boolean
    doc: When writing BEDPE (-bedpe) format, always report mate one as the first
      BEDPE "block".
    inputBinding:
      position: 101
      prefix: -mate1
  - id: split
    type:
      - 'null'
      - boolean
    doc: Report "split" BAM alignments as separate BED entries. Splits only on N
      CIGAR operations.
    inputBinding:
      position: 101
      prefix: -split
  - id: split_d
    type:
      - 'null'
      - boolean
    doc: Split alignments based on N and D CIGAR operators. Forces -split.
    inputBinding:
      position: 101
      prefix: -splitD
  - id: tag
    type:
      - 'null'
      - string
    doc: Use other NUMERIC BAM alignment tag for BED score. Disallowed with 
      BEDPE output.
    inputBinding:
      position: 101
      prefix: -tag
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_bamtobed.out
