cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - summary
label: bedtools_summary
doc: "Report summary statistics of the intervals in a file\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: genome_file
    type: File
    doc: 'Genome file (tab delimited: <chromName><TAB><chromSize>)'
    inputBinding:
      position: 101
      prefix: -g
  - id: input_file
    type: File
    doc: Input file (bed/gff/vcf/bam)
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
stdout: bedtools_summary.out
