/* ****************************************
����(JOIN) �̶�
- 2�� �̻��� ���̺� �ִ� �÷����� ���ļ� ������ ���̺��� ����� ��ȸ�ϴ� ����� ���Ѵ�.
 	- �ҽ����̺� : ���� ���� �о�� �Ѵٰ� �����ϴ� ���̺� - ���� ������ ���̺�
	- Ÿ�����̺� : �ҽ��� ���� �� �ҽ��� ������ ����� �Ǵ� ���̺� - �߰� ����, �ΰ� ����
        -id�� 100�� ������ id�� �̸�, ����, �μ��̸�, �μ���ġ : �ҽ�: ����/Ÿ��: �μ�
        -id�� 100�� �μ��� �̸�, ��ġ, �Ҽ������� �̸�, ���� : �ҽ�: �μ�/Ÿ��: ����
 
 
- �� ���̺��� ��� ��ĥ���� ǥ���ϴ� ���� ���� �����̶�� �Ѵ�.
    - ���� ���꿡 ���� ��������
        - Equi join , non-equi join
- ������ ����
    - Inner Join 
        - ���� ���̺��� ���� ������ �����ϴ� ��鸸 ��ģ��. 
    - Outer Join
        - ���� ���̺��� ����� ��� ����ϰ� �ٸ� �� ���̺��� ���� ������ �����ϴ� �ุ ��ģ��. ���������� �����ϴ� ���� ���� ��� NULL�� ��ģ��.
        - ���� : Left Outer Join,  Right Outer Join, Full Outer Join
    - Cross Join
        - �� ���̺��� �������� ��ȯ�Ѵ�. 
- ���� ����
    - ANSI ���� ����
        - ǥ�� SQL ����
        - ����Ŭ�� 9i ���� ����.
    - ����Ŭ ���� ����
        - ����Ŭ ���� �����̸� �ٸ� DBMS�� �������� �ʴ´�.
**************************************** */        
        

/* ****************************************
-- inner join : ANSI ���� ����
FROM  ���̺�a ��Ī INNER JOIN ���̺�b ��Ī ON �������� 

- inner�� ���� �� �� �ִ�.
**************************************** */
-- ������ ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
select emp_id, emp_name, hire_date, dept_name
from emp inner join dept on emp.dept_id = dept.dept_id;

select * from emp;
select * from dept where dept_id = 90;
select * from emp where dept_id is null;

-- ������ ID(emp.emp_id)�� 100�� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ.
select e.emp_id, e.emp_name, to_char(e.hire_date, 'yyyy"��"') hire_year, d.dept_name
from emp e inner join dept d on e.dept_id = d.dept_id --inner ���� ����
where e.emp_id = 100;

-- ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
select e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name
from emp e join job j on e.job_id = j.job_id join dept d on e.dept_id = d.dept_id;


-- �μ�_ID(dept.dept_id)�� 30�� �μ��� �̸�(dept.dept_name), ��ġ(dept.loc), �� �μ��� �Ҽӵ� ������ �̸�(emp.emp_name)�� ��ȸ.
select d.dept_name, d.loc, e.emp_name
from dept d join emp e on d.dept_id = e.dept_id
where d.dept_id = 30;

-- ������ ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), �޿����(salary_grade.grade) �� ��ȸ. �޿� ��� ������������ ����
select e.emp_id, e.emp_name, e.salary, s.grade||'���'
from emp e join salary_grade s on e.salary between s.low_sal and s.high_sal
order by 4;

--TODO 200����(200 ~ 299) ���� ID(emp.emp_id)�� ���� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.
select e.emp_id, e.emp_name, e.salary, d.dept_name, d.loc
from emp e join dept d on e.dept_id = d.dept_id
where e.emp_id between 200 and 299;


--TODO ����(emp.job_id)�� 'FI_ACCOUNT'�� ������ ID(emp.emp_id), �̸�(emp.emp_name), ����(emp.job_id), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ.  ����_ID�� ������������ ����.
select e.emp_id, e.emp_name, e.job_id, d.dept_name, d.loc
from emp e join dept d on e.dept_id = d.dept_id
where e.job_id = 'FI_ACCOUNT'
order by e.emp_id;


--TODO Ŀ�̼Ǻ���(emp.comm_pct)�� �ִ� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), Ŀ�̼Ǻ���(emp.comm_pct), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.
select e.emp_id, e.emp_name, e.salary, e.comm_pct d.dept_name, d.loc
from emp e join dept d on e.dept_id = d.dept_id
where emp.comm_pct is not null
order by 1;



--TODO 'New York'�� ��ġ��(dept.loc) �μ��� �μ�_ID(dept.dept_id), �μ��̸�(dept.dept_name), ��ġ(dept.loc), 
--     �� �μ��� �Ҽӵ� ����_ID(emp.emp_id), ���� �̸�(emp.emp_name), ����(emp.job_id)�� ��ȸ. �μ�_ID �� ������������ ����.
select d.dept_id, d.dept_name, d.loc, e.emp_id, e.emp_name, e.job_id
from dept d join emp e on d.dept_id = e.dept_id
where d.loc = 'New York'
order by 1;


