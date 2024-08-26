-- DO $$ 
-- DECLARE 
--     schema_name TEXT;
-- BEGIN
--     FOR schema_name IN SELECT s.schema_name FROM information_schema.schemata s WHERE s.schema_name LIKE 'schema%' 
--     LOOP
--         EXECUTE format('UPDATE %I.example_table SET value = value + 10', schema_name);
--     END LOOP;
-- END $$;

DO $$ 
DECLARE 
    schema_name TEXT;
    result RECORD;
BEGIN
    FOR schema_name IN SELECT s.schema_name FROM information_schema.schemata s WHERE s.schema_name LIKE 'schema%' 
    LOOP
        FOR result IN EXECUTE format('SELECT * FROM %I.example_table', schema_name)
        LOOP
            RAISE NOTICE 'Schema: %, ID: %, Name: %, Value: %', schema_name, result.id, result.name, result.value;
        END LOOP;
    END LOOP;
END $$;

-- SELECT* FROM schema1.example_table