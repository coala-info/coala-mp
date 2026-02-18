cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - sample
label: bedtools_sample
doc: "Take sample of input file(s) using reservoir sampling algorithm.\n\nTool homepage:
  https://bedtools.readthedocs.io/"
inputs:
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print the header from the input file prior to results.
    inputBinding:
      position: 101
      prefix: -header
  - id: input_buffer_size
    type:
      - 'null'
      - string
    doc: Specify amount of memory to use for input buffer. Takes an integer 
      argument. Optional suffixes K/M/G supported.
    inputBinding:
      position: 101
      prefix: -iobuf
  - id: input_file
    type: File
    doc: Input bed/gff/vcf/bam file
    inputBinding:
      position: 101
      prefix: -i
  - id: no_buffer
    type:
      - 'null'
      - boolean
    doc: Disable buffered output. Using this option will cause each line of 
      output to be printed as it is generated, rather than saved in a buffer.
    inputBinding:
      position: 101
      prefix: -nobuf
  - id: number_of_records
    type:
      - 'null'
      - int
    doc: The number of records to generate.
    default: 1000000
    inputBinding:
      position: 101
      prefix: -n
  - id: same_strandedness
    type:
      - 'null'
      - string
    doc: Require same strandedness. That is, only give records that have the 
      same strand. Use '-s forward' or '-s reverse' for forward or reverse 
      strand records, respectively.
    inputBinding:
      position: 101
      prefix: -s
  - id: seed
    type:
      - 'null'
      - int
    doc: Supply an integer seed for the shuffling.
    inputBinding:
      position: 101
      prefix: -seed
  - id: uncompressed_bam
    type:
      - 'null'
      - boolean
    doc: Write uncompressed BAM output. Default writes compressed BAM.
    inputBinding:
      position: 101
      prefix: -ubam
  - id: write_as_bed
    type:
      - 'null'
      - boolean
    doc: If using BAM input, write output as BED.
    inputBinding:
      position: 101
      prefix: -bed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_sample.out
