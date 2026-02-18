cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - random
label: bedtools_random
doc: "Generate random intervals among a genome.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: genome
    type: File
    doc: 'The genome file should tab delimited and structured as follows: <chromName><TAB><chromSize>'
    inputBinding:
      position: 101
      prefix: -g
  - id: length
    type:
      - 'null'
      - int
    doc: The length of the intervals to generate.
    default: 100
    inputBinding:
      position: 101
      prefix: -l
  - id: number
    type:
      - 'null'
      - int
    doc: The number of intervals to generate.
    default: 1000000
    inputBinding:
      position: 101
      prefix: -n
  - id: seed
    type:
      - 'null'
      - int
    doc: Supply an integer seed for the shuffling. By default, the seed is 
      chosen automatically.
    inputBinding:
      position: 101
      prefix: -seed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_random.out
