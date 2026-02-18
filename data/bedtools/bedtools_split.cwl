cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - split
label: bedtools_split
doc: "Split a Bed file.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'Algorithm used to split data. size (default): uses a heuristic algorithm
      to group the items so all files contain the ~ same number of bases; simple :
      route records such that each split file has approximately equal records (like
      Unix split).'
    default: size
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: input
    type: File
    doc: BED input file (req'd).
    inputBinding:
      position: 101
      prefix: --input
  - id: number
    type: int
    doc: Number of files to create (req'd).
    inputBinding:
      position: 101
      prefix: --number
outputs:
  - id: prefix
    type:
      - 'null'
      - File
    doc: Output BED file prefix.
    outputBinding:
      glob: $(inputs.prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
