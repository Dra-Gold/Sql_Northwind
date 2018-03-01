/* selecciona la base de datos */
use Northwind
/* selecciona todos los productos */
Select * from Products
/* selecciona ciertos campos y solo los productos que cumplan la condicion */
Select ProductID, ProductName,SupplierID,QuantityPerUnit from Products where SupplierID=1
/* selecciona ciertos campos y solo los productos que cumplan una u otra condicion */
Select ProductID, ProductName,SupplierID,QuantityPerUnit from Products where SupplierID=1 or SupplierID=2
/* selecciona ciertos campos y solo los productos que cumplan una ambas condiciones */
Select ProductID, ProductName,SupplierID,QuantityPerUnit from Products where SupplierID=1 and CategoryID=1
/*selecciona  todos los campos que sean menor a 18.00*/
Select * from Products where UnitPrice<18.00
/*selecciona  todos los campos que sean menor o igual a 18.00*/
Select * from Products where UnitPrice<=18.00
/* Selecciona todos los campos que entren la fecha indicada */
Select * from Orders where OrderDate between '1996-07-04' and '1996-07-08'
/* Selecciona todos los campos que cumplan con una u otra condicion y los ordenas por el campo designado */
Select * from Products where SupplierID=1 or SupplierID=2 order by SupplierID
/* Selecciona todos los campos que cumplan con una u otra condicion 
y los ordenas por el campo designado de forma desencente*/
Select * from Products where SupplierID=1 or SupplierID=2 order by SupplierID desc
/* Selecciona todos los campos que cumplan con una u otra condicion y los ordenas por el campo designado 
 posteriormente ordana los campos agrupados por la segunda condicion otorgada */
Select * from Products where SupplierID=1 or SupplierID=2 order by SupplierID , UnitPrice
/* Selecciona todos los campos que cumplan con una u otra condicion y los ordenas por el campo designado 
 posteriormente ordana los campos agrupados por la segunda condicion otorgada de forma descendete */
Select * from Products where SupplierID=1 or SupplierID=2 order by SupplierID , UnitPrice desc
/* Selecciona todos los campos que cumplan con una u otra condicion y los ordenas por el campo designado 
 posteriormente ordana los campos agrupados por la segunda condicion y tercera condicion */
Select * from Products where SupplierID=1 or SupplierID=2 order by SupplierID , UnitPrice , ProductName


/*Funciones de agregado o totales AVG(Promedio de un campo) ,Count(Cuenta los registros de un campo), 
Sum(Suma los valores de un campo) ,Max(Devuelve el maximo de un campo), Min(Devuelve el minimo de un campo)*/
/* Deven tener dos campos obligatorio*/
/* Funcion suma Agrupada por un campo */
Select SupplierID,Sum(UnitPrice) from Products group by SupplierID
/* Funcion suma se le agrega nombre a la columna , Agrupada por un campo y ordenada por un campo */
Select SupplierID,Sum(UnitPrice) as Suma_Precio from Products group by SupplierID order by Suma_Precio
/* Funcion Promedio se le agrega nombre a la columna , Agrupada por un campo y ordenada por un campo */
Select SupplierID,Avg(UnitPrice) as Promedio_Precio from Products group by SupplierID order by Promedio_Precio
/*Funcion promedio agrupado por un campo y con una condicion  */
Select SupplierID,Avg(UnitPrice) as Promedio_Precio from Products group by SupplierID  having SupplierID=1
/* Funcion contar , cuanta la cantidad de productos que tinen cada SupplierID  */
Select  SupplierID,count(ProductID) as Cantidad_Producto from Products group by SupplierID
/* Funcion Max, seleciona el maximo segun la agrupacion  */
select SupplierID, Max(UnitPrice) as Precio_Maximo from Products group by SupplierID
/* Funcion Max, seleciona el maximo segun la agrupacion  y con una condicion */
select SupplierID, Max(UnitPrice) as Precio_Maximo from Products where SupplierID=1  group by SupplierID

