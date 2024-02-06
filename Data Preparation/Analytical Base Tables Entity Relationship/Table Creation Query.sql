CREATE TABLE analytical_tabels."Product_Info" (
  "ProductSKU" varchar PRIMARY KEY,
  "Description" varchar,
  "VolumeSize" integer,
  "AlcoholType" varchar,
  "ABV" float,
  "FlavorProfile" varchar,
  "Classification" varchar
);

CREATE TABLE analytical_tabels."Vendor_Info" (
  "VendorNumber" varchar PRIMARY KEY,
  "VendorName" varchar
);

CREATE TABLE analytical_tabels."Store_Info" (
  "StoreID" varchar PRIMARY KEY,
  "City" varchar
);

CREATE TABLE analytical_tabels."Product_Purchase_Sale_Prices" (
  "Brand" varchar PRIMARY KEY,
  "ProductSKU" varchar,
  "VendorNumber" varchar,
  "PurchasePrice" float,
  "SalesPrice" float,
  "ExciseTaxPerQty" float
);

CREATE TABLE analytical_tabels."Begin_End_Inventory" (
  "Date" date,
  "StoreID" varchar,
  "Brand" varchar,
  "InventorySize" integer,
  PRIMARY KEY ("Date", "StoreID", "Brand")
);

CREATE TABLE analytical_tabels."Purchase_Order_Deliviery_History" (
  "PONumber" varchar,
  "StoreID" varchar,
  "Brand" varchar,
  "ReceivingDate" date,
  "VendorNumber" varchar,
  "PODate" date,
  "InvoiceDate" date,
  "PayDate" date,
  "PurchaseQuantity" integer,
  "PurchasePriceTotal" float,
  PRIMARY KEY ("PONumber", "StoreID", "Brand", "ReceivingDate")
);

CREATE TABLE analytical_tabels."Sales_History" (
  "StoreID" varchar,
  "SalesDate" date,
  "Brand" varchar,
  "SalesQuantity" integer,
  "SalesPriceTotal" float,
  PRIMARY KEY ("StoreID", "SalesDate", "Brand")
);

COMMENT ON COLUMN analytical_tabels."Product_Info"."ProductSKU" IS 'Indicates a product SKU (Description x Volume)';

COMMENT ON COLUMN analytical_tabels."Vendor_Info"."VendorNumber" IS 'Indicates a vendor';

COMMENT ON COLUMN analytical_tabels."Product_Purchase_Sale_Prices"."Brand" IS 'Indicates a purchase combination (ProductID x Vendor X PurchasePrice)';

COMMENT ON COLUMN analytical_tabels."Product_Purchase_Sale_Prices"."PurchasePrice" IS 'Cost price';

COMMENT ON COLUMN analytical_tabels."Product_Purchase_Sale_Prices"."SalesPrice" IS 'Customer Selling price';

COMMENT ON COLUMN analytical_tabels."Product_Purchase_Sale_Prices"."ExciseTaxPerQty" IS 'Tax involved in price';

COMMENT ON TABLE analytical_tabels."Purchase_Order_Deliviery_History" IS 'Indicates a purchase combination (Note: Same PONumber can be allocated to multiple stores orderd on same day)';

COMMENT ON COLUMN analytical_tabels."Purchase_Order_Deliviery_History"."PurchasePriceTotal" IS 'PurchaseQuantity x PurchasePrice';

COMMENT ON COLUMN analytical_tabels."Sales_History"."SalesPriceTotal" IS 'SalesQuantity x SalesPrice';

ALTER TABLE analytical_tabels."Product_Purchase_Sale_Prices" ADD FOREIGN KEY ("ProductSKU") REFERENCES analytical_tabels."Product_Info" ("ProductSKU");

ALTER TABLE analytical_tabels."Product_Purchase_Sale_Prices" ADD FOREIGN KEY ("VendorNumber") REFERENCES analytical_tabels."Vendor_Info" ("VendorNumber");

ALTER TABLE analytical_tabels."Begin_End_Inventory" ADD FOREIGN KEY ("StoreID") REFERENCES analytical_tabels."Store_Info" ("StoreID");

ALTER TABLE analytical_tabels."Begin_End_Inventory" ADD FOREIGN KEY ("Brand") REFERENCES analytical_tabels."Product_Purchase_Sale_Prices" ("Brand");

ALTER TABLE analytical_tabels."Purchase_Order_Deliviery_History" ADD FOREIGN KEY ("Brand") REFERENCES analytical_tabels."Product_Purchase_Sale_Prices" ("Brand");

ALTER TABLE analytical_tabels."Purchase_Order_Deliviery_History" ADD FOREIGN KEY ("StoreID") REFERENCES analytical_tabels."Store_Info" ("StoreID");

ALTER TABLE analytical_tabels."Purchase_Order_Deliviery_History" ADD FOREIGN KEY ("VendorNumber") REFERENCES analytical_tabels."Vendor_Info" ("VendorNumber");

ALTER TABLE analytical_tabels."Sales_History" ADD FOREIGN KEY ("StoreID") REFERENCES analytical_tabels."Store_Info" ("StoreID");

ALTER TABLE analytical_tabels."Sales_History" ADD FOREIGN KEY ("Brand") REFERENCES analytical_tabels."Product_Purchase_Sale_Prices" ("Brand");
