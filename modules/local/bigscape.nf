process bigscape {
    container 'quay.io/biocontainers/bigscape:1.1.9--pyhdfd78af_0'
    publishDir 'results', mode: 'copy'		

    input:
        tuple path(capes_folders), path(pfam_dir) 



    output:
        path "results", emit: bigscape_output

    script:
    def folders_str = capes_folders.join(' ')
    """
    echo "===== BiG-SCAPE MULTI-RUN START ====="
    echo "CAPES folders   : ${folders_str}"
    echo "Pfam dir        : ${pfam_dir}"

    for dir in ${folders_str}; do
        sample_id=\$(basename "\$dir")
        outdir="results/\${sample_id}"
        mkdir -p "\$outdir"

        echo ">>> Running BiG-SCAPE for: \$sample_id"
        bigscape \\
        --input "\$dir" \\
        --outputdir "\$outdir" \\
        --pfam_dir "${pfam_dir}" \\
        --mode auto \\
        --cutoffs 0.3 \\
        --clan_cutoff 0.3 0.8 \\
        --cores ${task.cpus}
    done

    echo "===== BiG-SCAPE MULTI-RUN DONE ====="
    """
}
