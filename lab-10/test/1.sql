create trigger t1 after
insert on orders
for each row 
BEGIN
update orders set o_orderdate = '2023-12-01'
where o_orderdate LIKE '1995-12-%' and o_orderkey = new.o_orderkey;
END;


INSERT into orders(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment)
SELECT (o_orderkey+60000) as o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment
FROM orders
WHERE o_orderdate LIKE '1995-12%';


SELECT COUNT(*) as orders_cnt
FROM orders
WHERE o_orderdate LIKE '2023-%';