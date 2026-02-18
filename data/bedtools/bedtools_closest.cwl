cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - closest
label: bedtools_closest
doc: "For each feature in A, finds the closest feature (upstream or downstream) in
  B.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: db_names
    type:
      - 'null'
      - type: array
        items: string
    doc: When using multiple databases, provide an alias for each that will 
      appear instead of a fileId.
    inputBinding:
      position: 101
      prefix: -names
  - id: diff_names
    type:
      - 'null'
      - boolean
    doc: Require that the query and the closest hit have different names.
    inputBinding:
      position: 101
      prefix: -N
  - id: diff_strand
    type:
      - 'null'
      - boolean
    doc: Require different strandedness. Only report hits in B that overlap A on
      the opposite strand.
    inputBinding:
      position: 101
      prefix: -S
  - id: either_fraction
    type:
      - 'null'
      - boolean
    doc: Require that the minimum fraction be satisfied for A OR B.
    inputBinding:
      position: 101
      prefix: -e
  - id: first_downstream
    type:
      - 'null'
      - boolean
    doc: Choose first from features in B that are downstream of features in A. 
      This option requires -D.
    inputBinding:
      position: 101
      prefix: -fd
  - id: first_upstream
    type:
      - 'null'
      - boolean
    doc: Choose first from features in B that are upstream of features in A. 
      This option requires -D.
    inputBinding:
      position: 101
      prefix: -fu
  - id: genome_file
    type:
      - 'null'
      - File
    doc: Provide a genome file to enforce consistent chromosome sort order 
      across input files. Only applies when used with -sorted option.
    inputBinding:
      position: 101
      prefix: -g
  - id: ignore_downstream
    type:
      - 'null'
      - boolean
    doc: Ignore features in B that are downstream of features in A. This option 
      requires -D.
    inputBinding:
      position: 101
      prefix: -id
  - id: ignore_overlaps
    type:
      - 'null'
      - boolean
    doc: Ignore features in B that overlap A. That is, we want close, yet not 
      touching features only.
    inputBinding:
      position: 101
      prefix: -io
  - id: ignore_upstream
    type:
      - 'null'
      - boolean
    doc: Ignore features in B that are upstream of features in A. This option 
      requires -D.
    inputBinding:
      position: 101
      prefix: -iu
  - id: input_a
    type: File
    doc: Input BED/GFF/VCF file A
    inputBinding:
      position: 101
      prefix: -a
  - id: input_b
    type:
      type: array
      items: File
    doc: One or more BED/GFF/VCF file(s) B
    inputBinding:
      position: 101
      prefix: -b
  - id: input_buffer_size
    type:
      - 'null'
      - string
    doc: Specify amount of memory to use for input buffer (e.g. 10M).
    inputBinding:
      position: 101
      prefix: -iobuf
  - id: k_closest
    type:
      - 'null'
      - int
    doc: Report the k closest hits.
    default: 1
    inputBinding:
      position: 101
      prefix: -k
  - id: min_overlap_a
    type:
      - 'null'
      - float
    doc: Minimum overlap required as a fraction of A.
    default: 1e-09
    inputBinding:
      position: 101
      prefix: -f
  - id: min_overlap_b
    type:
      - 'null'
      - float
    doc: Minimum overlap required as a fraction of B.
    default: 1e-09
    inputBinding:
      position: 101
      prefix: -F
  - id: multiple_db_mode
    type:
      - 'null'
      - string
    doc: How multiple databases are resolved (each, all).
    default: each
    inputBinding:
      position: 101
      prefix: -mdb
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
  - id: output_bed
    type:
      - 'null'
      - boolean
    doc: If using BAM input, write output as BED.
    inputBinding:
      position: 101
      prefix: -bed
  - id: print_header
    type:
      - 'null'
      - boolean
    doc: Print the header from the A file prior to results.
    inputBinding:
      position: 101
      prefix: -header
  - id: reciprocal
    type:
      - 'null'
      - boolean
    doc: Require that the fraction overlap be reciprocal for A AND B.
    inputBinding:
      position: 101
      prefix: -r
  - id: report_distance
    type:
      - 'null'
      - boolean
    doc: In addition to the closest feature in B, report its distance to A as an
      extra column. The reported distance for overlapping features will be 0.
    inputBinding:
      position: 101
      prefix: -d
  - id: report_distance_oriented
    type:
      - 'null'
      - string
    doc: 'Like -d, report the closest feature in B, and its distance to A as an extra
      column. Unlike -d, use negative distances to report upstream features. Options:
      ref, a, b.'
    inputBinding:
      position: 101
      prefix: -D
  - id: same_strand
    type:
      - 'null'
      - boolean
    doc: Require same strandedness. Only report hits in B that overlap A on the 
      same strand.
    inputBinding:
      position: 101
      prefix: -s
  - id: show_filenames
    type:
      - 'null'
      - boolean
    doc: When using multiple databases, show each complete filename instead of a
      fileId.
    inputBinding:
      position: 101
      prefix: -filenames
  - id: sort_output
    type:
      - 'null'
      - boolean
    doc: When using multiple databases, sort the output DB hits for each record.
    inputBinding:
      position: 101
      prefix: -sortout
  - id: split_intervals
    type:
      - 'null'
      - boolean
    doc: Treat "split" BAM or BED12 entries as distinct BED intervals.
    inputBinding:
      position: 101
      prefix: -split
  - id: tie_mode
    type:
      - 'null'
      - string
    doc: How ties for closest feature are handled (all, first, last).
    default: all
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_closest.out
