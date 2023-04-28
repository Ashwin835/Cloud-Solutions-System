--CREATE TABLES
CREATE TABLE CUSTOMER_ACCOUNTS
(Customer_ID NUMBER(10) PRIMARY KEY,
 Company_Name VARCHAR(50) NOT NULL,
 Email VARCHAR(100) NOT NULL,
 City VARCHAR(50) NOT NULL,
 Address VARCHAR(100) NOT NULL,
 Zip NUMBER(5) NOT NULL,
 Payment_Method VARCHAR(50) NOT NULL);

 CREATE TABLE CLOUD_SERVICE
 (Service_ID NUMBER(10) PRIMARY KEY,
  Service_Description VARCHAR(500) NOT NULL);
  
  CREATE TABLE USAGE_TRACKING
  (Tracking_ID NUMBER(10) PRIMARY KEY,
   Total_Space_Available_Gigabytes NUMBER(20) NOT NULL,
   Total_Space_Used_Gigabytes NUMBER(20) NOT NULL,
   Percentage_Of_Usage NUMBER(3) NOT NULL,
   Fields_Applied NUMBER(3) NOT NULL,
   Service_ID REFERENCES CLOUD_SERVICE(Service_ID) NOT NULL);
   
   
   CREATE TABLE INFASTRUCTURE_TYPE_INFO
   (Infastructure_ID NUMBER(10) PRIMARY KEY,
    Number_Of_Computers NUMBER(10)NOT NULL,
    Number_Of_Administrators NUMBER(10) NOT NULL,
    Number_Employees_With_Access NUMBER(10) NOT NULL,
    Customer_ID REFERENCES CUSTOMER_ACCOUNTS(Customer_ID) NOT NULL);
    
    CREATE TABLE SUBSCRIPTION_PLAN
    (Subscription_ID NUMBER(10) PRIMARY KEY,
     Subscription_Name VARCHAR(100) NOT NULL,
     Service_Cost NUMBER(10) NOT NULL,
    Service_ID REFERENCES CLOUD_SERVICE(Service_ID) NOT NULL);
     
     CREATE TABLE SUBSCRIBES
     (Customer_ID REFERENCES CUSTOMER_ACCOUNTS(Customer_ID) NOT NULL,
      Subscription_ID REFERENCES SUBSCRIPTION_PLAN(Subscription_ID) NOT NULL,
      CONSTRAINT sub_pk PRIMARY KEY(Customer_ID, Subscription_ID));
      
      Commit;
      
      
      --ADD DATA
      INSERT INTO CUSTOMER_ACCOUNTS VALUES (4836593754,'Google', 'goog@gmail.com',
      'Mountain View', '1600 Amphitheatre Pkwy', 94043, 'Check');
      
      INSERT INTO CUSTOMER_ACCOUNTS VALUES(4895749444, 'Coca-Cola', 'drinkcoke@cola.com',
      'Atlanta', '121 Baker St NW, Atlanta', 30313, 'Check');
      
      INSERT INTO CLOUD_SERVICE VALUES(3854938553, 'Stands for Software as a Service. You are able to manage all 
       applications, data, storage, and servers');
      
      INSERT INTO CLOUD_SERVICE VALUES (4678463534, 'Stands for Infastructure as a Service. You are able to manage everything
      except for servers and storage'); 
      
      INSERT INTO USAGE_TRACKING VALUES (4848737373, 1000000, 1000, .1, 1, 3854938553);
      
      INSERT INTO USAGE_TRACKING VALUES(8747438467, 1000000, 50000, 5, 1, 4678463534); 
      
      INSERT INTO INFASTRUCTURE_TYPE_INFO VALUES (3748734636, 1000000, 50, 987000, 4836593754);
      
      INSERT INTO INFASTRUCTURE_TYPE_INFO VALUES (2846749992, 500000, 23, 497600, 4895749444);
      
      INSERT INTO SUBSCRIPTION_PLAN VALUES(7398373746, 'SaaS Plan', 80000, 3854938553);
      
      INSERT INTO SUBSCRIPTION_PLAN VALUES(8473737370, 'IaaS Plan', 100000, 4678463534);
      
      INSERT INTO SUBSCRIBES VALUES (4836593754, 7398373746);
      
      INSERT INTO SUBSCRIBES VALUES(4836593754, 8473737370);
      
      INSERT INTO SUBSCRIBES VALUES(4895749444, 7398373746);
      
      
      Commit;
      
      /*USE #1: Given subscription plans, we can find out what other
      companies are subscribed to
      */
      SELECT c.Company_Name FROM SUBSCRIPTION_PLAN a INNER JOIN SUBSCRIBES b
      ON (a.subscription_id=b.subscription_id) INNER JOIN
      CUSTOMER_ACCOUNTS c ON (b.customer_id=c.customer_id)
      WHERE a.Subscription_Name IN ('IaaS Plan');
      
      
      
      
      
      /*Use #2: We are able to see the descriptions that other companies
      are subscibed to*/
      SELECT a.company_name, c.subscription_name, d.service_description
      FROM customer_accounts a INNER JOIN subscribes
      b on (a.customer_id=b.customer_id)
      INNER JOIN subscription_plan c ON
      (b.subscription_id=c.subscription_id)
      INNER JOIN cloud_service d ON
      (c.service_id=d.service_id)
      ORDER BY a.company_name;
       