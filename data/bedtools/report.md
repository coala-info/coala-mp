# bedtools CWL Generation Report

## bedtools_intersect

### Tool Description
Report overlaps between two feature files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

Tool:    bedtools intersect (aka intersectBed)
Version: v2.31.1
Summary: Report overlaps between two feature files.

Usage:   bedtools intersect [OPTIONS] -a <bed/gff/vcf/bam> -b <bed/gff/vcf/bam>

	Note: -b may be followed with multiple databases and/or 
	wildcard (*) character(s). 
Options: 
	-wa	Write the original entry in A for each overlap.

	-wb	Write the original entry in B for each overlap.
		- Useful for knowing _what_ A overlaps. Restricted by -f and -r.

	-loj	Perform a "left outer join". That is, for each feature in A
		report each overlap with B.  If no overlaps are found, 
		report a NULL feature for B.

	-wo	Write the original A and B entries plus the number of base
		pairs of overlap between the two features.
		- Overlaps restricted by -f and -r.
		  Only A features with overlap are reported.

	-wao	Write the original A and B entries plus the number of base
		pairs of overlap between the two features.
		- Overlapping features restricted by -f and -r.
		  However, A features w/o overlap are also reported
		  with a NULL B feature and overlap = 0.

	-u	Write the original A entry _once_ if _any_ overlaps found in B.
		- In other words, just report the fact >=1 hit was found.
		- Overlaps restricted by -f and -r.

	-c	For each entry in A, report the number of overlaps with B.
		- Reports 0 for A entries that have no overlap with B.
		- Overlaps restricted by -f, -F, -r, and -s.

	-C	For each entry in A, separately report the number of
		- overlaps with each B file on a distinct line.
		- Reports 0 for A entries that have no overlap with B.
		- Overlaps restricted by -f, -F, -r, and -s.

	-v	Only report those entries in A that have _no overlaps_ with B.
		- Similar to "grep -v" (an homage).

	-ubam	Write uncompressed BAM output. Default writes compressed BAM.

	-s	Require same strandedness.  That is, only report hits in B
		that overlap A on the _same_ strand.
		- By default, overlaps are reported without respect to strand.

	-S	Require different strande...
```


## bedtools_window

### Tool Description
Examines a "window" around each feature in A and reports all features in B that overlap the window. For each overlap the entire entry in A and B are reported.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need -a and -b files. 
*****

Tool:    bedtools window (aka windowBed)
Version: v2.31.1
Summary: Examines a "window" around each feature in A and
	 reports all features in B that overlap the window. For each
	 overlap the entire entry in A and B are reported.

Usage:   bedtools window [OPTIONS] -a <bed/gff/vcf> -b <bed/gff/vcf>

Options: 
	-abam	The A input file is in BAM format.  Output will be BAM as well. Replaces -a.

	-ubam	Write uncompressed BAM output. Default writes compressed BAM.

	-bed	When using BAM input (-abam), write output as BED. The default
		is to write output in BAM when using -abam.

	-w	Base pairs added upstream and downstream of each entry
		in A when searching for overlaps in B.
		- Creates symmetrical "windows" around A.
		- Default is 1000 bp.
		- (INTEGER)

	-l	Base pairs added upstream (left of) of each entry
		in A when searching for overlaps in B.
		- Allows one to define asymmetrical "windows".
		- Default is 1000 bp.
		- (INTEGER)

	-r	Base pairs added downstream (right of) of each entry
		in A when searching for overlaps in B.
		- Allows one to define asymmetrical "windows".
		- Default is 1000 bp.
		- (INTEGER)

	-sw	Define -l and -r based on strand.  For example if used, -l 500
		for a negative-stranded feature will add 500 bp downstream.
		- Default = disabled.

	-sm	Only report hits in B that overlap A on the _same_ strand.
		- By default, overlaps are reported without respect to strand.

	-Sm	Only report hits in B that overlap A on the _opposite_ strand.
		- By default, overlaps are reported without respect to strand.

	-u	Write the original A entry _once_ if _any_ overlaps found in B.
		- In other words, just report the fact >=1 hit was found.

	-c	For each entry in A, report the number of overlaps with B.
		- Reports 0 for A entries that have no overlap with B.
		- Overlaps restricted by -w, -l, and -r.

	-v	Only report those entries in A that have _no overl...
```


## bedtools_closest

### Tool Description
For each feature in A, finds the closest feature (upstream or downstream) in B.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

Tool:    bedtools closest (aka closestBed)
Version: v2.31.1
Summary: For each feature in A, finds the closest 
	 feature (upstream or downstream) in B.

Usage:   bedtools closest [OPTIONS] -a <bed/gff/vcf> -b <bed/gff/vcf>

Options: 
	-d	In addition to the closest feature in B, 
		report its distance to A as an extra column.
		- The reported distance for overlapping features will be 0.

	-D	Like -d, report the closest feature in B, and its distance to A
		as an extra column. Unlike -d, use negative distances to report
		upstream features.
		The options for defining which orientation is "upstream" are:
		- "ref"   Report distance with respect to the reference genome. 
		            B features with a lower (start, stop) are upstream
		- "a"     Report distance with respect to A.
		            When A is on the - strand, "upstream" means B has a
		            higher (start,stop).
		- "b"     Report distance with respect to B.
		            When B is on the - strand, "upstream" means A has a
		            higher (start,stop).

	-io	Ignore features in B that overlap A.  That is, we want close,
		yet not touching features only.

	-iu	Ignore features in B that are upstream of features in A.
		This option requires -D and follows its orientation
		rules for determining what is "upstream".

	-id	Ignore features in B that are downstream of features in A.
		This option requires -D and follows its orientation
		rules for determining what is "downstream".

	-fu	Choose first from features in B that are upstream of features in A.
		This option requires -D and follows its orientation
		rules for determining what is "upstream".

	-fd	Choose first from features in B that are downstream of features in A.
		This option requires -D and follows its orientation
		rules for determining what is "downstream".

	-t	How ties for closest feature are handled.  This occurs when two
		features in B have exactly the same "closeness" with A.
		By default, all such features in B are reported.
		Here a...
```


## bedtools_coverage

### Tool Description
Returns the depth and breadth of coverage of features from B on the intervals in A.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

Tool:    bedtools coverage (aka coverageBed)
Version: v2.31.1
Summary: Returns the depth and breadth of coverage of features from B
	 on the intervals in A.

Usage:   bedtools coverage [OPTIONS] -a <bed/gff/vcf> -b <bed/gff/vcf>

Options: 
	-hist	Report a histogram of coverage for each feature in A
		as well as a summary histogram for _all_ features in A.

		Output (tab delimited) after each feature in A:
		  1) depth
		  2) # bases at depth
		  3) size of A
		  4) % of A at depth

	-d	Report the depth at each position in each A feature.
		Positions reported are one based.  Each position
		and depth follow the complete A feature.

	-counts	Only report the count of overlaps, don't compute fraction, etc.

	-mean	Report the mean depth of all positions in each A feature.

	-s	Require same strandedness.  That is, only report hits in B
		that overlap A on the _same_ strand.
		- By default, overlaps are reported without respect to strand.

	-S	Require different strandedness.  That is, only report hits in B
		that overlap A on the _opposite_ strand.
		- By default, overlaps are reported without respect to strand.

	-f	Minimum overlap required as a fraction of A.
		- Default is 1E-9 (i.e., 1bp).
		- FLOAT (e.g. 0.50)

	-F	Minimum overlap required as a fraction of B.
		- Default is 1E-9 (i.e., 1bp).
		- FLOAT (e.g. 0.50)

	-r	Require that the fraction overlap be reciprocal for A AND B.
		- In other words, if -f is 0.90 and -r is used, this requires
		  that B overlap 90% of A and A _also_ overlaps 90% of B.

	-e	Require that the minimum fraction be satisfied for A OR B.
		- In other words, if -e is used with -f 0.90 and -F 0.10 this requires
		  that either 90% of A is covered OR 10% of  B is covered.
		  Without -e, both fractions would have to be satisfied.

	-split	Treat "split" BAM or BED12 entries as distinct BED intervals.

	-g	Provide a genome file to enforce consistent chromosome sort order
		across input files. Only applies when used with -sorted option.

	-nonamech...
```


