import sqlite3
from sqlite3 import Error


def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn

def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V1")
    c = _conn.cursor()
    c.execute("drop view if exists V1")
    c.execute("""
              
create view V1 as
select c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, n_name as c_nation, r_name as c_region
from customer join nation on c_nationkey = n_nationkey join region on n_regionkey = r_regionkey;
              
              """)
    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")
    c = _conn.cursor()
    try:
        c.execute("""
                select c_nation as country, count(o_orderkey) as cnt
from orders, V1
where c_custkey = o_custkey and c_region = "EUROPE"
group by c_nation  


                  """)


        output = open('output/1.out', 'w')

        header = "{}|{}"
        output.write((header.format("country", "cnt")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V2")
    c = _conn.cursor()
    c.execute("drop view if exists V2")
    c.execute("""create view V2 as

select o_orderkey, o_custkey, o_orderstatus, o_totalprice, STRFTIME('%Y', o_orderdate) as o_orderyear, o_orderpriority, o_clerk,
o_shippriority, o_comment
from orders""")
    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")
    c = _conn.cursor()
    try:
        c.execute("""

        
select c_name as customer, count(o_orderkey) as cnt
from V1, V2
where c_custkey = o_custkey and c_nation == "EGYPT" and o_orderyear = '1992'
group by c_name

    """)

        
        output = open('output/2.out', 'w')
        header = "{}|{}"
        output.write((header.format("customer", "cnt")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")
    c = _conn.cursor()
    try:
        output = open('output/3.out', 'w')
        c.execute("""

        select c_name as customer, sum(o_totalprice) as total_price
from V1, orders
where c_custkey = o_custkey and c_nation == "ARGENTINA" and STRFTIME('%Y', orders.o_orderdate) == '1996'
group by c_name

        """)
        header = "{}|{}"
        output.write((header.format("customer", "total_price")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V4")
    c = _conn.cursor()
    c.execute("drop view if exists V4")
    c.execute("""

create view V4 as
select s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name as s_nation, r_name as s_region 
from supplier join nation on s_nationkey = n_nationkey join region on n_regionkey = r_regionkey;


        """)
    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")
    c = _conn.cursor()
    try:
        output = open('output/4.out', 'w')
        c.execute("""

       
select s_name as supplier, count(p_partkey) as cnt
from V4, partsupp, part
where ps_suppkey = s_suppkey and p_partkey = ps_partkey and s_nation = "KENYA" and INSTR(p_container, "BOX")
group by s_name;

        """)
        header = "{}|{}"
        output.write((header.format("supplier", "cnt")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")
    c = _conn.cursor()
    try:
        output = open('output/5.out', 'w')
        c.execute("""

       select s_nation as country, count(s_suppkey) as cnt
from V4
where s_nation = "ARGENTINA" or s_nation = "BRAZIL"
group by s_nation;

        """)
        header = "{}|{}"
        output.write((header.format("country", "cnt")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q6(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q6")
    c = _conn.cursor()
    try:
        output = open('output/6.out', 'w')
        c.execute("""

       select s_name as supplier, o_orderpriority as priority, count(DISTINCT l_partkey) as parts
from V4, V2, partsupp, lineitem
where o_orderkey = l_orderkey and l_suppkey = s_suppkey and ps_partkey = l_partkey and ps_suppkey = s_suppkey and s_nation = "INDONESIA"
group by s_name, o_orderpriority;

        """)
        header = "{}|{}|{}"
        output.write((header.format("supplier", "priority", "parts")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1], row[2])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q7(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q7")
    c = _conn.cursor()
    try:
        output = open('output/7.out', 'w')
        c.execute("""

       select c_nation as country, o_orderstatus as status, count(o_orderkey) as orders
from V1, V2
where c_region = "AFRICA" and o_custkey = c_custkey
group by o_orderstatus, c_nation;

        """)
        header = "{}|{}|{}"
        output.write((header.format("country", "status", "orders")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1], row[2])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q8(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q8")
    c = _conn.cursor()
    try:
        output = open('output/8.out', 'w')
        c.execute("""

       select count(DISTINCT(o_clerk)) as clerks
from lineitem, V2, V4
where s_nation = "PERU" and s_suppkey = l_suppkey and l_orderkey = o_orderkey;

        """)
        header = "{}"
        output.write((header.format("clerks")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q9(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q9")
    c = _conn.cursor()
    try:
        output = open('output/9.out', 'w')
        c.execute("""

       select country, cnt
from (select s_nation as country, count (DISTINCT o_orderkey) as cnt
		from lineitem, V2, V4
		where o_orderstatus = "F" and o_orderyear == '1993' and s_region = "AFRICA" and o_orderkey = l_orderkey and l_suppkey = s_suppkey
		group by s_nation)
where cnt > 200
group by country;

        """)
        header = "{}|{}"
        output.write((header.format("country", "cnt")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V10")
    c = _conn.cursor()
    c.execute("drop view if exists V10")
    c.execute("""

        create view V10 as
select p_type, min(l_discount) as min_discount, max(l_discount) as max_discount
from part join lineitem on p_partkey = l_partkey
group by p_type;

        """)
    print("++++++++++++++++++++++++++++++++++")


def Q10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q10")
    c = _conn.cursor()
    try:
        output = open('output/10.out', 'w')
        c.execute("""

       select p_type as part_type, min_discount as min_disc, max_discount as max_disc
from V10
where p_type like '%ECONOMY%' or p_type like '%COPPER%';

        """)
        header = "{}|{}|{}"
        output.write((header.format("part_type", "min_disc", "max_disc")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1], row[2])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View111(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V111")
    c = _conn.cursor()
    c.execute("drop view if exists V111")
    c.execute("""

    create view V111 as
select c_custkey, c_name, c_nationkey, c_acctbal
from customer where c_acctbal < 0;

        """)
    print("++++++++++++++++++++++++++++++++++")


def create_View112(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V112")
    c = _conn.cursor()
    c.execute("drop view if exists V112")
    c.execute("""

       create view V112 as
select s_suppkey, s_name, s_nationkey, s_acctbal
from supplier where s_acctbal > 0;

        """)
    print("++++++++++++++++++++++++++++++++++")


def Q11(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q11")
    c = _conn.cursor()
    try:
        output = open('output/11.out', 'w')
        c.execute("""

       
select count(distinct(o_orderkey)) as order_cnt
from V111, V112, orders, lineitem
where c_custkey = o_custkey and o_orderkey = l_orderkey and l_suppkey = s_suppkey;

        """)
        header = "{}"
        output.write((header.format("order_cnt")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q12(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q12")
    c = _conn.cursor()
    try:
        output = open('output/12.out', 'w')
        c.execute("""

       
select region, max_bal
from (select s_region as region, max(s_acctbal) as max_bal
		from V4
		group by s_region)
where max_bal > 9000;

        """)
        header = "{}|{}"
        output.write((header.format("region", "max_bal")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q13(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q13")
    c = _conn.cursor()
    try:
        output = open('output/13.out', 'w')
        c.execute("""

       select s_region as supp_region, c_region as cust_region, min(o_totalprice) as min_price
from V1 customer1 
join orders on o_custkey = c_custkey
join lineitem on l_orderkey = o_orderkey
join V4 supplier1 on s_suppkey = l_suppkey

group by c_region, s_region;

        """)
        header = "{}|{}|{}"
        output.write((header.format("supp_region", "cust_region", "min_price")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1], row[2])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q14(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q14")
    c = _conn.cursor()
    try:
        output = open('output/14.out', 'w')
        c.execute("""

       
select count(o_orderkey) as items
from lineitem, orders, V1, V4
where c_custkey = o_custkey and o_orderkey = l_orderkey and l_suppkey = s_suppkey and c_nation = "KENYA" and s_region = "ASIA";

        """)
        header = "{}"
        output.write((header.format("items")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q15(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q15")
    c = _conn.cursor()
    try:
        output = open('output/15.out', 'w')
        c.execute("""

       select region, supplier, max(acct_bal) as "acct_bal"
from 	(select s_region as region, s_name as supplier, s_acctbal as acct_bal
		from V4
		group by s_name
		)
group by region;

        """)
        header = "{}|{}|{}"
        output.write((header.format("region", "supplier", "acct_bal")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1], row[2])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        create_View1(conn)
        Q1(conn)

        create_View2(conn)
        Q2(conn)

        Q3(conn)

        create_View4(conn)
        Q4(conn)

        Q5(conn)
        Q6(conn)
        Q7(conn)
        Q8(conn)
        Q9(conn)

        create_View10(conn)
        Q10(conn)

        create_View111(conn)
        create_View112(conn)
        Q11(conn)

        Q12(conn)
        Q13(conn)
        Q14(conn)
        Q15(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
