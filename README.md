# wdl-mkref

Generating a hybrid (human + mouse) scRNA-seq STAR reference:

- Human (GRCh38) / Ensembl 98
- Mouse (GRCm38) / Ensembl 98

## Setup

Sharp is a part of SCING (Single-Cell pIpeliNe Garden; pronounced as "sing" /siŋ/). For setup, please refer to [this page](https://github.com/hisplan/scing). All the instructions below is given under the assumption that you have already configured SCING in your environment.

## Create Job Files

You need two files to create a reference package - one inputs file and one labels file. Use the following example files to help you create your job file:

- `configs/template.inputs.json`
- `configs/template.labels.json`

## Input

Note that a reference package created using STAR v2.5.3a is not compatible with STAR v2.7.6a or vice versa.

```json
{
    "mkref.genomeVersion": "38",
    "mkref.ensemblVersion": "98",
    "mkref.sjdbOverhang": 101,
    "mkref.biotypes": [
        "protein_coding",
        "lincRNA",
        "antisense",
        "IG_V_gene",
        "IG_D_gene",
        "IG_J_gene",
        "IG_C_gene",
        "TR_V_gene",
        "TR_D_gene",
        "TR_J_gene",
        "TR_C_gene"
    ],
    "mkref.starVersion": "2.5.3a",
    "mkref.dockerRegistry": "quay.io/hisplan"
}
```

## Submit Your Job

```bash
$ ./submit.sh \
    -k ~/keys/cromwell-secrets.json \
    -i configs/mkref-GRCh38-GRCm38-Ensembl98.inputs.json \
    -l configs/mkref-GRCh38-GRCm38-Ensembl98.labels.aws.json \
    -o mkref.options.aws.json
```