## bedtools_map

### Tool Description
Apply a function to a column from B intervals that overlap A.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

Tool:    bedtools map (aka mapBed)
Version: v2.31.1
Summary: Apply a function to a column from B intervals that overlap A.

Usage:   bedtools map [OPTIONS] -a <bed/gff/vcf> -b <bed/gff/vcf>

Options: 
	-c	Specify columns from the B file to map onto intervals in A.
		Default: 5.
		Multiple columns can be specified in a comma-delimited list.

	-o	Specify the operation that should be applied to -c.
		Valid operations:
		    sum, min, max, absmin, absmax,
		    mean, median, mode, antimode
		    stdev, sstdev
		    collapse (i.e., print a delimited list (duplicates allowed)), 
		    distinct (i.e., print a delimited list (NO duplicates allowed)), 
		    distinct_sort_num (as distinct, sorted numerically, ascending),
		    distinct_sort_num_desc (as distinct, sorted numerically, desscending),
		    distinct_only (delimited list of only unique values),
		    count
		    count_distinct (i.e., a count of the unique values in the column), 
		    first (i.e., just the first value in the column), 
		    last (i.e., just the last value in the column), 
		Default: sum
		Multiple operations can be specified in a comma-delimited list.

		If there is only column, but multiple operations, all operations will be
		applied on that column. Likewise, if there is only one operation, but
		multiple columns, that operation will be applied to all columns.
		Otherwise, the number of columns must match the the number of operations,
		and will be applied in respective order.
		E.g., "-c 5,4,6 -o sum,mean,count" will give the sum of column 5,
		the mean of column 4, and the count of column 6.
		The order of output columns will match the ordering given in the command.


	-delim	Specify a custom delimiter for the collapse operations.
		- Example: -delim "|"
		- Default: ",".

	-prec	Sets the decimal precision for output (Default: 5)

	-s	Require same strandedness.  That is, only report hits in B
		that overlap A on the _same_ strand.
		- By default, overlaps are reported without respect to stran...
```


## bedtools_genomecov

### Tool Description
Compute the coverage of a feature file among a genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need both a BED (-i) and a genome (-g) file. 
*****

Tool:    bedtools genomecov (aka genomeCoverageBed)
Version: v2.31.1
Summary: Compute the coverage of a feature file among a genome.

Usage: bedtools genomecov [OPTIONS] -i <bed/gff/vcf> -g <genome> OR -ibam <bam/cram>

Options: 
	-ibam		The input file is in BAM format.
			Note: BAM _must_ be sorted by position

	-g		Provide a genome file to define chromosome lengths.
			Note:Required when not using -ibam option.

	-d		Report the depth at each genome position (with one-based coordinates).
			Default behavior is to report a histogram.

	-dz		Report the depth at each genome position (with zero-based coordinates).
			Reports only non-zero positions.
			Default behavior is to report a histogram.

	-bg		Report depth in BedGraph format. For details, see:
			genome.ucsc.edu/goldenPath/help/bedgraph.html

	-bga		Report depth in BedGraph format, as above (-bg).
			However with this option, regions with zero 
			coverage are also reported. This allows one to
			quickly extract all regions of a genome with 0 
			coverage by applying: "grep -w 0$" to the output.

	-split		Treat "split" BAM or BED12 entries as distinct BED intervals.
			when computing coverage.
			For BAM files, this uses the CIGAR "N" and "D" operations 
			to infer the blocks for computing coverage.
			For BED12 files, this uses the BlockCount, BlockStarts, and BlockEnds
			fields (i.e., columns 10,11,12).

	-ignoreD	Ignore local deletions (CIGAR "D" operations) in BAM entries
			when computing coverage.

	-strand		Calculate coverage of intervals from a specific strand.
			With BED files, requires at least 6 columns (strand is column 6). 
			- (STRING): can be + or -

	-pc		Calculate coverage of pair-end fragments.
			Works for BAM files only
	-fs		Force to use provided fragment size instead of read length
			Works for BAM files only
	-du		Change strand af the mate read (so both reads from...
```


## bedtools_merge

### Tool Description
Merges overlapping BED/GFF/VCF entries into a single interval.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

Tool:    bedtools merge (aka mergeBed)
Version: v2.31.1
Summary: Merges overlapping BED/GFF/VCF entries into a single interval.

Usage:   bedtools merge [OPTIONS] -i <bed/gff/vcf>

Options: 
	-s	Force strandedness.  That is, only merge features
		that are on the same strand.
		- By default, merging is done without respect to strand.

	-S	Force merge for one specific strand only.
		Follow with + or - to force merge from only
		the forward or reverse strand, respectively.
		- By default, merging is done without respect to strand.

	-d	Maximum distance between features allowed for features
		to be merged.
		- Def. 0. That is, overlapping & book-ended features are merged.
		- (INTEGER)
		- Note: negative values enforce the number of b.p. required for overlap.

	-c	Specify columns from the B file to map onto intervals in A.
		Default: 5.
		Multiple columns can be specified in a comma-delimited list.

	-o	Specify the operation that should be applied to -c.
		Valid operations:
		    sum, min, max, absmin, absmax,
		    mean, median, mode, antimode
		    stdev, sstdev
		    collapse (i.e., print a delimited list (duplicates allowed)), 
		    distinct (i.e., print a delimited list (NO duplicates allowed)), 
		    distinct_sort_num (as distinct, sorted numerically, ascending),
		    distinct_sort_num_desc (as distinct, sorted numerically, desscending),
		    distinct_only (delimited list of only unique values),
		    count
		    count_distinct (i.e., a count of the unique values in the column), 
		    first (i.e., just the first value in the column), 
		    last (i.e., just the last value in the column), 
		Default: sum
		Multiple operations can be specified in a comma-delimited list.

		If there is only column, but multiple operations, all operations will be
		applied on that column. Likewise, if there is only one operation, but
		multiple columns, that operation will be applied to all columns.
		Otherwise, the number of columns must match the the number of operations,
		an...
```


## bedtools_cluster

### Tool Description
Clusters overlapping/nearby BED/GFF/VCF intervals.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


Tool:    bedtools cluster
Version: v2.31.1
Summary: Clusters overlapping/nearby BED/GFF/VCF intervals.

Usage:   bedtools cluster [OPTIONS] -i <bed/gff/vcf>

Options: 
	-s	Force strandedness.  That is, only merge features
		that are the same strand.
		- By default, merging is done without respect to strand.

	-d	Maximum distance between features allowed for features
		to be merged.
		- Def. 0. That is, overlapping & book-ended features are merged.
		- (INTEGER)


```


## bedtools_complement

### Tool Description
Returns the base pair complement of a feature file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

Tool:    bedtools complement (aka complementBed)
Version: v2.31.1
Summary: Returns the base pair complement of a feature file.

Usage:   bedtools complement [OPTIONS] -i <bed/gff/vcf> -g <genome>

Options: 
	-L	Limit output to solely the chromosomes with records in the input file.

Notes: 
	(1)  The genome file should tab delimited and structured as follows:
	     <chromName><TAB><chromSize>

	For example, Human (hg19):
	chr1	249250621
	chr2	243199373
	...
	chr18_gl000207_random	4262

Tip 1. Use samtools faidx to create a genome file from a FASTA: 
	One can the samtools faidx command to index a FASTA file.
	The resulting .fai index is suitable as a genome file, 
	as bedtools will only look at the first two, relevant columns
	of the .fai file.

	For example:
	samtools faidx GRCh38.fa
	bedtools complement -i my.bed -g GRCh38.fa.fai

