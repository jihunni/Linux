```
create database transfac_db onwer='postgre';
create shhema transfac;
```

```
psql -v filename='/home/data/TRANSFAC/TFP_2021.2_data/json/matrix.json' -d transfac_db -f '/home/data/TRANSFAC/TFP_2021.2_data/json/import_matrix.sql
'/home/data/TRANSFAC/TFP_2021.2_data/json/gene.json' -d transfac_db -f '/home/data/TRANSFAC/TFP_2021.2_data/json/import_gene.sql'
psql -v filename='/home/data/TRANSFAC/TFP_2021.2_data/json/site.json' -d transfac_db -f '/home/data/TRANSFAC/TFP_2021.2_data/json/import_site.sql'
psql -v filename='/home/data/TRANSFAC/TFP_2021.2_data/json/factor_wo_fragments.json' -d transfac_db -f '/home/data/TRANSFAC/TFP_2021.2_data/json/import_factor.sql'
```
