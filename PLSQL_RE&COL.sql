SET SERVEROUTPUT ON;

--RECORD
DECLARE
    TYPE REC_DEPT IS RECORD(
    DEPTNO NUMBER(2) NOT NULL := 99,
    DNAME  DEPT.DNAME%TYPE,
    LOC    DEPT.LOC%TYPE
    ); --선언한 레코드 정의
    DEPT_REC REC_DEPT; --레코드형 변수 선언, 같은 레코드형으로 변수 여러 개 선언 가능
BEGIN
    DEPT_REC.DEPTNO := 99;
    DEPT_REC.DNAME  := 'DATABASE';
    DEPT_REC.LOC    := 'SEOUL'; --레코드형 변수 내 포함된 변수에 값을 대입
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || DEPT_REC.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || DEPT_REC.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || DEPT_REC.LOC); --저장된 값 사용 시 레코드형 변수 이름과 마침표(.)
END;
/

--연습용 DEPT_RECORD 테이블 생성
CREATE TABLE    DEPT_RECORD
AS  SELECT      *
    FROM        DEPT;

SELECT  *
FROM    DEPT_RECORD;

DECLARE
    TYPE REC_DEPT IS RECORD(
    deptno NUMBER(2) NOT NULL := 99,
    dname  DEPT.DNAME%TYPE,
    loc    DEPT.LOC%TYPE
    );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.deptno := 99;
    dept_rec.dname  := 'DATABASE';
    dept_rec.loc    := 'SEOUL';
    
INSERT INTO     DEPT_RECORD
VALUES          dept_rec;
END;
/

DECLARE
    TYPE REC_DEPT IS RECORD(
     deptno NUMBER(2) NOT NULL := 99,
     dname  DEPT.DNAME%TYPE,
     loc    DEPT.LOC%TYPE
      );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.deptno := 50;
    dept_rec.dname  := 'DB';
    dept_rec.loc    := 'SEOUL';
    
    UPDATE      DEPT_RECORD
    SET         ROW = dept_rec
    WHERE       DEPTNO = 99;
END;
/

DECLARE
    TYPE REC_DEPT IS RECORD(
        deptno DEPT.DEPTNO%TYPE,
        dname  DEPT.DNAME%TYPE,
        loc    DEPT.LOC%TYPE
        );
    TYPE REC_EMP IS RECORD(
        empno EMP.EMPNO%TYPE,
        ename EMP.ENAME%TYPE,
        dinfo REC_DEPT
        );
        emp_rec REC_EMP;
BEGIN
    SELECT      E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
    
        INTO    emp_rec.empno, emp_rec.ename,
                emp_rec.dinfo.deptno,
                emp_rec.dinfo.dname,
                emp_rec.dinfo.loc
    FROM    EMP E, DEPT D
    WHERE   E.DEPTNO = D.DEPTNO
    AND     E.EMPNO  = 7902;
    DBMS_OUTPUT.PUT_LINE('EMPNO : ' || emp_rec.empno);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || emp_rec.ename);
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || emp_rec.dinfo.deptno);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || emp_rec.dinfo.dname);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || emp_rec.dinfo.loc);
END;
/

--COLLECTION
DECLARE
    TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
    INDEX BY PLS_INTEGER;

    text_arr ITAB_EX;

BEGIN
    text_arr(1) := '1st data';
    text_arr(2) := '2nd data';
    text_arr(3) := '3rd data';
    text_arr(4) := '4th data'; --연관 배열에 값 넣기
    
    DBMS_OUTPUT.PUT_LINE('text_arr(1) : ' || text_arr(1));
    DBMS_OUTPUT.PUT_LINE('text_arr(2) : ' || text_arr(2));
    DBMS_OUTPUT.PUT_LINE('text_arr(3) : ' || text_arr(3));
    DBMS_OUTPUT.PUT_LINE('text_arr(4) : ' || text_arr(4));
END;
/

DECLARE
    TYPE REC_DEPT IS RECORD(
        deptno DEPT.DEPTNO%TYPE,
        dname  DEPT.DNAME%TYPE
        );
   
    TYPE ITAB_DEPT IS TABLE OF REC_DEPT
        INDEX BY PLS_INTEGER; --배열 번호처럼 내가 타입을 정해주는 것 ex)1,2,3 A,B,C
    
    dept_arr ITAB_DEPT;
    idx PLS_INTEGER := 0; 
    
BEGIN
    FOR i IN (SELECT DEPTNO, DNAME FROM DEPT) LOOP
    idx := idx + 1;
    dept_arr(idx).deptno := i.DEPTNO;
    dept_arr(idx).dname  := i.DNAME;
    
    DBMS_OUTPUT.PUT_LINE(
        --dept_arr(idx) || ':' || 
        dept_arr(idx).deptno || ':' || dept_arr(idx).dname);
    END LOOP;
END;
/

CL SCR

DECLARE
    TYPE ITAB_DEPT IS TABLE OF DEPT%ROWTYPE
        INDEX BY PLS_INTEGER;
    
    dept_arr ITAB_DEPT;
    idx PLS_INTEGER := 0;

BEGIN
    FOR i IN(SELECT * FROM DEPT) LOOP
        idx := idx + 1;
        dept_arr(idx).deptno := i.DEPTNO;
        dept_arr(idx).dname  := i.DNAME;
        dept_arr(idx).loc    := i.LOC;
        
        DBMS_OUTPUT.PUT_LINE(
            dept_arr(idx).deptno || ':' ||
            dept_arr(idx).dname  || ':' ||
            dept_arr(idx).loc);
    END LOOP;
