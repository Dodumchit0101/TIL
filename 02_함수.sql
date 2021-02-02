/* *************************************
함수 - 문자열관련 함수
 UPPER()/ LOWER() : 대문자/소문자 로 변환
 INITCAP(): 단어 첫글자만 대문자 나머진 소문자로 변환
 LENGTH() : 글자수 조회
 LPAD(값, 크기, 채울값) : "값"을 지정한 "크기"의 고정길이 문자열로 만들고 모자라는 것은 왼쪽부터 "채울값"으로 채운다.
 RPAD(값, 크기, 채울값) : "값"을 지정한 "크기"의 고정길이 문자열로 만들고 모자라는 것은 오른쪽부터 "채울값"으로 채운다.
 SUBSTR(값, 시작index, 글자수) - "값"에서 "시작index"번째 글자부터 지정한 "글자수" 만큼의 문자열을 추출. 글자수 생략시 끝까지. 
 REPLACE(값, 찾을문자열, 변경할문자열) - "값"에서 "찾을문자열"을 "변경할문자열"로 바꾼다.
 LTRIM(값): 왼공백 제거
 RTRIM(값): 오른공백 제거
 TRIM(값): 양쪽 공백 제거
 ************************************* */

select upper(emp_name)
from emp;

select emp_name from emp;

select upper('abcDE') "소문자를 대문자로", lower('ABCde') "대문자를 소문자로", initcap('abcde abcde abcde') "단어의 첫글자만 대문자"
from dual;

select length('abcdef') "글자수"
from dual;

select * from emp
where length(emp_name) > 7;

select lpad('abc',10) "A", rpad('abc',10)"B",length(lpad('abc',10)), rpad('123456789',3)"C"
from dual;

select replace('010-1111-2222', '010','###') from dual;

select  trim ('    abc          ') "A",
        ltrim('    abc          ') "B",
        rtrim('    abc          ') "C"
from dual;

--EMP 테이블에서 직원의 이름(emp_name)을 모두 대문자, 소문자, 첫글자 대문자, 이름 글자수를 조회
select upper(emp_name) "대문자 이름", lower(emp_name) "소문자 이름", initcap(emp_name) "첫글자만 대문자", length(emp_name) "글자수"
from emp;

select * from emp
where upper(emp_name) = 'PETER';



-- TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 부서(dept_name)를 조회. 단 직원이름(emp_name)은 모두 대문자, 부서(dept_name)는 모두 소문자로 출력.
-- UPPER/LOWER
select emp_id, upper(emp_name), salary, lower(dept_name)
from emp;


--(아래 2개는 비교값의 대소문자를 확실히 모르는 가정)
--TODO: EMP 테이블에서 직원의 이름(emp_name)이 PETER인 직원의 모든 정보를 조회하시오.



--TODO: EMP 테이블에서 업무(job)가 'Sh_Clerk' 인 직원의의  ID(emp_id), 이름(emp_name), 업무(job), 급여(salary)를 조회



--TODO: 직원 이름(emp_name) 의 자릿수를 15자리로 맞추고 글자수가 모자랄 경우 공백을 앞에 붙여 조회. 끝이 맞도록 조회


    
--TODO: EMP 테이블에서 모든 직원의 이름(emp_name)과 급여(salary)를 조회.
--(단, "급여(salary)" 열을 길이가 7인 문자열로 만들고, 길이가 7이 안될 경우 왼쪽부터 빈 칸을 '_'로 채우시오. EX) ______5000) -LPAD() 이용



-- TODO: EMP 테이블에서 이름(emp_name)이 10글자 이상인 직원들의 이름(emp_name)과 이름의 글자수 조회




