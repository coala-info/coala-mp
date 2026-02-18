cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - sort
label: bedtools_sort
doc: "Sorts a feature file in various and useful ways.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: chr_then_score_a
    type:
      - 'null'
      - boolean
    doc: Sort by chrom (asc), then score (asc).
    inputBinding:
      position: 101
      prefix: -chrThenScoreA
  - id: chr_then_score_d
    type:
      - 'null'
      - boolean
    doc: Sort by chrom (asc), then score (desc).
    inputBinding:
      position: 101
      prefix: -chrThenScoreD
  - id: chr_then_size_a
    type:
      - 'null'
      - boolean
    doc: Sort by chrom (asc), then feature size (asc).
    inputBinding:
      position: 101
      prefix: -chrThenSizeA
  - id: chr_then_size_d
    type:
      - 'null'
      - boolean
    doc: Sort by chrom (asc), then feature size (desc).
    inputBinding:
      position: 101
      prefix: -chrThenSizeD
  - id: faidx
    type:
      - 'null'
      - File
    doc: Sort according to the chromosomes declared in "names.txt"
    inputBinding:
      position: 101
      prefix: -faidx
  - id: genome
    type:
      - 'null'
      - File
    doc: Sort according to the chromosomes declared in "genome.txt"
    inputBinding:
      position: 101
      prefix: -g
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print the header from the A file prior to results.
    inputBinding:
      position: 101
      prefix: -header
  - id: input_file
    type: File
    doc: Input bed/gff/vcf file
    inputBinding:
      position: 101
      prefix: -i
  - id: size_a
    type:
      - 'null'
      - boolean
    doc: Sort by feature size in ascending order.
    inputBinding:
      position: 101
      prefix: -sizeA
  - id: size_d
    type:
      - 'null'
      - boolean
    doc: Sort by feature size in descending order.
    inputBinding:
      position: 101
      prefix: -sizeD
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_sort.out
