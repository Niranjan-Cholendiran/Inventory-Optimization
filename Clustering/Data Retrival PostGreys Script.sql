SELECT
	P.*,
	sum(PP."PurchasePrice")/COALESCE(count(PP."PurchasePrice"),0) AS "PurchasePricePerQty",
	sum(PP."SalesPrice")/COALESCE(count(PP."SalesPrice"),0) AS "SalesPricePerQty",
	sum(S."SalesQuantity") as "TotalSalesQty",
	max(S."SalesDate") - min(S."SalesDate") as "TotalDaysSold",
	count(distinct S."StoreID") as "TotalStores"
FROM 
	analytical_tables."Sales_History" AS S 
LEFT JOIN 
	analytical_tables."Product_Purchase_Sale_Prices" AS PP
ON 
	S."Brand" = PP."Brand"
LEFT JOIN
	analytical_tables."Product_Info" AS P 
ON 
	PP."ProductSKU" = P."ProductSKU"
WHERE  
	S."StoreID" = '51'
	AND S."SalesDate" BETWEEN '2016-01-01' AND '2016-09-30'
GROUP BY 
	1,2,3,4,5,6,7
;