
#!/bin/sh
#export
LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"<<EOF
/*retail_store*/
INSERT INTO retail_store (Address, Cash) VALUES('104 Main Street', 1000.00);
INSERT INTO retail_store (Address, Cash) VALUES('43 Forest Road', 2320.50);
INSERT INTO retail_store (Address, Cash) VALUES('290 Major Macaque Street', 377.05);
INSERT INTO retail_store (Address, Cash) VALUES('67 Hill Street', 3321.00);
INSERT INTO retail_store (Address, Cash) VALUES('55 Side Street', 10872.22);


/*manager*/
INSERT INTO manager (ID, FullName, Username, Password, Email, Phone, Address, InvoiceInfo, HourlyRate, StoreID) VALUES('10283756', 'Becca Li', 'bccl123', '2hfiwh79', 'BeccaL123@gmail.com', '9995551111', '90 Suburbia Street', 'bank ref #543623', 22.04, '104 Main Street');
INSERT INTO manager (ID, FullName, Username, Password, Email, Phone, Address, InvoiceInfo, StoreID) VALUES('34567123', 'Ibrahim Khan', 'IbrhmK9', '28371gggh', 'KhanIb77@gmail.com', '9996352837', '11 Bicycle Street', 'bank ref #2837', '43 Forest Road');

