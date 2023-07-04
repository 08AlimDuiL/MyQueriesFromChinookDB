 -- 1. Покажите фамилии и имя клиентов, у которых имя Mарк.
    SELECT LastName, FirstName 
    FROM chinook.customer
    WHERE FirstName LIKE '%Mar_';

 -- 2. Покажите название и размер треков в Мегабайтах, применив округление до 2 знаков и отсортировав по убыванию. Столбец назовите MB.
    SELECT `Name`, ROUND(Bytes/1024/1024, 2)  AS MB  
    FROM chinook.track
    ORDER BY MB ASC;

 -- 3. Покажите возраст сотрудников, на момент оформления на работу. Вывести фамилию, имя, возраст. дату оформления и день рождения. Столбец назовите age.
    SELECT LastName, FirstName, HireDate, BirthDate, FLOOR(DATEDIFF(HireDate, BirthDate)/365) AS AGE
    FROM chinook.employee
    ORDER BY AGE DESC;
 
    SELECT LastName, FirstName, TIMESTAMPDIFF(YEAR, BirthDate, HireDate)  AS AGE
    FROM chinook.employee
    ORDER BY AGE;
 
 -- 4. Покажите покупателей-американцев без факса.
    SELECT CustomerId FROM chinook.customer
    WHERE Country LIKE 'USA' AND Fax IS NULL
    ORDER BY CustomerId;
 
 -- 5. Покажите почтовые адреса клиентов из домена gmail.com.
    SELECT CustomerId, Email FROM chinook.customer
    WHERE Email LIKE '%gmail.com'
    ORDER BY CustomerId;
 
 -- 6. Покажите в алфавитном порядке все уникальные должности в компании.
    SELECT DISTINCT Title 
    FROM chinook.employee
    ORDER BY Title;
 
 -- 7. Покажите самую короткую песню.
    SELECT  MIN(Milliseconds) 
    FROM chinook.track;
 
 -- 8. Покажите название и длительность в секундах самой короткой песни. Столбец назвать sec.
 
 
 -- 9. Покажите средний возраст сотрудников, работающих в компании.
   SELECT FLOOR(AVG(DATEDIFF(HireDate, BirthDate)/365)) AS AGE
   FROM chinook.employee;
 
 -- 10. Проведите аналитическую работу: узнайте фамилию, имя и компанию покупателя (номер 5). Сколько заказов он сделал и на какую сумму. Покажите 2 запроса Вашей работы.
   SELECT LastName, FirstName, Company, CustomerId
   FROM chinook.customer
   WHERE CustomerId = 5;

   SELECT CustomerId, SUM(Total), COUNT(CustomerId) 
   FROM chinook.invoice
   WHERE CustomerId = 5;
 -- 11. Напишите запрос, определяющий количество треков, где ID плейлиста > 15. Назовите столбцы соответственно их расположения.
  

 -- 12. Найти все ID счет-фактур, в которых количество треков больше или равно 6 и меньше или равно 9