cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - window
label: bedtools_window
doc: "Examines a \"window\" around each feature in A and reports all features in B
  that overlap the window. For each overlap the entire entry in A and B are reported.\n\
  \nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: count
    type:
      - 'null'
      - boolean
    doc: For each entry in A, report the number of overlaps with B.
    inputBinding:
      position: 101
      prefix: -c
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print the header from the A file prior to results.
    inputBinding:
      position: 101
      prefix: -header
  - id: input_a
    type:
      - 'null'
      - File
    doc: The A input file (BED/GFF/VCF).
    inputBinding:
      position: 101
      prefix: -a
  - id: input_a_bam
    type:
      - 'null'
      - File
    doc: The A input file is in BAM format. Output will be BAM as well. Replaces
      -a.
    inputBinding:
      position: 101
      prefix: -abam
  - id: input_b
    type: File
    doc: The B input file (BED/GFF/VCF).
    inputBinding:
      position: 101
      prefix: -b
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: Only report those entries in A that have no overlaps with B.
    inputBinding:
      position: 101
      prefix: -v
  - id: left_window
    type:
      - 'null'
      - int
    doc: Base pairs added upstream (left of) of each entry in A when searching 
      for overlaps in B. Allows one to define asymmetrical "windows".
    default: 1000
    inputBinding:
      position: 101
      prefix: -l
  - id: opposite_strand
    type:
      - 'null'
      - boolean
    doc: Only report hits in B that overlap A on the opposite strand.
    inputBinding:
      position: 101
      prefix: -Sm
  - id: output_bed
    type:
      - 'null'
      - boolean
    doc: When using BAM input (-abam), write output as BED. The default is to 
      write output in BAM when using -abam.
    inputBinding:
      position: 101
      prefix: -bed
  - id: right_window
    type:
      - 'null'
      - int
    doc: Base pairs added downstream (right of) of each entry in A when 
      searching for overlaps in B. Allows one to define asymmetrical "windows".
    default: 1000
    inputBinding:
      position: 101
      prefix: -r
  - id: same_strand
    type:
      - 'null'
      - boolean
    doc: Only report hits in B that overlap A on the same strand.
    inputBinding:
      position: 101
      prefix: -sm
  - id: strand_window
    type:
      - 'null'
      - boolean
    doc: Define -l and -r based on strand. For example if used, -l 500 for a 
      negative-stranded feature will add 500 bp downstream.
    inputBinding:
      position: 101
      prefix: -sw
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
  - id: window_size
    type:
      - 'null'
      - int
    doc: Base pairs added upstream and downstream of each entry in A when 
      searching for overlaps in B. Creates symmetrical "windows" around A.
    default: 1000
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_window.out
