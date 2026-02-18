cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - igv
label: bedtools_igv
doc: "Creates a batch script to create IGV images at each interval defined in a BED/GFF/VCF
  file.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: collapse
    type:
      - 'null'
      - boolean
    doc: Collapse the aligned reads prior to taking a snapshot.
    inputBinding:
      position: 101
      prefix: -clps
  - id: image_type
    type:
      - 'null'
      - string
    doc: 'The type of image to be created. Options: png, eps, svg'
    default: png
    inputBinding:
      position: 101
      prefix: -img
  - id: input_file
    type: File
    doc: BED/GFF/VCF file to create IGV images for.
    inputBinding:
      position: 101
      prefix: -i
  - id: session_file
    type:
      - 'null'
      - File
    doc: The full path to an existing IGV session file to be loaded prior to 
      taking snapshots.
    inputBinding:
      position: 101
      prefix: -sess
  - id: slop
    type:
      - 'null'
      - int
    doc: Number of flanking base pairs on the left & right of the image.
    default: 0
    inputBinding:
      position: 101
      prefix: -slop
  - id: sort_type
    type:
      - 'null'
      - string
    doc: 'The type of BAM sorting you would like to apply to each image. Options:
      base, position, strand, quality, sample, and readGroup'
    inputBinding:
      position: 101
      prefix: -sort
  - id: use_name_field
    type:
      - 'null'
      - boolean
    doc: Use the "name" field (column 4) for each image's filename.
    inputBinding:
      position: 101
      prefix: -name
outputs:
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: The full path to which the IGV snapshots should be written.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
