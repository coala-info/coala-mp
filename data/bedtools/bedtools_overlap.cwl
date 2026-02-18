cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - overlap
label: bedtools_overlap
doc: "Computes the amount of overlap (positive values) or distance (negative values)
  between genome features and reports the result at the end of the same line.\n\n\
  Tool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: columns
    type: string
    doc: "Specify the columns (1-based) for the starts and ends of the features for
      which you'd like to compute the overlap/distance. The columns must be listed
      in the following order: start1,end1,start2,end2"
    inputBinding:
      position: 101
      prefix: -cols
  - id: input_file
    type: File
    doc: Input file. Use "stdin" for pipes.
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
stdout: bedtools_overlap.out
