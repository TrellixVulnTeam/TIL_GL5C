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
    
CREATE TABLE cubeTBL(prodName NCHAR(3), color NCHAR(2), amount INT);
INSERT INTO cubeTBL VALUES('��ǻ��', '����', 11);
INSERT INTO cubeTBL VALUES('��ǻ��', '�Ķ�', 22);
INSERT INTO cubeTBL VALUES('�����', '����', 33);
INSERT INTO cubeTBL VALUES('�����', '����', 44);
SELECT prodName, color, SUM(amount) AS "�����հ�"
    FROM cubeTBL
    GROUP BY CUBE (color, prodName)
    ORDER BY prodName, color;
    WITH abc(userID, total)
AS
( SELECT userID, SUM(price*amount)
	FROM buyTBL GROUP BY userID)
SELECT * FROM abc ORDER BY total DESC;

CREATE TABLE EMPTBL ( EMP NCHAR(3), MANAGER NCHAR(3), DEPARTMENT NCHAR(3));
INSERT INTO EMPTBL VALUES('������', '����', '����');
INSERT INTO EMPTBL VALUES('���繫', '������', '�繫��');
INSERT INTO EMPTBL VALUES('�����', '���繫', '������');
INSERT INTO EMPTBL VALUES('�̺���', '���繫', '�繫��');
INSERT INTO EMPTBL VALUES('��븮', '�̺���', '�繫��');
INSERT INTO EMPTBL VALUES('�����', '�̺���', '�繫��');
INSERT INTO EMPTBL VALUES('�̿���', '������', '������');
INSERT INTO EMPTBL VALUES('�Ѱ���', '�̿���', '������');
INSERT INTO EMPTBL VALUES('������', '������', '������');
INSERT INTO EMPTBL VALUES('������', '������', '������');
INSERT INTO EMPTBL VALUES('������', '������', '������');

WITH empCTE(empName, mgrName, dept, empLevel)
AS
( 
	(SELECT emp, manager, department, 0
		FROM empTBL
		WHERE manager = '����')
	UNION ALL
	(SELECT empTBL.emp, empTBL.manager, empTBL.department, empCTE.empLevel + 1
    	FROM empTBL INNER JOIN empCTE
    		ON empTBL.manager = empCTE.empName)
)
SELECT * FROM empCTE ORDER BY dept, empLevel;

SELECT * FROM BUYTBL;

UPDATE buyTBL SET PRICE = PRICE * 1.5 ;

CREATE TABLE memberTBL AS
(SELECT userID, userName, addr FROM userTBL);

SELECT * FROM memberTBL;
CREATE TABLE changeTBL
( userID CHAR(8),
userName NVARCHAR2(10),
addr NCHAR(2),
changeType NCHAR(4)
);

INSERT INTO changeTBL VALUES('TKV', '�±Ǻ���', '�ѱ�', '�ű԰���');
INSERT INTO changeTBL VALUES('LSG', null, '����', '�ּҺ���');
INSERT INTO changeTBL VALUES('LJB', null, '����', '�ּҺ���');
INSERT INTO changeTBL VALUES('BBK', null, 'Ż��', 'ȸ��Ż��');
INSERT INTO changeTBL VALUES('SSK', null, 'Ż��', 'ȸ��Ż��');

MERGE INTO memberTBL M --M ���̺��� ����
	USING (SELECT changeType, userID, userName, addr FROM changeTBL) C -- C ���̺��� �����ؼ�
	ON (M.userID = C.userID) -- �� ���̺��� userID�� �������� ��
	WHEN MATCHED THEN
		UPDATE SET M.addr = C.addr -- ������ �̸��� ������ �ּ� ����
		DELETE WHERE C.changeType = 'ȸ��Ż��' -- �ٵ� ȸ��Ż������ �����
	WHEN NOT MATCHED THEN -- �̸� ������ �߰�
		INSERT (userID, userName, addr) VALUES(C.userID, C.userName, C.addr);