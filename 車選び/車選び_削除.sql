IF DB_NAME() = N'SP_USER_DAT' BEGIN RAISERROR(N'本番DBでは流せません', 16, 1); RETURN; END
-- 車選び.COM の UIテスト用の試験データを消す(車選び.sql の前に流す)。試験用DB以外では止める(上の1行)。
-- 番号: 車両仕入 9501〜9506 / 車両 39501〜39506 / 取引先 9501 / KY送信履歴 は車両仕入 9501〜9506 の行 / KY企業マスタ・KY店舗マスタ は契約企業コードが KY95 で始まる行
--   (テストが連携設定の「追加」・店舗設定の「追加」で足す行も KY95 で始まる契約企業コードにする)
DELETE FROM KY送信履歴 WHERE 車両仕入番号 BETWEEN 9501 AND 9506;
DELETE FROM 車両仕入公開情報 WHERE 車両仕入番号 BETWEEN 9501 AND 9506;
DELETE FROM 車両仕入 WHERE 車両仕入番号 BETWEEN 9501 AND 9506;
DELETE FROM 車両 WHERE 車両番号 BETWEEN 39501 AND 39506;
DELETE FROM 取引先 WHERE 取引先番号 = 9501;
DELETE FROM KY店舗マスタ WHERE 店舗番号 BETWEEN 9501 AND 9599 OR 契約企業コード LIKE N'KY95%';
DELETE FROM KY企業マスタ WHERE 企業番号 BETWEEN 9501 AND 9599 OR 契約企業コード LIKE N'KY95%';
-- 列設定(4025)・初期値設定の保管場所(4036)・送信先設定(4037・4040)は、ひな形(営業所0・担当者0)も含めて消し、車選び.sql で作り直す。
-- 4025・4036 を使うのは車選び.COM の画面だけ(車両販売_車選び連携 の MainWindow と UcRowSetting)。4037・4040 は車選び送信.exe(バッチ)も読む
DELETE FROM 汎用データ管理 WHERE データ区分 IN (4025, 4036, 4037, 4040);
