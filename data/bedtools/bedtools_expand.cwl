cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - expand
label: bedtools_expand
doc: "Replicate lines in a file based on columns of comma-separated values.\n\nTool
  homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: columns
    type: string
    doc: Specify the column (1-based) that should be summarized. Multiple 
      columns can be specified as comma-separated values.
    inputBinding:
      position: 101
      prefix: -c
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file. Assumes "stdin" if omitted.
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_expand.out
