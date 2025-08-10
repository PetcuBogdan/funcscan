process bigscape_setup {
    container 'quay.io/biocontainers/bigscape:1.1.9--pyhdfd78af_0'
    publishDir "${params.pfam_dir}", mode: 'copy'

    output:
    path 'Pfam-A.hmm*', emit: pfam_files

    script:
    """
    docker pull quay.io/biocontainers/bigscape:1.1.9--pyhdfd78af_0
    wget https://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz
    gunzip Pfam-A.hmm.gz
    hmmpress Pfam-A.hmm
    """
}