--TODO ����_ID(emp.emp_id), �̸�(emp.emp_name), ����_ID(emp.job_id), ������(job.job_title) �� ��ȸ.
select e.emp_id, e.emp_name, e.job_id, j.job_title
from emp e join job j on e.job_id = j.job_id;

              
-- TODO: ���� ID �� 200 �� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--       ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ              
select e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name
from emp e join job j on e.job_id = j.job_id join dept d on e.dept_id = d.dept_id
where e.emp_id = 200;


-- TODO: 'Shipping' �μ��� �μ���(dept.dept_name), ��ġ(dept.loc), �Ҽ� ������ �̸�(emp.emp_name), ������(job.job_title)�� ��ȸ. 
--       �����̸� ������������ ����
select d.dept_name, d.loc, e.emp_name, j.job_title
from dept d join emp e on d.dept_id = e.dept_id join job j on e.job_id = j.job_id
where d.dept_name = 'Shipping'
order by e.emp_name desc;


-- TODO:  'San Francisco' �� �ٹ�(dept.loc)�ϴ� ������ id(emp.emp_id), �̸�(emp.emp_name), �Ի���(emp.hire_date)�� ��ȸ
--         �Ի����� 'yyyy-mm-dd' �������� ���
select e.emp_id, e.emp_name, to_char(e.hire_date, 'yyyy/mm/dd')hire_date
from emp e join dept d on e.dept_id = d.dept_id
where d.loc = 'San Francisco';


-- TODO �μ��� �޿�(salary)�� ����� ��ȸ. �μ��̸�(dept.dept_name)�� �޿������ ���. �޿� ����� ���� ������ ����.
-- �޿��� , ���������ڿ� $ �� �ٿ� ���.
select d.dept_id, d.dept_name, to_char(round(avg(salary), 2), '$999,999') salary_��� 
from emp e join dept d on e.dept_id = d.dept_id
group by d.dept_id, d.dept_name
order by 3 desc;


select dept_id, avg(salary)
from emp
group by dept_id;



--TODO ������ ID(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), 
--     �޿����(salary_grade.grade), �ҼӺμ���(dept.dept_name)�� ��ȸ. ��� ������������ ����
select e.emp_id, e.emp_name, j.job_title, e.salary, s.grade, d.dept_name
from emp e  join job j on e.job_id = j.job_id
            join salary_grade s on e.salary between s.low_sal and s.high_sal
            join dept d on e.dept_id = d.dept_id
order by s.grade;


--TODO �μ��� �޿������(salary_grade.grade) 1�� �����ִ� �μ��̸�(dept.dept_name)�� 1����� ������ ��ȸ. �������� ���� �μ� ������� ����.
select d.dept_name, count(*)"������"
from emp e join dept d on e.dept_id = d.dept_id
            join salary_grade s on e.salary between s.low_sal and s.high_sal
where s.grade = 1
group by d.dept_id, d.dept_name
order by 1;



/* ###################################################################################### 
����Ŭ ���� 
- Join�� ���̺���� from���� �����Ѵ�.
- Join ������ where���� ����Ѵ�. 

###################################################################################### */
-- ������ ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
-- �Ի�⵵�� �⵵�� ���
select e.emp_id, e.emp_name, extract(year from e.hire_date), d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id;

from emp e join dept d on e.dept_id = d.dept_id

-- ������ ID(emp.emp_id)�� 100�� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
-- �Ի�⵵�� �⵵�� ���
select e.emp_id, e.emp_name, e.hire_date,d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id  --join
and e.emp_id = 100;  --where���ǹ�


-- ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
select e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name
from emp e, job j, dept d
where e.job_id = j.job_id
and e.dept_id = d.dept_id;


--TODO 200����(200 ~ 299) ���� ID(emp.emp_id)�� ���� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.
select e.emp_id, e.emp_name, e.salary, d.dept_name, d.loc
from emp e, dept d
where e.dept_id = d.dept_id
and e.emp_id between 200 and 299;


--TODO ����(emp.job_id)�� 'FI_ACCOUNT'�� ������ ID(emp.emp_id), �̸�(emp.emp_name), ����(emp.job_id), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ.  ����_ID�� ������������ ����.
select e.emp_id, e.emp_name, e.job_id, d.dept_name, d.loc
from emp e, dept d
where e.dept_id = d.dept_id
and e.job_id = 'FI_ACCOUNT';


--TODO Ŀ�̼Ǻ���(emp.comm_pct)�� �ִ� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), Ŀ�̼Ǻ���(emp.comm_pct), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.
select e.emp_id, e.emp_name, e.salary, e.comm_pct, d.dept_name, d.loc
from emp e, dept d
where e.dept_id = d.dept_id
and e.comm_pct is not null
order by e.emp_id asc;



