create trigger t4_1 after
insert on lineitem
for each row 
BEGIN
update orders set o_orderpriority = "2-HIGH"
where old.l_orderkey = o_orderkey;
END;

create trigger t4_2 after
delete on lineitem
for each row 
BEGIN
update orders set o_orderpriority = "2-HIGH"
where old.l_orderkey = o_orderkey;
END;

delete from lineitem where l_orderkey in (select o_orderkey from orders where o_orderdate like '1995-12-%');

select count(o_orderkey) from orders where o_orderdate >= '1995-09-01' and o_orderdate <= '1995-12-31' and o_orderpriority = "2-HIGH";