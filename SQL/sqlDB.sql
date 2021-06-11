CREATE TABLE userTBL
( userID CHAR(8) NOT NULL PRIMARY KEY,
userName NVARCHAR2(10) NOT NULL,
birthYear NUMBER(4) NOT NULL,
addr NCHAR(2) NOT NULL,
mobile1 CHAR(3),
mobile2 CHAR(8),
height NUMBER(3),
mDate DATE
);

CREATE TABLE buyTBL
( idNum NUMBER(8) NOT NULL PRIMARY KEY,
userID CHAR(8) NOT NULL,
prodName NCHAR(6) NOT NULL,
groupName NCHAR(4),
price NUMBER(8) NOT NULL,
amount NUMBER(3) NOT NULL,
FOREIGN KEY (userID) REFERENCES userTBL(userID)
);

INSERT INTO userTBL VALUES('LSG', '�̽±�', 1987, '����', '011', '11111111', 182, '2008-8-8');
INSERT INTO userTBL VALUES('KBS', '�����', 1979, '�泲', '011', '22222222', 173, '2012-4-4');
INSERT INTO userTBL VALUES('KKH', '���ȣ', 1971, '����', '019', '33333333', 177, '2007-7-7');
INSERT INTO userTBL VALUES('JYP', '������', 1950, '���', '011', '44444444', 166, '2009-4-4');
INSERT INTO userTBL VALUES('SSK', '���ð�', 1979, '����', NULL, NULL, 186, '2013-12-12');
INSERT INTO userTBL VALUES('LJB', '�����', 1963, '����', '016', '66666666', 182, '2009-9-9');
INSERT INTO userTBL VALUES('YJS', '������', 1969, '�泲', NULL, NULL, 170, '2005-5-5');
INSERT INTO userTBL VALUES('EJW', '������', 1972, '���', '011', '88888888', 174, '2014-3-3');
INSERT INTO userTBL VALUES('JKW', '������', 1965, '���', '018', '99999999', 172, '2010-10-10');
INSERT INTO userTBL VALUES('BBK', '�ٺ�Ŵ', 1973, '����', '010', '00000000', 176, '2013-5-5');

CREATE SEQUENCE idSEQ; -- ������ȣ �Է��� ���ؼ� ������ ����
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '�ȭ', NULL, 30, 2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '��Ʈ��', '����', 1000, 1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'JYP', '�����', '����', 200, 1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�����', '����', 200, 5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', 'û����', '�Ƿ�', 50, 3);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�޸�', '����', 80, 10);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'SSK', 'å', '����', 15, 5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', 'å', '����', 15, 2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', 'û����', NULL, 50, 1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�ȭ', NULL, 30, 2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', 'å', '����', 15, 1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�ȭ', NULL, 30, 2);

COMMIT;
SELECT * FROM userTBL;
SELECT * FROM buyTBL;

SELECT * FROM userTBL WHERE userName = '���ȣ' OR userName = '������';
SELECT * FROM userTBL WHERE birthYear >= 1970 AND height >= 182;
SELECT userid, username FROM userTBL WHERE birthYear >= 1970 AND height >= 182;
SELECT username, height FROM userTBL WHERE height BETWEEN 180 AND 183;
SELECT username, height FROM userTBL WHERE height <= 183 AND height >= 180;
SELECT userName, addr FROM userTBL WHERE addr IN ('�泲', '����', '���') ;

SELECT userName, height FROM userTBL WHERE userName LIKE '��%';
SELECT userName, height FROM userTBL WHERE userName LIKE '_����';
SELECT userName, height FROM userTBL WHERE userName LIKE '_��_';


SELECT userName, height FROM userTBL
	WHERE height > (SELECT height FROM userTBL WHERE userName = '���ȣ');

SELECT rownum, userName, height FROM userTBL
	WHERE height >= ANY (SELECT height FROM userTBL WHERE addr = '�泲');
    
SELECT rownum, userName, height FROM userTBL
	WHERE height >= ALL (SELECT height FROM userTBL WHERE addr = '�泲');
    
SELECT userName, height FROM userTBL
	WHERE height IN (SELECT height FROM userTBL WHERE addr = '�泲');

SELECT * FROM buyTBL;
SELECT userID, SUM(amount) FROM buyTBL GROUP BY userID ORDER BY userID;
SELECT userID AS ���̵�, SUM(amount) AS �Ѽ��� FROM buyTBL GROUP BY userID;
SELECT userID AS ���̵�, SUM(price*amount) AS �ѱ��Ű��� FROM buyTBL GROUP BY userID;
    
SELECT userName, height FROM userTBL 
    WHERE height = (SELECT MAX(height) FROM userTBL) 
        OR height = (SELECT MIN(height) FROM userTBL)
    ORDER BY height DESC;
    
SELECT COUNT(*) FROM userTBL;
SELECT * FROM userTBL;

SELECT userID AS ���̵�, SUM(price*amount) AS �ѱ��Ű��� FROM buyTBL GROUP BY userID
HAVING SUM(price*amount) >= 1000;
    
SELECT idNum, groupName, SUM(price*amount) AS "���"
	FROM buyTBL
	GROUP BY ROLLUP (groupName, idNum);    

SELECT groupName, SUM(price*amount) AS ���, GROUPING_ID(groupName) AS �߰����ΰ�
	FROM buyTBL
	GROUP BY ROLLUP(groupName);