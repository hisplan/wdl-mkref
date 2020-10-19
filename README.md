# wdl-mkref

Generating a hybrid (human + mouse) scRNA-seq STAR reference:
- Human (GRCh38) / Ensembl 100
- Mouse (GRCm38) / Ensembl 100

## Input

```json
{
    "mkref.genomeVersion": "38",
    "mkref.ensemblVersion": "100",
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
        "TR_C_gene",
    ]
}
```

## Submitting a Job

```bash
$ ./submit.sh \
    -k ~/keys/secrets-aws.json \
    -i configs/mkref-GRCh38-GRCm38-Ensembl100.inputs.json \
    -l configs/mkref-GRCh38-GRCm38-Ensembl100.labels.aws.json \
    -o mkref.options.aws.json
```
