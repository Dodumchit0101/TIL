
/* ***********************************************************************************
DDL - Database�� ��ü�� ����
- ���� : create
- ���� : alter
- ���� : drop

���̺� ����
- ����
create table ���̺� �̸�(
  �÷� ����
)

�������� ���� 
- �÷� ���� ����
    - �÷� ������ ���� ����
- ���̺� ���� ����
    - �÷� �����ڿ� ���� ����

- �⺻ ���� : constraint ���������̸� ��������Ÿ��
- ���̺� ���� ���� ��ȸ
    - USER_CONSTRAINTS ��ųʸ� �信�� ��ȸ
    
���̺� ����
- ����
DROP TABLE ���̺��̸� [CASCADE CONSTRAINTS]
*********************************************************************************** */
--no number primary key : default �̸� ����
create table parent_tb(
    no number constraint pk_parent_tb primary key,
    name nvarchar2(30) not null, 
    birthday date default sysdate,  --�⺻�� ���� : insert �� ���� ���� �ʾ��� �� insert�� �⺻��  
    email varchar2(100) constraint uk_parent_tb_email unique, --unique ��������: �ߺ���X
    gender char(1) not null constraint ck_parent_tb_gender check(gender in ('M', 'F')) --check key: ���� ���� ����
);

--����: M, F

insert into parent_tb values(1, 'ȫ�浿', '2000/01/01', 'a@a.com', 'M');
insert into parent_tb (no, name, gender) values (2, '�̼���', 'M');
insert into parent_tb values(3, 'ȫ�浿2', null, 'b@b.com', 'M'); --���������� null�� ������ default���� �ƴ� null�� ��
insert into parent_tb values(4, 'ȫ�浿2', null, 'b@b.com', 'M');
insert into parent_tb values(5, '�迵��', null, 'c@c.com', 'm');

select * from parent_tb;

insert into dept values ('10', 'a', 'b');

create table child_tb(
    no number,  --pk
    jumin_num char(14) not null,  --uk
    age number(3) default 0, --10~90(ck)
    parent_no number,  --parent_tb�� �����ϴ� fk
    constraint pk_child_tb primary key (no),
    constraint uk_child_tb_jumin_num unique(jumin_num),
    constraint ch_child_tb_age check(age between 10 and 50),
    constraint fk_child_tb_parent_tb foreign key(parent_no) references parent_tb(no)
);




/* ************************************************************************************
ALTER : ���̺� ����

�÷� ���� ����

- �÷� �߰�
  ALTER TABLE ���̺��̸� ADD (�߰��� �÷����� [, �߰��� �÷�����])
  - �ϳ��� �÷��� �߰��� ��� ( ) �� ��������

- �÷� ����
  ALTER TABLE ���̺��̸� MODIFY (�������÷���  ���漳�� [, �������÷���  ���漳��])
	- �ϳ��� �÷��� ������ ��� ( )�� ���� ����
	- ����/���ڿ� �÷��� ũ�⸦ �ø� �� �ִ�.
		- ũ�⸦ ���� �� �ִ� ��� : ���� ���� ���ų� ��� ���� ���̷��� ũ�⺸�� ���� ���
	- �����Ͱ� ��� NULL�̸� ������Ÿ���� ������ �� �ִ�. (�� CHAR<->VARCHAR2 �� ����.)

- �÷� ����	
  ALTER TABLE ���̺��̸� DROP COLUMN �÷��̸� [CASCADE CONSTRAINTS]
    - CASCADE CONSTRAINTS : �����ϴ� �÷��� Primary Key�� ��� �� �÷��� �����ϴ� �ٸ� ���̺��� Foreign key ������ ��� �����Ѵ�.
	- �ѹ��� �ϳ��� �÷��� ���� ����.
	
  ALTER TABLE ���̺��̸� SET UNUSED (�÷��� [, ..])
  ALTER TABLE ���̺��̸� DROP UNUSED COLUMNS
	- SET UNUSED ������ �÷��� �ٷ� �������� �ʰ� ���� ǥ�ø� �Ѵ�. 
	- ������ �÷��� ����� �� ������ ���� ��ũ���� ����� �ִ�. �׷��� �ӵ��� ������.
	- DROP UNUSED COLUMNS �� SET UNUSED�� �÷��� ��ũ���� �����Ѵ�. 

- �÷� �̸� �ٲٱ�
  ALTER TABLE ���̺��̸� RENAME COLUMN �����̸� TO �ٲ��̸�;

**************************************************************************************  
���� ���� ���� ����
-�������� �߰�
  ALTER TABLE ���̺��� ADD CONSTRAINT �������� ����

- �������� ����
  ALTER TABLE ���̺��� DROP CONSTRAINT ���������̸�
  PRIMARY KEY ����: ALTER TABLE ���̺��� DROP PRIMARY KEY [CASCADE]
	- CASECADE : �����ϴ� Primary Key�� Foreign key ���� �ٸ� ���̺��� Foreign key ������ ��� �����Ѵ�.

- NOT NULL <-> NULL ��ȯ�� �÷� ������ ���� �Ѵ�.
   - ALTER TABLE ���̺��� MODIFY (�÷��� NOT NULL),  - ALTER TABLE ���̺��� MODIFY (�÷��� NULL)  
************************************************************************************ */
--customers ī���ؼ� cust �����
--select ���set�� ���̺��� ����, (not null�� ������ �ٸ� ���������� ī�ǰ� �ȵ�)
create table cust
as 
select * from customers;

