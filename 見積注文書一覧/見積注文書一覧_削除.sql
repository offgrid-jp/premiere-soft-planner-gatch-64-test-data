IF DB_NAME() = N'SP_USER_DAT' BEGIN RAISERROR(N'本番DBでは流せません', 16, 1); RETURN; END
-- 見積・注文書一覧の UIテスト用の試験データを消す(見積注文書一覧.sql の前に流す)。試験用DB以外では止める(上の1行)。
-- 番号: 注文書表題 9301〜9310 / 車両仕入 9301〜9310 / 車両 39301〜39310 / 取引先 9301〜9310
DELETE FROM 車両名変履歴 WHERE 車両仕入番号 BETWEEN 9301 AND 9310;
DELETE FROM 注文書手続代行費用 WHERE 車両売上番号 BETWEEN 9301 AND 9310;
DELETE FROM 注文書預法定費用 WHERE 車両売上番号 BETWEEN 9301 AND 9310;
DELETE FROM 注文書表題 WHERE 車両売上番号 BETWEEN 9301 AND 9310;
DELETE FROM 車両仕入 WHERE 車両仕入番号 BETWEEN 9301 AND 9310;
DELETE FROM 車両 WHERE 車両番号 BETWEEN 39301 AND 39310;
DELETE FROM 取引先売上情報 WHERE 取引先番号 BETWEEN 9301 AND 9310;
DELETE FROM 取引先 WHERE 取引先番号 BETWEEN 9301 AND 9310;
-- 列設定(4001)は、ひな形(営業所0・担当者0)も含めて消し、見積注文書一覧.sql で作り直す(列名・幅・並びを毎回同じにする)。
-- 4001 を使うのは見積・注文書の画面だけ(車両販売_見積注文書検索 の MainWindow.kubun と UcRowSetting)
DELETE FROM 汎用データ管理 WHERE データ区分 = 4001;
-- 初期値設定(4011 売上営業所 / 4012 販売担当者 / 4013 販売状況 / 4015 作成日)は、設定画面の OK で作られるログインした人の行を消し、
-- ひな形(共通データ.sql で作る)を初期の値に戻す。OK はログインした人の行が無いとき、ひな形そのものを書き換える(UcRowSetting.btOK_Click の else)
DELETE FROM 汎用データ管理 WHERE データ区分 IN (4011, 4012, 4013, 4015) AND (営業所番号 <> 0 OR 更新担当者番号 <> 0);
UPDATE 汎用データ管理 SET 種別１ = 0, 種別３ = 2, 種別４ = 2, 削除フラグ = 0 WHERE データ区分 = 4011 AND 営業所番号 = 0;
UPDATE 汎用データ管理 SET 種別１ = 0, 種別３ = 1, 種別４ = 1, 削除フラグ = 0 WHERE データ区分 IN (4012, 4013, 4015) AND 営業所番号 = 0;
