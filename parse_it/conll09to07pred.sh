
# ID FORM LEMMA PLEMMA POS PPOS FEAT PFEAT HEAD PHEAD DEPREL PDEPREL FILLPRED PRED APREDs 
# to:
# ID FORM LEMMA CPOS POS FEATS HEAD DEPREL _ _ 
awk -F'\t' '{ if (NF>0) printf "%s\t%s\t%s\t%s\t_\t%s\t%s\t%s\t_\t_\n",$1,$2,$3,$5,$7,$10,$12; else print }' $1