select * from cust;

create table cust2
as
select cust_id, cust_name, address from customers;

create table cust3
as
select * from customers
where 1 = 0; --False

select * from cust3;

--�÷� �߰�
alter table cust3 add(age number default 0 not null, point number);
--����
alter table cust3 modify(age number(3));
alter table cust3 modify(cust_email null); --not null -> null
desc cust3;
--�÷��� ����
alter table cust3 rename column cust_email to email; --cust_email => email�� ����
desc cust3;
--�÷� ����
alter table cust3 drop column age;
desc cust3;

alter table cust3 modify (cust_id number(2));

--�������� ����
--�� ���̺��� �������ǵ� ��ȸ
select * from user_constraints;
select * from user_constraints where table_name = 'CUST';
desc cust;

alter table cust add constraint pk_cust primary key(cust_id); --cust���̺��� pk�� �߰�
alter table cust add constraint uk_cust_email unique(cust_email); --uk �߰�
alter table cust add constraint ck_cust_gender check(gender in ('M', 'F')); --ch

--����
alter table cust drop constraint ck_cust_gender;
alter table cust drop constraint pk_cust;
alter table cust drop primary key;
select * from user_constraints where table_name= 'CUST';



--TODO: emp ���̺��� ī���ؼ� emp2�� ����(Ʋ�� ī��)
create table emp2
as
select * from emp where 1 != 1;

select * from emp2;


--TODO: gender �÷��� �߰�: type char(1)
alter table emp2 add (gender char(1));

desc emp2;

--TODO: email �÷� �߰�. type: varchar2(100),  not null  �÷�
alter table emp2 add (email varchar2(100) not null);

desc emp2;

--TODO: jumin_num(�ֹι�ȣ) �÷��� �߰�. type: char(14), null ���. ������ ���� ������ �÷�.
alter table emp2 add(jumin_num char(14) constraint uk_emp2_jumin unique);

desc emp2;
select * from user_constraints where table_name = 'EMP2';

--TODO: emp_id �� primary key �� ����
alter table emp2 add constraint pk_emp2 primary key(emp_id);

select * from user_constraints where table_name = 'EMP2';
  
--TODO: gender �÷��� M, F �����ϵ���  �������� �߰�
alter table emp2 add constraint ck_emp2_gender check(gender in ('M', 'F'));

select * from user_constraints where table_name = 'EMP2';

--TODO: salary �÷��� 0�̻��� ���鸸 ������ �������� �߰�
alter table emp2 add constraint ck_emp2_salary check(salary > 0);

