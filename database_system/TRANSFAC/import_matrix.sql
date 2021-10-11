begin;

\lo_import :filename
\set obj :LASTOID

create table transfac.matrix as
  select *
    from jsonb_to_recordset(convert_from(lo_get(:'obj'),'UTF8')::jsonb)
           as r(accession text, 
                identifier text, 
                name text,
                type text,
                copyright text,
                description text,
                comments jsonb,
                organism text,
                "taxClass" text,
                "matrixClass" jsonb,
                "bindingFactors" jsonb,
                "bindingSites" jsonb,
                profiles jsonb,
                "statisticalBasis" jsonb,
                tfmatrix jsonb,
                superfamilies jsonb,
                subfamilies jsonb,
                "preferredVersion" jsonb,
                "oldVersions" jsonb,
                "relatedSpecificMatrices" jsonb,
                "dbReferences" jsonb,
                "references" jsonb,
                "secondaryAccessions" jsonb,
                "secondaryIdentifiers" jsonb
                );

create index ix_mx_accession on transfac.matrix (accession);
create index ix_mx_identifier on transfac.matrix (identifier);
create index ix_mx_name on transfac.matrix (name);
create index ix_mx_bsites on transfac.matrix using gin ("bindingSites" jsonb_path_ops);
create index ix_mx_bfactors on transfac.matrix using gin ("bindingFactors" jsonb_path_ops);

\lo_unlink :obj
commit;