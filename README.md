# wdl-mkref

Generating a hybrid (human + mouse) scRNA-seq STAR reference:
- Human (GRCh38) / Ensembl 99
- Mouse (GRCm38) / Ensembl 99 

```bash
$ ./submit.sh \
    -k ~/keys/secrets-aws.json \
    -i configs/mkref.inputs.json \
    -l configs/mkref.labels.aws.json \
    -o mkref.options.aws.json
```
