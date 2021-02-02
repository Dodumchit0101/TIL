/* **************************************************************************
����(Aggregation) �Լ��� GROUP BY, HAVING
************************************************************************** */

/* ************************************************************
�����Լ�, �׷��Լ�, ������ �Լ�
- �μ�(argument)�� �÷�.
  - sum(): ��ü�հ�
  - avg(): ���
  - min(): �ּҰ�
  - max(): �ִ밪
  - stddev(): ǥ������
  - variance(): �л�
  - count(): ����
        - �μ�: 
            - �÷���: null�� ������ ����
            -  *: �� ���(null�� ����)

- count(*) �� �����ϰ� ��� �����Լ��� null�� ���� ����Ѵ�.
- sum, avg, stddev, variance: number Ÿ�Կ��� ��밡��.
- min, max, count :  ��� Ÿ�Կ� �� ��밡��.
************************************************************* */

-- EMP ���̺��� �޿�(salary)�� ���հ�, ���, �ּҰ�, �ִ밪, ǥ������, �л�, ���������� ��ȸ 


-- EMP ���̺��� ���� �ֱ� �Ի���(hire_date)�� ���� ������ �Ի����� ��ȸ



-- EMP ���̺��� �μ�(dept_name) �� ������ ��ȸ



-- emp ���̺��� job ������ ���� ��ȸ
select count(distinct job)
from emp;


--TODO:  Ŀ�̼� ����(comm_pct)�� �ִ� ������ ���� ��ȸ
select count(comm_pct)
from emp;

select count(*)
from emp
where comm_pct is not null;

--TODO: Ŀ�̼� ����(comm_pct)�� ���� ������ ���� ��ȸ
select count(*)
from emp
where comm_pct is null;

select count(*) - count(comm_pct)
from emp;


--TODO: ���� ū Ŀ�̼Ǻ���(comm_pct)�� �� ���� ���� Ŀ�̼Ǻ����� ��ȸ
select  max(comm_pct),
        min(comm_pct)
from emp;


