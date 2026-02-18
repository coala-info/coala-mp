cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - unionbedg
label: bedtools_unionbedg
doc: "Combines multiple BedGraph files into a single file such that one can directly
  compare coverage (and other BedGraph values) across multiple samples.\n\nTool homepage:
  https://bedtools.readthedocs.io/"
inputs:
  - id: empty
    type:
      - 'null'
      - boolean
    doc: Report empty regions (i.e., regions not covered by any of the input 
      files). Requires -g.
    inputBinding:
      position: 101
      prefix: -empty
  - id: filler
    type:
      - 'null'
      - string
    doc: TEXT to use for empty regions.
    default: '0'
    inputBinding:
      position: 101
      prefix: -filler
  - id: genome
    type:
      - 'null'
      - File
    doc: 'Genome file. The genome file should be tab-delimited and have two columns:
      <chrom> <size>. Note: This is only required if you want to include chromosomes
      that are not present in the input files.'
    inputBinding:
      position: 101
      prefix: -g
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print a header line. (Requires -names)
    inputBinding:
      position: 101
      prefix: -header
  - id: input_files
    type:
      type: array
      items: File
    doc: List of BedGraph files to combine. Each must be sorted by chrom, then 
      start.
    inputBinding:
      position: 101
      prefix: -i
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of names (one/file) to describe each file in -i. These names 
      will be printed in the header line.
    inputBinding:
      position: 101
      prefix: -names
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_unionbedg.out
