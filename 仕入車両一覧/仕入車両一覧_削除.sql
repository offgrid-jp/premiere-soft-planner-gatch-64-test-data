-- 仕入車両一覧の UIテスト用の試験データを消す(仕入車両一覧.sql の前に流す)。試験用DB以外では止める。
IF DB_NAME() = N'SP_USER_DAT' BEGIN RAISERROR(N'本番DBでは流せません', 16, 1); RETURN; END
DELETE FROM 車両名変履歴 WHERE 車両仕入番号 BETWEEN 9001 AND 9014;
DELETE FROM 車両経費 WHERE 車両仕入番号 BETWEEN 9001 AND 9014;
DELETE FROM 整備表題 WHERE 伝票番号 IN (9101, 9102);
DELETE FROM 注文書手続代行費用 WHERE 車両売上番号 BETWEEN 9021 AND 9023;
DELETE FROM 注文書預法定費用 WHERE 車両売上番号 BETWEEN 9021 AND 9023;
DELETE FROM 注文書表題 WHERE 車両仕入番号 BETWEEN 9001 AND 9014 OR 車両売上番号 BETWEEN 9001 AND 9030;
DELETE FROM 車両仕入 WHERE 車両仕入番号 BETWEEN 9001 AND 9014;
DELETE FROM 車両 WHERE 車両番号 BETWEEN 39001 AND 39030;
DELETE FROM 取引先売上情報 WHERE 取引先番号 IN (904, 905, 906);
DELETE FROM 取引先 WHERE 取引先番号 IN (900, 901, 902, 903, 904, 905, 906);
-- 設定画面で保存した列設定・初期値・並び順(汎用データ管理)は、営業所0のひな形を残して消す(開いた直後の状態を毎回同じにする)
DELETE FROM 汎用データ管理 WHERE データ区分 IN (4004, 4008, 4009, 4010, 4024, 4046) AND 営業所番号 <> 0;
-- 列設定のひな形(4004・営業所0)を初期の状態に戻す。列設定の保存(車販Common Generic.saveSetting)は行を番号で探して書き換えるので、
-- 設定画面がひな形から作った一覧のまま保存されると、ひな形そのものの並び(種別１)・幅(種別３)・表示(フラグ２)が書き換わり、以降の回にも残る(10/21)。
-- 初期値は同じ行の 種別２(初期の並び)・種別４(初期の幅)・フラグ３(初期の表示)
UPDATE 汎用データ管理 SET 種別１ = 種別２, 種別３ = 種別４, フラグ２ = フラグ３ WHERE データ区分 = 4004 AND 営業所番号 = 0;
