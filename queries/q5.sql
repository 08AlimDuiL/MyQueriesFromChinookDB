-- 1. Используя запрос, установи нашу базу данных как БД по умолчанию;
    USE testdb;

-- 2. Используя запрос, посмотри какие таблицы содержит БД testdb;
    SHOW TABLES;

-- 3. Отобразите данные таблицы department;
    SELECT * 
    FROM testdb.department;

/* 
    4.Наша компания активно растет и теперь у нас в структуре появляется 2 отдела: 
    отдел сопровождения и отдел планирования и продаж. 
    Добавьте в таблицу новые отделы следующими по списку. 
    Описание отделов придумайте самостоятельно;
*/
    INSERT INTO testdb.department
        (id, department, description_dep)
    VALUES (5, 'отдел сопровождения', 'техническая поддержка'),
            (6, 'отдел планирования и продаж', 'планируют и продают(но это не точно)');

/* 
    5.В компании поменялась «штатка». От отдела кадров поступил запрос на изменение
    описания отдела аналитики и наименования подразделения администрация.
    Необходимо изменить 
    описание на:системный и бизнес анализ, 
    название на: проектный офис;
*/
    UPDATE testdb.department
    SET description_dep = 'системный и бизнес анализ'
    WHERE ID = 4;

    UPDATE testdb.department
    SET department = 'проектный офис'
    WHERE ID = 2;

-- 6. Покажите описание отдела тестирования;
    SELECT description_dep 
    FROM testdb.department
    WHERE ID = 3;

/* 
    7. А теперь представьте, что ID отделов Вы не видите.
    Попробуйте найти описание отдела тестирования еще раз. Используйте оператор like;
*/
    SELECT description_dep
    FROM testdb.department
    WHERE department LIKE '%отдел тестирования%';

-- 8. Отобразите данные всех сотрудников;
    SELECT * FROM testdb.employee;

/* 
    9. На совещании руководителей и заместителей ИТ-компании решили оптимизировать 
    количество отделов в компании. Отдел «проектный офис» решили упразднить 
    распределив всех руководителей подразделений в соответствующие отделы, 
    сохранив при этом им должности. Внесите соответствующие изменения в таблицы;
    !Важно: id отделов в таблице department не изменять.
*/

    /*
    Чтобы избежать ошибки при удалении(таблицы связаны между собой) нам нужно сначала 
    изменить данные таблицы testdb.employee(разнести руководителей по отделам), а потом
    удалить строку в таблице testdb.department.
    */
    UPDATE testdb.employee
    SET testdb.employee.department = 1
    WHERE ServiceId = 5;

    UPDATE testdb.employee
    SET testdb.employee.department = 4
    WHERE ServiceId = 6;

    UPDATE testdb.department
    SET 
        testdb.department.department = NULL,
        testdb.department.description_dep = NULL
    WHERE ServiceId = 2;

-- 10. Посчитайте количество сотрудников отдела разработки;
    SELECT COUNT(department) AS 'Кол-во сотрудников отдела разработки'
    FROM testdb.employee
    WHERE department = 1;

/*
    11. В компанию взяли 2 новеньких сотрудников в отдел сопровождения на должности
    инженер сопровождения. ФИО:   Матрешкин Олег Геннадьевич и Широкова Мария Валерьевна.
    Обогатите данными соответствующую таблицу. 
    P.S. При добавлении данных, не указывайте и не вставляйте данные в столбец ServiceId;
*/
    INSERT INTO testdb.employee
        (LastName, FirstName, MiddleName, Position, department)
    VALUES 
        ('Матрешкин', 'Олег', 'Геннадьевич', 'инженер сопровождения', 5),
        ('Широкова', 'Мария', 'Валерьевна', 'инженер сопровождения', 5);

/*
    12. Сотрудники Алексеев Алексей с должностью аналитик и Исаев Илья уволились.
    Внесите изменения в таблицу используя один запрос;
*/
    DELETE FROM testdb.employee
    WHERE ServiceId IN (1, 3);

