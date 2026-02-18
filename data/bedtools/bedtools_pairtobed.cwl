cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - pairtobed
label: bedtools_pairtobed
doc: "Report overlaps between a BEDPE file and a BED/GFF/VCF file.\n\nTool homepage:
  https://bedtools.readthedocs.io/"
inputs:
  - id: diff_strand
    type:
      - 'null'
      - boolean
    doc: Require different strandedness when finding overlaps. Default is to 
      ignore strand. Not applicable with -type inspan or -type outspan.
    inputBinding:
      position: 101
      prefix: -S
  - id: edit_distance
    type:
      - 'null'
      - boolean
    doc: Use BAM total edit distance (NM tag) for BEDPE score. Default for BEDPE
      is to use the minimum of the two mapping qualities for the pair. When -ed 
      is used the total edit distance from the two mates is reported as the 
      score.
    inputBinding:
      position: 101
      prefix: -ed
  - id: input_a
    type:
      - 'null'
      - File
    doc: The A input file (BEDPE format).
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
    doc: The B input file (BED/GFF/VCF format).
    inputBinding:
      position: 101
      prefix: -b
  - id: output_bedpe
    type:
      - 'null'
      - boolean
    doc: When using BAM input (-abam), write output as BEDPE. The default is to 
      write output in BAM when using -abam.
    inputBinding:
      position: 101
      prefix: -bedpe
  - id: overlap_fraction
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
    doc: 'Approach to reporting overlaps between BEDPE and BED. Options: either (default),
      neither, both, xor, notboth, ispan, ospan, notispan, notospan.'
    inputBinding:
      position: 101
      prefix: -type
  - id: same_strand
    type:
      - 'null'
      - boolean
    doc: Require same strandedness when finding overlaps. Default is to ignore 
      strand. Not applicable with -type inspan or -type outspan.
    inputBinding:
      position: 101
      prefix: -s
  - id: uncompressed_bam
    type:
      - 'null'
      - boolean
    doc: Write uncompressed BAM output. Default writes compressed BAM.
    inputBinding:
      position: 101
      prefix: -ubam
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_pairtobed.out
