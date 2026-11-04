-- 車販入金入力の UIテスト用の試験データを消す(車販入金入力.sql の前に流す)。試験用DB以外では止める。
IF DB_NAME() = N'SP_USER_DAT' BEGIN RAISERROR(N'本番DBでは流せません', 16, 1); RETURN; END
-- 試験中に画面で足した入金(入金番号は自動で振られる)も、伝票番号・取引先で拾って消す
DELETE FROM 入金 WHERE 入金番号 BETWEEN 9001 AND 9009 OR 伝票番号 BETWEEN 9001 AND 9008 OR 取引先番号 BETWEEN 9701 AND 9706;
DELETE FROM 整備表題 WHERE 伝票番号 BETWEEN 9001 AND 9008;
DELETE FROM 注文書表題 WHERE 車両売上番号 BETWEEN 70 AND 75;
DELETE FROM 車両仕入 WHERE 車両仕入番号 BETWEEN 290 AND 295;
DELETE FROM 車両 WHERE 車両番号 BETWEEN 36640 AND 36645;
DELETE FROM 取引先売上情報 WHERE 取引先番号 BETWEEN 9701 AND 9706;
DELETE FROM 取引先 WHERE 取引先番号 BETWEEN 9701 AND 9706;
-- 列設定保存で保存した検索条件(汎用データ管理 4050)は、営業所0のひな形を残して消す(開いた直後の条件を毎回同じにする)
DELETE FROM 汎用データ管理 WHERE データ区分 = 4050 AND 営業所番号 <> 0;