Tip 2. Use UCSC Table Browser to create a genome file: 
	One can use the UCSC Genome Browser's MySQL database to extract
	chromosome sizes. For example, H. sapiens:

	mysql --user=genome --host=genome-mysql.cse.ucsc.edu -A -e \
	"select chrom, size from hg19.chromInfo"  > hg19.genome





```


## bedtools_shift

### Tool Description
Shift each feature by requested number of base pairs.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need both a BED (-i) and a genome (-g) file. 
*****

*****
*****ERROR: Need -m and -p together or -s alone. 
*****

Tool:    bedtools shift (aka shiftBed)
Version: v2.31.1
Summary: Shift each feature by requested number of base pairs.

Usage:   bedtools shift [OPTIONS] -i <bed/gff/vcf> -g <genome> [-s <int> or (-p and -m)]

Options: 
	-s	Shift the BED/GFF/VCF entry -s base pairs.
		- (Integer) or (Float, e.g. 0.1) if used with -pct.

	-p	Shift features on the + strand by -p base pairs.
		- (Integer) or (Float, e.g. 0.1) if used with -pct.

	-m	Shift features on the - strand by -m base pairs.
		- (Integer) or (Float, e.g. 0.1) if used with -pct.

	-pct	Define -s, -m and -p as a fraction of the feature's length.
		E.g. if used on a 1000bp feature, -s 0.50, 
		will shift the feature 500 bp "upstream".  Default = false.

	-header	Print the header from the input file prior to results.

Notes: 
	(1)  Starts will be set to 0 if options would force it below 0.
	(2)  Ends will be set to the chromosome length if  requested slop would
	force it above the max chrom length.
	(3)  The genome file should tab delimited and structured as follows:

	<chromName><TAB><chromSize>

	For example, Human (hg19):
	chr1	249250621
	chr2	243199373
	...
	chr18_gl000207_random	4262

Tip 1. Use samtools faidx to create a genome file from a FASTA: 
	One can the samtools faidx command to index a FASTA file.
	The resulting .fai index is suitable as a genome file, 
	as bedtools will only look at the first two, relevant columns
	of the .fai file.

	For example:
	samtools faidx GRCh38.fa
	bedtools shift -i my.bed -g GRCh38.fa.fai

Tip 2. Use UCSC Table Browser to create a genome file: 
	One can use the UCSC Genome Browser's MySQL database to extract
	chromosome sizes. For example, H. sapiens:

	mysql --user=genome --host=genome-mysql.cse.ucsc.edu -A -e \
	"select chrom, size from hg19.chromInfo"  > hg19.genome


```


## bedtools_subtract

