-- 既に存在する集約用テーブルを削除
DROP TABLE IF EXISTS aggregated_data;

DO $$
DECLARE
    schema_name TEXT;
    table_exists BOOLEAN;
BEGIN
    -- 新しい集約用の空のテーブルを作成
    CREATE TEMP TABLE aggregated_data (
        schema_name TEXT,
        name VARCHAR(255),
        value INT
    );

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

        -- テーブルが存在する場合のみデータを選択して集約テーブルに挿入
        IF table_exists THEN
            EXECUTE format('INSERT INTO aggregated_data (schema_name, name, value) SELECT $1, name, value FROM %I.example_table WHERE name IN ($2, $3)', schema_name)
            USING schema_name, '##__麦100%（税込）_##', '##__若葉100%（税込）_##';
        END IF;
    END LOOP;
END $$;

-- 集約したデータを全て選択して表示
SELECT * FROM aggregated_data;

-- 使用後に集約用テーブルを削除
DROP TABLE IF EXISTS aggregated_data;