/*
    13. Покажите количество сотрудников в каждом отделе. Используйте данные из одной
    таблицы employee;
*/
    SELECT department, COUNT(department) AS 'quantity'
    FROM testdb.employee
    GROUP BY department;

/*
    14. Покажите ФИО сотрудников и наименования отделов, в которых они работают.
    (Решить с помощью JOIN);
*/
    SELECT 
	    testdb.department.department, 
	    testdb.employee.FirstName,  
        testdb.employee.LastName,
	    testdb.employee.MiddleName
    FROM testdb.employee
    JOIN testdb.department
    ON testdb.employee.department = testdb.department.id;

-- 15. Покажите отделы, в которых количество сотрудников, больше 2. (Решить с помощью JOIN);
    SELECT 
	    testdb.department.department, 
        COUNT(testdb.department.department) AS 'quantity'
    FROM testdb.employee
    JOIN testdb.department
    ON testdb.employee.department = testdb.department.id
    GROUP BY testdb.department.department
    HAVING COUNT(testdb.department.department) > 2
    ORDER BY COUNT(testdb.department.department) ASC;

/*
    16. Выполните левостороннее соединение двух таблиц. 
    Выполните правостороннее соединение двух таблиц. 
    Объясните разницу между двумя запросами;
*/
    SELECT * 
    FROM testdb.employee
    RIGHT JOIN testdb.department
    ON testdb.employee.department = testdb.department.id;

    SELECT * 
    FROM testdb.employee
    LEFT JOIN testdb.department
    ON testdb.employee.department = testdb.department.id;
    /*
    С просторов интерента:
    
    RIGHT JOIN
    Показывает все записи из правой таблицы («right», правая, означает вторую в запросе)
    и записи из левой таблицы, которые имеют совпадающие значения ключей (если такие имеются).
    Если в левой таблице нет записей с совпадающими значениями, то оператор вместо них
    показывает значение NULL.
    Т. е. этот тип соединения возвращает все строки из таблиц с правосторонним соединением,
    указанным в условии ON, и только те строки из другой таблицы, где объединяемые поля равны.

    LEFT JOIN
    Показывает все записи из левой таблицы («left», левая, означает первую в запросе) 
    и записи из правой таблицы, которые имеют совпадающие значения ключей (если такие имеются).
    Если в правой таблице нет записей с совпадающими значениями, то оператор вместо них 
    показывает значение NULL.
    Т. е. этот тип соединения возвращает все строки из таблиц с левосторонним соединением, 
    указанным в условии ON, и только те строки из другой таблицы, где объединяемые поля равны.
    */

/*
    17. Покажите отделы, должности и количество работников в каждом отделе, 
    у которых руководящая должность. (Решить с помощью JOIN);
*/
    SELECT 
	    testdb.department.department, 
        testdb.employee.Position,
        COUNT(testdb.department.department) AS 'quantity'
    FROM testdb.employee
    JOIN testdb.department
    ON testdb.employee.department = testdb.department.id
    WHERE testdb.employee.Position LIKE '%руководитель%'
    GROUP BY testdb.department.department;
    
/*
    18. У нас в отделе тестирования хорошие новости! 
    Алёна стала руководителем тестирования и обещала устроить пир.
    Прежде чем ты отправишься праздновать,  нужно внести изменения в БД. Сделай это);
*/  
    UPDATE testdb.employee
    SET testdb.employee.Position = 'руководитель тестирования'
    WHERE testdb.employee.ServiceId = 7;    

-- 19. Выполни еще раз запрос № 17 и запиши в комментарии общее количество руководителей.
    SELECT 
	    testdb.department.department, 
        testdb.employee.Position,
        COUNT(testdb.department.department) AS 'quantity'
    FROM testdb.employee
    JOIN testdb.department
    ON testdb.employee.department = testdb.department.id
    WHERE testdb.employee.Position LIKE '%руководитель%'
    GROUP BY testdb.department.department;