--TODO 'New York'�� ��ġ��(dept.loc) �μ��� �μ�_ID(dept.dept_id), �μ��̸�(dept.dept_name), ��ġ(dept.loc), 
--     �� �μ��� �Ҽӵ� ����_ID(emp.emp_id), ���� �̸�(emp.emp_name), ����(emp.job_id)�� ��ȸ. �μ�_ID �� ������������ ����.
select d.dept_id, d.dept_name, d.loc, e.emp_id, e.emp_name, e.job_id
from dept d, emp e
where d.dept_id = e.dept_id
and d.loc = 'New York'
order by d.dept_id;



--TODO ����_ID(emp.emp_id), �̸�(emp.emp_name), ����_ID(emp.job_id), ������(job.job_title) �� ��ȸ.
select e.emp_id, e.emp_name, e.job_id, j.job_title
from emp e, job j
where e.job_id = j.job_id;

             
-- TODO: ���� ID �� 200 �� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--       ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ              



-- TODO: 'Shipping' �μ��� �μ���(dept.dept_name), ��ġ(dept.loc), �Ҽ� ������ �̸�(emp.emp_name), ������(job.job_title)�� ��ȸ. 
--       �����̸� ������������ ����



-- TODO:  'San Francisco' �� �ٹ�(dept.loc)�ϴ� ������ id(emp.emp_id), �̸�(emp.emp_name), �Ի���(emp.hire_date)�� ��ȸ
--         �Ի����� 'yyyy-mm-dd' �������� ���



--TODO �μ��� �޿�(salary)�� ����� ��ȸ. �μ��̸�(dept.dept_name)�� �޿������ ���. �޿� ����� ���� ������ ����.
-- �޿��� , ���������ڿ� $ �� �ٿ� ���.



--TODO ������ ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), �޿����(salary_grade.grade) �� ��ȸ. ���� id ������������ ����




--TODO ������ ID(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), 
--     �޿����(salary_grade.grade), �ҼӺμ���(dept.dept_name)�� ��ȸ. ��� ������������ ����



--TODO �μ��� �޿������(salary_grade.grade) 1�� �����ִ� �μ��̸�(dept.dept_name)�� 1����� ������ ��ȸ. �������� ���� �μ� ������� ����.


/* ****************************************************
Self ����
- ���������� �ϳ��� ���̺��� �ΰ��� ���̺�ó�� �����ϴ� ��.
**************************************************** */
--������ ID(emp.emp_id), �̸�(emp.emp_name), ����̸�(emp.emp_name)�� ��ȸ



-- TODO : EMP ���̺��� ���� ID(emp.emp_id)�� 110�� ������ �޿�(salary)���� ���� �޴� �������� id(emp.emp_id), 
-- �̸�(emp.emp_name), �޿�(emp.salary)�� ���� ID(emp.emp_id) ������������ ��ȸ.



/* ****************************************************
�ƿ��� ���� (Outer Join)

-����� ���� (���� ����� ������ ���� ����� �ص� ���̵���) 
 - �ҽ�(�����ؾ��ϴ����̺�)�� �����̸� left join, �������̸� right join �����̸� full outer join

-ANSI ����
from ���̺�a [LEFT | RIGHT | FULL] OUTER JOIN ���̺�b ON ��������
- OUTER�� ���� ����.

-����Ŭ JOIN ����
- FROM ���� ������ ���̺��� ����
- WHERE ���� ���� ������ �ۼ�
    - Ÿ�� ���̺� (+) �� ���δ�.
    - FULL OUTER JOIN�� �������� �ʴ´�.
- OUTER�� ���� �� �� �ִ�.	
**************************************************** */
-- ������ id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), �μ���(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. 
-- �μ��� ���� ������ ������ �������� ��ȸ. (�μ������� null). dept_name�� ������������ �����Ѵ�.




-- ��� ������ id(emp.emp_id), �̸�(emp.emp_name), �μ�_id(emp.dept_id)�� ��ȸ�ϴµ�
-- �μ�_id�� 80 �� �������� �μ���(dept.dept_name)�� �μ���ġ(dept.loc) �� ���� ����Ѵ�. (�μ� ID�� 80�� �ƴϸ� null�� ��������)




--TODO: ����_id(emp.emp_id)�� 100, 110, 120, 130, 140�� ������ ID(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title) �� ��ȸ. 
-- �������� ���� ��� '�̹���' ���� ��ȸ



--TODO: �μ��� ID(dept.dept_id), �μ��̸�(dept.dept_name)�� �� �μ��� ���� �������� ���� ��ȸ. 
--      ������ ���� �μ��� 0�� �������� ��ȸ�ϰ� �������� ���� �μ� ������ ��ȸ.



-- TODO: EMP ���̺��� �μ�_ID(emp.dept_id)�� 90 �� �������� id(emp.emp_id), �̸�(emp.emp_name), ����̸�(emp.emp_name), �Ի���(emp.hire_date)�� ��ȸ. 
-- �Ի����� yyyy-mm-dd �������� ���





--TODO 2003��~2005�� ���̿� �Ի��� ������ id(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), �Ի���(emp.hire_date),
--     ����̸�(emp.emp_name), ������Ի���(emp.hire_date), �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ.
-- 2003�⿡�� 2005�� ���� �Ի��� ������ ��� �������� ��ȸ�Ѵ�. 