--TODO:  Ŀ�̼� ����(comm_pct)�� ����� ��ȸ. 
--�Ҽ��� ���� 2�ڸ����� ���
select  round(avg(comm_pct), 2),  --comm_pct�� �ִ� �����鸸 ����� comm_pct ���
        round(avg(nvl(comm_pct, 0)), 3) --comm_[ct�� ���� ��� 0���� ġȯ�� �� ��� ���: ��ü ���� ���
from emp;


--TODO: ���� �̸�(emp_name) �� ���������� �����Ҷ� ���� ���߿� ��ġ�� �̸��� ��ȸ.
select max(emp_name), min(emp_name)
from emp;


--TODO: �޿�(salary)���� �ְ� �޿��װ� ���� �޿����� ������ ���
select max(salary), min(salary), max(salary)-min(salary)
from emp;


--TODO: ���� �� �̸�(emp_name)�� ����� ���� ��ȸ.
select max(length(emp_name))
from emp;

select emp_name
from emp
where length(emp_name) = (select max(length(emp_name)) from emp);
--where length(emp_name) = max(length(emp_name));  --where������ �����Լ� ��� �Ұ�




--TODO: EMP ���̺��� �μ�(dept_name)�� �������� �ִ��� ��ȸ. 
-- ���������� ����
select  count(distinct dept_name),  --null �����ϰ� ����
        count(distinct nvl(dept_name, 'a'))
from emp;



/* *****************************************************
group by ��
- Ư�� �÷�(��)�� ������ ���� ������ �� ������ �����÷��� �����ϴ� ����.
	- ��) ������ �޿����. �μ�-������ �޿� �հ�. ���� �������
- ����: group by �÷��� [, �÷���]
	- �÷�: �з���(������, �����) - �μ��� �޿� ���, ���� �޿� �հ�
	- select�� where �� ������ ����Ѵ�.
	- select ������ group by ���� ������ �÷��鸸 �����Լ��� ���� �� �� �ִ�
*******************************************************/

-- ����(job)�� �޿��� ���հ�, ���, �ּҰ�, �ִ밪, ǥ������, �л�, �������� ��ȸ


-- �Ի翬�� �� �������� �޿� ���.


-- �μ���(dept_name) �� 'Sales'�̰ų� 'Purchasing' �� �������� ������ (job) �������� ��ȸ



-- �μ�(dept_name), ����(job) �� �ִ� ��ձ޿�(salary)�� ��ȸ.



-- �޿�(salary) ������ �������� ���. �޿� ������ 10000 �̸�,  10000�̻� �� ����.




--TODO: �μ���(dept_name) �������� ��ȸ
select dept_name, count(*)
from emp
group by dept_name
order by 2 desc;


--TODO: ������(job) �������� ��ȸ. �������� ���� �ͺ��� ����.
select job, count(*)
from emp
group by job
order by 2 desc;


--TODO: �μ���(dept_name), ����(job)�� ������, �ְ�޿�(salary)�� ��ȸ. �μ��̸����� �������� ����.
select dept_name, job, count(*)
from emp
group by dept_name, job
order by 1;


--TODO: EMP ���̺��� �Ի翬����(hire_date) �� �޿�(salary)�� �հ��� ��ȸ. 
--(�޿� �հ�� �ڸ������� , �� �����ÿ�. ex: 2,000,000)
select  to_char(hire_date, 'yyyy') �Ի�⵵,
        to_char(sum(salary), 'fm9,999,999') �޿��հ� 
from emp
group by to_char(hire_date, 'yyyy');


--TODO: ����(job)�� �Ի�⵵(hire_date)�� ��� �޿�(salary)�� ��ȸ
select  job,
        extract(year from hire_date) "�Ի�⵵",
        round(avg(salary),2) "��ձ޿�"
from emp
group by job, extract(year from hire_date) "�Ի�⵵" 
order by 1;

--TODO: �μ���(dept_name) ������ ��ȸ�ϴµ� �μ���(dept_name)�� null�� ���� �����ϰ� ��ȸ.
select  dept_name,
        count(*)
from emp
where dept_name is not null
group by dept_name;

--TODO �޿� ������ �������� ���. �޿� ������ 5000 �̸�, 5000�̻� 10000 �̸�, 10000�̻� 20000�̸�, 20000�̻�. 
select count(*)
from emp
group by case   when salary < 5000 then '1���'
                when salary between 5000 and 9999.99 then '2���'
                when salary between 10000 and 19999.99 then '3���'
                else '4���' end
order by 1;

/* **************************************************************
having ��
- �������� ���� �� ���� ����
- group by ���� order by ���� �´�.
- ����
    having ��������  --�����ڴ� where���� �����ڸ� ����Ѵ�. �ǿ����ڴ� �����Լ�(�� ���)
************************************************************** */
-- �������� 10 �̻��� �μ��� �μ���(dept_name)�� �������� ��ȸ
select dept_name,
        count(*) "������"
from emp
group by dept_name
having count(*) >= 10
order by 2 desc; 



--TODO: 15�� �̻��� �Ի��� �⵵�� (�� �ؿ�) �Ի��� �������� ��ȸ.
select to_char(hire_date, 'yyyy')"�Ի�⵵", count(*)"������"
from emp
group by to_char(hire_date, 'yyyy')
having count(*) >= 15;



--TODO: �� ����(job)�� ����ϴ� ������ ���� 10�� �̻��� ����(job)��� ��� �������� ��ȸ
select job, count(*) 
from emp
group by job
having count(*) >= 10;



--TODO: ��� �޿���(salary) $5000�̻��� �μ��� �̸�(dept_name)�� ��� �޿�(salary), �������� ��ȸ
select dept_name, avg(salary), count(*)
from emp
group by dept_name
having avg(salary) >= 5000;



--TODO: ��ձ޿��� $5,000 �̻��̰� �ѱ޿��� $50,000 �̻��� �μ��� �μ���(dept_name), ��ձ޿��� �ѱ޿��� ��ȸ
select dept_name, round(avg(salary), 2), sum(salary)
from emp
group by dept_name
having avg(salary) >= 5000 and sum(salary) >= 50000;



--TODO ������ 2�� �̻��� �μ����� �̸��� �޿��� ǥ�������� ��ȸ
select dept_name, stddev(salary) "�޿�ǥ������"
from emp
group by dept_name
having count(*) >= 2;



/* **************************************************************
- rollup : group by�� Ȯ��.
  - �ΰ� �̻��� �÷��� group by�� ���� ��� ��������(�߰����質 ������)�� �κ� ���迡 �߰��ؼ� ��ȸ�Ѵ�.
  - ���� : group by rollup(�÷��� [,�÷���,..])



- grouping(), grouping_id()
  - rollup �̿��� ����� �÷��� �� ���� ���迡 �����ߴ��� ���θ� ��ȯ�ϴ� �Լ�.
  - case/decode�� �̿��� ���̺��� �ٿ� �������� ���� �� �ִ�.
  - ��ȯ��
	- 0 : ������ ���
	- 1 : ���� ���� ���.
 

- grouping() �Լ� 
 - ����: grouping(groupby�÷�)
 - select ���� ���Ǹ� rollup�̳� cube�� �Բ� ����ؾ� �Ѵ�.
 - group by�� �÷��� �����Լ��� ���迡 �����ߴ��� ���θ� ��ȯ
	- ��ȯ�� 0 : ������(�κ������Լ� ���), ��ȯ�� 1: ���� ����(���������� ���)
 - ���� �������� �κ������� ��������� �˷��ִ� �� �� �ִ�. 



- grouping_id
  - ����: grouping_id(groupby �÷�, ..)
  - ������ �÷��� ���迡 ���Ǿ����� ���� 2����(0: ���� ����, 1: ������)�� ��ȯ �ѵ� 10������ ��ȯ�ؼ� ��ȯ�Ѵ�.
 
************************************************************** */

-- EMP ���̺��� ����(job) �� �޿�(salary)�� ��հ� ����� �Ѱ赵 ���̳������� ��ȸ.
select dept_name, max(salary), min(salary)
from emp
group by rollup(dept_name);

-- EMP ���̺��� ����(JOB) �� �޿�(salary)�� ��հ� ����� �Ѱ赵 ���̳������� ��ȸ.
-- ���� �÷���  �Ұ質 �Ѱ��̸� '�����'��  �Ϲ� �����̸� ����(job)�� ���




-- EMP ���̺��� �μ�(dept_name), ����(job) �� salary�� �հ�� �������� �Ұ�� �Ѱ谡 �������� ��ȸ




--# �Ѱ�/�Ұ� ���� ��� :  �Ѱ�� '�Ѱ�', �߰������ '��' �� ���
--TODO: �μ���(dept_name) �� �ִ� salary�� �ּ� salary�� ��ȸ
select nvl(decode(grouping_id(dept_name), 0, dept_name, 1, '�Ѱ�'), '�̹�ġ') dept_name,
            max(salary), min(salary)
from emp
group by rollup(dept_name);



--TODO: ���_id(mgr_id) �� ������ ���� �Ѱ踦 ��ȸ�Ͻÿ�.
select decode(grouping_id(mgr_id), 1, "�Ѱ�", mgr_id)"���ID", count(*)"������" -- decode�� ��ȯ������ ���ڿ��� �ٸ� Ÿ���� ����� ���
from emp
group by rollup(mgr_id);

       

--TODO: �Ի翬��(hire_date�� year)�� �������� ���� ���� �հ� �׸��� �Ѱ谡 ���� ��µǵ��� ��ȸ.
select decode(grouping_id(to_char(hire_date, 'yyyy')), 1, '�Ѱ�',to_char(hire_date, 'yyyy'))"�Ի�⵵",
count(*)"������", sum(salary)"�޿��հ�"
from emp
group by rollup(to_char(hire_date, 'yyyy'));



--TODO: �μ���(dept_name), �Ի�⵵�� ��� �޿�(salary) ��ȸ. �μ��� ����� �����谡 ���� �������� ��ȸ
select decode(grouping_id(dept_name, to_char(hire_date, 'yyyy')),0, dept_name||'-'||to_char(hire_date, 'yyyy'),
                                                                1, dept_name||'�Ұ�',
                                                                '�Ѱ�') "Label",
        to_char(hire_date, 'yyyy'), round(avg(salary), 2)"��ձ޿�"
from emp
group by rollup(dept_name, to_char(hire_date, 'yyyy'));


