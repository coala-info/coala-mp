cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - flank
label: bedtools_flank
doc: "Creates flanking interval(s) for each BED/GFF/VCF feature.\n\nTool homepage:
  https://bedtools.readthedocs.io/"
inputs:
  - id: both
    type:
      - 'null'
      - float
    doc: Create flanking interval(s) using -b base pairs in each direction. 
      (Integer) or (Float, e.g. 0.1) if used with -pct.
    inputBinding:
      position: 101
      prefix: -b
  - id: genome_file
    type: File
    doc: 'Genome file (tab delimited: <chromName><TAB><chromSize>)'
    inputBinding:
      position: 101
      prefix: -g
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print the header from the input file prior to results.
    inputBinding:
      position: 101
      prefix: -header
  - id: input_file
    type: File
    doc: Input BED/GFF/VCF file
    inputBinding:
      position: 101
      prefix: -i
  - id: left
    type:
      - 'null'
      - float
    doc: The number of base pairs that a flank should start from orig. start 
      coordinate. (Integer) or (Float, e.g. 0.1) if used with -pct.
    inputBinding:
      position: 101
      prefix: -l
  - id: percentage
    type:
      - 'null'
      - boolean
    doc: Define -l and -r as a fraction of the feature's length.
    default: false
    inputBinding:
      position: 101
      prefix: -pct
  - id: right
    type:
      - 'null'
      - float
    doc: The number of base pairs that a flank should end from orig. end 
      coordinate. (Integer) or (Float, e.g. 0.1) if used with -pct.
    inputBinding:
      position: 101
      prefix: -r
  - id: strand_sensitive
    type:
      - 'null'
      - boolean
    doc: Define -l and -r based on strand. E.g. if used, -l 500 for a 
      negative-stranded feature, it will start the flank 500 bp downstream.
    default: false
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_flank.out
