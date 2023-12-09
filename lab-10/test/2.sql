create trigger t2 after
update on customer
for each row 
WHEN (new.c_acctbal < 0 and old.c_acctbal > 0)
BEGIN
update customer set c_comment = "Negative balance!!!"
where c_custkey = new.c_custkey;
END;


update customer
set c_acctbal = -100
where c_custkey in (select c_custkey from customer join nation on c_nationkey = n_nationkey join region on n_regionkey = r_regionkey where r_name = "AFRICA");


SELECT count(c_custkey) from customer join nation on c_nationkey = n_nationkey where c_acctbal < 0 and n_name = "EGYPT";