END;
/
CL SCR
--COLLECTION METHOD
DECLARE
    TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
        INDEX BY PLS_INTEGER;
        --INDEX BY VARCHAR2(10);

    text_arr ITAB_EX;
    
BEGIN
    text_arr(1)  := '1st data';
    text_arr(2)  := '2nd data';
    text_arr(3)  := '3rd data';
    text_arr(50) := '50th data';

    DBMS_OUTPUT.PUT_LINE('text_arr.COUNT : ' || text_arr.COUNT);
    DBMS_OUTPUT.PUT_LINE('text_arr.FIRST : ' || text_arr.FIRST);
    DBMS_OUTPUT.PUT_LINE('text_arr.LAST : ' || text_arr.LAST);
    DBMS_OUTPUT.PUT_LINE('text_arr.PRIOR(50) : ' || text_arr.PRIOR(50));
    DBMS_OUTPUT.PUT_LINE('text_arr.NEXT(50) : ' || text_arr.NEXT(50));
    
END;
/

--DELETE
DECLARE
    TYPE AV_TYPE IS TABLE OF VARCHAR2(40)
        --INDEX BY PLS_INTEGER;
        INDEX BY VARCHAR2(10);
    
    VAV_TEST AV_TYPE;
    VN_CNT NUMBER := 0;

BEGIN
    VAV_TEST('A') := '값1';
    VAV_TEST('B') := '값2';
    VAV_TEST('C') := '값3';
    
    VN_CNT := VAV_TEST.COUNT;
    
    DBMS_OUTPUT.PUT_LINE('삭제 전 요소의 개수 : ' || VN_CNT);
    
    --DELETE 메서드로 요소 두 개 제거
    VAV_TEST.DELETE('A','B');
    
    VN_CNT := VAV_TEST.COUNT;
    
    DBMS_OUTPUT.PUT_LINE('삭제 후 요소의 개수 : ' || VN_CNT);
END;
/
CL SCR    
--TRIM
DECLARE
    TYPE NT_TYPE IS TABLE OF VARCHAR2(10);
        --INDEX BY VARCHAR2(10);
    
    VNT_TEST NT_TYPE;
BEGIN
    VNT_TEST := NT_TYPE('FIRST','SECOND','THIRD','FOURTH','FIFTH');
    
    VNT_TEST.TRIM(2);
    
    DBMS_OUTPUT.PUT_LINE(VNT_TEST(1));
    DBMS_OUTPUT.PUT_LINE(VNT_TEST(2));
    DBMS_OUTPUT.PUT_LINE(VNT_TEST(3));
    DBMS_OUTPUT.PUT_LINE(VNT_TEST(4));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/

-------Q1
CREATE  TABLE       EMP_RECORD
AS      SELECT      *
        FROM        EMP
        WHERE       1=2; --테이블 구조만 복사

SELECT      *
FROM        EMP_RECORD; --확인

DESC        EMP_RECORD;

DECLARE
    TYPE rec_emp IS RECORD( --타입 맞추기
        empno       EMP.EMPNO%TYPE NOT NULL := 9999,
        ename       EMP.ENAME%TYPE,
        job         EMP.JOB%TYPE,
        mgr         EMP.MGR%TYPE,
        hiredate    EMP.HIREDATE%TYPE,
        sal         EMP.SAL%TYPE,
        comm        EMP.COMM%TYPE,
        deptno      EMP.DEPTNO%TYPE
    );
    emp_rec rec_emp; --레코드 변수 이름 타입
BEGIN    
    emp_rec.empno    := 1111; --값 지정
    emp_rec.ename    := 'TEST_USER';
    emp_rec.job      := 'TEST_JOB';
    emp_rec.mgr      := null;
    emp_rec.hiredate := TO_DATE('2018/03/01', 'YYYY/MM/DD');
    emp_rec.sal      := 3000;
    emp_rec.comm     := null;
    emp_rec.deptno   := 40;
    
INSERT  INTO    EMP_RECORD
VALUES          emp_rec;
END;
/

DECLARE
    TYPE emp_list IS TABLE OF EMP%ROWTYPE --EMP 테이블 ROW TYPE과 같게
        INDEX BY PLS_INTEGER;
   
    emp_arr emp_list;
    idx PLS_INTEGER := 0;

BEGIN
    FOR i IN(SELECT * FROM EMP) LOOP --인덱스가지고 전체 조회(루프)
        idx := idx+1;
        emp_arr(idx).empno    := i.EMPNO;
        emp_arr(idx).ename    := i.ENAME;
        emp_arr(idx).job      := i.JOB;
        emp_arr(idx).mgr      := i.MGR;
        emp_arr(idx).hiredate := i.HIREDATE;
        emp_arr(idx).sal      := i.SAL;
        emp_arr(idx).comm     := i.COMM;
        emp_arr(idx).deptno   := i.DEPTNO;
        
        DBMS_OUTPUT.PUT_LINE(
            emp_arr(idx).empno    || ':' ||
            emp_arr(idx).ename    || ':' ||
            emp_arr(idx).job      || ':' ||
            emp_arr(idx).mgr      || ':' ||
            emp_arr(idx).hiredate || ':' ||
            emp_arr(idx).sal      || ':' ||
            emp_arr(idx).comm     || ':' ||
            emp_arr(idx).deptno);
    END LOOP;
END;
/