### Tool Description
Removes the portion(s) of an interval that is overlapped by another feature(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

Tool:    bedtools subtract (aka subtractBed)
Version: v2.31.1
Summary: Removes the portion(s) of an interval that is overlapped
	 by another feature(s).

Usage:   bedtools subtract [OPTIONS] -a <bed/gff/vcf> -b <bed/gff/vcf>

Options: 
	-A	Remove entire feature if any overlap.  That is, by default,
		only subtract the portion of A that overlaps B. Here, if
		any overlap is found (or -f amount), the entire feature is removed.

	-N	Same as -A except when used with -f, the amount is the sum
		of all features (not any single feature).

	-wb	Write the original entry in B for each overlap.
		- Useful for knowing _what_ A overlaps. Restricted by -f and -r.

	-wo	Write the original A and B entries plus the number of base
		pairs of overlap between the two features.
		- Overlaps restricted by -f and -r.
		  Only A features with overlap are reported.

	-s	Require same strandedness.  That is, only report hits in B
		that overlap A on the _same_ strand.
		- By default, overlaps are reported without respect to strand.

	-S	Require different strandedness.  That is, only report hits in B
		that overlap A on the _opposite_ strand.
		- By default, overlaps are reported without respect to strand.

	-f	Minimum overlap required as a fraction of A.
		- Default is 1E-9 (i.e., 1bp).
		- FLOAT (e.g. 0.50)

	-F	Minimum overlap required as a fraction of B.
		- Default is 1E-9 (i.e., 1bp).
		- FLOAT (e.g. 0.50)

	-r	Require that the fraction overlap be reciprocal for A AND B.
		- In other words, if -f is 0.90 and -r is used, this requires
		  that B overlap 90% of A and A _also_ overlaps 90% of B.

	-e	Require that the minimum fraction be satisfied for A OR B.
		- In other words, if -e is used with -f 0.90 and -F 0.10 this requires
		  that either 90% of A is covered OR 10% of  B is covered.
		  Without -e, both fractions would have to be satisfied.

	-split	Treat "split" BAM or BED12 entries as distinct BED intervals.

	-g	Provide a genome file to enforce consistent chromosome sort order
		...
```


## bedtools_slop

### Tool Description
Add requested base pairs of "slop" to each feature.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need both a BED (-i) and a genome (-g) file. 
*****

*****
*****ERROR: Need -l and -r together or -b alone. 
*****

Tool:    bedtools slop (aka slopBed)
Version: v2.31.1
Summary: Add requested base pairs of "slop" to each feature.

Usage:   bedtools slop [OPTIONS] -i <bed/gff/vcf> -g <genome> [-b <int> or (-l and -r)]

Options: 
	-b	Increase the BED/GFF/VCF entry -b base pairs in each direction.
		- (Integer) or (Float, e.g. 0.1) if used with -pct.

	-l	The number of base pairs to subtract from the start coordinate.
		- (Integer) or (Float, e.g. 0.1) if used with -pct.

	-r	The number of base pairs to add to the end coordinate.
		- (Integer) or (Float, e.g. 0.1) if used with -pct.

	-s	Define -l and -r based on strand.
		E.g. if used, -l 500 for a negative-stranded feature, 
		it will add 500 bp downstream.  Default = false.

	-pct	Define -l and -r as a fraction of the feature's length.
		E.g. if used on a 1000bp feature, -l 0.50, 
		will add 500 bp "upstream".  Default = false.

	-header	Print the header from the input file prior to results.

Notes: 
	(1)  Starts will be set to 0 if options would force it below 0.
	(2)  Ends will be set to the chromosome length if requested slop would
	force it above the max chrom length.
	(3)  The genome file should be tab delimited and structured as follows:

	<chromName><TAB><chromSize>

	For example, Human (hg19):
	chr1	249250621
	chr2	243199373
	...
	chr18_gl000207_random	4262

Tip 1. Use samtools faidx to create a genome file from a FASTA: 
	One can the samtools faidx command to index a FASTA file.
	The resulting .fai index is suitable as a genome file, 
	as bedtools will only look at the first two, relevant columns
	of the .fai file.

	For example:
	samtools faidx GRCh38.fa
	bedtools slop -b 10 -i my.bed -g GRCh38.fa.fai

Tip 2. Use UCSC Table Browser to create a genome file: 
	One can use the UCSC Genome Browser's MySQL database to extract
	chromosome siz...
```


## bedtools_flank

### Tool Description
Creates flanking interval(s) for each BED/GFF/VCF feature.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need both a BED (-i) and a genome (-g) file. 
*****

*****
*****ERROR: Need -l and -r together or -b alone. 
*****

Tool:    bedtools flank (aka flankBed)
Version: v2.31.1
Summary: Creates flanking interval(s) for each BED/GFF/VCF feature.

Usage:   bedtools flank [OPTIONS] -i <bed/gff/vcf> -g <genome> [-b <int> or (-l and -r)]

Options: 
	-b	Create flanking interval(s) using -b base pairs in each direction.
		- (Integer) or (Float, e.g. 0.1) if used with -pct.

	-l	The number of base pairs that a flank should start from
		orig. start coordinate.
		- (Integer) or (Float, e.g. 0.1) if used with -pct.

	-r	The number of base pairs that a flank should end from
		orig. end coordinate.
		- (Integer) or (Float, e.g. 0.1) if used with -pct.

	-s	Define -l and -r based on strand.
		E.g. if used, -l 500 for a negative-stranded feature, 
		it will start the flank 500 bp downstream.  Default = false.

	-pct	Define -l and -r as a fraction of the feature's length.
		E.g. if used on a 1000bp feature, -l 0.50, 
		will add 500 bp "upstream".  Default = false.

	-header	Print the header from the input file prior to results.

Notes: 
	(1)  Starts will be set to 0 if options would force it below 0.
	(2)  Ends will be set to the chromosome length if requested flank would
	force it above the max chrom length.
	(3)  In contrast to slop, which _extends_ intervals, bedtools flank
	creates new intervals from the regions just up- and down-stream
	of your existing intervals.
	(4)  The genome file should tab delimited and structured as follows:

	<chromName><TAB><chromSize>

	For example, Human (hg19):
	chr1	249250621
	chr2	243199373
	...
	chr18_gl000207_random	4262

Tip 1. Use samtools faidx to create a genome file from a FASTA: 
	One can the samtools faidx command to index a FASTA file.
	The resulting .fai index is suitable as a genome file, 
	as bedtools will only look at the first two, relevant columns
	of the .fai file....
```


## bedtools_sort

### Tool Description
Sorts a feature file in various and useful ways.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


Tool:    bedtools sort (aka sortBed)
Version: v2.31.1
Summary: Sorts a feature file in various and useful ways.

Usage:   bedtools sort [OPTIONS] -i <bed/gff/vcf>

Options: 
	-sizeA			Sort by feature size in ascending order.
	-sizeD			Sort by feature size in descending order.
	-chrThenSizeA		Sort by chrom (asc), then feature size (asc).
	-chrThenSizeD		Sort by chrom (asc), then feature size (desc).
	-chrThenScoreA		Sort by chrom (asc), then score (asc).
	-chrThenScoreD		Sort by chrom (asc), then score (desc).
	-g (names.txt)	Sort according to the chromosomes declared in "genome.txt"
	-faidx (names.txt)	Sort according to the chromosomes declared in "names.txt"
	-header	Print the header from the A file prior to results.


```


## bedtools_random

### Tool Description
Generate random intervals among a genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need a genome (-g) file. 
*****

Tool:    bedtools random (aka randomBed)
Version: v2.31.1
Summary: Generate random intervals among a genome.

Usage:   bedtools random [OPTIONS] -g <genome>

Options: 
	-l	The length of the intervals to generate.
		- Default = 100.
		- (INTEGER)

	-n	The number of intervals to generate.
		- Default = 1,000,000.
		- (INTEGER)

	-seed	Supply an integer seed for the shuffling.
		- By default, the seed is chosen automatically.
		- (INTEGER)

Notes: 
	(1)  The genome file should tab delimited and structured as follows:
	     <chromName><TAB><chromSize>

	For example, Human (hg19):
	chr1	249250621
	chr2	243199373
	...
	chr18_gl000207_random	4262

Tip 1. Use samtools faidx to create a genome file from a FASTA: 
	One can the samtools faidx command to index a FASTA file.
	The resulting .fai index is suitable as a genome file, 
	as bedtools will only look at the first two, relevant columns
	of the .fai file.

	For example:
	samtools faidx GRCh38.fa
	bedtools random -l 1000 -g GRCh38.fa.fai

Tip 2. Use UCSC Table Browser to create a genome file: 
	One can use the UCSC Genome Browser's MySQL database to extract
	chromosome sizes. For example, H. sapiens:

	mysql --user=genome --host=genome-mysql.cse.ucsc.edu -A -e \
	"select chrom, size from hg19.chromInfo"  > hg19.genome


```


## bedtools_shuffle

### Tool Description
Randomly permute the locations of a feature file among a genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need both a BED (-i) and a genome (-g) file. 
*****

Tool:    bedtools shuffle (aka shuffleBed)
Version: v2.31.1
Summary: Randomly permute the locations of a feature file among a genome.

Usage:   bedtools shuffle [OPTIONS] -i <bed/gff/vcf> -g <genome>

Options: 
	-excl	A BED/GFF/VCF file of coordinates in which features in -i
		should not be placed (e.g. gaps.bed).

	-incl	Instead of randomly placing features in a genome, the -incl
		options defines a BED/GFF/VCF file of coordinates in which 
		features in -i should be randomly placed (e.g. genes.bed). 
		Larger -incl intervals will contain more shuffled regions. 
		This method DISABLES -chromFirst. 
	-chrom	Keep features in -i on the same chromosome.
		- By default, the chrom and position are randomly chosen.
		- NOTE: Forces use of -chromFirst (see below).

	-seed	Supply an integer seed for the shuffling.
		- By default, the seed is chosen automatically.
		- (INTEGER)

	-f	Maximum overlap (as a fraction of the -i feature) with an -excl
		feature that is tolerated before searching for a new, 
		randomized locus. For example, -f 0.10 allows up to 10%
		of a randomized feature to overlap with a given feature
		in the -excl file. **Cannot be used with -incl file.**
		- Default is 1E-9 (i.e., 1bp).
		- FLOAT (e.g. 0.50)

	-chromFirst	
		Instead of choosing a position randomly among the entire
		genome (the default), first choose a chrom randomly, and then
		choose a random start coordinate on that chrom.  This leads
		to features being ~uniformly distributed among the chroms,
		as opposed to features being distribute as a function of chrom size.

	-bedpe	Indicate that the A file is in BEDPE format.

	-maxTries	
		Max. number of attempts to find a home for a shuffled interval
		in the presence of -incl or -excl.
		Default = 1000.
	-noOverlapping	
		Don't allow shuffled intervals to overlap.
	-allowBeyondChromEnd	
		Allow shuffled intervals to be relo...
```


## bedtools_sample

### Tool Description
Take sample of input file(s) using reservoir sampling algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

Tool:    bedtools sample (aka sampleFile)
Version: v2.31.1
Summary: Take sample of input file(s) using reservoir sampling algorithm.

Usage:   bedtools sample [OPTIONS] -i <bed/gff/vcf/bam>

WARNING:	The current sample algorithm will hold all requested sample records in memory prior to output.
		The user must ensure that there is adequate memory for this.

Options: 
	-n	The number of records to generate.
		- Default = 1,000,000.
		- (INTEGER)

	-seed	Supply an integer seed for the shuffling.
		- By default, the seed is chosen automatically.
		- (INTEGER)

	-ubam	Write uncompressed BAM output. Default writes compressed BAM.

	-s	Require same strandedness.  That is, only give records
		that have the same strand. Use '-s forward' or '-s reverse'
		for forward or reverse strand records, respectively.
		- By default, records are reported without respect to strand.

	-header	Print the header from the input file prior to results.

	-bed	If using BAM input, write output as BED.

	-header	Print the header from the A file prior to results.

	-nobuf	Disable buffered output. Using this option will cause each line
		of output to be printed as it is generated, rather than saved
		in a buffer. This will make printing large output files 
		noticeably slower, but can be useful in conjunction with
		other software tools and scripts that need to process one
		line of bedtools output at a time.

	-iobuf	Specify amount of memory to use for input buffer.
		Takes an integer argument. Optional suffixes K/M/G supported.
		Note: currently has no effect with compressed files.

Notes: 




```


## bedtools_spacing

### Tool Description
Report (last col.) the gap lengths between intervals in a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

Tool:    bedtools spacing
Version: v2.31.1
Summary: Report (last col.) the gap lengths between intervals in a file.

Usage:   bedtools spacing [OPTIONS] -i <bed/gff/vcf/bam>

Notes: 
	(1)  Input must be sorted by chrom,start (sort -k1,1 -k2,2n for BED).
	(2)  The 1st element for each chrom will have NULL distance. (".").
	(3)  Distance for overlapping intervals is -1 and 0 for adjacent intervals.

Example: 
	$ cat test.bed 
	chr1    0   10 
	chr1    10  20 
	chr1    19  30 
	chr1    35  45 
	chr1    100 200 

	$ bedtools spacing -i test.bed 
	chr1    0   10  . 
	chr1    10  20  0 
	chr1    19  30  -1 
	chr1    35  45  5 
	chr1    100 200 55 

	-bed	If using BAM input, write output as BED.

	-header	Print the header from the A file prior to results.

	-nobuf	Disable buffered output. Using this option will cause each line
		of output to be printed as it is generated, rather than saved
		in a buffer. This will make printing large output files 
		noticeably slower, but can be useful in conjunction with
		other software tools and scripts that need to process one
		line of bedtools output at a time.

	-iobuf	Specify amount of memory to use for input buffer.
		Takes an integer argument. Optional suffixes K/M/G supported.
		Note: currently has no effect with compressed files.





```


## bedtools_annotate

### Tool Description
Annotates the depth & breadth of coverage of features from multiple files on the intervals in -i.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need -i and -files files. 
*****

Tool:    bedtools annotate (aka annotateBed)
Version: v2.31.1
Summary: Annotates the depth & breadth of coverage of features from mult. files
	 on the intervals in -i.

Usage:   bedtools annotate [OPTIONS] -i <bed/gff/vcf> -files FILE1 FILE2..FILEn

Options: 
	-names	A list of names (one / file) to describe each file in -i.
		These names will be printed as a header line.

	-counts	Report the count of features in each file that overlap -i.
		- Default is to report the fraction of -i covered by each file.

	-both	Report the counts followed by the % coverage.
		- Default is to report the fraction of -i covered by each file.

	-s	Require same strandedness.  That is, only counts overlaps
		on the _same_ strand.
		- By default, overlaps are counted without respect to strand.

	-S	Require different strandedness.  That is, only count overlaps
		on the _opposite_ strand.
		- By default, overlaps are counted without respect to strand.


```


## bedtools_multiinter

### Tool Description
Identifies common intervals among multiple BED/GFF/VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text
Error: missing file names (-i) to combine.

```


## bedtools_unionbedg

### Tool Description
Combines multiple BedGraph files into a single file such that one can directly compare coverage (and other BedGraph values) across multiple samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text
Error: missing BedGraph file names (-i) to combine.

```


## bedtools_pairtobed

### Tool Description
Report overlaps between a BEDPE file and a BED/GFF/VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need -a and -b files. 
*****

Tool:    bedtools pairtobed (aka pairToBed)
Version: v2.31.1
Summary: Report overlaps between a BEDPE file and a BED/GFF/VCF file.

Usage:   bedtools pairtobed [OPTIONS] -a <bedpe> -b <bed/gff/vcf>

Options: 
	-abam	The A input file is in BAM format.  Output will be BAM as well. Replaces -a.
		- Requires BAM to be grouped or sorted by query.

	-ubam	Write uncompressed BAM output. Default writes compressed BAM.

		is to write output in BAM when using -abam.

	-bedpe	When using BAM input (-abam), write output as BEDPE. The default
		is to write output in BAM when using -abam.

	-ed	Use BAM total edit distance (NM tag) for BEDPE score.
		- Default for BEDPE is to use the minimum of
		  of the two mapping qualities for the pair.
		- When -ed is used the total edit distance
		  from the two mates is reported as the score.

	-f	Minimum overlap required as fraction of A (e.g. 0.05).
		Default is 1E-9 (effectively 1bp).

	-s	Require same strandedness when finding overlaps.
		Default is to ignore stand.
		Not applicable with -type inspan or -type outspan.

	-S	Require different strandedness when finding overlaps.
		Default is to ignore stand.
		Not applicable with -type inspan or -type outspan.

	-type 	Approach to reporting overlaps between BEDPE and BED.

		either	Report overlaps if either end of A overlaps B.
			- Default.
		neither	Report A if neither end of A overlaps B.
		both	Report overlaps if both ends of A overlap  B.
		xor	Report overlaps if one and only one end of A overlaps B.
		notboth	Report overlaps if neither end or one and only one 
			end of A overlap B.  That is, xor + neither.

		ispan	Report overlaps between [end1, start2] of A and B.
			- Note: If chrom1 <> chrom2, entry is ignored.

		ospan	Report overlaps between [start1, end2] of A and B.
			- Note: If chrom1 <> chrom2, entry is ignored.

		notispan	Report A if ispan of A doesn't overlap B.
				- Note...
```


## bedtools_pairtopair

### Tool Description
Report overlaps between two paired-end BED files (BEDPE).

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need -a and -b files. 
*****

Tool:    bedtools pairtopair (aka pairToPair)
Version: v2.31.1
Summary: Report overlaps between two paired-end BED files (BEDPE).

Usage:   bedtools pairtopair [OPTIONS] -a <BEDPE> -b <BEDPE>

Options: 
	-f	Minimum overlap required as fraction of A (e.g. 0.05).
		Default is 1E-9 (effectively 1bp).

	-type 	Approach to reporting overlaps between A and B.

		neither	Report overlaps if neither end of A overlaps B.
		either	Report overlaps if either ends of A overlap B.
		both	Report overlaps if both ends of A overlap B.
		notboth	Report overlaps if one or neither of A's overlap B.
		- Default = both.

	-slop 	The amount of slop (in b.p.). to be added to each footprint of A.
		*Note*: Slop is subtracted from start1 and start2
			and added to end1 and end2.

		- Default = 0.

	-ss	Add slop based to each BEDPE footprint based on strand.
		- If strand is "+", slop is only added to the end coordinates.
		- If strand is "-", slop is only added to the start coordinates.
		- By default, slop is added in both directions.

	-is	Ignore strands when searching for overlaps.
		- By default, strands are enforced.

	-rdn	Require the hits to have different names (i.e. avoid self-hits).
		- By default, same names are allowed.

Refer to the BEDTools manual for BEDPE format.


```


## bedtools_bamtobed

### Tool Description
Converts BAM alignments to BED6 or BEDPE format.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


Tool:    bedtools bamtobed (aka bamToBed)
Version: v2.31.1
Summary: Converts BAM alignments to BED6 or BEDPE format.

Usage:   bedtools bamtobed [OPTIONS] -i <bam> 

Options: 
	-bedpe	Write BEDPE format.
		- Requires BAM to be grouped or sorted by query.

	-mate1	When writing BEDPE (-bedpe) format, 
		always report mate one as the first BEDPE "block".

	-bed12	Write "blocked" BED format (aka "BED12"). Forces -split.

		http://genome-test.cse.ucsc.edu/FAQ/FAQformat#format1

	-split	Report "split" BAM alignments as separate BED entries.
		Splits only on N CIGAR operations.

	-splitD	Split alignments based on N and D CIGAR operators.
		Forces -split.

	-ed	Use BAM edit distance (NM tag) for BED score.
		- Default for BED is to use mapping quality.
		- Default for BEDPE is to use the minimum of
		  the two mapping qualities for the pair.
		- When -ed is used with -bedpe, the total edit
		  distance from the two mates is reported.

	-tag	Use other NUMERIC BAM alignment tag for BED score.
		- Default for BED is to use mapping quality.
		  Disallowed with BEDPE output.

	-color	An R,G,B string for the color used with BED12 format.
		Default is (255,0,0).

	-cigar	Add the CIGAR string to the BED entry as a 7th column.


```


## bedtools_bedtobam

### Tool Description
Converts feature records to BAM format.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need -g (genome) file. 
*****

Tool:    bedtools bedtobam (aka bedToBam)
Version: v2.31.1
Summary: Converts feature records to BAM format.

Usage:   bedtools bedtobam [OPTIONS] -i <bed/gff/vcf> -g <genome>

Options: 
	-mapq	Set the mappinq quality for the BAM records.
		(INT) Default: 255

	-bed12	The BED file is in BED12 format.  The BAM CIGAR
		string will reflect BED "blocks".

	-ubam	Write uncompressed BAM output. Default writes compressed BAM.

Notes: 
	(1)  BED files must be at least BED4 to create BAM (needs name field).


```


## bedtools_bamtofastq

### Tool Description
Convert BAM alignments to FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need bam file (-i). 
*****

*****
*****ERROR: Need -fq. 
*****

Tool:    bedtools bamtofastq (aka bamToFastq)
Version: v2.31.1
Summary: Convert BAM alignments to FASTQ files. 

Usage:   bamToFastq [OPTIONS] -i <BAM> -fq <FQ> 

Options:
	-fq2	FASTQ for second end.  Used if BAM contains paired-end data.
		BAM should be sorted by query name is creating paired FASTQ.

	-tags	Create FASTQ based on the mate info
		in the BAM R2 and Q2 tags.

Tips: 
	If you want to create a single, interleaved FASTQ file 
	for paired-end data, you can just write both to /dev/stdout:

	bedtools bamtofastq -i x.bam -fq /dev/stdout -fq2 /dev/stdout > x.ilv.fq

	Also, the samtools fastq command has more fucntionality and is a useful alternative.


```


## bedtools_bedpetobam

### Tool Description
Converts feature records to BAM format.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need -g (genome) file. 
*****

Tool:    bedtools bedpetobam (aka bedpeToBam)
Version: v2.31.1
Summary: Converts feature records to BAM format.

Usage:   bedpetobam [OPTIONS] -i <bed/gff/vcf> -g <genome>

Options: 
	-mapq	Set the mappinq quality for the BAM records.
		(INT) Default: 255

	-ubam	Write uncompressed BAM output. Default writes compressed BAM.

Notes: 
	(1)  BED files must be at least BED4 to create BAM (needs name field).


```


## bedtools_bed12tobed6

### Tool Description
Splits BED12 features into discrete BED6 features.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


Tool:    bedtools bed12tobed6 (aka bed12ToBed6)
Version: v2.31.1
Summary: Splits BED12 features into discrete BED6 features.

Usage:   bedtools bed12tobed6 [OPTIONS] -i <bed12>

Options: 
	-n	Force the score to be the (1-based) block number from the BED12.


```


## bedtools_getfasta

### Tool Description
Extract DNA sequences from a fasta file based on feature coordinates.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text
*****ERROR: Unrecognized parameter: --help *****


Tool:    bedtools getfasta (aka fastaFromBed)
Version: v2.31.1
Summary: Extract DNA sequences from a fasta file based on feature coordinates.

Usage:   bedtools getfasta [OPTIONS] -fi <fasta> -bed <bed/gff/vcf>

Options: 
	-fi		Input FASTA file
	-fo		Output file (opt., default is STDOUT
	-bed		BED/GFF/VCF file of ranges to extract from -fi
	-name		Use the name field and coordinates for the FASTA header
	-name+		(deprecated) Use the name field and coordinates for the FASTA header
	-nameOnly	Use the name field for the FASTA header
	-split		Given BED12 fmt., extract and concatenate the sequences
			from the BED "blocks" (e.g., exons)
	-tab		Write output in TAB delimited format.
	-bedOut		Report extract sequences in a tab-delimited BED format instead of in FASTA format.
			- Default is FASTA format.
	-s		Force strandedness. If the feature occupies the antisense,
			strand, the sequence will be reverse complemented.
			- By default, strand information is ignored.
	-fullHeader	Use full fasta header.
			- By default, only the word before the first space or tab 
			is used.
	-rna	The FASTA is RNA not DNA. Reverse complementation handled accordingly.


```


## bedtools_maskfasta

### Tool Description
Mask a fasta file based on feature coordinates.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text
*****ERROR: Unrecognized parameter: --help *****


Tool:    bedtools maskfasta (aka maskFastaFromBed)
Version: v2.31.1
Summary: Mask a fasta file based on feature coordinates.

Usage:   bedtools maskfasta [OPTIONS] -fi <fasta> -fo <fasta> -bed <bed/gff/vcf>

Options:
	-fi		Input FASTA file
	-bed		BED/GFF/VCF file of ranges to mask in -fi
	-fo		Output FASTA file
	-soft		Enforce "soft" masking.
			Mask with lower-case bases, instead of masking with Ns.
	-mc		Replace masking character.
			Use another character, instead of masking with Ns.
	-fullHeader	Use full fasta header.
			By default, only the word before the first space or tab
			is used.


```


## bedtools_nuc

### Tool Description
Profiles the nucleotide content of intervals in a fasta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text
*****ERROR: Unrecognized parameter: --help *****


Tool:    bedtools nuc (aka nucBed)
Version: v2.31.1
Summary: Profiles the nucleotide content of intervals in a fasta file.

Usage:   bedtools nuc [OPTIONS] -fi <fasta> -bed <bed/gff/vcf>

Options: 
	-fi	Input FASTA file

	-bed	BED/GFF/VCF file of ranges to extract from -fi

	-s	Profile the sequence according to strand.

	-seq	Print the extracted sequence

	-pattern	Report the number of times a user-defined sequence
			is observed (case-sensitive).

	-C	Ignore case when matching -pattern. By defaulty, case matters.

	-fullHeader	Use full fasta header.
		- By default, only the word before the first space or tab is used.

Output format: 
	The following information will be reported after each BED entry:
	    1) %AT content
	    2) %GC content
	    3) Number of As observed
	    4) Number of Cs observed
	    5) Number of Gs observed
	    6) Number of Ts observed
	    7) Number of Ns observed
	    8) Number of other bases observed
	    9) The length of the explored sequence/interval.
	    10) The seq. extracted from the FASTA file. (opt., if -seq is used)
	    11) The number of times a user's pattern was observed.
	        (opt., if -pattern is used.)


