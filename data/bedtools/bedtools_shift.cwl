cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - shift
label: bedtools_shift
doc: "Shift each feature by requested number of base pairs.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
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
  - id: pct
    type:
      - 'null'
      - boolean
    doc: Define -s, -m and -p as a fraction of the feature's length.
    default: false
    inputBinding:
      position: 101
      prefix: -pct
  - id: shift_all
    type:
      - 'null'
      - float
    doc: Shift the BED/GFF/VCF entry -s base pairs. (Integer) or (Float, e.g. 
      0.1) if used with -pct.
    inputBinding:
      position: 101
      prefix: -s
  - id: shift_minus
    type:
      - 'null'
      - float
    doc: Shift features on the - strand by -m base pairs. (Integer) or (Float, 
      e.g. 0.1) if used with -pct.
    inputBinding:
      position: 101
      prefix: -m
  - id: shift_plus
    type:
      - 'null'
      - float
    doc: Shift features on the + strand by -p base pairs. (Integer) or (Float, 
      e.g. 0.1) if used with -pct.
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_shift.out