/* *************************************
함수 - 숫자관련 함수

 round(값, 자릿수) : 자릿수이하에서 반올림 (양수 - 실수부, 음수 - 정수부, 기본값 : 0)
 trunc(값, 자릿수) : 자릿수이하에서 절삭(양수 - 실수부, 음수 - 정수부, 기본값: 0)
 ceil(값) : 올림
 floor(값) : 내림
 mod(나뉘는수, 나누는수) : 나눗셈의 나머지 연산
 
************************************* */

select round(1.2345,2), round(1.5678,2), round(1.2345,0), round(156.12,-1)
from dual;

select trunc(1.5678,2), trunc(156,-2)
from dual;

--ceil/floor : 실수 -> 정수
select  ceil(15.67),
        floor(15.67)
from dual;

select round(10/3,2)
from dual;

select mod(10,3) from dual; --10을 3으로 나눴을 때의 나머지

--TODO: EMP 테이블에서 각 직원에 대해 직원ID(emp_id), 이름(emp_name), 급여(salary) 그리고 15% 인상된 급여(salary)를 조회하는 질의를 작성하시오.
--(단, 15% 인상된 급여는 올림해서 정수로 표시하고, 별칭을 "SAL_RAISE"로 지정.)
select  emp_id,
        emp_name
        salary,
        salary * 1.15
from emp



--TODO: 위의 SQL문에서 인상 급여(sal_raise)와 급여(salary) 간의 차액을 추가로 조회 (직원ID(emp_id), 이름(emp_name), 15% 인상급여, 인상된 급여와 기존 급여(salary)와 차액)



-- TODO: EMP 테이블에서 커미션이 있는 직원들의 직원_ID(emp_id), 이름(emp_name), 커미션비율(comm_pct), 커미션비율(comm_pct)을 8% 인상한 결과를 조회.
--(단 커미션을 8% 인상한 결과는 소숫점 이하 2자리에서 반올림하고 별칭은 comm_raise로 지정)




/* *************************************
함수 - 날짜관련 계산 및 함수

sysdate: 실행 시점의 일시
Date +- 정수 : 일자 계산.
months_between(d1, d2) -경과한 개월수(d1이 최근, d2가 과거)
add_months(d1, 정수) - 정수개월 지난 날짜. 마지막 날짜의 1개월 후는 달의 마지막 날이 된다. 
next_day(d1, '요일') - d1에서 첫번째 지정한 요일의 날짜. 요일은 한글(locale)로 지정한다.
last_day(d) - d 달의 마지막날.
extract(year|month|day from date) - date에서 year/month/day만 추출
************************************* */

select sysdate,
    to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss')
from dual;
--to_char(date값, '날짜형식'): date를 문자열로 변환

select months_between(sysdate, '2020/12/28')||'개월',
        months_between(sysdate, '2019/10/28')||'개월',
        ceil(months_between(sysdate, '2020/12/26'))||'개월'
from dual;

select add_months(sysdate, 2), --양수: 2개월 후
        add_months(sysdate, -2) --음수: 2개월 전
from dual;

select next_day(sysdate, '금요일'),
        next_day(sysdate,'수요일')
from dual;

select last_day(sysdate) from dual;
select extract(year from sysdate),
        extract(month from sysdate),
        extract(day from sysdate)
from dual;

select * from emp
where extract(month from hire_date) = 11;



--TODO: EMP 테이블에서 부서이름(dept_name)이 'IT'인 직원들의 '입사일(hire_date)로 부터 10일전', 입사일과 '입사일로 부터 10일후',  의 날짜를 조회. 


--TODO: 부서가 'Purchasing' 인 직원의 이름(emp_name), 입사 6개월전과 입사일(hire_date), 6개월후 날짜를 조회.
     

--TODO: EMP 테이블에서 입사일과 입사일 2달 후, 입사일 2달 전 날짜를 조회.


-- TODO: 각 직원의 이름(emp_name), 근무 개월수 (입사일에서 현재까지의 달 수)를 계산하여 조회.
--(단 근무 개월수가 실수 일 경우 정수로 반올림. 근무개월수 내림차순으로 정렬.)



