CREATE FUNCTION keepcoding.fnc_clean_integer (p_integer INT64) RETURNS INT64
AS ((SELECT CASE WHEN SAFE_CAST(p_integer AS INT64) IS NULL THEN  -999999 ELSE SAFE_CAST(p_integer AS INT64) END ));

select keepcoding.fnc_clean_integer (null)