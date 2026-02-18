cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - subtract
label: bedtools_subtract
doc: "Removes the portion(s) of an interval that is overlapped by another feature(s).\n\
  \nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: diff_strand
    type:
      - 'null'
      - boolean
    doc: Require different strandedness. That is, only report hits in B that 
      overlap A on the opposite strand.
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
  - id: genome
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
    doc: Main input file (BED/GFF/VCF)
    inputBinding:
      position: 101
      prefix: -a
  - id: input_b
    type: File
    doc: Feature file to subtract (BED/GFF/VCF)
    inputBinding:
      position: 101
      prefix: -b
  - id: input_buffer_size
    type:
      - 'null'
      - string
    doc: Specify amount of memory to use for input buffer. Takes an integer 
      argument. Optional suffixes K/M/G supported.
    inputBinding:
      position: 101
      prefix: -iobuf
  - id: min_overlap_a
    type:
      - 'null'
      - float
    doc: Minimum overlap required as a fraction of A.
    default: '1E-9'
    inputBinding:
      position: 101
      prefix: -f
  - id: min_overlap_b
    type:
      - 'null'
      - float
    doc: Minimum overlap required as a fraction of B.
    default: '1E-9'
    inputBinding:
      position: 101
      prefix: -F
  - id: no_buf
    type:
      - 'null'
      - boolean
    doc: Disable buffered output. Using this option will cause each line of 
      output to be printed as it is generated.
    inputBinding:
      position: 101
      prefix: -nobuf
  - id: no_name_check
    type:
      - 'null'
      - boolean
    doc: For sorted data, don't throw an error if the file has different naming 
      conventions for the same chromosome. ex. "chr1" vs "chr01".
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
  - id: reciprocal
    type:
      - 'null'
      - boolean
    doc: Require that the fraction overlap be reciprocal for A AND B.
    inputBinding:
      position: 101
      prefix: -r
  - id: remove_entire
    type:
      - 'null'
      - boolean
    doc: Remove entire feature if any overlap. That is, by default, only 
      subtract the portion of A that overlaps B. Here, if any overlap is found 
      (or -f amount), the entire feature is removed.
    inputBinding:
      position: 101
      prefix: -A
  - id: remove_entire_sum
    type:
      - 'null'
      - boolean
    doc: Same as -A except when used with -f, the amount is the sum of all 
      features (not any single feature).
    inputBinding:
      position: 101
      prefix: -N
  - id: same_strand
    type:
      - 'null'
      - boolean
    doc: Require same strandedness. That is, only report hits in B that overlap 
      A on the same strand.
    inputBinding:
      position: 101
      prefix: -s
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Use the "chromsweep" algorithm for sorted (-k1,1 -k2,2n) input.
    inputBinding:
      position: 101
      prefix: -sorted
  - id: split
    type:
      - 'null'
      - boolean
    doc: Treat "split" BAM or BED12 entries as distinct BED intervals.
    inputBinding:
      position: 101
      prefix: -split
  - id: write_b
    type:
      - 'null'
      - boolean
    doc: Write the original entry in B for each overlap. Useful for knowing what
      A overlaps. Restricted by -f and -r.
    inputBinding:
      position: 101
      prefix: -wb
  - id: write_overlap
    type:
      - 'null'
      - boolean
    doc: Write the original A and B entries plus the number of base pairs of 
      overlap between the two features. Overlaps restricted by -f and -r. Only A
      features with overlap are reported.
    inputBinding:
      position: 101
      prefix: -wo
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_subtract.out
