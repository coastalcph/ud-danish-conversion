from __future__ import print_function, division
import networkx as nx

CONLL06_COLUMNS = ['id', 'word', 'lemma', 'cpos', 'pos', 'feats', 'head', 'deprel', 'phead', 'pdeprel']

def parse_id(id_str):
    if id_str == '_':
        return None
    ids = tuple(map(int, id_str.split("-")))
    if len(ids) == 1:
        return ids[0]
    else:
        return ids

def parse_feats(feats_str):
    if feats_str == '_':
        return {}
    feat_pairs = [pair.split("=") for pair in feats_str.split("|")]
    return {k: v for k, v in feat_pairs}

def parse_deps(dep_str):
    if dep_str == '_':
        return []
    dep_pairs = [pair.split(":") for pair in dep_str.split("|")]
    return [(int(pair[0]), pair[1]) for pair in dep_pairs]



CONLL_U_COLUMNS = [('id', parse_id), ('form', str), ('lemma', str), ('cpostag', str),
                   ('postag', str), ('feats', parse_feats), ('head', parse_id), ('deprel', str),
                   ('deps', parse_deps), ('misc', str)]


def read_conll_u_file(filename):
    sentences = []
    sent = nx.DiGraph()

    for line_no, line in enumerate(open(filename), 1):
        line = line.strip("\n")
        if not line:
            # Add extra properties to ROOT node if exists
            if 0 in sent:
                for key in ('form', 'lemma', 'cpostag', 'postag'):
                    sent.node[0][key] = 'ROOT'

            sentences.append(sent)
            sent = nx.DiGraph()
        elif line.startswith("#"):
            if 'comment' not in sent.graph:
                sent.graph['comment'] = []
            else:
                sent.graph['comment'].append(line)
        else:
            parts = line.split("\t")
            if len(parts) != len(CONLL_U_COLUMNS):
                error_msg = 'Invalid number of columns in line {} (found {}, expected {})'.format(line_no, len(parts), len(CONLL_U_COLUMNS))
                raise Exception(error_msg)

            token_dict = {key: conv_fn(val) for (key, conv_fn), val in zip(CONLL_U_COLUMNS, parts)}
            if isinstance(token_dict['id'], int):
                sent.add_edge(token_dict['head'], token_dict['id'], deprel=token_dict['deprel'])
                sent.node[token_dict['id']].update({k: v for (k, v) in token_dict.items()
                                                    if k not in ('head', 'id', 'deprel', 'deps')})
                for head, deprel in token_dict['deps']:
                    sent.add_edge(head, token_dict['id'], deprel=deprel, secondary=True)



    return sentences


# def head_of(sent, n):
#     for u, v in sent.edges():
#         if v == n:
#             return u
#     return None
#
#
# def pathtoroot(sent, child):
#     path = []
#     newhead = head_of(sent, child)
#     while newhead:
#         path.append(newhead)
#         newhead = head_of(sent, newhead)
#     return path
#
#
# def get_highest_index_of_span(sent, span):  # retrieves the node index that is closest to root
#     distancestoroot = [len(pathtoroot(sent, x)) for x in span]
#     shortestdistancetoroot = min(distancestoroot)
#     spanhead = span[distancestoroot.index(shortestdistancetoroot)]
#     return spanhead
#
#
# def get_deepest_index_of_span(sent, span):  # retrieves the node index that is farthest from root
#     distancestoroot = [len(pathtoroot(sent, x)) for x in span]
#     shortestdistancetoroot = max(distancestoroot)
#     lownode = span[distancestoroot.index(shortestdistancetoroot)]
#     return lownode
#
#
# def subsumes(sent, head, child):
#     if head in pathtoroot(sent, child):
#         return True
#
#
# def get_sentence_as_string(sent,printid=False):
#     out = []
#     for token_i in range(1, max(sent.nodes()) + 1):
#         if printid:
#             out.append(str(token_i)+":"+sent.node[token_i]['word'])
#         else:
#             out.append(sent.node[token_i]['word'])
#     return u" ".join(out)
#
