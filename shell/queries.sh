
#!/bin/sh
#export
continue(){
        echo "Enter any key to return to the menu"
        read X
        clear
}

QueryProductSales(){
LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"<<EOF
SELECT rp.STORELOCATION,p.name,
(
SELECT   count(t.id)
from TRANSACTION t, TRANSACTION_PRODUCT tp
where t.id = tp.transactionid and tp.productid = p.id
group by p.name
) as "#of transactions"
FROM RETAIL_STORE_PRODUCT rp, product p
where rp.productid = p.id;
exit;
EOF
continue
}


QueryUnderstaffed(){
LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"<<EOF
SELECT m.FullName, count(e.ID) AS subordinates
FROM manager m
LEFT JOIN employee e
ON m.ID = e.ManagerID
GROUP BY m.FullName
HAVING count(e.ID) < 4;
exit;
EOF
continue
}


QueryCreditDebitTransactions(){
LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"<<EOF
SELECT *
FROM transaction
WHERE PaymentMethod = 'credit'
UNION
SELECT *
FROM transaction
WHERE PaymentMethod = 'debit';
exit;
EOF
continue
}



QueryExclusiveProducts(){
LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"<<EOF
SELECT StoreLocation, rsp1.ProductID, Name
FROM retail_store_product rsp1, product
WHERE rsp1.ProductID = product.ID
AND NOT EXISTS
(SELECT *
FROM retail_store_product rsp2
WHERE rsp1.ProductID = rsp2.ProductID
AND rsp1.StoreLocation <> rsp2.StoreLocation);
exit;
EOF
continue
}


QueryAssetsPerStore(){
LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"<<EOF
select r.address ,    count(w.address) as "WareHouses#",
(
select count(*)
from employee e
where r.address = e.storeid
group by r.address
) as employees#
from RETAIL_STORE r, WAREHOUSE_RETAIL_STORE l, WAREHOUSE w
where r.address = l.storelocation
and l.warehouselocation = w.address
group by r.address;
exit;
EOF
continue
}


QueryInStoresAndAtWarehouses(){
LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"<<EOF
SELECT ID, Name
FROM product
WHERE EXISTS
(SELECT rsp.ProductID
FROM retail_store_product rsp, warehouse_product w1, warehouse_product w2
WHERE ID = rsp.ProductID
AND w1.WarehouseLocation = '90 Penny Boulevard'
AND w2.WarehouseLocation = '43 Farside Road'
AND rsp.ProductID = w1.ProductID
AND rsp.ProductID = w2.ProductID);
exit;
EOF
continue
}


ViewActivePromotions(){
LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"<<EOF
SELECT * FROM active_promotions;
exit;
EOF
continue
}


ViewRestock(){
LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"<<EOF
SELECT * FROM need_restock;
exit;
EOF
continue
}


ViewExperienced(){
LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"<<EOF
SELECT * FROM experienced_employees;
exit;
EOF
continue
}

QueryYellowSandalsAtTime(){
LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"<<EOF
SELECT product_tag.Tag AS Promotion, promotion.DiscountPercentage AS Percent
FROM product_tag
INNER JOIN promotion_tag
ON promotion_tag.Tag = product_tag.Tag
AND product_tag.ProductID = '49827669'
INNER JOIN promotion
ON promotion_tag.PromotionID = promotion.ID
AND TO_TIMESTAMP('2020-06-13 10:23:00', 'YYYY-MM-DD HH24:MI:SS') > promotion.StartTime
AND TO_TIMESTAMP('2020-06-13 10:23:00', 'YYYY-MM-DD HH24:MI:SS') < promotion.EndTime;
exit;
EOF
continue
}

QueryBlueJeansForMainStreet(){
LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
SELECT w.Address AS Warehouse, wp.Quantity
FROM warehouse w
INNER JOIN warehouse_retail_store wr
ON  w.Address = wr.WarehouseLocation AND wr.StoreLocation = '104 Main Street'
INNER JOIN warehouse_product wp
ON wp.ProductID = '09827356' AND wp.WarehouseLocation = w.Address;
quit;
EOF
continue
}


MainMenu()
{
        while [ "$CHOICE" != "START" ]
        do
                echo "================================================================="
                echo "|                    Oracle All Inclusive Tool                  |"
                echo "|               Query - Select Desired Operation(s):            |"
                echo "|        <CTRL-Z Anytime to Enter Interactive CMD Prompt>       |"
                echo "-----------------------------------------------------------------"
                #echo " $IS_SELECTEDM M)  View Manual"
                echo " "
                echo " $IS_SELECTED1 1)  List warehouses that can deliver blue jeans to 104 Main Street"
                echo " $IS_SELECTED2 2)  Retrieve active promotions for yellow sandals on 2020-06-13"
                echo " $IS_SELECTED3 3)  Access view of experienced employees"
                echo " $IS_SELECTED4 4)  Access view of products in need of restock"
                echo " $IS_SELECTED4 5)  Access view of all promotions active at this time"
                echo " $IS_SELECTED4 6)  Query all products located at penny blv and farside road that are on sale"
                echo " $IS_SELECTED4 7)  Query the total manpower and warehouse access per store"
                echo " $IS_SELECTED4 8)  Query all products that can only be found at one store location"
                echo " $IS_SELECTED4 9) Query all transactions made with credit or debit"
                echo " $IS_SELECTED4 10) Query all managers with fewer than 4 subordinates"
                echo " $IS_SELECTED4 11) Query sales of product per store"

                echo " "

                echo " $IS_SELECTEDE E)  Back to main menu"
                echo "Choose: "
                read CHOICE
                clear
                if [ "$CHOICE" == "1" ]
                then
                        QueryBlueJeansForMainStreet
                elif [ "$CHOICE" == "2" ]
                then
                        QueryYellowSandalsAtTime
                elif [ "$CHOICE" == "3" ]
                then
                        ViewExperienced
                elif [ "$CHOICE" == "4" ]
                then
                        ViewRestock
                elif [ "$CHOICE" == "5" ]
                then
                        ViewActivePromotions
                elif [ "$CHOICE" == "6" ]
                then
                        QueryInStoresAndAtWarehouses
                elif [ "$CHOICE" == "7" ]
                then
                        QueryAssetsPerStore
                elif [ "$CHOICE" == "8" ]
                then
                        QueryExclusiveProducts
                elif [ "$CHOICE" == "9" ]
                then
                        QueryCreditDebitTransactions
                elif [ "$CHOICE" == "10" ]
                then
                        QueryUnderstaffed
                elif [ "$CHOICE" == "11" ]
                then
                        QueryProductSales
                elif [ "$CHOICE" == "E" ]
                then
                        exit
                fi
        done
}



#--COMMENTS BLOCK--
# Main Program
#--COMMENTS BLOCK--


ProgramStart()
{
        while [ 1 ]
        do
                MainMenu
        done
}

ProgramStart


