process bigscape_setup {
    label 'pfam_download'
    publishDir './pfam_db', mode: 'copy'

    output:
    path 'Pfam-A.hmm*'

    script:
    """
    docker pull quay.io/biocontainers/bigscape:1.1.9--pyhdfd78af_0
    wget https://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz
    gunzip Pfam-A.hmm.gz
    hmmpress Pfam-A.hmm
    """
}
