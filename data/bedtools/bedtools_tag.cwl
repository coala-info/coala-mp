cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - tag
label: bedtools_tag
doc: "Annotates a BAM file based on overlaps with multiple BED/GFF/VCF files on the
  intervals in -i.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: annotation_files
    type:
      type: array
      items: File
    doc: Annotation files (BED/GFF/VCF) to check for overlaps.
    inputBinding:
      position: 101
      prefix: -files
  - id: input_bam
    type: File
    doc: Input BAM file to be annotated.
    inputBinding:
      position: 101
      prefix: -i
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Labels to use for each file. Required if -names or -scores are not 
      used.
    inputBinding:
      position: 101
      prefix: -labels
  - id: min_overlap
    type:
      - 'null'
      - float
    doc: Minimum overlap required as a fraction of the alignment. Default is 
      1E-9 (i.e., 1bp).
    default: '1E-9'
    inputBinding:
      position: 101
      prefix: -f
  - id: opposite_strand
    type:
      - 'null'
      - boolean
    doc: Require overlaps on the opposite strand. That is, only tag alignments 
      that have the opposite strand as a feature in the annotation file(s).
    inputBinding:
      position: 101
      prefix: -S
  - id: same_strand
    type:
      - 'null'
      - boolean
    doc: Require overlaps on the same strand. That is, only tag alignments that 
      have the same strand as a feature in the annotation file(s).
    inputBinding:
      position: 101
      prefix: -s
  - id: tag_id
    type:
      - 'null'
      - string
    doc: Dictate what the tag should be. Default is YB (two characters, e.g., 
      YK).
    default: YB
    inputBinding:
      position: 101
      prefix: -tag
  - id: use_intervals
    type:
      - 'null'
      - boolean
    doc: Use the full interval (including name, score, and strand) to populate 
      tags. Requires the -labels option to identify from which file the interval
      came.
    inputBinding:
      position: 101
      prefix: -intervals
  - id: use_names
    type:
      - 'null'
      - boolean
    doc: Use the name field from the annotation files to populate tags. By 
      default, the -labels values are used.
    inputBinding:
      position: 101
      prefix: -names
  - id: use_scores
    type:
      - 'null'
      - boolean
    doc: Use the score field from the annotation files to populate tags. By 
      default, the -labels values are used.
    inputBinding:
      position: 101
      prefix: -scores
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_tag.out
