cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - groupby
label: bedtools_groupby
doc: "Summarizes a dataset column based upon common column groupings. Akin to the
  SQL \"group by\" command.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Specify a custom delimiter for the collapse operations.
    default: ','
    inputBinding:
      position: 101
      prefix: -delim
  - id: full_columns
    type:
      - 'null'
      - boolean
    doc: Print all columns from input file. The first line in the group is used.
    inputBinding:
      position: 101
      prefix: -full
  - id: group_columns
    type:
      - 'null'
      - string
    doc: Specify the columns (1-based) for the grouping. The columns must be 
      comma separated.
    default: 1,2,3
    inputBinding:
      position: 101
      prefix: -grp
  - id: header
    type:
      - 'null'
      - boolean
    doc: Same as '-inheader -outheader'
    inputBinding:
      position: 101
      prefix: -header
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Group values regardless of upper/lower case.
    inputBinding:
      position: 101
      prefix: -ignorecase
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file. Assumes "stdin" if omitted.
    inputBinding:
      position: 101
      prefix: -i
  - id: input_header
    type:
      - 'null'
      - boolean
    doc: Input file has a header line - the first line will be ignored.
    inputBinding:
      position: 101
      prefix: -inheader
  - id: operation_columns
    type: string
    doc: Specify the column (1-based) that should be summarized.
    inputBinding:
      position: 101
      prefix: -opCols
  - id: operations
    type:
      - 'null'
      - string
    doc: Specify the operation that should be applied to opCol (sum, count, 
      count_distinct, min, max, mean, median, mode, antimode, stdev, sstdev, 
      collapse, distinct, distinct_sort_num, distinct_sort_num_desc, concat, 
      freqdesc, freqasc, first, last).
    default: sum
    inputBinding:
      position: 101
      prefix: -ops
  - id: output_header
    type:
      - 'null'
      - boolean
    doc: Print header line in the output, detailing the column names.
    inputBinding:
      position: 101
      prefix: -outheader
  - id: precision
    type:
      - 'null'
      - int
    doc: Sets the decimal precision for output
    default: 5
    inputBinding:
      position: 101
      prefix: -prec
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_groupby.out
