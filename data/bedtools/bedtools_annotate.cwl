cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - annotate
label: bedtools_annotate
doc: "Annotates the depth & breadth of coverage of features from multiple files on
  the intervals in -i.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: both
    type:
      - 'null'
      - boolean
    doc: Report the counts followed by the % coverage. Default is to report the 
      fraction of -i covered by each file.
    inputBinding:
      position: 101
      prefix: -both
  - id: counts
    type:
      - 'null'
      - boolean
    doc: Report the count of features in each file that overlap -i. Default is 
      to report the fraction of -i covered by each file.
    inputBinding:
      position: 101
      prefix: -counts
  - id: diff_strand
    type:
      - 'null'
      - boolean
    doc: Require different strandedness. That is, only count overlaps on the 
      opposite strand.
    inputBinding:
      position: 101
      prefix: -S
  - id: files
    type:
      type: array
      items: File
    doc: A list of files to use for annotating the intervals in -i.
    inputBinding:
      position: 101
      prefix: -files
  - id: input_file
    type: File
    doc: The input bed/gff/vcf file to be annotated.
    inputBinding:
      position: 101
      prefix: -i
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of names (one / file) to describe each file in -files. These 
      names will be printed as a header line.
    inputBinding:
      position: 101
      prefix: -names
  - id: same_strand
    type:
      - 'null'
      - boolean
    doc: Require same strandedness. That is, only counts overlaps on the same 
      strand.
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
stdout: bedtools_annotate.out
