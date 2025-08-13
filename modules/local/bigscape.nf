process bigscape {
   container 'quay.io/biocontainers/bigscape:1.1.9--pyhdfd78af_0'
    publishDir 'results', mode: 'copy'

    input:
        tuple val(capes_folders), path(pfam_dir)

    output:
        path "results", emit: bigscape_output

    script:
    def capes_list_file = "capes_list.txt"
    def out_root = "results"

    """
    cat > ${capes_list_file} <<EOF
${capes_folders.join('\n')}
EOF

    while IFS= read -r dir; do
        [ -z "\$dir" ] && continue
        sample_id=\$(basename "\$dir")
        outdir="${out_root}/\${sample_id}"
        mkdir -p "\$outdir"

        echo ">>> Running BiG-SCAPE for: \$sample_id"
        bigscape \\
          --input "\$dir" \\
          --outputdir "\$outdir" \\
          --pfam_dir "${pfam_dir}" \\
         --mode "${params.bigscape_mode}" \\
         --cutoffs "${params.bigscape_cutoffs}" \\
        --clan_cutoff ${params.bigscape_clan_cutoff} \\
          --cores ${task.cpus}
    done < ${capes_list_file}

    """
}