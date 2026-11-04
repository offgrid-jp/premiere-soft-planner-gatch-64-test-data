IF DB_NAME() = N'SP_USER_DAT' BEGIN RAISERROR(N'本番DBでは流せません', 16, 1); RETURN; END
-- 在庫車両販売の UIテスト用の試験データを消す(在庫車両販売.sql の前に流す)。試験用DB以外では止める(上の1行)。
-- 番号: 車両仕入 9401〜9420 / 車両 39401〜39420 / 注文書表題(車両売上番号) 9401〜9405 / 取引先 9401。古い 在庫車販売.sql の行は消さない
DELETE FROM 車両名変履歴 WHERE 車両仕入番号 BETWEEN 9401 AND 9420;
DELETE FROM 注文書表題 WHERE 車両売上番号 BETWEEN 9401 AND 9405;
DELETE FROM 車両仕入 WHERE 車両仕入番号 BETWEEN 9401 AND 9420;
DELETE FROM 車両 WHERE 車両番号 BETWEEN 39401 AND 39420;
DELETE FROM 取引先 WHERE 取引先番号 = 9401;
-- 列設定(4002)と初期値設定(4017 保管場所 / 4018 仕入営業所 / 4019 販売担当者)は、ひな形(営業所0・担当者0)も含めて消し、在庫車両販売.sql で作り直す。
-- 4002・4017〜4019 を使うのは在庫車両販売の画面だけ(車両販売_在庫車両販売 の MainWindow と UcRowSet)。設定画面の OK・初期値読込・列設定保存はこれらを書き換える
DELETE FROM 汎用データ管理 WHERE データ区分 IN (4002, 4017, 4018, 4019);
