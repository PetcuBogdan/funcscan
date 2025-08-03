process bigscape {
    container 'quay.io/biocontainers/bigscape:1.1.9--pyhdfd78af_0'
    publishDir 'results', mode: 'copy'		
   
    input:
        path input_dir
	    path pfam_dir

    output:
        path "./results" emit: bigscape_output

    script:
    """
    bigscape \\
      --input $input_dir \\
      --outputdir ${params.outputdir} \\
      --pfam_dir $pfam_dir \\
      --mode ${params.mode} \\
      --cutoffs ${params.cutoffs} \\
      --clan_cutoff ${params.clan_cutoff}
    """
}