select * from user_constraints where table_name = 'EMP2';

--TODO: email �÷��� null�� ���� �� �ֵ� �ٸ� ��� ���� ���� ������ ���ϵ��� ���� ���� ����
alter table emp2 modify (email null);

select * from user_constraints where table_name = 'EMP2';
desc emp2;

--TODO: emp_name �� ������ Ÿ���� varchar2(100) ���� ��ȯ
alter table emp2 modify (emp_name varchar2(100));

desc emp2;

--TODO: job_id�� not null �÷����� ����
alter table emp2 modify (job_id not null);


--TODO: dept_id�� not null �÷����� ����
alter table emp2 modify (dept_id not null);

desc emp2;

--TODO: job_id  �� null ��� �÷����� ����
alter table emp2 modify (job_id null);


--TODO: dept_id  �� null ��� �÷����� ����
alter table emp2 modify (dept_id null);

desc emp2;

--TODO: ������ ������ emp2_email_uk ���� ������ ����




--TODO: ������ ������ emp2_salary_ck ���� ������ ����
alter table emp2 drop constraint ck_emp2_salary;


--TODO: primary key �������� ����
alter table emp2 drop primary key;

select * from user_constraints where table_name = 'EMP2';

--TODO: gender �÷�����
alter table emp2 drop column gender;


--TODO: email �÷� ����
alter table emp2 drop column email;

desc emp2;

/* **************************************************************************************************************
--����Ŭ ����
������ : SEQUENCE
- �ڵ������ϴ� ���ڸ� �����ϴ� ����Ŭ ��ü
- ���̺� �÷��� �ڵ������ϴ� ������ȣ�� ������ ����Ѵ�.
	- �ϳ��� �������� ���� ���̺��� �����ϸ� �߰��� �� ������ �� �� �ִ�.

���� ����
CREATE SEQUENCE sequence�̸�
	[INCREMENT BY n]	
	[START WITH n]                		  
	[MAXVALUE n | NOMAXVALUE]   
	[MINVALUE n | NOMINVALUE]	
	[CYCLE | NOCYCLE(�⺻)]		
	[CACHE n | NOCACHE]		  

- INCREMENT BY n: ����ġ ����. ������ 1
- START WITH n: ���� �� ����. ������ 0
	- ���۰� ������
	 - ����: MINVALUE ���� ũĿ�� ���� ���̾�� �Ѵ�.
	 - ����: MAXVALUE ���� �۰ų� ���� ���̾�� �Ѵ�.
- MAXVALUE n: �������� ������ �� �ִ� �ִ밪�� ����
- NOMAXVALUE : �������� ������ �� �ִ� �ִ밪�� ���������� ��� 10^27 �� ��. ���������� ��� -1�� �ڵ����� ����. 
- MINVALUE n :�ּ� ������ ���� ����
- NOMINVALUE :�������� �����ϴ� �ּҰ��� ���������� ��� 1, ���������� ��� -(10^26)���� ����
- CYCLE �Ǵ� NOCYCLE : �ִ�/�ּҰ����� ������ ��ȯ�� �� ����. NOCYCLE�� �⺻��(��ȯ�ݺ����� �ʴ´�.)
- CACHE|NOCACHE : ĳ�� ��뿩�� ����.(����Ŭ ������ �������� ������ ���� �̸� ��ȸ�� �޸𸮿� ����) NOCACHE�� �⺻��(CACHE�� ������� �ʴ´�. )


������ �ڵ������� ��ȸ
 - sequence�̸�.nextval  : ���� ����ġ ��ȸ
 - sequence�̸�.currval  : ���� �������� ��ȸ


������ ����
ALTER SEQUENCE ������ �������̸�
	[INCREMENT BY n]	               		  
	[MAXVALUE n | NOMAXVALUE]   
	[MINVALUE n | NOMINVALUE]	
	[CYCLE | NOCYCLE(�⺻)]		
	[CACHE n | NOCACHE]	

������ �����Ǵ� ������ ������ �޴´�. (�׷��� start with ���� ��������� �ƴϴ�.)	  


������ ����
DROP SEQUENCE sequence�̸�
	
************************************************************************************************************** */