```


## bedtools_multicov

### Tool Description
Counts sequence coverage for multiple bams at specific loci.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


Tool:    bedtools multicov (aka multiBamCov)
Version: v2.31.1
Summary: Counts sequence coverage for multiple bams at specific loci.

Usage:   bedtools multicov [OPTIONS] -bams aln.1.bam aln.2.bam ... aln.n.bam -bed <bed/gff/vcf>

Options: 
	-bams	The bam files.

	-bed	The bed file.

	-split	Treat "split" BAM or BED12 entries as distinct BED intervals.

	-s	Require same strandedness.  That is, only report hits in B
		that overlap A on the _same_ strand.
		- By default, overlaps are reported without respect to strand.

	-S	Require different strandedness.  That is, only report hits in B
		that overlap A on the _opposite_ strand.
		- By default, overlaps are reported without respect to strand.

	-f	Minimum overlap required as a fraction of each -bed record.
		- Default is 1E-9 (i.e., 1bp).
		- FLOAT (e.g. 0.50)

	-r	Require that the fraction overlap be reciprocal for each -bed and B.
		- In other words, if -f is 0.90 and -r is used, this requires
		  that B overlap 90% of each -bed and the -bed record _also_ overlaps 90% of B.

	-q	Minimum mapping quality allowed. Default is 0.

	-D	Include duplicate reads.  Default counts non-duplicates only

	-F	Include failed-QC reads.  Default counts pass-QC reads only

	-p	Only count proper pairs.  Default counts all alignments with
		MAPQ > -q argument, regardless of the BAM FLAG field.


```


