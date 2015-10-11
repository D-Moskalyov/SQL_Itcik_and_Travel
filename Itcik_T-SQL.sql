--======================================
--2.0

select orderid, orderdate, custid, empid
from Sales.Orders
where orderdate < '20070701' and orderdate >='20070601'

--======================================

select orderid, orderdate, custid, empid
from Sales.Orders
where month(dateadd(day, 1, orderdate)) != month(orderdate)

--======================================

select empid, firstname, lastname
from HR.Employees
where lastname like '%a%a%'

--======================================

select orderid, sum(unitprice * qty) as totalvale
from Sales.OrderDetails
group by orderid
having sum(unitprice * qty) > 10000
order by totalvale desc

--======================================

select distinct top(3) shipcountry, 
(sum(freight) over(partition by shipcountry))/(count(freight) over(partition by shipcountry)) as freightByCount
from Sales.Orders
where orderdate >='20070101' and orderdate < '20080101'
order by freightByCount desc

--======================================

select custid, orderdate, orderid,
row_number() over(partition by custid order by custid, orderdate) as rownum
from Sales.Orders

--======================================

select empid, firstname, lastname, titleofcourtesy,
case titleofcourtesy
when 'Ms.' then 'Female'
when 'Mrs.' then 'Female'
when 'Mr.' then 'Male'
when 'Dr.' then 'Unknown'
end as gender
from HR.Employees

--======================================

select custid, region
from Sales.Customers
order by
case when region is null then 1 else 0 end, region

--======================================
--3.0

select empid, firstname, lastname, n
from HR.Employees
inner join Nums
on n < 6

select empid, firstname, lastname, n
from HR.Employees
cross join Nums
where n < 6

--======================================

select empid, dateadd(day, n - 1, '20090612') as date
from HR.Employees
inner join Nums
on n < datediff(day, '20090612', '20090617') + 1
order by empid, date

--======================================

select c.custid, c.country, 
count(distinct o.orderid), 
sum(oD.qty * oD.unitprice)
from Sales.Customers as c
join Sales.Orders as o
on c.custid = o.custid
join Sales.OrderDetails as oD
on o.orderid = oD.orderid
where c.country = 'USA'
group by c.custid, c.country
order by c.custid

--======================================

select c.custid, companyname, orderid, orderdate
from Sales.Customers as c
left join Sales.Orders as o
on c.custid = o.custid

--======================================

select c.custid, companyname
from Sales.Customers as c
left join Sales.Orders as o
on c.custid = o.custid
where o.orderid is null

--======================================

select c.custid, companyname, orderid, orderdate
from Sales.Customers as c
join Sales.Orders as o
on c.custid = o.custid and o.orderdate = '20070212'

--======================================

select c.custid, c.companyname, o.orderid, o.orderdate
from Sales.Customers as c
left join Sales.Orders as o
on o.custid = c.custid and o.orderdate = '20070212'

--======================================

select c.custid, c.companyname, 
case
when o.orderid is null then 'No'
else 'Yes'
end
as HasOrderOn20070212
from Sales.Customers as c
left join Sales.Orders as o
on o.custid = c.custid and o.orderdate = '20070212'

--======================================
--4.0

select orderid, orderdate, custid, empid 
from Sales.Orders as o1
where o1.orderdate = 
(
select max(o2.orderdate)
from Sales.Orders as o2
)

--======================================

select custid, orderid, orderdate, empid 
from Sales.Orders as o1
where o1.custid in
(
select top (1) with ties custid
from Sales.Orders as o2
group by custid
order by count(orderid) desc
)

--======================================

select empid, firstname, lastname
from HR.Employees as e
where not exists
(
select *
from Sales.Orders as o
where o.empid = e.empid and o.orderdate > '20080501'
)

--======================================

select distinct country
from Sales.Customers
where country not in
(
select  country
from HR.Employees
)

--======================================

select o1.custid, orderid, orderdate, empid
from Sales.Orders as o1
where o1.orderdate = 
(
select max(o2.orderdate)
from Sales.Orders as o2
where o1.custid = o2.custid
)
order by custid

--======================================

select custid, companyname
from Sales.Customers as c
where exists 
(		
select *
from Sales.Orders as o1
where o1.custid = c.custid
and o1.orderdate >= '20070101' and o1.orderdate <= '20071231'
)
and not exists
(
select *
from Sales.Orders as o2
where o2.custid = c.custid
and o2.orderdate >= '20080101' and o2.orderdate <= '20081231'
)

--======================================

select custid, companyname
from Sales.Customers as c
where exists
(
select *
from Sales.Orders as o
join Sales.OrderDetails as oD
on o.orderid = oD.orderid and oD.productid = 12
where o.custid = c.custid
)

--======================================

select custid, ordermonth, qty,
(
select sum(cO2.qty)
from Sales.CustOrders as cO2
where cO1.custid = cO2.custid
and cO1.ordermonth >= cO2.ordermonth
group by cO2.custid
)
from Sales.CustOrders as cO1
order by custid

select * from Sales.CustOrders
order by custid

--======================================
--5.0

select empid, max(orderdate) as maxorderdate
from Sales.Orders
group by empid

--======================================

select o.empid, o.orderdate, o.orderid, o.custid
from
(select max(orderdate) as maxorderdate, empid as em
from Sales.Orders
group by empid) as D
join Sales.Orders as o
on D.maxorderdate = o.orderdate
and D.em = o.empid

--======================================

select orderid, orderdate, custid, empid,
row_number() over(order by orderdate, orderid) as rownum
from Sales.Orders

--======================================

with OrdersRN as
(
select orderid, orderdate, custid, empid,
row_number() over(order by orderdate, orderid) as rownum
from Sales.Orders
)
select orderid, orderdate, custid, empid, rownum
from OrdersRN
where rownum between 11 and 20

