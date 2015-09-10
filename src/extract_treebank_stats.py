import argparse
from collections import Counter, defaultdict
from pathlib import Path
from conll import read_conll_u_file
import pandas as pd

parser = argparse.ArgumentParser(description="""Extract counts of (head_POS, deprel, dep_POS) tuples in the UD treebank,
                                grouped by language""")
parser.add_argument("treebanks_dir", help="Directory for UD treebanks", type=Path)
parser.add_argument("out_file", help="Save counts here", type=Path)

args = parser.parse_args()


count_cols = defaultdict(list)
for treebank_dir in args.treebanks_dir.glob("UD*"):
    treebank_lang = treebank_dir.name.replace("UD_", "").lower()
    counts = Counter()
    left_dist = Counter()
    right_dist = Counter()

    for conll_file in treebank_dir.glob("*.conllu"):
        for sent in read_conll_u_file(str(conll_file)):
            for (u, v, data) in sent.edges(data=True):
                key = (sent.node[u]['cpostag'], data['deprel'], sent.node[v]['cpostag'])
                counts[key] += 1
                right_dist[key] += max(v - u, 0)
                left_dist[key] += max(u - v, 0)


    # Write completed counts into a columnar format
    for edge, observed_num in counts.items():
        head_pos, deprel, dep_pos = edge
        count_cols['head'].append(head_pos)
        count_cols['deprel'].append(deprel)
        count_cols['dep'].append(dep_pos)
        count_cols['lang'].append(treebank_lang)
        count_cols['count'].append(observed_num)
        count_cols['left_dist'].append(left_dist[edge])
        count_cols['right_dist'].append(right_dist[edge])




# Save to DataFrame
pd.DataFrame(count_cols).to_csv(str(args.out_file))
