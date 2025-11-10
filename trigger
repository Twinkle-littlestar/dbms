//trigger

mysql> use practical;
Database changed
mysql> create table lib_audit(bid int, bname varchar(20), qty int);
Query OK, 0 rows affected (0.07 sec)

mysql> create table lib_book(bid int, bname varchar(20), qty int);
Query OK, 0 rows affected (0.03 sec)

mysql> insert into lib_book values(1,'dbms',70);
Query OK, 1 row affected (0.01 sec)

mysql> insert into lib_book values(2,'spos',40);
Query OK, 1 row affected (0.00 sec)

mysql> insert into lib_book values(3,'spm',10);
Query OK, 1 row affected (0.00 sec)

mysql> insert into lib book values(4,'cns',60);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'book values(4,'cns',60)' at line 1
mysql> insert into lib_book values(4,'cns',60);
Query OK, 1 row affected (0.00 sec)

mysql> insert into lib_book values(5,'toc',20);
Query OK, 1 row affected (0.00 sec)

mysql> select*from lib_book;
+------+-------+------+
| bid  | bname | qty  |
+------+-------+------+
|    1 | dbms  |   70 |
|    2 | spos  |   40 |
|    3 | spm   |   10 |
|    4 | cns   |   60 |
|    5 | toc   |   20 |
+------+-------+------+
5 rows in set (0.00 sec)

mysql> select*from lib_audit;
Empty set (0.00 sec)
mysql> DELIMITER //
mysql>
mysql> CREATE TRIGGER make_audit1
    -> AFTER DELETE ON lib_book
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO lib_audit (bid, bname, qty)
    ->     VALUES (OLD.bid, OLD.bname, OLD.qty);
    -> END;
    -> //
Query OK, 0 rows affected (0.02 sec)

mysql>
mysql> DELIMITER ;
mysql> select*from lib_book;
+------+-------+------+
| bid  | bname | qty  |
+------+-------+------+
|    1 | dbms  |   70 |
|    2 | spos  |   40 |
|    3 | spm   |   10 |
|    4 | cns   |   60 |
|    5 | toc   |   20 |
+------+-------+------+
5 rows in set (0.00 sec)

mysql> select*from lib_audit;
Empty set (0.00 sec)

mysql> delete from lib_book where bid=4;
Query OK, 1 row affected (0.01 sec)

mysql> select*from lib_book;
+------+-------+------+
| bid  | bname | qty  |
+------+-------+------+
|    1 | dbms  |   70 |
|    2 | spos  |   40 |
|    3 | spm   |   10 |
|    5 | toc   |   20 |
+------+-------+------+
4 rows in set (0.00 sec)

mysql> select*from lib_audit;
+------+-------+------+
| bid  | bname | qty  |
+------+-------+------+
|    4 | cns   |   60 |
+------+-------+------+
1 row in set (0.00 sec)

mysql> DELIMITER //
mysql>
mysql> CREATE TRIGGER make_audit2
    -> AFTER UPDATE ON lib_book
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO lib_audit (bid, bname, qty)
    ->     VALUES (OLD.bid, OLD.bname, OLD.qty);
    -> END;
    -> //
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> DELIMITER ;
mysql> update lib_book set qty=qty+10 where bid=5;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select*from lib_book;
+------+-------+------+
| bid  | bname | qty  |
+------+-------+------+
|    1 | dbms  |   70 |
|    2 | spos  |   40 |
|    3 | spm   |   10 |
|    5 | toc   |   30 |
+------+-------+------+
4 rows in set (0.00 sec)

mysql> select*from lib_audit
    -> ;
+------+-------+------+
| bid  | bname | qty  |
+------+-------+------+
|    4 | cns   |   60 |
|    5 | toc   |   20 |
+------+-------+------+
2 rows in set (0.00 sec)

mysql>
