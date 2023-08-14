-- 1. Покажите длительность самой длинной песни. Столбец назвать sec.
    SELECT Milliseconds 
    FROM chinook.track
    WHERE  Milliseconds = (SELECT MAX(Milliseconds) AS sec FROM chinook.track);

/*
    2. Покажите название и длительность в секундах самой длинной песни применив округление по 
    правилам математики.Столбец назвать sec.
*/
    SELECT
        `Name`,
        ROUND(Milliseconds/1000) AS sec
    FROM chinook.track
    WHERE Milliseconds = (SELECT MAX(Milliseconds) FROM chinook.track);

-- 3. Покажите все счёт-фактуры, стоимость которых ниже средней.
    SELECT * 
    FROM chinook.invoice
    WHERE Total < (SELECT AVG(Total) FROM chinook.invoice);

-- 4. Покажите счёт-фактуру с высокой стоимостью.
    SELECT * 
    FROM chinook.invoice
    WHERE Total = (SELECT MAX(Total) FROM chinook.invoice);

-- 5. Покажите города, в которых живут и сотрудники, и клиенты.
    SELECT City 
    FROM chinook.customer
    WHERE City IN (SELECT City FROM chinook.employee);

/*
    6. Покажите имя, фамилию покупателя (номер 16), компанию и общую сумму его заказов.
    Столбец назовите sum.
*/
    SELECT 
        FirstName, 
        LastName, 
        CustomerId, 
        Company, 
        (SELECT SUM(Total) FROM chinook.invoice WHERE CustomerId = 16) AS sum
    FROM chinook.customer
    WHERE CustomerId = 16;

/*
    7. Покажите сколько раз покупали треки группы Queen.  
    Количество покупок необходимо посчитать по каждому треку. 
    Вывести название, ИД трека и количество купленных треков группы Queen. 
    Столбец назовите total.
*/
    SELECT
	    Name, 
        TrackId, 
	    (SELECT COUNT(TrackId) FROM chinook.invoiceline WHERE TrackId=chinook.track.TrackId) AS Total
    FROM chinook.track
    WHERE Composer = "Queen";

-- 8. Посчитайте количество треков в каждом альбоме. В результате вывести имя альбома и кол-во треков.
    SELECT 
        Title, 
        (SELECT COUNT(*) FROM chinook.track WHERE track.AlbumId=chinook.album.AlbumId) AS count_track 
    FROM chinook.album;