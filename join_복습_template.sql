/*
1. ��ǰ ���̺��� ��ǰ_ID �÷��� _primary key_ �÷����� �� ���� �ٸ� ��� �ĺ��� �� ���ȴ�.
2. ��ǰ ���̺��� ������ �÷��� Not Null(NN) �� ������ ���� _null_ �� ������ ���� ����.
3. �� ���̺��� �ٸ���� �ĺ��� �� ����ϴ� �÷��� _cust_ID_ �̴�. 
4. �� ���̺��� ��ȭ��ȣ �÷��� ������ Ÿ���� _VARCHAR2_ ����_���ڿ�_������ �� _15_����Ʈ ������ �� ������
NULL ���� _���� �� �ִ�_.
5. �� ���̺��� ������ �÷��� ���� 4�� ó�� ������ ���ÿ�.
������ Ÿ��: DATE, ��¥/�ð� ����
6. �ֹ� ���̺��� �� 5�� �÷��� �ִ�. ���� Ÿ���� _3_���̰� ���ڿ� Ÿ���� _1_�� �̰� ��¥ Ÿ���� __���̴�.
7. �� ���̺�� �ֹ����̺��� ���� ���谡 �ִ� ���̺��Դϴ�.
    �θ����̺��� _CUSTOMERS_ �̰� �ڽ� ���̺��� _ORDERS_�̴�.
    �θ����̺��� _CUST_ID_�÷��� �ڽ����̺��� _CUST_ID(FK)_�÷��� �����ϰ� �ִ�.
    �����̺��� ������ �����ʹ� �ֹ����̺��� _0~N_ ��� ���谡 ���� �� �ִ�.
    �ֹ����̺��� ������ �����̺��� _1_��� ���谡 ���� �� �ִ�.
8. �ֹ� ���̺�� �ֹ�_��ǰ ���̺��� ���� ���谡 �ִ� ���̺��Դϴ�.
    �θ� ���̺��� _ORDERS_ �̰� �ڽ� ���̺��� _ORDER_ITEMS_�̴�.
    �θ� ���̺��� _ORDER_ID(PK)_�÷��� �ڽ� ���̺��� _ORDER_ID(FK)_�÷��� �����ϰ� �ִ�.
    �ֹ� ���̺��� ������ �����ʹ� �ֹ�_��ǰ ���̺��� _0~N_ ��� ���谡 ���� �� �ִ�.
    �ֹ�_��ǰ ���̺��� ������ �ֹ� ���̺��� _1_��� ���谡 ���� �� �ִ�.
9. ��ǰ�� �ֹ�_��ǰ�� ���� ���谡 �ִ� ���̺��Դϴ�. 
    �θ� ���̺��� _PRODUCTS_ �̰� �ڽ� ���̺��� _ORDER_ITEMS_�̴�.
    �θ� ���̺��� _PRODUCT_ITEM(PK)_�÷��� �ڽ� ���̺��� _PRODUCT_ID(FK)_�÷��� �����ϰ� �ִ�.
    ��ǰ ���̺��� ������ �����ʹ� �ֹ�_��ǰ ���̺��� _0~N_ ��� ���谡 ���� �� �ִ�.
    �ֹ�_��ǰ ���̺��� ������ ��ǰ ���̺��� _1_��� ���谡 ���� �� �ִ�.
*/

-- TODO: 4���� ���̺� � ������ �ִ��� Ȯ��.
select *
from customers, orders, order_items, products;

-- TODO: �ֹ� ��ȣ�� 1�� �ֹ��� �ֹ��� �̸�, �ּ�, �����ȣ, ��ȭ��ȣ ��ȸ
select c.cust_name, c.address, c.postal_code, c.phone_number
from customers c join orders o on c.cust_id = o.cust_id
where o.order_id = 1;

-- TODO : �ֹ� ��ȣ�� 2�� �ֹ��� �ֹ���, �ֹ�����, �ѱݾ�, �ֹ��� �̸�, �ֹ��� �̸��� �ּ� ��ȸ
select o.order_date, o.order_status, c.cust_name, c.cust_email
from customers c join orders o on c.cust_id = o.cust_id
where o.order_id = 2;


-- TODO : �� ID�� 120�� ���� �̸�, ����, �����ϰ� ���ݱ��� �ֹ��� �ֹ������� �ֹ�_ID, �ֹ���, �ѱݾ��� ��ȸ
select c.cust_name, c.gender, decode(c.gender, 'M', 'MALE', 'FEMALE') gender2, c.join_date, o.order_id, o.order_date, o.order_total
from customers c join orders o on c.cust_id = o.cust_id
where c.cust_id = 120;


-- TODO : �� ID�� 110�� ���� �̸�, �ּ�, ��ȭ��ȣ, �װ� ���ݱ��� �ֹ��� �ֹ������� �ֹ�_ID, �ֹ���, �ֹ����� ��ȸ
select c.cust_name, c.address, c.phone_number, o.order_id, o.order_date, o.order_status 
from customers c left join orders o on c.cust_id = o.cust_id
where c.cust_id = 110;


-- TODO : �� ID�� 120�� ���� ������ ���ݱ��� �ֹ��� �ֹ������� ��� ��ȸ.
select *
--select c.* : customers�� �÷�
--select o.* : orders�� �÷�
from customers c left join orders o on c.cust_id = o.cust_id
where c.cust_id = 120;


-- TODO : '2017/11/13'(�ֹ���¥) �� �ֹ��� �ֹ��� �ֹ����� ��_ID, �̸�, �ֹ�����, �ѱݾ��� ��ȸ
select c.cust_id, c.cust_name, o.order_status, o.order_total
from orders o join customers c on o.cust_id = c.cust_id
where o.order_date = '2017/11/13';


-- TODO : �ֹ��� ID�� xxxx�� �ֹ���ǰ�� ��ǰ�̸�, �ǸŰ���, ��ǰ������ ��ȸ.
select * from order_items;

select p.product_name, to_char(oi.sell_price, 'fmL999,999')"�ǸŰ���", p.price"��ǰ����", p.price - oi.sell_price"���ξ׼�"
from order_items oi left join products p on oi.product_id = p.product_id
where oi.order_item_id = 1;

-- TODO : �ֹ� ID�� 4�� �ֹ��� �ֹ� ���� �̸�, �ּ�, �����ȣ, �ֹ���, �ֹ�����, �ѱݾ�, �ֹ� ��ǰ�̸�, ������, ��ǰ����, �ǸŰ���, ��ǰ������ ��ȸ.
select c.cust_name, c.address, c.postal_code, o.order_date, o.order_status, o.order_total, p.product_name, p.maker,
        p.price, oi.sell_price, oi.quantity
from orders o left join customers c on o.cust_id = c.cust_id
            left join order_items oi on o.order_id = oi.order_id
            left join products p on oi.product_id = p.product_id
where o.order_id = 4;


-- TODO : ��ǰ ID�� 200�� ��ǰ�� 2017�⿡ � �ֹ��Ǿ����� ��ȸ.
select * from products where product_id = 200;

select *
--select count(*) : �� �� �ֹ�?
--select sum(oi.quantity)"�� �ֹ� ����"
from products p left join order_items oi on p.product_id = oi.product_id
                left join orders o on oi.order_id = o.order_id
where p.product_id  = 200
and to_char(o.order_date, 'yyyy') = '2017';


-- TODO : ��ǰ�з��� �� �ֹ����� ��ȸ
select distinct category from products;

select p.category, nvl(sum(quantity), 0)"�ֹ�����"
from products p left join order_items oi on p.product_id = oi.product_id
group by p.category
order by 2;




