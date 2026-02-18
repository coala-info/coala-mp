cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - map
label: bedtools_map
doc: "Apply a function to a column from B intervals that overlap A.\n\nTool homepage:
  https://bedtools.readthedocs.io/"
inputs:
  - id: columns
    type:
      - 'null'
      - string
    doc: Specify columns from the B file to map onto intervals in A. Multiple 
      columns can be specified in a comma-delimited list.
    default: '5'
    inputBinding:
      position: 101
      prefix: -c
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Specify a custom delimiter for the collapse operations.
    default: ','
    inputBinding:
      position: 101
      prefix: -delim
  - id: either_fraction
    type:
      - 'null'
      - boolean
    doc: Require that the minimum fraction be satisfied for A OR B.
    inputBinding:
      position: 101
      prefix: -e
  - id: genome_file
    type:
      - 'null'
      - File
    doc: Provide a genome file to enforce consistent chromosome sort order 
      across input files. Only applies when used with -sorted option.
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
  - id: input_a
    type: File
    doc: The A input file (bed/gff/vcf).
    inputBinding:
      position: 101
      prefix: -a
  - id: input_b
    type: File
    doc: The B input file (bed/gff/vcf).
    inputBinding:
      position: 101
      prefix: -b
  - id: input_buffer_size
    type:
      - 'null'
      - string
    doc: Specify amount of memory to use for input buffer (e.g. 10M, 1G).
    inputBinding:
      position: 101
      prefix: -iobuf
  - id: no_buffer
    type:
      - 'null'
      - boolean
    doc: Disable buffered output.
    inputBinding:
      position: 101
      prefix: -nobuf
  - id: no_name_check
    type:
      - 'null'
      - boolean
    doc: For sorted data, don't throw an error if the file has different naming 
      conventions for the same chromosome.
    inputBinding:
      position: 101
      prefix: -nonamecheck
  - id: operation
    type:
      - 'null'
      - string
    doc: Specify the operation that should be applied to -c (sum, min, max, 
      mean, etc.). Multiple operations can be specified in a comma-delimited 
      list.
    default: sum
    inputBinding:
      position: 101
      prefix: -o
  - id: opposite_strand
    type:
      - 'null'
      - boolean
    doc: Require different strandedness. Only report hits in B that overlap A on
      the opposite strand.
    inputBinding:
      position: 101
      prefix: -S
  - id: output_bed
    type:
      - 'null'
      - boolean
    doc: If using BAM input, write output as BED.
    inputBinding:
      position: 101
      prefix: -bed
  - id: overlap_fraction_a
    type:
      - 'null'
      - float
    doc: Minimum overlap required as a fraction of A.
    default: '1E-9'
    inputBinding:
      position: 101
      prefix: -f
  - id: overlap_fraction_b
    type:
      - 'null'
      - float
    doc: Minimum overlap required as a fraction of B.
    default: '1E-9'
    inputBinding:
      position: 101
      prefix: -F
  - id: precision
    type:
      - 'null'
      - int
    doc: Sets the decimal precision for output.
    default: 5
    inputBinding:
      position: 101
      prefix: -prec
  - id: reciprocal
    type:
      - 'null'
      - boolean
    doc: Require that the fraction overlap be reciprocal for A AND B.
    inputBinding:
      position: 101
      prefix: -r
  - id: same_strand
    type:
      - 'null'
      - boolean
    doc: Require same strandedness. Only report hits in B that overlap A on the 
      same strand.
    inputBinding:
      position: 101
      prefix: -s
  - id: split
    type:
      - 'null'
      - boolean
    doc: Treat "split" BAM or BED12 entries as distinct BED intervals.
    inputBinding:
      position: 101
      prefix: -split
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_map.out
