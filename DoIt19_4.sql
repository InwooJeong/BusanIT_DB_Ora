SET SERVEROUTPUT ON;
--패키지 명세
--패키지에 포함할 변수, 상수, 예외, 커서 그리고 PL/SQL 서브 프로그램을 선언하는 용도로 작성
--패키지 명세에 선언한 여러 객체는 패키지 내부 뿐 아니라 외부에서도 참조 가능
--CREATE [OR REPLACE] PACKAGE 패키지 이름
--IS | AS
--    서브프로그램을 포함한 다양한 객체 선언
--END [패키지 이름];

CREATE OR REPLACE PACKAGE pkg_example
IS
    spec_no NUMBER := 10;
    FUNCTION func_aftertax(sal NUMBER) RETURN NUMBER;
    PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE);
    PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE);
END;
/

--이미 생성되어 있는 패키지 명세 코드를 확인하거나 선언한 서브프로그램을 확인
--USER_SOURCE데이터 사전을 조회하거나 DESC
SELECT      TEXT
FROM        USER_SOURCE
WHERE       TYPE = 'PACKAGE'
AND         NAME = 'PKG_EXAMPLE';

DESC PKG_EXAMPLE;

--패키지 본문
--패키지 명세에서 선언한 서브프로그램 코드를 작성
--패키지 명세에 선언하지 않은 객체나 서브프로그램 정의도 가능 -> 패키지 본문에만 존재하는 프로그램은 패키지 내부에서만 사용 가능
--패키지 본문 이름은 패키지 명세 이름과 같게 지정
--CREATE [OR REPLACE] PACKAGE BODY 패키지 이름
--IS | AS
--    패키지 명세에서 선언한 서브프로그램을 포함, 여러 객체를 정의
--    경우에 따라 패키지 명세에 존재하지 않는 객체 및 서브프로그램도 정의 가능
--END [패키지 이름];    
