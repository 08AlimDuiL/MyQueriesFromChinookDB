-- 1. Покажите содержимое таблицы исполнителей (артистов).
    SELECT *
    FROM artist;

-- 2. Покажите фамилии и имена клиентов из города Лондон.
    SELECT
        FirstName,
        LastName 
    FROM customer
    WHERE City LIKE 'London';

-- 3. Покажите продажи за 2012 год, со стоимостью продаж более 4 долларов.
    SELECT
        InvoiceDate,
        Total  
    FROM chinook.invoice
    WHERE InvoiceDate LIKE '%2012%' AND Total > 4.00
    ORDER BY Total DESC;

/* 
    4. Покажите дату продажи, адрес продажи, город в которую совершена продажа и стоимость 
    покупки   не  равную 17.91. Присвоить названия столбцам:
    InvoiceDate – Дата Продажи;
    BillingAddress – Адрес Продажи;
    BillingCity - Город Продажи.
*/
    SELECT
        InvoiceDate AS 'Дата Продажи',
        BillingAddress AS 'Адрес Продажи',
        BillingCity AS 'Город Продажи',
        Total
    FROM chinook.invoice
    WHERE Total !=17.91
    ORDER BY Total DESC;

-- 5. Покажите фамилии и имена сотрудников компании, нанятых в 2003 году из города Калгари.
    SELECT
        LastName,
        FirstName,
        HireDate,
        City 
    FROM chinook.employee
    WHERE HireDate LIKE '2003%' AND City LIKE 'Calgary';

-- 6. Покажите канадские города, в которые были сделаны продажи в августе?
    SELECT
        BillingCity,
        InvoiceDate,
        BillingCountry
    FROM chinook.invoice
    WHERE BillingCountry LIKE 'Canada' AND InvoiceDate LIKE '%-08-%';

-- 7. Покажите Фамилии и имена работников, нанятых в октябре?
    SELECT
        LastName,
        FirstName,
        HireDate
    FROM chinook.employee
    WHERE HireDate LIKE '%-10-%';

/* 
    8. Покажите фамилии и имена сотрудников, занимающих должность менеджера по продажам и
    ИТ менеджера. Решите задание двумя способами:
    используя оператор IN;
    используя логические операции.
*/
    SELECT
        LastName,
        FirstName,
        Title  
    FROM chinook.employee
    WHERE Title IN ( 'IT Manager', 'Sales Manager');
    
    SELECT
        LastName,
        FirstName,
        Title  
    FROM chinook.employee
    WHERE Title LIKE 'IT Manager' OR Title LIKE 'Sales Manager';