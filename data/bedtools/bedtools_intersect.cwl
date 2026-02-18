cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - intersect
label: bedtools_intersect
doc: "Report overlaps between two feature files.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: count
    type:
      - 'null'
      - boolean
    doc: For each entry in A, report the number of overlaps with B. Reports 0 
      for A entries that have no overlap with B.
    inputBinding:
      position: 101
      prefix: -c
  - id: count_separate
    type:
      - 'null'
      - boolean
    doc: For each entry in A, separately report the number of overlaps with each
      B file on a distinct line.
    inputBinding:
      position: 101
      prefix: -C
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
  - id: filenames
    type:
      - 'null'
      - boolean
    doc: When using multiple databases, show each complete filename instead of a
      fileId when also printing the DB record.
    inputBinding:
      position: 101
      prefix: -filenames
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
    doc: The A input file (bed/gff/vcf/bam).
    inputBinding:
      position: 101
      prefix: -a
  - id: input_b
    type:
      type: array
      items: File
    doc: One or more B input files (bed/gff/vcf/bam).
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
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: Only report those entries in A that have no overlaps with B.
    inputBinding:
      position: 101
      prefix: -v
  - id: left_outer_join
    type:
      - 'null'
      - boolean
    doc: Perform a 'left outer join'. That is, for each feature in A report each
      overlap with B. If no overlaps are found, report a NULL feature for B.
    inputBinding:
      position: 101
      prefix: -loj
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: When using multiple databases, provide an alias for each that will 
      appear instead of a fileId when also printing the DB record.
    inputBinding:
      position: 101
      prefix: -names
  - id: no_buf
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
    doc: Require same strandedness. That is, only report hits in B that overlap 
      A on the same strand.
    inputBinding:
      position: 101
      prefix: -s
  - id: sort_output
    type:
      - 'null'
      - boolean
    doc: When using multiple databases, sort the output DB hits for each record.
    inputBinding:
      position: 101
      prefix: -sortout
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Use the 'chromsweep' algorithm for sorted (-k1,1 -k2,2n) input.
    inputBinding:
      position: 101
      prefix: -sorted
  - id: split
    type:
      - 'null'
      - boolean
    doc: Treat 'split' BAM or BED12 entries as distinct BED intervals.
    inputBinding:
      position: 101
      prefix: -split
  - id: uncompressed_bam
    type:
      - 'null'
      - boolean
    doc: Write uncompressed BAM output. Default writes compressed BAM.
    inputBinding:
      position: 101
      prefix: -ubam
  - id: unique
    type:
      - 'null'
      - boolean
    doc: Write the original A entry once if any overlaps found in B.
    inputBinding:
      position: 101
      prefix: -u
  - id: write_a
    type:
      - 'null'
      - boolean
    doc: Write the original entry in A for each overlap.
    inputBinding:
      position: 101
      prefix: -wa
  - id: write_all_overlap
    type:
      - 'null'
      - boolean
    doc: Write the original A and B entries plus the number of base pairs of 
      overlap between the two features. Overlapping features restricted by -f 
      and -r. However, A features w/o overlap are also reported with a NULL B 
      feature and overlap = 0.
    inputBinding:
      position: 101
      prefix: -wao
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
stdout: bedtools_intersect.out
