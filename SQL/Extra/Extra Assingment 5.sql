-- Exercise1
-- Question1
SELECT p.`Name` 
FROM product p 
WHERE p.ProductSubcategoryID IN (	SELECT ps.ProductSubcategoryID 
									FROM productsubcategory  ps 
                                    WHERE `Name` = 'Saddles');
                                    

-- Question2
SELECT p.`Name` 
FROM product p 
WHERE p.ProductSubcategoryID IN (	SELECT ps.ProductSubcategoryID 
									FROM productsubcategory  ps 
                                    WHERE `Name` LIKE 'Bo%');
                                    
                                    
-- Question3
SELECT p.`Name`
FROM product p 
WHERE p.ListPrice = (	SELECT MIN(p.ListPrice) 
						FROM product p 
						WHERE p.ProductSubcategoryID IN (	SELECT ps.ProductSubcategoryID 
															FROM productsubcategory  ps 
															WHERE `Name` = 'Touring Bikes'));
                                                            

-- Exercise2
-- Question1
SELECT cr.`Name`,sp.`Name`
FROM countryregion cr 
JOIN stateprovince sp ON cr.CountryRegionCode = sp.CountryRegionCode;

-- Question2
SELECT cr.`Name`,sp.`Name`
FROM countryregion cr 
JOIN stateprovince sp ON cr.CountryRegionCode = sp.CountryRegionCode
WHERE cr.`Name` IN ('Germany','Canada')
ORDER BY cr.`Name`;

-- Question3 
SELECT soh.SalesOrderID,soh.OrderDate,sp.SalesPersonID,sp.Bonus,sp.SalesYTD
FROM salesperson sp
JOIN salesorderheader soh ON sp.SalesPersonID = soh.SalesPersonID
WHERE soh.OnlineOrderFlag = 0;

-- Question4
SELECT soh.SalesOrderID,soh.OrderDate,e.Title,sp.Bonus,sp.SalesYTD
FROM salesperson sp
JOIN salesorderheader soh ON sp.SalesPersonID = soh.SalesPersonID
JOIN employee e ON sp.SalesPersonID = e.EmployeeID
WHERE soh.OnlineOrderFlag = 0;