--======================================

with EmpsCTE as
(
select empid, mgrid, firstname, lastname
from HR.Employees
where empid = 9

union all

select c.empid, c.mgrid, c.firstname, c.lastname
from EmpsCTE as p
join HR.Employees as c
on c.empid = p.mgrid
)
select empid, mgrid, firstname, lastname
from EmpsCTE

--======================================

if object_id('Sales.VEmpOrders') is not null
drop view Sales.VEmpOrders
go

create view Sales.VEmpOrders
as

select empid, year(orderdate) as orderyear, sum(qty) as qty
from Sales.Orders as o
join Sales.OrderDetails as oD
on o.orderid = oD.orderid
group by empid, year(orderdate)
go

select * from Sales.VEmpOrders
order by empid, orderyear

--======================================

select empid, orderyear, qty,
(
select sum(v2.qty) as runqty
from Sales.VEmpOrders as v2
where v1.orderyear >= v2.orderyear
and v1.empid = v2.empid
group by v2.empid
)
from Sales.VEmpOrders as v1
order by empid, orderyear

--======================================

if object_id('Production.fn_TopProducts') is not null
drop function Production.fn_TopProducts
go
create function Production.fn_TopProducts
(@supid as int, @n as int)
returns table
as
return
select top (@n) productid, productname, unitprice
from Production.Products
where supplierid = @supid
order by unitprice desc
go 
select * from Production.fn_TopProducts(5, 2)

--======================================

select p.supplierid, p.companyname, a.productid, a.productname, a.unitprice
from Production.Suppliers as p
cross apply
Production.fn_TopProducts(p.supplierid, 2) as a
order by p.supplierid

--======================================
--6.0

select 1 as n
union all select 2
union all select 3
union all select 4
union all select 5
union all select 6
union all select 7
union all select 8
union all select 9
union all select 10

--======================================

select custid, empid
from Sales.Orders
where orderdate between '20080301' and '20080331'  
except
select custid, empid
from from Sales.Orders
where orderdate between '20080201' and '20080229'

--======================================

select custid, empid
from Sales.Orders
where orderdate between '20080301' and '20080331'  
intersect
select custid, empid
from from Sales.Orders
where orderdate between '20080201' and '20080229'

--======================================

select custid, empid
from Sales.Orders
where orderdate between '20080301' and '20080331'  
intersect
select custid, empid
from from Sales.Orders
where orderdate between '20080201' and '20080229'
except
select custid, empid
from from Sales.Orders
where orderdate between '20070101' and '20071231'

--======================================

with union_all
as
(
select country, region, city, 1 as n
from HR.Employees
union all
select country, region, city, 2 as n
from Production.Suppliers
)

select country, region, city
from union_all
order by n, country, region, city

--======================================
--7.0
use tempdb
if OBJECT_ID('dbo.Orders', 'U') is not null drop table dbo.Orders
create table dbo.Orders
(
orderid int not null,
orderdate date not null,
empid int not null,
custid varchar(5) not null,
qty int not null,
constraint PK_Orders primary key(orderid)
);

insert into dbo.Orders(orderid, orderdate, empid, custid, qty)
values
(30001, '20070802', 3, 'A', 10),
(10001, '20071224', 2, 'A', 12),
(10005, '20071224', 1, 'B', 20),
(40001, '20080109', 2, 'A', 40),
(10006, '20080118', 1, 'C', 14),
(20001, '20080212', 2, 'B', 12),
(40005, '20090212', 3, 'A', 10),
(20002, '20090216', 1, 'C', 20),
(30003, '20090418', 2, 'B', 15),
(30004, '20070418', 3, 'C', 22),
(30007, '20090907', 3, 'D', 30)

select * from dbo.Orders

select empid,
count(case when orderyear = 2007 then orderyear end) as cnt2007,
count(case when orderyear = 2008 then orderyear end) as cnt2008,
count(case when orderyear = 2009 then orderyear end) as cnt2009
from
(select empid, year(orderdate) as orderyear
from dbo.Orders) as d
group by empid

select empid, [2007] as cnt2007, [2008] as cnt2008, [2009] as cnt2009
from
(select empid, year(orderdate) as orderyear
from dbo.Orders) as d
pivot(count(orderyear) for orderyear in([2007], [2008], [2009])) as p

--======================================

if OBJECT_ID('dbo.EmpYearOrders', 'U') is not null drop table dbo.EmpYearOrders;

select empid, [2007] as cnt2007, [2008] as cnt2008, [2009] as cnt2009
into dbo.EmpYearOrders
from
(select empid, year(orderdate) as orderyear
from dbo.Orders) as d
pivot(count(orderyear) for orderyear in([2007], [2008], [2009])) as p

select * from dbo.EmpYearOrders

select *
from
(select empid, orderyear,
case orderyear
when 2007 then cnt2007
when 2008 then cnt2008
when 2009 then cnt2009
end as cnt
from dbo.EmpYearOrders
cross join
(select 2007 as orderyear
union all select 2008
union all select 2009) as years)
as d
where cnt <> 0

select empid, cast(right(orderyaer, 4) as int) as orderyaer, cnt
from dbo.EmpYearOrders
unpivot(cnt for orderyaer in (cnt2007, cnt2008,cnt2009)) as u
where cnt <> 0

--======================================

select 
grouping_id(empid, custid, year(orderdate)) as groupingset,
empid, custid, year(orderdate) as orderyear, sum(qty) as sumqty
from dbo.Orders
group by
grouping sets
((empid, custid, year(orderdate)),
(empid, year(orderdate)),
(custid, year(orderdate)))