-- 1���� 1�� �ڵ������ϴ� ������
create sequence dept_id_seq; --�̸� ����: ������������÷���_seq

--seq�̸�.nextval()
select dept_id_seq.nextval from dual;
select dept_id_seq.currval from dual;

insert into dept values (dept_id_seq.nextval, '���μ�'||dept_id_seq.currval, '����');

select * from dept order by dept_id;

-- 1���� 50���� 10�� �ڵ����� �ϴ� ������
create sequence exl_seq increment by 10
                        maxvalue 50;

select exl_seq.nextval from dual;


-- 100 ���� 150���� 10�� �ڵ������ϴ� ������
create sequence ex2_seq increment by 10
                        start with 100
                        maxvalue 150;

select ex2_seq.nextval from dual;

-- 100 ���� 150���� 20�� �ڵ������ϵ� �ִ밪�� �ٴٸ��� ��ȯ�ϴ� ������
--��ȯ(cycle)�� �� ����: minvalue���� ����
--��ȯ(cycle)�� �� ����: maxvalue���� ����
drop sequence ex3_seq;
create sequence ex3_seq increment by 10
                        start with 100
                        maxvalue 150
                        cache 5
                        cycle;
                        
select ex3_seq.nextval from dual;


-- -1���� -1�� �ڵ� �����ϴ� ������
create sequence ex4_seq increment by -1; --�ڵ�����: start with �⺻���� -1

select ex4_seq.nextval from dual;

-- -1���� -50���� -10�� �ڵ� �����ϴ� ������
drop sequence ex5_seq;
create sequence ex5_seq increment by -10
                        minvalue -50;

select ex5_seq.nextval from dual;

-- 100 ���� -100���� -100�� �ڵ� �����ϴ� ������
create sequence ex6_seq increment by -100
                        start with 100
                        minvalue -100
                        maxvalue 100;
                        --maxvalue: 1(����)  - ����: maxvalue >= startvalue / ����: minvalue <= startvalue


-- 15���� -15���� 1�� �����ϴ� ������ �ۼ�
create sequence ex7_seq increment by -1
                        start with 15
                        minvalue -15
                        maxvalue 15;

select ex7_seq.nextval from dual;

-- -10 ���� 1�� �����ϴ� ������ �ۼ�
create sequence ex8_seq increment by 1
                        start with -10
                        minvalue -10;

select ex8_seq.nextval from dual;

-- Sequence�� �̿��� �� insert







-- TODO: �μ�ID(dept.dept_id)�� ���� �ڵ����� ��Ű�� sequence�� ����. 10 ���� 10�� �����ϴ� sequence
-- ������ ������ sequence�� ����ؼ�  dept_copy�� 5���� ���� insert.
create sequence dept_id2_seq
        start with 10
        increment by 10;

create table dept_copy
as
select * from dept where 1 <> 1;

select * from dept_copy;

insert into dept_copy values(dept_id2_seq.nextval, '��ȹ��', '����');
insert into dept_copy values(dept_id2_seq.nextval, '���ź�', '����');
insert into dept_copy values(dept_id2_seq.nextval, '���ߺ�', '����');



-- TODO: ����ID(emp.emp_id)�� ���� �ڵ����� ��Ű�� sequence�� ����. 10 ���� 1�� �����ϴ� sequence
-- ������ ������ sequence�� ����� emp_copy�� ���� 5�� insert
create sequence emp_id_seq
        start with 10
        increment by 1;
    
insert into emp2 values(emp_id_seq.nextval, 'ȫ�浿', null, null, '2021/01/05', 30000, null, null, null);
insert into emp2 values(emp_id_seq.nextval, '�̼���', null, null, '2021/01/05', 30000, null, null, null);
insert into emp2 values(emp_id_seq.nextval, '�ڹ���', null, null, '2021/01/05', 30000, null, null, null);
desc emp2;

select * from emp2;