--TODO: 직원 ID(emp_id)가 100 인 직원의 입사일 이후 첫번째 금요일의 날짜를 구하시오.

/* *************************************
함수 - 변환 함수

#####################################################################################
#				# = to_char() =>	#					#<=to_char()=	#			#
#   Number 타입	#					#  Character 타입	#				#  Date 타입	#
#				# <=to_number()=    #	    			#=to_date()=>	#			#
#####################################################################################


to_char() : 숫자형, 날짜형을 문자형으로 변환
to_number() : 문자형을 숫자형으로 변환 
to_date() : 문자형을 날짜형으로 변환


형식(format)문자 
숫자 :
    0, 9 : 숫자가 들어갈 자릿수 지정. (9: 정수부 남는자리를 공백으로 채움, 0은 0으로 채움) - 실수부 남는 자리는 둘다 0으로 채운다.
           fm으로 시작하면 9일 경우 공백을 제거.
    . : 정수/실수부 구문자.
    ,: 정수부 단위구분자
    'L', '$' : 통화표시. L; 로컬통화기호
일시 :yyyy : 연도 4자리, yy: 연도 2자리(2000년대), rr: 연도2자리(50이상:90년대, 50미만:2000년대)
      mm: 월 2자리  (11, 05)
      dd: 일 2자리
      hh24: 시간(00 ~ 23) 2자리, hh(01 ~ 12)
      mi: 분 2자리
      ss: 초 2자리
      day(요일), 
      am 또는 pm : 오전/오후
************************************* */

select 10+'10' from dual;
select to_char(1000000, '999,999,999') from dual;

select to_char(salary, '99,999')
from emp;

select 10+to_number('1,000.53', '9,999.99')
from dual;

select to_char(12345678, '999,999,999'),
        to_char(12345678, 'fm999,999,999'),
        to_char(12345678, '999,999'),
        to_char(10000, '$99,999'),
        to_char(10000, 'L99,999')
from dual;

select to_char(1234.567, '0,000.000'),
        to_char(1234.56, '000,000.000'),
        to_char(1234.56, '999,999.999')
from dual;

select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
        to_char(sysdate, 'yyyy'),
        to_char(sysdate, 'day'),
        to_char(sysdate, 'dy'),
        to_char(sysdate, 'hh24:mi:ss'),
        to_char(sysdate, 'yyyy"년" mm"월" dd"일"')
from dual;

select to_date('2000/10', 'yyyy/mm') from dual;

-- EMP 테이블에서 업무(job)에 "CLERK"가 들어가는 직원들의 ID(emp_id), 이름(name), 업무(job), 급여(salary)를 조회
--(급여는 단위 구분자 , 를 사용하고 앞에 $를 붙여서 출력.)
select emp_id, emp_name, job, to_char(salary, 'fm$999,999.00')"salary"
from emp
where job like '%CLERK%';



-- 문자열 '20030503' 를 2003년 05월 03일 로 출력.

select to_char(to_date('20030503', 'yyyymmdd'), 'yyyy"년" mm"월" dd"일"')
from dual;

--날짜: char(s) yyyymmdd
--일시: char(15) yyyymmddhhmiss

-- TODO: 부서명(dept_name)이 'Finance'인 직원들의 ID(emp_id), 이름(emp_name)과 입사년도(hire_date) 4자리만 출력하시오. (ex: 2004);
--to_char()


--TODO: 직원들중 11월에 입사한 직원들의 직원ID(emp_id), 이름(emp_name), 입사일(hire_date)을 조회
--to_char()


--TODO: 2006년에 입사한 모든 직원의 이름(emp_name)과 입사일(yyyy-mm-dd 형식)을 입사일(hire_date)의 오름차순으로 조회
--to_char()


--TODO: 2004년 05월 이후 입사한 직원 조회의 이름(emp_name)과 입사일(hire_date) 조회



