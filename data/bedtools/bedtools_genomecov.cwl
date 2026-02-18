cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - genomecov
label: bedtools_genomecov
doc: "Compute the coverage of a feature file among a genome.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: change_mate_strand
    type:
      - 'null'
      - boolean
    doc: Change strand of the mate read (so both reads from the same strand) 
      useful for strand specific. Works for BAM files only.
    inputBinding:
      position: 101
      prefix: -du
  - id: five_prime
    type:
      - 'null'
      - boolean
    doc: Calculate coverage of 5" positions (instead of entire interval).
    inputBinding:
      position: 101
      prefix: '-5'
  - id: fragment_size
    type:
      - 'null'
      - boolean
    doc: Force to use provided fragment size instead of read length. Works for 
      BAM files only.
    inputBinding:
      position: 101
      prefix: -fs
  - id: genome_file
    type:
      - 'null'
      - File
    doc: Provide a genome file to define chromosome lengths. Required when not 
      using -ibam.
    inputBinding:
      position: 101
      prefix: -g
  - id: ignore_deletions
    type:
      - 'null'
      - boolean
    doc: Ignore local deletions (CIGAR "D" operations) in BAM entries when 
      computing coverage.
    inputBinding:
      position: 101
      prefix: -ignoreD
  - id: input_bam
    type:
      - 'null'
      - File
    doc: 'The input file is in BAM format. Note: BAM must be sorted by position.'
    inputBinding:
      position: 101
      prefix: -ibam
  - id: input_file
    type:
      - 'null'
      - File
    doc: The input file in BED/GFF/VCF format. Required when not using -ibam.
    inputBinding:
      position: 101
      prefix: -i
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Combine all positions with a depth >= max into a single bin in the 
      histogram.
    inputBinding:
      position: 101
      prefix: -max
  - id: pair_end
    type:
      - 'null'
      - boolean
    doc: Calculate coverage of pair-end fragments. Works for BAM files only.
    inputBinding:
      position: 101
      prefix: -pc
  - id: report_bedgraph
    type:
      - 'null'
      - boolean
    doc: Report depth in BedGraph format.
    inputBinding:
      position: 101
      prefix: -bg
  - id: report_bedgraph_all
    type:
      - 'null'
      - boolean
    doc: Report depth in BedGraph format, including regions with zero coverage.
    inputBinding:
      position: 101
      prefix: -bga
  - id: report_depth_one_based
    type:
      - 'null'
      - boolean
    doc: Report the depth at each genome position (with one-based coordinates). 
      Default behavior is to report a histogram.
    inputBinding:
      position: 101
      prefix: -d
  - id: report_depth_zero_based
    type:
      - 'null'
      - boolean
    doc: Report the depth at each genome position (with zero-based coordinates).
      Reports only non-zero positions.
    inputBinding:
      position: 101
      prefix: -dz
  - id: scale
    type:
      - 'null'
      - float
    doc: Scale the coverage by a constant factor.
    default: 1.0
    inputBinding:
      position: 101
      prefix: -scale
  - id: split
    type:
      - 'null'
      - boolean
    doc: Treat "split" BAM or BED12 entries as distinct BED intervals.
    inputBinding:
      position: 101
      prefix: -split
  - id: strand
    type:
      - 'null'
      - string
    doc: Calculate coverage of intervals from a specific strand. Can be + or -.
    inputBinding:
      position: 101
      prefix: -strand
  - id: three_prime
    type:
      - 'null'
      - boolean
    doc: Calculate coverage of 3" positions (instead of entire interval).
    inputBinding:
      position: 101
      prefix: '-3'
  - id: trackline
    type:
      - 'null'
      - boolean
    doc: Adds a UCSC/Genome-Browser track line definition in the first line of 
      the output.
    inputBinding:
      position: 101
      prefix: -trackline
  - id: trackopts
    type:
      - 'null'
      - string
    doc: Writes additional track line definition parameters in the first line.
    inputBinding:
      position: 101
      prefix: -trackopts
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_genomecov.out
