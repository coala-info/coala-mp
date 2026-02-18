cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - pairtopair
label: bedtools_pairtopair
doc: "Report overlaps between two paired-end BED files (BEDPE).\n\nTool homepage:
  https://bedtools.readthedocs.io/"
inputs:
  - id: bedpe_a
    type: File
    doc: First paired-end BED file (BEDPE).
    inputBinding:
      position: 101
      prefix: -a
  - id: bedpe_b
    type: File
    doc: Second paired-end BED file (BEDPE).
    inputBinding:
      position: 101
      prefix: -b
  - id: ignore_strands
    type:
      - 'null'
      - boolean
    doc: Ignore strands when searching for overlaps. By default, strands are 
      enforced.
    inputBinding:
      position: 101
      prefix: -is
  - id: min_overlap_fraction
    type:
      - 'null'
      - float
    doc: Minimum overlap required as fraction of A (e.g. 0.05). Default is 1E-9 
      (effectively 1bp).
    default: '1E-9'
    inputBinding:
      position: 101
      prefix: -f
  - id: overlap_type
    type:
      - 'null'
      - string
    doc: 'Approach to reporting overlaps between A and B. Options: neither, either,
      both, notboth.'
    default: both
    inputBinding:
      position: 101
      prefix: -type
  - id: require_different_names
    type:
      - 'null'
      - boolean
    doc: Require the hits to have different names (i.e. avoid self-hits). By 
      default, same names are allowed.
    inputBinding:
      position: 101
      prefix: -rdn
  - id: slop
    type:
      - 'null'
      - int
    doc: The amount of slop (in b.p.). to be added to each footprint of A. Slop 
      is subtracted from start1 and start2 and added to end1 and end2.
    default: 0
    inputBinding:
      position: 101
      prefix: -slop
  - id: strand_slop
    type:
      - 'null'
      - boolean
    doc: Add slop based to each BEDPE footprint based on strand. If strand is 
      '+', slop is only added to the end coordinates. If strand is '-', slop is 
      only added to the start coordinates.
    inputBinding:
      position: 101
      prefix: -ss
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_pairtopair.out
