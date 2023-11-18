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


def createTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create table")
    _conn.execute("""  CREATE TABLE warehouse ( w_warehousekey decimal(9,0) not null,
                        w_name char(100) not null,
                        w_capacity decimal(6,0) not null,
                        w_suppkey decimal(9,0) not null,
                        w_nationkey decimal(2,0) not null
    );""")
    print("++++++++++++++++++++++++++++++++++")


def dropTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Drop tables")
    _conn.execute("""  DROP TABLE IF EXISTS warehouse;""")
    print("++++++++++++++++++++++++++++++++++")


def populateTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Populate table")
    locationname = """select tb2.s_name, tb2.n_name as name, tb2.l, tb2.s
                from
                (
                    select tb1.s_name, tb1.c_nationkey,tb1.l,tb1.n_name, (ROW_NUMBER() over (partition by tb1.s_name)) as s
                    from (
                    Select s_name, c_nationkey,n_name, sum(l_quantity) as l
                    From supplier
                    join lineitem on s_suppkey = l_suppkey
                    join orders on l_orderkey = o_orderkey
                    join customer on o_custkey = c_custkey
                    join nation on n_nationkey = c_nationkey
                    group by s_name, c_nationkey
                    order by sum(l_quantity) desc
                    ) as tb1
                ) as tb2
                where tb2.s <= 3
                """
        
    LocationKeydata  = """ select tb2.c as c, ROW_NUMBER() over () as a
                from
                (
                    select tb1.s_name, tb1.c_nationkey as c,tb1.l,tb1.n_name, 
                    (ROW_NUMBER() over (partition by tb1.s_name)) as s

                    from (
                    Select s_name, c_nationkey,n_name, sum(l_quantity) as l
                    From supplier
                    join lineitem on s_suppkey = l_suppkey
                    join orders on l_orderkey = o_orderkey
                    join customer on o_custkey = c_custkey
                    join nation on n_nationkey = c_nationkey
                    group by s_name, c_nationkey
                    order by s_name, sum(l_quantity) desc
                    ) as tb1
                ) as tb2
                where tb2.s <= 3
                """
    cap = """select max(p)*3
            from
            (
                select sup_name, name, ROW_NUMBER() over () as a, p
                from
                (
                    select tb1.s_name as sup_name, tb1.c_nationkey as c,tb1.l, tb1.n_name as name,
                    (ROW_NUMBER() over (partition by tb1.s_name)) as s, p

                    from (
                    Select s_name, c_nationkey, n_name, sum(l_quantity) as l, sum(p_size) as p
                    From supplier
                    join lineitem on s_suppkey = l_suppkey
                    join orders on l_orderkey = o_orderkey
                    join customer on o_custkey = c_custkey
                    join nation on n_nationkey = c_nationkey
                    join part on p_partkey = l_partkey
                    group by s_name, c_nationkey
                    order by s_name, sum(l_quantity) desc
                    ) as tb1
                ) as tb2
                where tb2.s <= 3

            ) as tb3

            group by sup_name

            """

    text1 = _conn.execute(locationname,1)
    text2 = _conn.execute(LocationKeydata,1)
    text3 = _conn.execute(cap,1)

    sql = "INSERT INTO warehouse VALUES(?, ?, ?, ?, ?)"
    arg = [1,text1,text3,1,text2]
    _conn.execute(sql,arg)
    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")
    c = _conn.cursor()
    try:
        output = open('output/1.out', 'w')
        c.execute("SELECT * from warehouse order by w_warehousekey;")
        
        header = "{:>10} {:<40} {:>10} {:>10} {:>10}"
        output.write((header.format("wId", "wName", "wCap", "sId", "nId")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1],row[2],row[3],row[4])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")
    c = _conn.cursor()
    try:
        c.execute("""

select n_name, count(w_warehousekey), sum(w_capacity)
from warehouse join nation on w_nationkey = n_nationkey
group by n_nationkey
order by count(w_warehousekey) desc, sum(w_capacity) desc, n_name;


""")    
        


        output = open('output/2.out', 'w')

        header = "{:<40} {:>10} {:>10}"
        output.write((header.format("nation", "numW", "totCap")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1], row[2])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")
    c = _conn.cursor()
    try:
        input = open("input/3.in", "r")
        nation = input.readline().strip()
        input.close()

        c.execute("""

select s_name, n_name, w_name
from supplier join warehouse on s_suppkey = w_suppkey
               join nation on n_nationkey = s_nationkey
where n_name = ?
group by s_name;


""", [nation])
        
        output = open('output/3.out', 'w')

        header = "{:<20} {:<20} {:<40}"
        output.write((header.format("supplier", "nation", "warehouse")) + '\n')

        
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1], row[2])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")
    c = _conn.cursor()
    try:
        input = open("input/4.in", "r")
        region = input.readline().strip()
        cap = input.readline().strip()
        input.close()


        c.execute("""

select w_name, w_capacity
                   from warehouse join nation on w_nationkey = n_nationkey
                   join region on n_regionkey = r_regionkey
                   where r_name = ? and w_capacity > ?;


""", [region, cap])
        output = open('output/4.out', 'w')

        header = "{:<40} {:>10}"
        output.write((header.format("warehouse", "capacity")) + '\n')
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
        input = open("input/5.in", "r")
        nation = input.readline().strip()
        input.close()

        c.execute("""

select r_name, sum(w_capacity) from
                   warehouse join supplier on w_suppkey = s_suppkey
                   join nation on s_nationkey = n_nationkey
                   join region on n_regionkey = r_regionkey
                   
                   where n_name = ?

group by r_regionkey
order by r_name;

""", [nation])
        
        output = open('output/5.out', 'w')

        header = "{:<20} {:>20}"
        output.write((header.format("region", "capacity")) + '\n')
        rows = c.fetchall()
        for row in rows:
            output.write((header.format(row[0], row[1])) + '\n')
        output.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        dropTable(conn)
        createTable(conn)
        populateTable(conn)

        Q1(conn)
        Q2(conn)
        Q3(conn)
        Q4(conn)
        Q5(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