/* Consultas de calculo sobre registros individuales  */
/* Select con calculo sobre un campo y redondeo de dos decimales */
select ProductID, ProductName , UnitPrice, round(UnitPrice*1.19,2) as Precio_Con_Iva from Products 
/* Select con calculo sobre un campo  */
select ProductID, ProductName , UnitPrice, UnitPrice-3 as Precio_Con_Dct from Products 
/* Select obteniendo la fecha del dia de la consulta  */
Select OrderID, CustomerID, OrderDate, RequiredDate , getdate() as Dia_Hoy from Orders
/* Select   obteniendo la fecha del dia de la consulta  y obteniendo la diferencia entre dos fechas */
Select OrderID, CustomerID, OrderDate , getdate() as Dia_Hoy,datediff(DAY,OrderDate,getdate())
 as Dias_De_Diferencia from Orders
 /* Select   obteniendo la fecha del dia de la consulta  y obteniendo la diferencia entre dos fechas y dando formato  */
 Select OrderID, CustomerID, OrderDate ,  format(getdate(),'dd/MM/yyyy') as Dia_Hoy,datediff(DAY,OrderDate,getdate())
 as Dias_De_Diferencia from Orders

 /*  Consultas multitabla */
 /* union externa union, union All,except, intersect, minus */
 /* Union interna inner join , left join , right join  */
 /* Union no muestra los registros repetidos , las tablas tienen que ser identicas en campos*/
  /*Select conjunto unido con otro select que cumplan cada condicion pertinente similares */
  Select * from Products where SupplierID=1 union Select * from Products where SupplierID=2
 /*Select conjunto unido con otro select que cumplan cada condicion pertinente diferentes */
 Select * from Products where UnitPrice<=18.00 union Select * from Products where SupplierID=1
 /* union all si repite los registros */
 /*Select conjunto unido con otro select que cumplan cada condicion pertinente diferentes */
 Select * from Products where UnitPrice<=18.00 union all Select * from Products where SupplierID=1
 /* inner join devuelve la informacion en comun de dos tablas o mas */
 /* left join devuelve la informacion en comun de dos tablas o mas 
y toda la informacion de la primera tabla */
/* right join devuelve la informacion en comun de dos tablas o mas
 y toda la informacion de la segunda tabla*/
 /* Select todos los compradores que tengan una orden , con inner join */
 Select * from Customers inner join Orders on Customers.CustomerID=Orders.CustomerID where Country='Germany'
  /* Select todos los compradores tengan o no una orden de compra , con inner join */
  Select * from Customers left join Orders on Customers.CustomerID=Orders.CustomerID where Country='Germany'

  /* Subconsultas */
  /* Operadores logicos y de comparacion */
  /* logicos= and/ or /not   */
  /* Compracion= like/</>/=/<=/>=/between/in/any/all */
  /*  Subconsulta escalonada devuelve un unico valor y unica columna a la consulta padre */
  /* Consulta escalona que devuelvesolamten los datos que cumplan la condicion de la cunsulta hija */
   select ProductID,ProductName,UnitPrice from Products where UnitPrice < (select avg(UnitPrice) from Products)
   /* Subconsulta de lista devuelve una lista  */
   /* consulta obtiene todos los campos de los productos donde los precio sean menores al menor de la subconsulta  */
   select * from Products where UnitPrice < all (  select  UnitPrice  from Products where  SupplierID=1)
   /*  consulta obtiene todos los campos de los productos donde los precio sean menores al mayor de la subconsulta */
   select * from Products where UnitPrice < any (  select  UnitPrice  from Products where  SupplierID=1)
    /*  consulta obtiene todos los campos de los productos donde los precio sean mayores al mayor de la subconsulta */
   select * from Products where UnitPrice > all (  select  UnitPrice  from Products where  SupplierID=1)
    /*   consulta obtiene todos los campos de los productos donde los precio sean mayores al menor de la subconsulta*/
   select * from Products where UnitPrice > any (  select  UnitPrice  from Products where  SupplierID=1)
   /* consulta obtiene los campos de los productos que esten en la subconsulta  */
   select ProductName,UnitPrice from Products where ProductID in (select ProductID from [Order Details] where Quantity >20 )
   /* consulta obtienen los campos de los clientes que no estan en la subconsulta */
   select  CustomerID,CompanyName from Customers where CustomerID not in (select CustomerID from Orders )
    /* consulta obtienen los campos de los clientes que no estan en la tabla Orders y relizen envio a UK */
   select  CustomerID,CompanyName from Customers where CustomerID not in (select CustomerID from Orders where ShipCountry='UK')

   /* Consultas de accion  */
   /*  actualizar , eliminar , insert , delete , crear tabla*/
   /* actualiza el precio de los productos donde sea el supplierid=1  */
   update Products set UnitPrice=UnitPrice+10 where SupplierID=1
   /* actualiza el precio de los productos donde sea el supplierid=1  */
   update Products set UnitPrice=UnitPrice-10 where SupplierID=1
   /* crea una tabla Productos y le agrega los datos de Products que cumplan la condicion */
   select * into Productos from  Products where SupplierID=1
   /* elimina los productos con la cateoriaid=2 */
   Delete from Productos where CategoryID=2
   /* borra los productos que su precio sean entre 17 a 20 */
   Delete from Productos where UnitPrice between 17 and 20
   /* seleciona todos los compradores que tengan una orden sin repitir tupla */
   /* distinct ve si hay mas campos repetidos y no los muestra mientras distinct row ve la fila completa */
   select distinct CompanyName from Customers inner join Orders on Customers.CustomerID=Orders.CustomerID
   select distinct CompanyName from Customers left join Orders on Customers.CustomerID=Orders.CustomerID where Orders.CustomerID is null

   /* inserta los datos de products en la tabla productos */
   insert into Productos select * from Products where SupplierID=2
   
   /* ddl comandos data definiton languaje  */
   /* crea una tabla */
   create table Produ (id int,Nombre varchar(20), edad tinyint); 
   /* Elimina la tabla */
   drop table Produ
   /* borra toda la informacion de la tabla */
   truncate  table Produ
   /* Modifica una tabla ya creada y le agrega una columna */
   alter table Produ add  Rut varchar(20)
   alter table Produ add  ciudad varchar(30)
   /* Moficica una tabla ya creada y le elimina una columna */
   alter table Produ drop column Rut
   /* moficica una columna de la tabla */
   alter table Produ alter column Rut int
   /* agrega por defecto que el campo ciudad al crearce sea desconocido */
   alter table Produ add default 'desconocido' for ciudad 

   /*  Indice primari key no permite duclicados ni null*/
   create table ejemplo (Rut varchar(20),nombre varchar(20), apeliido varchar(20), edad tinyint, primary key(Rut))
   /* creacion de un indice ordinario permite duplicados y null */
   create index MIndice on ejemplo (nombre)
   /* creacion de un indice unique sin duplicados , permite null */
   create unique index MIndice2 on ejemplo (apeliido)
   /* creacion de un multi_Indice unique sin duplicados , permite null */
   create unique index MIndice3 on ejemplo (apeliido,nombre)
   /* elimina el indice  */
   drop index MIndice on ejemplo 

   /* triggers se actica con isert , delete o actualizar */
   create table Productos (Codigo_Art varchar(25),Nombre_Art varchar(20),Precio int, primary key(Codigo_Art))
   drop table Productos
   create table Reg_Productos (Codigo_Art varchar(25),Nombre_Art varchar(20)
   ,Precio int,Insertado datetime, primary key(Codigo_Art))
   /* crea triger que inserta en la tabla reg_productos el registro insertado en productos  */
   drop table Reg_Productos
   create trigger Productos_AI 
   on Productos after insert as
   begin
   insert into Reg_Productos(Codigo_Art ,Nombre_Art ,Precio,Insertado) select Codigo_Art,Nombre_Art ,Precio,getdate() from INSERTED
   end 

   /* elimina trigger */
   drop trigger Productos_AI

   insert into Productos values ('650','Auto',250)
   insert into Productos values ('450','A',250)
   select * from Productos
   select * from Reg_Productos
   select * from Act_Productos
   update Productos set Precio=550 where Codigo_Art='650'
   update Productos set Precio=550 where Codigo_Art='450'
   
   create table Act_Productos (Id int Identity(1,1) PRIMARY KEY,Anterior_Codigo_Art varchar(25),Anterior_Nombre_Art varchar(20),
   Anterior_Precio int ,Nuevo_Codigo_Art varchar(25),Nuevo_Nombre_Art varchar(20),Nuevo_Precio int,
   fecha_actu datetime , usuario varchar(20))
  
   drop table Act_Productos

   create trigger Actualizar_Productos_AU 
   on Productos after update 
   as declare @user varchar(20)
   begin
   SELECT @user = SYSTEM_USER
   insert into Act_Productos (Anterior_Codigo_Art,Anterior_Nombre_Art,
   Anterior_Precio ,Nuevo_Codigo_Art ,Nuevo_Nombre_Art ,Nuevo_Precio ,
   fecha_actu  , usuario) select d.Codigo_Art,d.Nombre_Art,d.Precio,i.Codigo_Art,i.Nombre_Art,i.Precio,getdate(),@user
    from Deleted d inner join inserted i on i.Codigo_Art = d.Codigo_Art
   end


   drop trigger Actualizar_Productos_BU

   create table Productos_Eli (Codigo_Art varchar(25),Nombre_Art varchar(20),Precio int
   ,fecha_delete datetime, primary key(Codigo_Art)) 

   drop table Productos_Eli

   create trigger Eliminar_Productos_AD
   on Productos after delete
   as begin
   insert into Productos_Eli (Codigo_Art,Nombre_Art,Precio,fecha_delete) 
   select Codigo_Art,Nombre_Art ,Precio,getdate() from Deleted
   end

   delete from Productos where Codigo_Art='450'
   select * from Productos 
   select * from Productos_Eli 
   /* crea procedimiento */
   create procedure Selec_Produ
   as
   select * from Productos
   go
   /* ejecuta procedimiento */
   exec Selec_Produ
   
   create procedure Update_Pro @codigo varchar(5),@Precio int
   as
   update Productos set Precio=@Precio where Codigo_Art=@codigo
   go

   exec Update_Pro @codigo='650',@Precio=550

   /* crea una vista  es como sacar una foto*/

   create view vista_Productos
   as
   select ProductID, ProductName , UnitPrice from Products;
   go

   select * from vista_Productos