--TODO: 문자열 '20100107232215' 를 2010년 01월 07일 23시 22분 15초 로 출력. (dual 테입블 사용)



/* *************************************
함수 - null 관련 함수 
NVL()
NVL2(expr, nn, null) - expr이 null이 아니면 nn, 널이면 세번째
nullif(ex1, ex2) 둘이 같으면 null, 다르면 ex1

************************************* */

-- EMP 테이블에서 직원 ID(emp_id), 이름(emp_name), 급여(salary), 커미션비율(comm_pct)을 조회. 단 커미션비율이 NULL인 직원은 0이 출력되도록 한다..


--TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 업무(job), 부서(dept_name)을 조회. 부서가 없는 경우 '부서미배치'를 출력.
select emp_id, emp_name, job, nvl(dept_name, '부서미배치') dept_name
from emp
order by dept_name desc;


--TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 커미션 (salary * comm_pct)을 조회. 커미션이 없는 직원은 0이 조회되록 한다.
select emp_id, emp_name, salary, comm_pct, salary * comm_pct as commission
from emp;


/* *************************************
DECODE함수와 CASE 문
decode(컬럼, [비교값, 출력값, ...] , else출력) 

case문 동등비교
case 컬럼 when 비교값 then 출력값
              [when 비교값 then 출력값]
              [else 출력값]
              end
              
case문 조건문
case when 조건 then 출력값
       [when 조건 then 출력값]
       [else 출력값]
       end

************************************* */
--EMP테이블에서 급여와 급여의 등급을 조회하는데 급여 등급은 10000이상이면 '1등급', 10000미만이면 '2등급' 으로 나오도록 조회


--decode()/case 를 이용한 정렬
-- 직원들의 모든 정보를 조회한다. 단 정렬은 업무(job)가 'ST_CLERK', 'IT_PROG', 'PU_CLERK', 'SA_MAN' 순서대로 먼저나오도록 한다. (나머지 JOB은 상관없음)


--TODO: EMP 테이블에서 업무(job)이 'AD_PRES'거나 'FI_ACCOUNT'거나 'PU_CLERK'인 직원들의 ID(emp_id), 이름(emp_name), 업무(job)을 조회. 
-- 업무(job)가 'AD_PRES'는 '대표', 'FI_ACCOUNT'는 '회계', 'PU_CLERK'의 경우 '구매'가 출력되도록 조회
select  emp_id,
        emp_name,
        decode(job, 'AD_PRES', '대표',
                    'FI_ACCOUNT', '회계',
                    'PU_CLERK', '구매') job
        case job when 'AD_PRES' then '대표'
                 when 'FI_ACCOUNT' then '회계'
                 when 'PU_CLERK' then '구매' end JOB2
from emp
where job in ('AD_PRES', 'FI_ACCOUNT', 'PU_CLERK');

--TODO: EMP 테이블에서 부서이름(dept_name)과 급여 인상분을 조회. 급여 인상분은 부서이름이 'IT' 이면 급여(salary)에 10%를 'Shipping' 이면 급여(salary)의 20%를 'Finance'이면 30%를 나머지는 0을 출력
-- decode 와 case문을 이용해 조회
select  dept_name,
        salary,
        decode(dept_name, 'IT', salary*1.1,
                          'Shipping', salary*1.2,
                          'Finance', salary*1.3,
                          0) "인상된급여",
        case dept_name when 'IT' then salary*1,1
                       when 'Shipping' then salary*1.2
                       when 'Finance' then salary*1.3
                       else 0 end "인상된급여2"
from emp;

--TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 인상된 급여를 조회한다. 
--단 급여 인상율은 급여가 5000 미만은 30%, 5000이상 10000 미만는 20% 10000 이상은 10% 로 한다.
select  emp_id,
        emp_name,
        salary,
        case when salary < 5000 then salary*13
             when salary >= 10000 then salary*1.1
             else salary*1.2 end "인상급여"
from  emp;



