cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - multiinter
label: bedtools_multiinter
doc: "Identifies common intervals among multiple BED/GFF/VCF files.\n\nTool homepage:
  https://bedtools.readthedocs.io/"
inputs:
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: Cluster the overlapping features.
    inputBinding:
      position: 101
      prefix: -cluster
  - id: empty
    type:
      - 'null'
      - boolean
    doc: Report empty regions (i.e., regions not covered by any file).
    inputBinding:
      position: 101
      prefix: -empty
  - id: filler
    type:
      - 'null'
      - string
    doc: Text to use for empty regions.
    inputBinding:
      position: 101
      prefix: -filler
  - id: genome
    type:
      - 'null'
      - File
    doc: Genome file (required for -empty).
    inputBinding:
      position: 101
      prefix: -g
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print a header line.
    inputBinding:
      position: 101
      prefix: -header
  - id: input_files
    type:
      type: array
      items: File
    doc: A list of names (one/file) to describe each file in -i.
    inputBinding:
      position: 101
      prefix: -i
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of labels (one/file) to describe each file in -i.
    inputBinding:
      position: 101
      prefix: -labels
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of names (one/file) to describe each file in -i.
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
stdout: bedtools_multiinter.out
