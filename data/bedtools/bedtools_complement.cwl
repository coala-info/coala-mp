cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - complement
label: bedtools_complement
doc: "Returns the base pair complement of a feature file.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: genome_file
    type: File
    doc: 'Genome file (tab delimited: <chromName><TAB><chromSize>)'
    inputBinding:
      position: 101
      prefix: -g
  - id: input_file
    type: File
    doc: Input BED/GFF/VCF file
    inputBinding:
      position: 101
      prefix: -i
  - id: limit_chromosomes
    type:
      - 'null'
      - boolean
    doc: Limit output to solely the chromosomes with records in the input file.
    inputBinding:
      position: 101
      prefix: -L
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_complement.out
