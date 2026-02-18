cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - cluster
label: bedtools_cluster
doc: "Clusters overlapping/nearby BED/GFF/VCF intervals.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: force_strandedness
    type:
      - 'null'
      - boolean
    doc: Force strandedness. That is, only merge features that are the same 
      strand. By default, merging is done without respect to strand.
    inputBinding:
      position: 101
      prefix: -s
  - id: input_file
    type: File
    doc: Input BED/GFF/VCF file to be clustered.
    inputBinding:
      position: 101
      prefix: -i
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum distance between features allowed for features to be merged. 
      Def. 0. That is, overlapping & book-ended features are merged.
    default: 0
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_cluster.out