## bedtools_tag

### Tool Description
Annotates a BAM file based on overlaps with multiple BED/GFF/VCF files on the intervals in -i.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need -i, -files
*****

*****
*****ERROR: Need -labels or -names or -scores
*****

Tool:    bedtools tag (aka tagBam)
Version: v2.31.1
Summary: Annotates a BAM file based on overlaps with multiple BED/GFF/VCF files
	 on the intervals in -i.

Usage:   bedtools tag [OPTIONS] -i <BAM> -files FILE1 .. FILEn  -labels LAB1 .. LABn

Options: 
	-s	Require overlaps on the same strand.  That is, only tag alignments that have the same
		strand as a feature in the annotation file(s).

	-S	Require overlaps on the opposite strand.  That is, only tag alignments that have the opposite
		strand as a feature in the annotation file(s).

	-f	Minimum overlap required as a fraction of the alignment.
		- Default is 1E-9 (i.e., 1bp).
		- FLOAT (e.g. 0.50)

	-tag	Dictate what the tag should be. Default is YB.
		- STRING (two characters, e.g., YK)

	-names	Use the name field from the annotation files to populate tags.
		By default, the -labels values are used.

	-scores	Use the score field from the annotation files to populate tags.
		By default, the -labels values are used.

	-intervals	Use the full interval (including name, score, and strand) to populate tags.
			Requires the -labels option to identify from which file the interval came.


