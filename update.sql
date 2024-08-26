DO $$
DECLARE
    schema_name TEXT;
    table_exists BOOLEAN;
BEGIN
    -- 全てのユーザー定義スキーマを取得
    FOR schema_name IN 
        SELECT s.schema_name
        FROM information_schema.schemata s
        WHERE s.schema_name NOT IN ('pg_catalog', 'information_schema')
    LOOP
        -- テーブルがスキーマ内に存在するかチェック
        SELECT EXISTS (
            SELECT 1 
            FROM information_schema.tables 
            WHERE table_schema = schema_name 
            AND table_name = 'example_table'
        ) INTO table_exists;

        -- テーブルが存在する場合のみデータを更新
        IF table_exists THEN
            EXECUTE format('UPDATE %I.example_table SET name = $1 WHERE name = $2', schema_name)
            USING '##__麦100%（税込み）_##', '##__麦100%（税込）_##';
        END IF;
    END LOOP;
END $$;
