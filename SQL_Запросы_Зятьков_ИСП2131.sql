-- Домашнее задание: Импорт учебной базы данных и выполнение 10 SQL-запросов
-- Выполнил: Зятьков Георгий
-- Группа: ИСП2131

USE IT_ServiceCenter_Practice;
GO

-- Запрос 1. Полный список заявок
SELECT
    RequestId,
    Description,
    CreatedAt,
    Cost
FROM ServiceRequests
ORDER BY CreatedAt DESC;
GO

-- Запрос 2. Новые заявки
SELECT
    sr.RequestId,
    sr.Description,
    sr.CreatedAt
FROM ServiceRequests AS sr
INNER JOIN RequestStatuses AS rs
    ON sr.StatusId = rs.StatusId
WHERE rs.StatusName = N'Новая';
GO

-- Запрос 3. Дорогие сетевые обращения
SELECT
    sr.RequestId,
    sr.Description,
    sr.Cost,
    c.CategoryName
FROM ServiceRequests AS sr
INNER JOIN Categories AS c
    ON sr.CategoryId = c.CategoryId
WHERE c.CategoryName = N'Сеть'
  AND sr.Cost > 1000;
GO

-- Запрос 4. Поиск по фрагменту текста
SELECT
    RequestId,
    Description,
    CreatedAt
FROM ServiceRequests
WHERE Description LIKE N'%принтер%';
GO

-- Запрос 5. Подробный отчёт по заявкам
SELECT
    sr.RequestId,
    cl.FullName AS ClientName,
    c.CategoryName,
    sr.Description,
    rs.StatusName,
    e.FullName AS EmployeeName,
    sr.Cost
FROM ServiceRequests AS sr
INNER JOIN Clients AS cl
    ON sr.ClientId = cl.ClientId
INNER JOIN Categories AS c
    ON sr.CategoryId = c.CategoryId
INNER JOIN RequestStatuses AS rs
    ON sr.StatusId = rs.StatusId
LEFT JOIN Employees AS e
    ON sr.EmployeeId = e.EmployeeId;
GO

-- Запрос 6. Заявки без назначенного сотрудника
SELECT
    sr.RequestId,
    sr.Description,
    sr.CreatedAt,
    cl.FullName AS ClientName
FROM ServiceRequests AS sr
INNER JOIN Clients AS cl
    ON sr.ClientId = cl.ClientId
WHERE sr.EmployeeId IS NULL
ORDER BY sr.CreatedAt ASC;
GO

-- Запрос 7. Количество заявок по статусам
SELECT
    rs.StatusName,
    COUNT(sr.RequestId) AS RequestCount
FROM RequestStatuses AS rs
LEFT JOIN ServiceRequests AS sr
    ON rs.StatusId = sr.StatusId
GROUP BY rs.StatusName
ORDER BY RequestCount DESC;
GO

-- Запрос 8. Анализ стоимости по категориям
SELECT
    c.CategoryName,
    AVG(sr.Cost) AS AverageCost,
    MAX(sr.Cost) AS MaximumCost
FROM Categories AS c
INNER JOIN ServiceRequests AS sr
    ON c.CategoryId = sr.CategoryId
GROUP BY c.CategoryName
HAVING AVG(sr.Cost) > 1000;
GO

-- Запрос 9. Клиенты с несколькими обращениями
SELECT
    cl.FullName,
    COUNT(sr.RequestId) AS RequestCount
FROM Clients AS cl
INNER JOIN ServiceRequests AS sr
    ON cl.ClientId = sr.ClientId
GROUP BY cl.ClientId, cl.FullName
HAVING COUNT(sr.RequestId) >= 2
ORDER BY RequestCount DESC;
GO

-- Запрос 10. Клиенты без заявок
SELECT
    cl.FullName,
    cl.City
FROM Clients AS cl
LEFT JOIN ServiceRequests AS sr
    ON cl.ClientId = sr.ClientId
WHERE sr.RequestId IS NULL;
GO
