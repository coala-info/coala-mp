cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - shuffle
label: bedtools_shuffle
doc: "Randomly permute the locations of a feature file among a genome.\n\nTool homepage:
  https://bedtools.readthedocs.io/"
inputs:
  - id: allow_beyond_chrom_end
    type:
      - 'null'
      - boolean
    doc: Allow shuffled intervals to be relocated to a position in which the 
      entire original interval cannot fit w/o exceeding the end of the 
      chromosome.
    inputBinding:
      position: 101
      prefix: -allowBeyondChromEnd
  - id: bedpe
    type:
      - 'null'
      - boolean
    doc: Indicate that the A file is in BEDPE format.
    inputBinding:
      position: 101
      prefix: -bedpe
  - id: chrom_first
    type:
      - 'null'
      - boolean
    doc: Instead of choosing a position randomly among the entire genome (the 
      default), first choose a chrom randomly, and then choose a random start 
      coordinate on that chrom.
    inputBinding:
      position: 101
      prefix: -chromFirst
  - id: exclude_file
    type:
      - 'null'
      - File
    doc: A BED/GFF/VCF file of coordinates in which features in -i should not be
      placed (e.g. gaps.bed).
    inputBinding:
      position: 101
      prefix: -excl
  - id: genome_file
    type: File
    doc: 'A genome file (tab delimited: <chromName><TAB><chromSize>).'
    inputBinding:
      position: 101
      prefix: -g
  - id: include_file
    type:
      - 'null'
      - File
    doc: Instead of randomly placing features in a genome, the -incl options 
      defines a BED/GFF/VCF file of coordinates in which features in -i should 
      be randomly placed (e.g. genes.bed). Larger -incl intervals will contain 
      more shuffled regions. This method DISABLES -chromFirst.
    inputBinding:
      position: 101
      prefix: -incl
  - id: input_file
    type: File
    doc: A BED/GFF/VCF file of coordinates to be shuffled.
    inputBinding:
      position: 101
      prefix: -i
  - id: keep_chrom
    type:
      - 'null'
      - boolean
    doc: 'Keep features in -i on the same chromosome. NOTE: Forces use of -chromFirst.'
    inputBinding:
      position: 101
      prefix: -chrom
  - id: max_tries
    type:
      - 'null'
      - int
    doc: Max. number of attempts to find a home for a shuffled interval in the 
      presence of -incl or -excl.
    default: 1000
    inputBinding:
      position: 101
      prefix: -maxTries
  - id: no_overlapping
    type:
      - 'null'
      - boolean
    doc: Don't allow shuffled intervals to overlap.
    inputBinding:
      position: 101
      prefix: -noOverlapping
  - id: overlap_fraction
    type:
      - 'null'
      - float
    doc: Maximum overlap (as a fraction of the -i feature) with an -excl feature
      that is tolerated before searching for a new, randomized locus. Cannot be 
      used with -incl file.
    default: 1e-09
    inputBinding:
      position: 101
      prefix: -f
  - id: seed
    type:
      - 'null'
      - int
    doc: Supply an integer seed for the shuffling. By default, the seed is 
      chosen automatically.
    inputBinding:
      position: 101
      prefix: -seed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_shuffle.out
