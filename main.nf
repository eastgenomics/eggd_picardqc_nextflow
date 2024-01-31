nextflow.enable.dsl=2

include { PICARDQC } from './modules/PICARDQC'

// run

workflow{


bam_pairs_ch = channel.fromFilePairs(params.sorted_bam_path)

    PICARDQC(bam_pairs_ch, params.fasta_index, params.bedfile, params.run_CollectMultipleMetrics, \
    params.run_CollectHsMetrics, params.run_CollectTargetedPcrMetrics, params.run_CollectRnaSeqMetrics, \
    params.ref_annot_refflat_path)
}