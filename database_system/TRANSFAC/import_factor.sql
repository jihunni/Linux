begin;

\lo_import :filename
\set obj :LASTOID

create table transfac.factor as
  select *
    from jsonb_to_recordset(convert_from(lo_get(:'obj'),'UTF8')::jsonb)
           as r(accession text, 
                identifier text, 
                factor text,
                type text,
                copyright text,
                organism text,
                "taxClass" text,
                synonyms jsonb,
                "factorClass" jsonb,
                gene jsonb,
                "functionalProperties" text,
                "bindingRegions" jsonb,
                "bindingSites" jsonb,
                complexes jsonb,
                subunits jsonb,
                expression jsonb,
                superfamilies jsonb,
                subfamilies jsonb,
                features jsonb,
                "structFeatures" jsonb,
                "sequence" jsonb,
                homologs jsonb,
                "interactingFactors" jsonb,
                matrices jsonb,
                "posCellSpecificity" text,
                "negCellSpecificity" text,
                "dbReferences" jsonb,
                "references" jsonb,
                "secondaryAccessions" jsonb
                );

create index ix_fa_accession on transfac.factor (accession);
create index ix_fa_identifier on transfac.factor (identifier);
create index ix_fa_name on transfac.factor (factor);
create index ix_fa_gene on transfac.factor using gin (gene jsonb_path_ops);
create index ix_fa_bsites on transfac.factor using gin ("bindingSites" jsonb_path_ops);
create index ix_fa_intfactors on transfac.factor using gin ("interactingFactors" jsonb_path_ops);

\lo_unlink :obj
commit;