/*employee*/
INSERT INTO employee(ID, FullName, Username, Password, Email, Phone, Address, InvoiceInfo, HourlyRate, ManagerID, StoreID, HoursWorked) VALUES ('472631', 'Marny Soo', 'MSoo44', 'jjir883', 'MarnyS11@yahoo.com', 8885552342, '22 Normal Road', 'bank ref #883726', 13.40, '34567123', '43 Forest Road', 207);
INSERT INTO employee(ID, FullName, Username, Password, Email, Phone, Address, InvoiceInfo, HourlyRate, ManagerID, StoreID, HoursWorked) VALUES ('223456', 'Jimmy Ozar', 'Jimmo22', 'gjsb231f', 'OzarJ63@yahoo.com', 2432222312, '6 Pleasant Road', 'bank ref #029412', 14.21, '34567123', '43 Forest Road', 432);
INSERT INTO employee(ID, FullName, Username, Password, Email, Phone, Address, InvoiceInfo, HourlyRate, ManagerID, StoreID, HoursWorked) VALUES ('548273', 'Mani Yano', 'MYano88', 'ysurbj22', 'YanoMani@gmail.com', 6733232212, '73 Leeway Street', 'bank ref #090822', 15.55, '10283756', '104 Main Street', 345);
INSERT INTO employee(ID, FullName, Username, Password, Email, Phone, Address, InvoiceInfo, HourlyRate, ManagerID, StoreID, HoursWorked) VALUES ('837463', 'Ernesto Wright', 'ErnW21', 'sjdaa71', 'ErnestoW1@gmail.com', 2317349274, '22 Pleasant Road', 'bank ref #273611', 12.05, '10283756', '104 Main Street', 186);
/*admin*/
INSERT INTO admin(ID, FullName, Username, Password, AdminUsername, AdminPassword, Email, Phone, Address, InvoiceInfo, HourlyRate) VALUES('283746', 'Kate Vessel', 'Kves92', 'sjshdj222', 'jsnFU87s', 'aodjw85D', 'KateV672@gmail.com', '8470982635', '83 Normal Road', 'bank ref #36253', 34.59);
/*tag*/
INSERT INTO tag(Name) VALUES('Clearance');
INSERT INTO tag(Name) VALUES('Spring');
INSERT INTO tag(Name) VALUES('Summer');
INSERT INTO tag(Name) VALUES('Fall');
INSERT INTO tag(Name) VALUES('Winter');
/*promotion*/
INSERT INTO promotion(ID, StartTime, EndTIme, DiscountPercentage) VALUES('0001', TO_TIMESTAMP( '2000-01-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP( '2100-01-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'),75);
INSERT INTO promotion(ID, StartTime, EndTIme, DiscountPercentage) VALUES('0002', TO_TIMESTAMP( '2019-11-20 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP( '2020-02-11 17:00:00', 'YYYY-MM-DD HH24:MI:SS'),50);
INSERT INTO promotion(ID, StartTime, EndTIme, DiscountPercentage) VALUES('0003', TO_TIMESTAMP( '2020-03-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP( '2020-05-11 17:00:00', 'YYYY-MM-DD HH24:MI:SS'),50);
INSERT INTO promotion(ID, StartTime, EndTIme, DiscountPercentage) VALUES('0004', TO_TIMESTAMP( '2020-05-20 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP( '2020-08-11 17:00:00', 'YYYY-MM-DD HH24:MI:SS'),50);
INSERT INTO promotion(ID, StartTime, EndTIme, DiscountPercentage) VALUES('0005', TO_TIMESTAMP( '2020-09-10 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP( '2020-11-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'),50);


/*product*/
INSERT INTO product(ID, Name, Price) VALUES('09827356', 'blue jeans', 20.99);
INSERT INTO product(ID, Name, Price) VALUES('09822837', 'red sweater', 22.55);
INSERT INTO product(ID, Name, Price) VALUES('02227356', 'black coat', 45.99);
INSERT INTO product(ID, Name, Price) VALUES('09827399', 'white tank top', 12.99);
INSERT INTO product(ID, Name, Price) VALUES('09827669', 'thermal socks', 7.99);
INSERT INTO product(ID, Name, Price) VALUES('49827669', 'yellow sandals', 5.99);
INSERT INTO product(ID, Name, Price) VALUES('09887669', 'orange windbreaker', 18.99);
INSERT INTO product(ID, Name, Price) VALUES('00027669', 'pink raincoat', 5.99);
/*rewards_customer*/
INSERT INTO rewards_customer(ID, FullName, Email, Password, PaymentInfo) VALUES('293851', 'Antony Smitt', 'ASmitt55@yahoo.ca', 'ufhwg88', 'bank ref #55908');
INSERT INTO rewards_customer(ID, FullName, Email, Password, Phone, PaymentInfo) VALUES('200821', 'Mandy Arn', 'Arnie33@yahoo.ca', 'ffh6488', '2758263759', 'bank ref #52932');
/*transaction*/
INSERT INTO transaction(ID, RegisterNumber, TransactionTime, PaymentMethod, StoreID) VALUES ('093827', '#4', TO_TIMESTAMP('2018-04-06 10:24:50', 'YYYY-MM-DD HH24:MI:SS'), 'credit', '104 Main Street');
INSERT INTO transaction(ID, RegisterNumber, TransactionTime, PaymentMethod, StoreID) VALUES ('093227', '#6', TO_TIMESTAMP('2019-12-22 14:53:46', 'YYYY-MM-DD HH24:MI:SS'), 'debit', '104 Main Street');
INSERT INTO transaction(ID, RegisterNumber, TransactionTime, PaymentMethod, StoreID) VALUES ('013827', '#2', TO_TIMESTAMP('2019-07-13 13:44:21', 'YYYY-MM-DD HH24:MI:SS'), 'cash', '104 Main Street');
INSERT INTO transaction(ID, RegisterNumber, TransactionTime, PaymentMethod, StoreID) VALUES ('017827', '#1', TO_TIMESTAMP('2018-01-09 16:37:30', 'YYYY-MM-DD HH24:MI:SS'), 'cash', '43 Forest Road');
INSERT INTO transaction(ID, RegisterNumber, TransactionTime, PaymentMethod, StoreID) VALUES ('014827', '#1', TO_TIMESTAMP('2017-06-27 11:12:58', 'YYYY-MM-DD HH24:MI:SS'), 'credit', '43 Forest Road');
INSERT INTO transaction(ID, RegisterNumber, TransactionTime, PaymentMethod, StoreID) VALUES ('113822', '#2', TO_TIMESTAMP('2017-09-12 12:55:21', 'YYYY-MM-DD HH24:MI:SS'), 'credit', '43 Forest Road');
/*warehouse*/
INSERT INTO warehouse(Address) VALUES('28 Portside Street');
INSERT INTO warehouse(Address) VALUES('90 Penny Boulevard');
INSERT INTO warehouse(Address) VALUES('43 Farside Road');
/*employee_shift*/
INSERT INTO employee_shift(ID, StartTime, EndTime, StoreID) VALUES('092873', TO_TIMESTAMP( '2018-02-21 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2018-02-21 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), '104 Main Street');
INSERT INTO employee_shift(ID, StartTime, EndTime, StoreID) VALUES('092573', TO_TIMESTAMP( '2019-04-23 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2019-04-23 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), '104 Main Street');
INSERT INTO employee_shift(ID, StartTime, EndTime, StoreID) VALUES('092273', TO_TIMESTAMP( '2017-05-16 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2017-05-16 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), '104 Main Street');
INSERT INTO employee_shift(ID, StartTime, EndTime, StoreID) VALUES('222873', TO_TIMESTAMP( '2018-09-12 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2018-09-12 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), '43 Forest Road');
INSERT INTO employee_shift(ID, StartTime, EndTime, StoreID) VALUES('223873', TO_TIMESTAMP( '2020-01-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2020-01-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), '43 Forest Road');
INSERT INTO employee_shift(ID, StartTime, EndTime, StoreID) VALUES('258873', TO_TIMESTAMP( '2020-10-12 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2020-10-12 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), '43 Forest Road');
INSERT INTO employee_shift(ID, StartTime, EndTime, StoreID) VALUES('258873',TO_TIMESTAMP( '2019-01-12 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2019-01-12 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), '43 Forest Road');
/*TO_TIMESTAMP( '2018-02-21 09:00:00', 'YYYY-MM-DD HH24:MI:SS')*/
/*employee_shift_employee*/
INSERT INTO employee_shift_employee(ShiftID, EmployeeID, AssignedTask) VALUES('092873', '472631', 'Sales floor');
INSERT INTO employee_shift_employee(ShiftID, EmployeeID, AssignedTask) VALUES('092573', '223456', 'Sales floor');
INSERT INTO employee_shift_employee(ShiftID, EmployeeID, AssignedTask) VALUES('092273', '472631', 'Sales floor');
INSERT INTO employee_shift_employee(ShiftID, EmployeeID, AssignedTask) VALUES('092273', '223456', 'Sales floor');
INSERT INTO employee_shift_employee(ShiftID, EmployeeID, AssignedTask) VALUES('222873', '548273', 'Sales floor');
INSERT INTO employee_shift_employee(ShiftID, EmployeeID, AssignedTask) VALUES('223873', '837463', 'Sales floor');
INSERT INTO employee_shift_employee(ShiftID, EmployeeID, AssignedTask) VALUES('258873', '548273', 'Sales floor');
INSERT INTO employee_shift_employee(ShiftID, EmployeeID, AssignedTask) VALUES('258873', '837463', 'Sales floor');
/*warehouse_retail_store*/
INSERT INTO warehouse_retail_store(StoreLocation, WareHouseLocation) VALUES('104 Main Street', '28 Portside Street');
INSERT INTO warehouse_retail_store(StoreLocation, WareHouseLocation) VALUES('104 Main Street', '43 Farside Road');
INSERT INTO warehouse_retail_store(StoreLocation, WareHouseLocation) VALUES('43 Forest Road', '90 Penny Boulevard');
INSERT INTO warehouse_retail_store(StoreLocation, WareHouseLocation) VALUES('43 Forest Road', '28 Portside Street');
INSERT INTO warehouse_retail_store(StoreLocation, WareHouseLocation) VALUES('290 Major Macaque Street', '28 Portside Street');
INSERT INTO warehouse_retail_store(StoreLocation, WareHouseLocation) VALUES('290 Major Macaque Street', '90 Penny Boulevard');
INSERT INTO warehouse_retail_store(StoreLocation, WareHouseLocation) VALUES('290 Major Macaque Street', '43 Farside Road');
INSERT INTO warehouse_retail_store(StoreLocation, WareHouseLocation) VALUES('67 Hill Street', '90 Penny Boulevard');
INSERT INTO warehouse_retail_store(StoreLocation, WareHouseLocation) VALUES('67 Hill Street', '43 Farside Road');
INSERT INTO warehouse_retail_store(StoreLocation, WareHouseLocation) VALUES('55 Side Street', '90 Penny Boulevard');
/*retail_store_product*/
INSERT INTO retail_store_product(StoreLocation, ProductID, Quantity) VALUES('104 Main Street', '09827356', 90);
INSERT INTO retail_store_product(StoreLocation, ProductID, Quantity) VALUES('104 Main Street', '09822837', 24);
INSERT INTO retail_store_product(StoreLocation, ProductID, Quantity) VALUES('104 Main Street', '02227356', 63);
INSERT INTO retail_store_product(StoreLocation, ProductID, Quantity) VALUES('104 Main Street', '09827399', 14);
INSERT INTO retail_store_product(StoreLocation, ProductID, Quantity) VALUES('104 Main Street', '09827669', 53);
INSERT INTO retail_store_product(StoreLocation, ProductID, Quantity) VALUES('43 Forest Road',  '09827669', 132);
INSERT INTO retail_store_product(StoreLocation, ProductID, Quantity) VALUES('43 Forest Road',  '02227356', 67);
INSERT INTO retail_store_product(StoreLocation, ProductID, Quantity) VALUES('43 Forest Road',  '00027669', 52);
INSERT INTO retail_store_product(StoreLocation, ProductID, Quantity) VALUES('43 Forest Road',  '09827399', 22);
INSERT INTO retail_store_product(StoreLocation, ProductID, Quantity) VALUES('43 Forest Road',  '09822837', 42);
/*warehouse_product*/
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('28 Portside Street', '09827356', 252);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('28 Portside Street', '09822837', 412);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('28 Portside Street', '02227356', 502);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('28 Portside Street', '09827399', 324);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('28 Portside Street', '09827669', 192);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('28 Portside Street', '49827669', 643);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('90 Penny Boulevard', '02227356', 502);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('90 Penny Boulevard', '09827399', 324);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('90 Penny Boulevard', '09827669', 192);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('90 Penny Boulevard', '49827669', 442);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('90 Penny Boulevard', '09887669', 98);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('90 Penny Boulevard', '00027669', 472);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('43 Farside Road', '09827356', 212);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('43 Farside Road', '09822837', 632);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('43 Farside Road', '02227356', 672);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('43 Farside Road', '09827669', 213);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('43 Farside Road', '09887669', 181);
INSERT INTO warehouse_product(WarehouseLocation, ProductID, Quantity) VALUES('43 Farside Road', '00027669', 335);

/*transaction_product*/
INSERT INTO transaction_product(TransactionID, ProductID, Quantity) VALUES('113822', '00027669', 1);
INSERT INTO transaction_product(TransactionID, ProductID, Quantity) VALUES('113822', '09827399', 2);
INSERT INTO transaction_product(TransactionID, ProductID, Quantity) VALUES('093827', '09827356', 1);
INSERT INTO transaction_product(TransactionID, ProductID, Quantity) VALUES('093227', '09822837', 3);
INSERT INTO transaction_product(TransactionID, ProductID, Quantity) VALUES('013827', '02227356', 6);
INSERT INTO transaction_product(TransactionID, ProductID, Quantity) VALUES('017827', '09827399', 3);
INSERT INTO transaction_product(TransactionID, ProductID, Quantity) VALUES('014827', '09827669', 11);
/*transaction_promotion*/
INSERT INTO transaction_promotion (TransactionID, PromotionID) VALUES('113822', '0001');
/*promotion_tag*/
INSERT INTO promotion_tag(PromotionID, Tag) VALUES('0001', 'Clearance');
INSERT INTO promotion_tag(PromotionID, Tag) VALUES('0002', 'Winter');
INSERT INTO promotion_tag(PromotionID, Tag) VALUES('0003', 'Spring');
INSERT INTO promotion_tag(PromotionID, Tag) VALUES('0004', 'Summer');
INSERT INTO promotion_tag(PromotionID, Tag) VALUES('0005', 'Fall');

/*product_tag*/
INSERT INTO product_tag(ProductID, Tag) VALUES('09827356', 'Spring');
INSERT INTO product_tag(ProductID, Tag) VALUES('09827356', 'Fall');
INSERT INTO product_tag(ProductID, Tag) VALUES('09822837', 'Winter');
INSERT INTO product_tag(ProductID, Tag) VALUES('09822837', 'Fall');
INSERT INTO product_tag(ProductID, Tag) VALUES('02227356', 'Winter');
INSERT INTO product_tag(ProductID, Tag) VALUES('09827399', 'Summer');
INSERT INTO product_tag(ProductID, Tag) VALUES('09827399', 'Clearance');
INSERT INTO product_tag(ProductID, Tag) VALUES('09827669', 'Winter');
INSERT INTO product_tag(ProductID, Tag) VALUES('49827669', 'Summer');
INSERT INTO product_tag(ProductID, Tag) VALUES('49827669', 'Clearance');
INSERT INTO product_tag(ProductID, Tag) VALUES('09887669', 'Spring');
INSERT INTO product_tag(ProductID, Tag) VALUES('09887669', 'Fall');
INSERT INTO product_tag(ProductID, Tag) VALUES('00027669', 'Spring');
INSERT INTO product_tag(ProductID, Tag) VALUES('00027669', 'Summer');
INSERT INTO product_tag(ProductID, Tag) VALUES('00027669', 'Fall');
INSERT INTO product_tag(ProductID, Tag) VALUES('00027669', 'Clearance');


exit;
EOF


