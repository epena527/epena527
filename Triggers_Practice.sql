use SAMPLE;

create table orders(
	oid int identity primary key,
	orderamt decimal(8,2),
	orderdate date)

create table orderlog(
	logid int identity primary key,
	oid int,
	orderamt decimal(8,2),
	orderdate date,
	actiondate date,
	actiontaken char(3))

create trigger trg_order
ON Exam.dbo.orders
AFTER INSERT, DELETE
as
begin
	SET NOCOUNT ON;
	INSERT INTO orderlog(oid,orderamt,orderdate,actiondate,actiontaken)
	SELECT
		i.oid,
		i.orderamt,
		i.orderdate,
		getdate(),
		'INS'
	from inserted i
	UNION ALL
	SELECT 
		d.oid,
		d.orderamt,
		d.orderdate,
		getdate(),
		'DEL'
	from deleted d
end;

INSERT INTO orders values(5000.00, '03/22/2022')
INSERT INTO orders values(2000.00, '03/31/2022')
DELETE FROM orders where orderamt = 5000.00