```


## bedtools_jaccard

### Tool Description
Calculate Jaccard statistic b/w two feature files. Jaccard is the length of the intersection over the union. Values range from 0 (no intersection) to 1 (self intersection).

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

Tool:    bedtools jaccard (aka jaccard)
Version: v2.31.1
Summary: Calculate Jaccard statistic b/w two feature files.
	 Jaccard is the length of the intersection over the union.
	 Values range from 0 (no intersection) to 1 (self intersection).

Usage:   bedtools jaccard [OPTIONS] -a <bed/gff/vcf> -b <bed/gff/vcf>

Options: 
	-s	Require same strandedness.  That is, only report hits in B
		that overlap A on the _same_ strand.
		- By default, overlaps are reported without respect to strand.

	-S	Require different strandedness.  That is, only report hits in B
		that overlap A on the _opposite_ strand.
		- By default, overlaps are reported without respect to strand.

	-f	Minimum overlap required as a fraction of A.
		- Default is 1E-9 (i.e., 1bp).
		- FLOAT (e.g. 0.50)

	-F	Minimum overlap required as a fraction of B.
		- Default is 1E-9 (i.e., 1bp).
		- FLOAT (e.g. 0.50)

	-r	Require that the fraction overlap be reciprocal for A AND B.
		- In other words, if -f is 0.90 and -r is used, this requires
		  that B overlap 90% of A and A _also_ overlaps 90% of B.

	-e	Require that the minimum fraction be satisfied for A OR B.
		- In other words, if -e is used with -f 0.90 and -F 0.10 this requires
		  that either 90% of A is covered OR 10% of  B is covered.
		  Without -e, both fractions would have to be satisfied.

	-split	Treat "split" BAM or BED12 entries as distinct BED intervals.

	-g	Provide a genome file to enforce consistent chromosome sort order
		across input files. Only applies when used with -sorted option.

	-nonamecheck	For sorted data, don't throw an error if the file has different naming conventions
			for the same chromosome. ex. "chr1" vs "chr01".

	-bed	If using BAM input, write output as BED.

	-header	Print the header from the A file prior to results.

	-nobuf	Disable buffered output. Using this option will cause each line
		of output to be printed as it is generated, rather than saved
		in a buffer. This will make printing large output files 
		noticeabl...
```


## bedtools_reldist

### Tool Description
Calculate the relative distance distribution b/w two feature files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need -a and -b files. 
*****

Tool:    bedtools reldist
Version: v2.31.1
Summary: Calculate the relative distance distribution b/w two feature files.

Usage:   bedtools reldist [OPTIONS] -a <bed/gff/vcf> -b <bed/gff/vcf>

Options: 
	-detail	Report the relativedistance for each interval in A


```


## bedtools_fisher

### Tool Description
Calculate Fisher statistic b/w two feature files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

Tool:    bedtools fisher (aka fisher)
Version: v2.31.1
Summary: Calculate Fisher statistic b/w two feature files.

Usage:   bedtools fisher [OPTIONS] -a <bed/gff/vcf> -b <bed/gff/vcf> -g <genome file>

Options: 
	-m	Merge overlapping intervals before
		- looking at overlap.

	-s	Require same strandedness.  That is, only report hits in B
		that overlap A on the _same_ strand.
		- By default, overlaps are reported without respect to strand.

	-S	Require different strandedness.  That is, only report hits in B
		that overlap A on the _opposite_ strand.
		- By default, overlaps are reported without respect to strand.

	-f	Minimum overlap required as a fraction of A.
		- Default is 1E-9 (i.e., 1bp).
		- FLOAT (e.g. 0.50)

	-F	Minimum overlap required as a fraction of B.
		- Default is 1E-9 (i.e., 1bp).
		- FLOAT (e.g. 0.50)

	-r	Require that the fraction overlap be reciprocal for A AND B.
		- In other words, if -f is 0.90 and -r is used, this requires
		  that B overlap 90% of A and A _also_ overlaps 90% of B.

	-e	Require that the minimum fraction be satisfied for A OR B.
		- In other words, if -e is used with -f 0.90 and -F 0.10 this requires
		  that either 90% of A is covered OR 10% of  B is covered.
		  Without -e, both fractions would have to be satisfied.

	-split	Treat "split" BAM or BED12 entries as distinct BED intervals.

	-g	Provide a genome file to enforce consistent chromosome sort order
		across input files. Only applies when used with -sorted option.

	-nonamecheck	For sorted data, don't throw an error if the file has different naming conventions
			for the same chromosome. ex. "chr1" vs "chr01".

	-bed	If using BAM input, write output as BED.

	-header	Print the header from the A file prior to results.

	-nobuf	Disable buffered output. Using this option will cause each line
		of output to be printed as it is generated, rather than saved
		in a buffer. This will make printing large output files 
		noticeably slower, but can be useful in conjunction with
	...
```


## bedtools_overlap

### Tool Description
Computes the amount of overlap (positive values) or distance (negative values) between genome features and reports the result at the end of the same line.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


Tool:    bedtools overlap (aka getOverlap)
Version: v2.31.1
Summary: Computes the amount of overlap (positive values)
	 or distance (negative values) between genome features
	 and reports the result at the end of the same line.

Options: 
	-i	Input file. Use "stdin" for pipes.

	-cols	Specify the columns (1-based) for the starts and ends of the
		features for which you'd like to compute the overlap/distance.
		The columns must be listed in the following order: 

		start1,end1,start2,end2

Example: 
	$ bedtools window -a A.bed -b B.bed -w 10
	chr1 10  20  A   chr1    15  25  B
	chr1 10  20  C   chr1    25  35  D

	$ bedtools window -a A.bed -b B.bed -w 10 | bedtools overlap -i stdin -cols 2,3,6,7
	chr1 10  20  A   chr1    15  25  B   5
	chr1 10  20  C   chr1    25  35  D   -5

```


## bedtools_igv

### Tool Description
Creates a batch script to create IGV images at each interval defined in a BED/GFF/VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


Tool:    bedtools igv (aka bedToIgv)
Version: v2.31.1
Summary: Creates a batch script to create IGV images 
         at each interval defined in a BED/GFF/VCF file.

Usage:   bedtools igv [OPTIONS] -i <bed/gff/vcf>

Options: 
	-path	The full path to which the IGV snapshots should be written.
		(STRING) Default: ./

	-sess	The full path to an existing IGV session file to be 
		loaded prior to taking snapshots.

		(STRING) Default is for no session to be loaded.

	-sort	The type of BAM sorting you would like to apply to each image. 
		Options: base, position, strand, quality, sample, and readGroup
		Default is to apply no sorting at all.

	-clps	Collapse the aligned reads prior to taking a snapshot. 
		Default is to no collapse.

	-name	Use the "name" field (column 4) for each image's filename. 
		Default is to use the "chr:start-pos.ext".

	-slop	Number of flanking base pairs on the left & right of the image.
		- (INT) Default = 0.

	-img	The type of image to be created. 
		Options: png, eps, svg
		Default is png.

Notes: 
	(1)  The resulting script is meant to be run from within IGV.
	(2)  Unless you use the -sess option, it is assumed that prior to 
		running the script, you've loaded the proper genome and tracks.


```


