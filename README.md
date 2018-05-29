# scanMyWorkDir
Non-destructive &amp; Informative scan of a NextFlow work folder

## Usage
```
./scanMyWorkDir.sh <pipelineDir-nf>
```

## Example
```
$ ./scanMyWorkDir.sh gatk4-fromUBAMtoCallableBAM-nf/
Scanning gatk4-fromUBAMtoCallableBAM-nf/ Nexflow work directory for suffix outputs........................................................................done!

Top ten suffixes that are eating up disk space in gatk4-fromUBAMtoCallableBAM-nf :
1       18G     *.fastq
2       18G     *.aln.bam
3       16G     *.recal.bam
4       12G     *.aln.dup.bam
5       22M     *.aln.bam.bai
6       15M     *.recal.bai
7       15M     *.aln.dup.bam.bai
8       2.6M    *.recal_stats/qualimapReport.html
9       2.2M    *.recal_data.table
10      688K    *.recal_stats/qualimapReportOutsideRegions.html

Try these commands to further investigate (and maybe rm, who knows) :
├── find gatk4-fromUBAMtoCallableBAM-nf/work/ -name *.fastq -type f
└── ls -lrh --sort=size gatk4-fromUBAMtoCallableBAM-nf/work/*/*/*.fastq
```
