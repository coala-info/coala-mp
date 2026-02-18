cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - links
label: bedtools_links
doc: "Creates HTML links to an UCSC Genome Browser from a feature file.\n\nTool homepage:
  https://bedtools.readthedocs.io/"
inputs:
  - id: base_url
    type:
      - 'null'
      - string
    doc: The browser basename.
    default: http://genome.ucsc.edu
    inputBinding:
      position: 101
      prefix: -base
  - id: db_build
    type:
      - 'null'
      - string
    doc: The build.
    default: hg18
    inputBinding:
      position: 101
      prefix: -db
  - id: input_file
    type: File
    doc: The input bed/gff/vcf file
    inputBinding:
      position: 101
      prefix: -i
  - id: organism
    type:
      - 'null'
      - string
    doc: The organism.
    default: human
    inputBinding:
      position: 101
      prefix: -org
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_links.out
