PL/SQL 블록 -> 작성한 내용을 단 한 번 실행 : 익명 블록(annoymous block)
오라클에 저장되지 않기 때문에 한 번 실행한 뒤 다시 실행하려면 PL/SQL 블록을 다시 작성하여 실행해야 한다.
(샐행 내용을 따로 sql파일에 저장하여 실행하기도 하지만 오라클에 저장되는 것은 아니다.)

이를 주기적으로 또는 필요할 때 여러번 사용하기 위해 이름을 지정, 오라클에 저장해 두는 PL/SQL 프로그램
: 저장 서브프로그램(stored subprogram)
오라클에 저장하여 공유할 수 있으므로 메모리, 성능, 재사용성 좋다.

                        익명 블록          저장 서브프로그램
이름                   : 이름 없음       |  이름 지정
오라클 저장             : 저장할 수 없음   | 저장
컴파일                 : 실행 할 때 마다  |  저장할 때 한 번
공유                   : 공유할 수 없음   |    공유 가능
다른 응용 프로그램 호출  : 호출할 수 없음   |    호출 가능

프로시저 : 일반적으로 특정 처리 작업 수행을 위한 서브프로그램. SQL문에서는 사용 불가
함수    : 일반적으로 특정 연산을 거친 결과 값을 반환하는 서브프로그램. SQL문에서 사용 가능
패키지   : 저장 서브프로그램을 그룹화
트리거   : 특정 상황(이벤트)이 발생할 때 자동으로 연달아 수행할 기능을 구현