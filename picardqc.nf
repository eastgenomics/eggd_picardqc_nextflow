nextflow.enable.dsl=2

// get params

params.fasta_index_path
params.bedfile_path
params.sorted_bam_path
params.run_CollectMultipleMetrics
params.run_CollectHsMetrics
params.run_CollectTargetedPcrMetrics
params.run_CollectRnaSeqMetrics
params.ref_annot_refflat


// build process


process PICARDQC {
    input:
      path fasta_index_path
      path bedfile_path
      path sorted_bam_path
      val run_CollectMultipleMetrics
      val run_CollectHsMetrics
      val run_CollectTargetedPcrMetrics
      val run_CollectRnaSeqMetrics
      path ref_annot_refflat

    script:
    """
    echo $fasta_index_path
    echo $bedfile_path
    echo $sorted_bam_path
    bash ${baseDir}/src/nextflow_code.sh $fasta_index_path $bedfile_path $sorted_bam_path $run_CollectMultipleMetrics \
    $run_CollectHsMetrics $run_CollectTargetedPcrMetrics $run_CollectRnaSeqMetrics $ref_annot_refflat $ref_annot_refflat_path
    """


}

// run

workflow{

bedfile_channel = channel.fromPath(params.bedfile_path)
sorted_bam_channel = channel.fromPath(params.sorted_bam_path)

    PICARDQC(params.fasta_index_path, bedfile_channel, sorted_bam_channel,params.run_CollectMultipleMetrics, \
    params.run_CollectHsMetrics, params.run_CollectTargetedPcrMetrics, params.run_CollectRnaSeqMetrics, \
    params.ref_annot_refflat)
}