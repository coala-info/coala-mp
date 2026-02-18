cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - bamtofastq
label: bedtools_bamtofastq
doc: "Convert BAM alignments to FASTQ files.\n\nTool homepage: https://bedtools.readthedocs.io/"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: -i
  - id: tags
    type:
      - 'null'
      - boolean
    doc: Create FASTQ based on the mate info in the BAM R2 and Q2 tags.
    inputBinding:
      position: 101
      prefix: -tags
outputs:
  - id: fastq_1
    type: File
    doc: FASTQ file for first end
    outputBinding:
      glob: $(inputs.fastq_1)
  - id: fastq_2
    type:
      - 'null'
      - File
    doc: FASTQ for second end. Used if BAM contains paired-end data. BAM should 
      be sorted by query name is creating paired FASTQ.
    outputBinding:
      glob: $(inputs.fastq_2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
