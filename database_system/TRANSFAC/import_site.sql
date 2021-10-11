begin;

\lo_import :filename
\set obj :LASTOID

create table transfac.site as
  select *
    from jsonb_to_recordset(convert_from(lo_get(:'obj'),'UTF8')::jsonb)
           as r(accession text, 
                identifier text, 
                type text,
                copyright text,
                organism text,
                "taxClass" text,
                description text,
                comments jsonb,
                "geneRegion" text,
                element text,
                "cellFactorSources" text,
                "experimentMethods" jsonb,
                "bindingFactors" jsonb,
                "sequence" jsonb,
                matrices jsonb,
                "dbReferences" jsonb,
                "references" jsonb,
                "secondaryAccessions" jsonb
                );

create index ix_si_accession on transfac.site (accession);
create index ix_si_identifier on transfac.site (identifier);
create index ix_si_method on transfac.site using gin ("experimentMethods" jsonb_path_ops);
create index ix_si_cell on transfac.site ("cellFactorSources");
create index ix_si_bindfactors on transfac.site using gin ("bindingFactors" jsonb_path_ops);

\lo_unlink :obj
commit;