## bedtools_links

### Tool Description
Creates HTML links to an UCSC Genome Browser from a feature file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


Tool:    bedtools links (aka linksBed)
Version: v2.31.1
Summary: Creates HTML links to an UCSC Genome Browser from a feature file.

Usage:   bedtools links [OPTIONS] -i <bed/gff/vcf> > out.html

Options: 
	-base	The browser basename.  Default: http://genome.ucsc.edu 
	-org	The organism. Default: human
	-db	The build.  Default: hg18

Example: 
	By default, the links created will point to human (hg18) UCSC browser.
	If you have a local mirror, you can override this behavior by supplying
	the -base, -org, and -db options.

	For example, if the URL of your local mirror for mouse MM9 is called: 
	http://mymirror.myuniversity.edu, then you would use the following:
	-base http://mymirror.myuniversity.edu
	-org mouse
	-db mm9

```


## bedtools_makewindows

### Tool Description
Makes adjacent or sliding windows across a genome or BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

Tool: bedtools makewindows
Version: v2.31.1
Summary: Makes adjacent or sliding windows across a genome or BED file.

Usage: bedtools makewindows [OPTIONS] [-g <genome> OR -b <bed>]
 [ -w <window_size> OR -n <number of windows> ]

Input Options: 
	-g <genome>
		Genome file size (see notes below).
		Windows will be created for each chromosome in the file.

	-b <bed>
		BED file (with chrom,start,end fields).
		Windows will be created for each interval in the file.

Windows Output Options: 
	-w <window_size>
		Divide each input interval (either a chromosome or a BED interval)
		to fixed-sized windows (i.e. same number of nucleotide in each window).
		Can be combined with -s <step_size>

	-s <step_size>
		Step size: i.e., how many base pairs to step before
		creating a new window. Used to create "sliding" windows.
		- Defaults to window size (non-sliding windows).

	-n <number_of_windows>
		Divide each input interval (either a chromosome or a BED interval)
		to fixed number of windows (i.e. same number of windows, with
		varying window sizes).

	-reverse
		 Reverse numbering of windows in the output, i.e. report 
		 windows in decreasing order

ID Naming Options: 
	-i src|winnum|srcwinnum
		The default output is 3 columns: chrom, start, end .
		With this option, a name column will be added.
		 "-i src" - use the source interval's name.
		 "-i winnum" - use the window number as the ID (e.g. 1,2,3,4...).
		 "-i srcwinnum" - use the source interval's name with the window number.
		See below for usage examples.

Notes: 
	(1) The genome file should tab delimited and structured as follows:
	 <chromName><TAB><chromSize>

	For example, Human (hg19):
	chr1	249250621
	chr2	243199373
	...
	chr18_gl000207_random	4262

Tip 1. Use samtools faidx to create a genome file from a FASTA: 
	One can the samtools faidx command to index a FASTA file.
	The resulting .fai index is suitable as a genome file, 
	as bedtools will only look at the first two, relevant columns
	of the .fai file.

	For...
```


## bedtools_groupby

### Tool Description
Summarizes a dataset column based upon common column groupings. Akin to the SQL "group by" command.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

Tool:    bedtools groupby 
Version: v2.31.1
Summary: Summarizes a dataset column based upon
	 common column groupings. Akin to the SQL "group by" command.

Usage:	 bedtools groupby -g [group_column(s)] -c [op_column(s)] -o [ops] 
	 cat [FILE] | bedtools groupby -g [group_column(s)] -c [op_column(s)] -o [ops] 

Options: 
	-i		Input file. Assumes "stdin" if omitted.

	-g -grp		Specify the columns (1-based) for the grouping.
			The columns must be comma separated.
			- Default: 1,2,3

	-c -opCols	Specify the column (1-based) that should be summarized.
			- Required.

	-o -ops		Specify the operation that should be applied to opCol.
			Valid operations:
			    sum, count, count_distinct, min, max,
			    mean, median, mode, antimode,
			    stdev, sstdev (sample standard dev.),
			    collapse (i.e., print a comma separated list (duplicates allowed)), 
			    distinct (i.e., print a comma separated list (NO duplicates allowed)), 
			    distinct_sort_num (as distinct, but sorted numerically, ascending), 
			    distinct_sort_num_desc (as distinct, but sorted numerically, descending), 
			    concat   (i.e., merge values into a single, non-delimited string), 
			    freqdesc (i.e., print desc. list of values:freq)
			    freqasc (i.e., print asc. list of values:freq)
			    first (i.e., print first value)
			    last (i.e., print last value)
			- Default: sum

		If there is only column, but multiple operations, all operations will be
		applied on that column. Likewise, if there is only one operation, but
		multiple columns, that operation will be applied to all columns.
		Otherwise, the number of columns must match the the number of operations,
		and will be applied in respective order.
		E.g., "-c 5,4,6 -o sum,mean,count" will give the sum of column 5,
		the mean of column 4, and the count of column 6.
		The order of output columns will match the ordering given in the command.


	-full		Print all columns from input file.  The first line in the group is used.
			Default:...
```


## bedtools_expand

### Tool Description
Replicate lines in a file based on columns of comma-separated values.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

*****ERROR: Unrecognized parameter: --help *****


*****
*****ERROR: Need -opCols.
*****

Tool:    bedtools expand 
Version: v2.31.1
Summary: Replicate lines in a file based on columns of comma-separated values.

Usage:	 bedtools expand -c [COLS] 
Options: 
	-i	Input file. Assumes "stdin" if omitted.

	-c 	Specify the column (1-based) that should be summarized.
		- Required.
Examples: 
  $ cat test.txt
  chr1	10	20	1,2,3	10,20,30
  chr1	40	50	4,5,6	40,50,60

  $ bedtools expand test.txt -c 5
  chr1	10	20	1,2,3	10
  chr1	10	20	1,2,3	20
  chr1	10	20	1,2,3	30
  chr1	40	50	4,5,6	40
  chr1	40	50	4,5,6	50
  chr1	40	50	4,5,6	60

  $ bedtools expand test.txt -c 4,5
  chr1	10	20	1	10
  chr1	10	20	2	20
  chr1	10	20	3	30
  chr1	40	50	4	40
  chr1	40	50	5	50
  chr1	40	50	6	60

```


## bedtools_split

### Tool Description
Split a Bed file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text
Tool:    bedtools split
Version: v2.31.1
Summary: Split a Bed file.

Usage:   bedtools split [OPTIONS] -i <bed> -n number-of-files

Options: 
	-i|--input (file)	BED input file (req'd).
	-n|--number (int)	Number of files to create (req'd).
	-p|--prefix (string)	Output BED file prefix.
	-a|--algorithm (string) Algorithm used to split data.
		* size (default): uses a heuristic algorithm to group the items
		  so all files contain the ~ same number of bases
		* simple : route records such that each split file has
		  approximately equal records (like Unix split).

	-h|--help		Print help (this screen).
	-v|--version		Print version.


Note: This programs stores the input BED records in memory.
```


## bedtools_summary

### Tool Description
Report summary statistics of the intervals in a file

### Metadata
- **Docker Image**: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
- **Homepage**: https://bedtools.readthedocs.io/
- **Validation**: PASS

### Original Help Text
```text

Tool:    bedtools sammary
Version: v2.31.1
Summary: Report summary statistics of the intervals in a file 

Usage:   bedtools summary [OPTIONS] -i <bed/gff/vcf/bam> -g <genome>

Notes: 
	(1)  The genome file should tab delimited and structured as follows:
	     <chromName><TAB><chromSize>

	For example, Human (hg19):
	chr1	249250621
	chr2	243199373
	...
	chr18_gl000207_random	4262





```


## Metadata
- **Skill**: generated
