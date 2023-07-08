 -- 1. Покажите все данные заказов покупателя (номер 13) и отсортируйте стоимость по возрастанию.
   SELECT * FROM chinook.customer 
   INNER JOIN chinook.invoice 
   ON customer.CustomerId = invoice.CustomerId
   WHERE chinook.customer.CustomerId=13 AND chinook.invoice.CustomerId=13;

 -- 2. Посчитайте количество треков в каждом альбоме. В результате вывести ID альбома, имя альбома и кол-во треков. 
   SELECT 
	   chinook.track.AlbumId,
      chinook.album.Title, 
      COUNT(chinook.album.Title) AS total
   FROM chinook.album JOIN chinook.track
   ON chinook.track.AlbumId = chinook.album.AlbumId
   GROUP BY chinook.track.AlbumId ;
   
 -- 3. Покажите имя, фамилию, кол-во и стоимость покупок по каждому клиенту. Столбцы кол-во назвать quantity, стоимость - sum.
   SELECT 
	   customer.FirstName,
      customer.LastName, 
      SUM(invoice.Total) AS sum,
      COUNT(invoice.Total) AS quantity
   FROM chinook.customer
   INNER JOIN chinook.invoice
   ON customer.CustomerId = invoice.CustomerId
   GROUP BY customer.CustomerId;
   
 -- 4. Посчитайте общую сумму продаж в США в 1 квартале 2012 года. Присвойте любой псевдоним столбцу.
  SELECT SUM(invoice.Total) AS total 
  FROM chinook.invoice
  WHERE 
    BillingCountry = "USA"
       AND 
    (InvoiceDate BETWEEN DATE '2012-01-01' AND DATE '2012-03-31');

  SELECT SUM(invoiceline.UnitPrice) AS total 
  FROM chinook.invoiceline
  JOIN chinook.invoice
  ON invoiceline.InvoiceId = invoice.InvoiceId
  WHERE 
    BillingCountry = "USA"
       AND 
    (InvoiceDate BETWEEN DATE '2012-01-01' AND DATE '2012-03-31');

    /*
    5. Выполните запросы по очереди и ответьте на вопросы:
    Вернут ли данные запросы одинаковый результат?  Ответы: Да или НЕТ. 

    1.  Если ДА. Объяснить почему.
    2.  Если НЕТ. Объяснить почему. 
    3.  Какой запрос вернет больше строк? 
    */

-- НЕТ
  SELECT * FROM chinook.customer 
  LEFT JOIN chinook.employee
  ON chinook.customer.SupportRepId = chinook.employee.employeeId;
   
  SELECT * FROM chinook.customer 
  RIGHT JOIN chinook.employee
  ON chinook.customer.SupportRepId = chinook.employee.employeeId;

  /*
  Данные запросы вернут разные результаты. 
  В первом запросе мы делаем LEFT JOIN. Т. е. мы берем все строчки из chinook.customer
  и к ней добавляем строчки из таблицы chinook.employee. Общий знаменатель - это SupportRepId, 
  который соответствует employeeId. Не все chinook.employee занимались покупателями. Те кто 
  на менеджерских позициях они не привязаны к customer
  */

    /*
    6. Выполните запросы по очереди и ответьте на вопросы:
    Вернут ли данные запросы одинаковый результат? Ответы: Да или НЕТ. 
    1. Если ДА. Объяснить почему.
    2. Если НЕТ. Объяснить почему. 
    3. Какой запрос вернет больше строк ?
    */

-- НЕТ

   SELECT * FROM chinook.customer 
   LEFT JOIN chinook.employee
   ON chinook.customer.SupportRepId = chinook.employee.employeeId
   WHERE chinook.employee.FirstName IS NULL;
-- Здесь условие  WHERE


   SELECT * FROM chinook.customer
   LEFT JOIN chinook.employee
   ON chinook.customer.SupportRepId = chinook.employee.employeeId
   AND  chinook.employee.FirstName IS NULL;
-- Здесь условие соединения таблиц

 -- 7. Покажите количество и среднюю стоимость треков в каждом жанре. Вывести ID жанра, название жанра, количество и среднюю стоимость.

  SELECT 
    chinook.genre.GenreId,
    chinook.genre.Name, 
    COUNT(chinook.track.AlbumId) AS total_count, 
    ROUND(AVG(UnitPrice), 2) AS average
  FROM chinook.genre
  JOIN chinook.track
  ON chinook.genre.GenreId = chinook.track.GenreId
  GROUP BY chinook.track.GenreId, chinook.genre.Name
  ORDER BY total_count DESC;

    /*
    8. Покажите клиента, который потратил больше всего денег.
    Для сокращения количества символов в запросе, используйте псевдонимы. 
    Для ограничения количества записей используйте оператор "limit".
    */

  SELECT  
	  i.CustomerId AS customer, 
    FirstName, LastName,
    SUM(i.Total) AS max_total
  FROM chinook.customer AS c
  JOIN chinook.invoice AS i
  ON c.CustomerId = i.CustomerId
  GROUP BY  i.CustomerId
  ORDER BY  max_total DESC 
  LIMIT 1;

  /*
    9. Покажите список названий альбомов, ID альбомов,
    количество треков и общую цену альбомов для исполнителя Audioslave.
  */
  SELECT
	  AR.Name, 
    AL.Title,
    TR.AlbumId,
    COUNT(TR.AlbumId), 
    SUM(TR.UnitPrice)
  FROM chinook.album AS AL
  INNER JOIN chinook.artist AS AR ON AL.ArtistId= AR.ArtistId 
  INNER JOIN chinook.track AS TR ON AL.AlbumId = TR.AlbumId
  WHERE AR.Name = 'Audioslave'
  GROUP BY 
	  AR.Name, 
    AL.Title,
    TR.AlbumId;