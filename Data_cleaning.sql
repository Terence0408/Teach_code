
--- CREATE
--- 放新資料的位置
--- * TABLE: 以實體存在
--- * VIEW: 以指令存在，只有執行時才會跑，關閉 DB 就自動刪除

Drop Table IF Exists old_A;
CREATE TABLE old_A
       (id      serial, 
        area    text, 
        age     double precision, 
        sex     CHAR(10));


Drop Table IF Exists old_B;
CREATE TABLE old_B
       (id      serial, 
        income  double precision);



--- Insert data

INSERT INTO old_A 
       VALUES (1, 'S',  5,  'male');        

INSERT INTO old_A (id, area, sex) 
       VALUES (2, 'N',     'female');

INSERT INTO old_A (id, area, age, sex) 
       VALUES (3, 'E', 30,   'male'),
              (4, 'S', 10, 'female'),
              (5, 'N', 60,   'male'),
              (6, 'E', 90, 'female');       

INSERT INTO old_B (id, income) VALUES (1,20);
INSERT INTO old_B (id, income) VALUES (4,10);
INSERT INTO old_B (id, income) VALUES (5,30);
INSERT INTO old_B (id, income) VALUES (7,40);
INSERT INTO old_B (id, income) VALUES (8,11);
INSERT INTO old_B (id, income) VALUES (19,20);



--- Update data
UPDATE old_A 
       SET age = 20
       WHERE id = 2;



--- SELECT  
--- 選取需要的變數

SELECT * FROM old_A;

SELECT t1.id, t1.area FROM old_A as t1;

SELECT t1.id, 
       t1.sex, 
       Case When t1.sex = 'female' then 0 
            When t1.sex =   'male' then 1
            ELSE NULL 
       END as sex_n
FROM old_A as t1;



--- WHERE
--- 條件式篩選資料，ex. 只處理年齡 > 60

SELECT t1.id, t1.area, t1.age, t1.sex 
FROM old_A as t1 
WHERE t1.area = 'S' or t1.area = 'N';

SELECT t1.id, t1.area, t1.age, t1.sex 
FROM old_A as t1 
WHERE t1.area in ('S', 'N');



--- FROM
--- 從那些表格得到資料，牽涉到 JOIN
SELECT t1.id, t1.age, t1.sex, t2.income 
FROM old_A as t1, old_B as t2 
WHERE t1.id = t2.id;

SELECT t1.id, t1.age, t1.sex, t2.income 
FROM old_A as t1 INNER JOIN old_B as t2 on t1.id = t2.id;



--- GROUP BY
--- 分群計算，ex. 計算總和

SELECT t1.area, SUM(t1.age), AVG(t1.age) as avg_age, count(*) as count 
FROM old_A as t1 
GROUP BY t1.area;



--- HAVING
--- 篩選分群計算後的結果
--- * 必須與 GROUP BY 搭配

SELECT t1.area, SUM(t1.age), AVG(t1.age) as avg_age, count(*) as count 
FROM old_A as t1 
GROUP BY t1.area 
HAVING avg_age >=40;


--- ORDER BY
--- 排序資料

SELECT t1.area, SUM(t1.age), AVG(t1.age) as avg_age, count(*) as count 
FROM old_A as t1 
GROUP BY t1.area 
HAVING avg_age >=40 
ORDER BY avg_age;