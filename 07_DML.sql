/* *********************************************************************
DML - ������(��)�� �ٷ�� SQL��
    - insert: ���� (Create)
    - select: ��ȸ (Read, Retrieve)
    - update: ���� (Update)
    - delete: ���� (Delete)

INSERT �� - �� �߰�
����
 - �����߰� :
   - INSERT INTO ���̺�� (�÷� [, �÷�]) VALUES (�� [, ��[])
   - ��� �÷��� ���� ���� ��� �÷� ���������� ���� �� �� �ִ�.

 - ��ȸ����� INSERT �ϱ� (subquery �̿�)
   - INSERT INTO ���̺�� (�÷� [, �÷�])  SELECT ����
	- INSERT�� �÷��� ��ȸ��(subquery) �÷��� ������ Ÿ���� �¾ƾ� �Ѵ�.
	- ��� �÷��� �� ���� ��� �÷� ������ ������ �� �ִ�.
	
  
************************************************************************ */
desc dept;
insert into dept(dept_id, dept_name, loc) values (1000, '��ȹ��', '����');
insert into dept values(1100, '���ź�', '�λ�');
commit;

rollback; --insert/update/delete�ϱ� �� ���·� ������(������ commit ���·� ������)
select * from dept order by dept_id desc;

desc emp;

insert into emp values(1000, 'ȫ�浿', 'FI_ACCOUNT', 100, '2017/10/20', 5000, 0.1, 20);
insert into emp (emp_id, emp_name, hire_date, salary) values(1100, '�̼���', '2000/01/05', 6000);
insert into emp values(1200, '�ڿ���', 'FI_ACCOUNT', null, '2020/01/02', 7000, null, 10);
insert into emp values(1300, '�ڿ���', 'FI_ACCOUNT', null, to_date('2020/01', 'yyyy/mm'), 7000, null, 10);
rollback;
select * from emp order by emp_id desc;

insert into emp values (1000, '�迵��', 'FI_ACCOUNT', 100, '2021/01/06', 1000, 0.1, 20); --�̹� �ִ� PK���� ����
insert into emp values (1000, null, 'FI_ACCOUNT', 100, '2021/01/06', 1000, 0.1, 20); --not null �÷��� null�� �ȵ�
insert into emp values (1000, '�迵��', 'ȸ��', 100, '2021/01/06', 1000, 0.1, 20); --emp�� job_id�� FK �÷� => �θ� ���̺� PK�÷��� �ִ� ���� ����
insert into emp values (1000, '�迵���迵���迵��', 'FI_ACCOUNT', 100, '2021/01/06', 1000, 0.1, 20);


create table emp_copy(
    emp_id number(6),
    emp_name varchar2(20),
    salary number(7, 2)
);

insert into emp_copy(emp_id, emp_name, salary)
select emp_id, emp_name, salary
from emp
where dept_id = 10;


--TODO: �μ��� ������ �޿��� ���� ��� ���̺� ����. 
--      ��ȸ����� insert. ����: �հ�, ���, �ִ�, �ּ�, �л�, ǥ������
create table salary_stat(
    dept_id number(6),
    salary_sum number(15,2),
    salary_avg number(10, 2),
    salary_max number(7,2),
    salary_min number(7,2),
    salary_var number(20,2),
    salary_stddev number(7,2)
);

insert into salary_stat
select dept_id, sum(salary),
        round(avg(salary), 2), max(salary),
        min(salary), round(variance(salary), 2), stddev(salary) 
from emp
group by dept_id
order by dept_id;


rollback;

select * from salary_stat;

/* *********************************************************************
UPDATE : ���̺��� �÷��� ���� ����
UPDATE ���̺��
SET    ������ �÷� = ������ ��  [, ������ �÷� = ������ ��]
[WHERE ��������]

 - UPDATE: ������ ���̺� ����
 - SET: ������ �÷��� ���� ����
 - WHERE: ������ ���� ����. 
************************************************************************ */



-- ���� ID�� 200�� ������ �޿��� 5000���� ���� (��: 4400)
select * from emp where emp_id = 200;

update emp
set salary = 5000;
rollback;

select * from emp;


-- ���� ID�� 200�� ������ �޿��� 10% �λ��� ������ ����. salary * 1.1
select * from emp where emp_id = 200;

update emp
set salary = salary * 1.1
where emp_id = 200;


-- �μ� ID�� 100�� ������ Ŀ�̼� ������ 0.2�� salary�� 3000�� ���� ������, ���_id�� 100 ����.
select * from emp where emp_id = 100;
update emp
set comm_pct = 0.2,
    salary = salary + 3000,
    mgr_id = 100
where emp_id = 100;
commit;

-- TODO: �μ� ID�� 100�� �������� �޿��� 100% �λ�
select * from emp where dept_id = 100;

update emp
set salary = salary * 2
where dept_id = 100;

-- TODO: IT �μ��� �������� �޿��� 3�� �λ�
select * from emp where dept_id = 60;

update emp
set salary = salary * 3
where dept_id in (select dept_id from dept where dept_name = 'IT');
rollback;

-- TODO: EMP ���̺��� ��� �����͸� MGR_ID�� NULL�� HIRE_DATE �� �����Ͻ÷� COMM_PCT�� 0.5�� ����.
update emp
set mgr_id = null, hire_date = sysdate, comm_pct = 0.5;


-- TODO: COMM_PCT �� 0.3�̻��� �������� COMM_PCT�� NULL �� ����.
update emp
set comm_pct = null
where comm_pct >= 0.3;

-- TODO: ��ü ��ձ޿����� ���� �޴� �������� �޿��� 50% �λ�.
update emp
set salary = salary * 1.5
where salary < (select avg(salary) from emp);

select * from emp
where salary < (select avg(salary) from emp);


/* *********************************************************************
DELETE : ���̺��� ���� ����
���� 
 - DELETE FROM ���̺�� [WHERE ��������]
   - WHERE: ������ ���� ����
************************************************************************ */



-- �μ����̺��� �μ�_ID�� 200�� �μ� ����
select * from dept;
delete from dept where dept_id = 200;

-- �μ����̺��� �μ�_ID�� 10�� �μ� ����
--200, 1200, 1300
select * from emp where dept_id =  10;
select * from emp where emp_id in (200, 1200, 1300);
delete from dept where dept_id = 10;
rollback;



-- TODO: �μ� ID�� ���� �������� ����
select * from emp where dept_id is null;

delete from dept where dept_id is null;


-- TODO: ��� ����(emp.job_id)�� 'SA_MAN'�̰� �޿�(emp.salary) �� 12000 �̸��� �������� ����.
delete from emp where job_id = 'SA_MAN' and salary < 12000;


-- TODO: comm_pct �� null�̰� job_id �� IT_PROG�� �������� ����
delete from emp where comm_pct is null and job_id = 'IT_PROG';



-- TODO: job_id�� CLERK�� �� ������ �ϴ� ������ ����
delete from emp where job_id like '%CLERK%';

