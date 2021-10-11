begin;

\lo_import :filename
\set obj :LASTOID

create table transfac.gene as
  select *
    from json_to_recordset(convert_from(lo_get(:'obj'),'UTF8')::json)
           as r(accession text, 
                identifier text, 
                "shortDesc" text,
                type text,
                copyright text,
                organism text,
                "taxClass" text,
                description text,
                synonyms json,
                gene json,
                "geneFactor" json,
                "epdPromoterClass" text,
                "chromLocation" json,
                "compositeElements" json,
                "hostGene" json,
                "intronicGenes" json,
                "bindingSites" json,
                "bindingFactors" json,
                regulation json,
                "dbReferences" json,
                "references" json,
                "secondaryAccessions" json
                );

create index ix_ge_accession on transfac.gene (accession);
create index ix_ge_identifier on transfac.gene (identifier);
create index ix_ge_shortdesc on transfac.gene ("shortDesc");
create index ix_ge_bindsites on transfac.gene(("bindingSites"->>'acc'));
create index ix_ge_bindfactors on transfac.gene(("bindingFactors"->>'acc'));

\lo_unlink :obj
commit;
