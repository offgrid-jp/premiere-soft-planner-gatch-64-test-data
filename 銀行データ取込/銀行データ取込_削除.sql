IF DB_NAME() = N'SP_USER_DAT' BEGIN RAISERROR(N'本番DBでは流せません', 16, 1); RETURN; END
-- 銀行データ取込の UIテスト用の試験データを消す(銀行データ取込.sql の前に流す)。試験用DB以外では止める(上の1行)。
-- 入金確定で作った入金(入金番号は自動で振られる)は、伝票番号・取引先で拾って消す
DELETE FROM 入金 WHERE 伝票番号 BETWEEN 9601 AND 9606 OR 取引先番号 BETWEEN 9601 AND 9606;
DELETE FROM 整備表題 WHERE 伝票番号 BETWEEN 9601 AND 9606;
DELETE FROM 注文書表題 WHERE 車両売上番号 BETWEEN 9601 AND 9606;
DELETE FROM 車両仕入 WHERE 車両仕入番号 BETWEEN 9601 AND 9606;
DELETE FROM 車両 WHERE 車両番号 BETWEEN 39601 AND 39606;
DELETE FROM 取引先売上情報 WHERE 取引先番号 BETWEEN 9601 AND 9606;
DELETE FROM 取引先 WHERE 取引先番号 BETWEEN 9601 AND 9606;
-- 店舗振込番号マスタ(4021): 試験データの2行と、テストが画面の「追加」で足す行(試験項目書 No23〜25 の 東京店・北海道店・沖縄店、No16 の ＵＴ追加店)
DELETE FROM 汎用データ管理 WHERE データ区分 = 4021 AND (名称２ LIKE N'ＵＴ%' OR 名称２ IN (N'東京店', N'北海道店', N'沖縄店'));
-- 振込依頼人マスタ(4022): 試験データの4行と、テストが振込依頼人登録マスタで足す行(ﾃｽﾄﾄｳﾛｸ で始まる)
DELETE FROM 汎用データ管理 WHERE データ区分 = 4022 AND (名称２ IN (N'ﾃｽﾄｼﾞﾖｶﾞｲ', N'*ﾃｽﾄｷﾞﾖｳｼﾔ*', N'*ﾃｽﾄｳｼﾛ', N'ﾃｽﾄﾏｴ*') OR 名称２ LIKE N'ﾃｽﾄﾄｳﾛｸ%');
