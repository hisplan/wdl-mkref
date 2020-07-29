# wdl-mkref

Generating a hybrid (human + mouse) scRNA-seq STAR reference:
- Human (GRCh38) / Ensembl 99
- Mouse (GRCm38) / Ensembl 99 

## Input

```json
{
    "mkref.genomeVersion": "38",
    "mkref.ensemblVersion": "99",
    "mkref.sjdbOverhang": 101,
    "mkref.biotypes": [
        "protein_coding",
        "lncRNA",
        "IG_C_gene",
        "IG_D_gene",
        "IG_J_gene",
        "IG_V_gene",
        "IG_LV_gene",
        "TR_C_gene",
        "TR_D_gene",        
        "TR_J_gene",
        "TR_V_gene"
    ]
}
```

## Submitting a Job

```bash
$ ./submit.sh \
    -k ~/keys/secrets-aws.json \
    -i configs/mkref.inputs.json \
    -l configs/mkref.labels.aws.json \
    -o mkref.options.aws.json
```
