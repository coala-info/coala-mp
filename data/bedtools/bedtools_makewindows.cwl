cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - makewindows
label: bedtools_makewindows
doc: "Makes adjacent or sliding windows across a genome or BED file.\n\nTool homepage:
  https://bedtools.readthedocs.io/"
inputs:
  - id: bed
    type:
      - 'null'
      - File
    doc: BED file (with chrom,start,end fields). Windows will be created for 
      each interval in the file.
    inputBinding:
      position: 101
      prefix: -b
  - id: genome
    type:
      - 'null'
      - File
    doc: Genome file size. Windows will be created for each chromosome in the 
      file.
    inputBinding:
      position: 101
      prefix: -g
  - id: id_naming
    type:
      - 'null'
      - string
    doc: "The default output is 3 columns: chrom, start, end. With this option, a
      name column will be added. \"-i src\" - use the source interval's name; \"-i
      winnum\" - use the window number; \"-i srcwinnum\" - use the source interval's
      name with the window number."
    inputBinding:
      position: 101
      prefix: -i
  - id: number_of_windows
    type:
      - 'null'
      - int
    doc: Divide each input interval to fixed number of windows (i.e. same number
      of windows, with varying window sizes).
    inputBinding:
      position: 101
      prefix: -n
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Reverse numbering of windows in the output, i.e. report windows in 
      decreasing order
    inputBinding:
      position: 101
      prefix: -reverse
  - id: step_size
    type:
      - 'null'
      - int
    doc: 'Step size: i.e., how many base pairs to step before creating a new window.
      Used to create "sliding" windows. Defaults to window size.'
    inputBinding:
      position: 101
      prefix: -s
  - id: window_size
    type:
      - 'null'
      - int
    doc: Divide each input interval to fixed-sized windows (i.e. same number of 
      nucleotide in each window).
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
stdout: bedtools_makewindows.out
