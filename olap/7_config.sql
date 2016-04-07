-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com

-- Clean up the database 
DROP TABLE all_orders;
DROP TABLE new_orders;
DROP TABLE orders_archive;

-- Create required tables
CREATE TABLE all_orders (
  order_id NUMBER(12) PRIMARY KEY, 
  order_date DATE, 
  order_mode VARCHAR2(8), 
  customer_id NUMBER(6), 
  order_status NUMBER(2),
  order_total NUMBER(8,2), 
  sales_rep_id NUMBER(6),
  promotion_id NUMBER(6)
  );
-- Adding comment for the order_status column 
COMMENT ON COLUMN ALL_ORDERS.ORDER_STATUS IS '0: Not fully entered, 1: Entered, 2: Canceled - bad credit,  3: Canceled - by customer, 4: Shipped - whole order,  5: Shipped - replacement items, 6: Shipped - backlog on items,  7: Shipped - special delivery, 8: Shipped - billed, 9: Shipped - payment plan, 10: Shipped - paid'
/
COMMENT ON COLUMN ALL_ORDERS.ORDER_MODE IS 'Mode of order : online or direct'
/

CREATE TABLE new_orders (
  order_id NUMBER(12) PRIMARY KEY, 
  order_date DATE, 
  order_mode VARCHAR2(8), 
  customer_id NUMBER(6), 
  order_status NUMBER(2),
  order_total NUMBER(8,2), 
  sales_rep_id NUMBER(6),
  promotion_id NUMBER(6)
  );
  
CREATE TABLE orders_archive (
  order_id NUMBER(12) PRIMARY KEY, 
  order_date DATE, 
  order_mode VARCHAR2(8), 
  customer_id NUMBER(6), 
  order_status NUMBER(2),
  order_total NUMBER(8,2), 
  sales_rep_id NUMBER(6),
  promotion_id NUMBER(6)
  );  

-- Insert orders data into the table 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2458, '17-AUG-99', 'direct', 101, 0, 78279.6, 153, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2397, '20-NOV-99', 'direct', 102, 1, 42283.2, 154, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2454, '03-OCT-99', 'direct', 103, 1, 6653.4, 154, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2354, '15-JUL-00', 'direct', 104, 0, 46257, 155, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2358, '09-JAN-00', 'direct', 105, 2, 7826, 155, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2381, '15-MAY-00', 'direct', 106, 3, 23034.6, 156, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2440, '01-SEP-99', 'direct', 107, 3, 70576.9, 156, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2357, '09-JAN-98', 'direct', 108, 5, 59872.4, 158, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2394, '11-FEB-00', 'direct', 109, 5, 21863, 158, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2435, '03-SEP-99', 'direct', 144, 6, 62303, 159, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2455, '21-SEP-99', 'direct', 145, 7, 14087.5, 160, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2379, '16-MAY-99', 'direct', 146, 8, 17848.2, 161, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2396, '02-FEB-98', 'direct', 147, 8, 34930, 161, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2406, '29-JUN-99', 'direct', 148, 8, 2854.2, 161, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2434, '13-SEP-99', 'direct', 149, 8, 268651.8, 161, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2436, '02-SEP-99', 'direct', 116, 8, 6394.8, 161, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2446, '27-JUL-99', 'direct', 117, 8, 103679.3, 161, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2447, '27-JUL-00', 'direct', 101, 8, 33893.6, 161, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2432, '14-SEP-99', 'direct', 102, 10, 10523, 163, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2433, '13-SEP-99', 'direct', 103, 10, 78, 163, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2355, '26-JAN-98', 'online', 104, 8, 94513.5, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2356, '26-JAN-00', 'online', 105, 5, 29473.8, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2359, '09-JAN-98', 'online', 106, 9, 5543.1, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2360, '15-NOV-99', 'online', 107, 4, 990.4, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2361, '14-NOV-99', 'online', 108, 8, 120131.3, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2362, '14-NOV-99', 'online', 109, 4, 92829.4, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2363, '24-OCT-99', 'online', 144, 0, 10082.3, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2364, '29-AUG-99', 'online', 145, 4, 9500, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2365, '29-AUG-99', 'online', 146, 9, 27455.3, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2366, '29-AUG-99', 'online', 147, 5, 37319.4, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2367, '28-JUN-00', 'online', 148, 10, 144054.8, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2368, '27-JUN-00', 'online', 149, 10, 60065, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2369, '27-JUN-99', 'online', 116, 0, 11097.4, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2370, '27-JUN-00', 'online', 117, 4, 126, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2371, '16-MAY-99', 'online', 118, 6, 79405.6, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2372, '27-FEB-99', 'online', 119, 9, 16447.2, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2373, '27-FEB-00', 'online', 120, 4, 416, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2374, '27-FEB-00', 'online', 121, 0, 4797, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2375, '26-FEB-99', 'online', 122, 2, 103834.4, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2376, '07-JUN-99', 'online', 123, 6, 11006.2, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2377, '07-JUN-99', 'online', 141, 5, 38017.8, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2378, '24-MAY-99', 'online', 142, 5, 25691.3, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2380, '16-MAY-99', 'online', 143, 3, 27132.6, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2382, '14-MAY-00', 'online', 144, 8, 71173, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2383, '12-MAY-00', 'online', 145, 8, 36374.7, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2384, '13-MAY-00', 'online', 146, 3, 29249.1, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2385, '09-DEC-99', 'online', 147, 4, 295892, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2386, '07-DEC-99', 'online', 148, 10, 21116.9, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2387, '12-MAR-99', 'online', 149, 5, 52758.9, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2388, '05-JUN-99', 'online', 150, 4, 282694.3, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2389, '05-JUN-00', 'online', 151, 4, 17620, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2390, '19-NOV-99', 'online', 152, 9, 7616.8, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2391, '28-FEB-98', 'direct', 153, 2, 48070.6, 156, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2392, '22-JUL-99', 'direct', 154, 9, 26632, 161, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2393, '11-FEB-00', 'direct', 155, 4, 23431.9, 161, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2395, '03-FEB-98', 'direct', 156, 3, 68501, 163, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2398, '20-NOV-99', 'direct', 157, 9, 7110.3, 163, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2399, '20-NOV-99', 'direct', 158, 0, 25270.3, 161, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2400, '10-JUL-99', 'direct', 159, 2, 69286.4, 161, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2401, '10-JUL-99', 'direct', 160, 3, 969.2, 163, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2402, '02-JUL-99', 'direct', 161, 8, 600, 154, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2403, '02-JUL-99', 'direct', 162, 0, 220, 154, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2404, '02-JUL-99', 'direct', 163, 6, 510, 158, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2405, '02-JUL-99', 'direct', 164, 5, 1233, 159, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2407, '29-JUN-99', 'direct', 165, 9, 2519, 155, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2408, '29-JUN-99', 'direct', 166, 1, 309, 158, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2409, '29-JUN-99', 'direct', 167, 2, 48, 154, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2410, '24-MAY-00', 'direct', 168, 6, 45175, 156, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2411, '24-MAY-99', 'direct', 169, 8, 15760.5, 156, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2412, '30-MAR-98', 'direct', 170, 9, 66816, 158, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2413, '30-MAR-00', 'direct', 101, 5, 48552, 161, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2414, '30-MAR-99', 'direct', 102, 8, 10794.6, 153, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2415, '30-MAR-97', 'direct', 103, 6, 310, 161, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2416, '30-MAR-99', 'direct', 104, 6, 384, 160, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2417, '21-MAR-99', 'direct', 105, 5, 1926.6, 163, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2418, '21-MAR-96', 'direct', 106, 4, 5546.6, 163, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2419, '21-MAR-99', 'direct', 107, 3, 31574, 160, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2420, '14-MAR-99', 'direct', 108, 2, 29750, 160, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2421, '13-MAR-99', 'direct', 109, 1, 72836, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2422, '17-DEC-99', 'direct', 144, 2, 11188.5, 153, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2423, '22-NOV-99', 'direct', 145, 3, 10367.7, 160, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2424, '22-NOV-99', 'direct', 146, 4, 13824, 153, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2425, '17-NOV-98', 'direct', 147, 5, 1500.8, 163, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2426, '17-NOV-98', 'direct', 148, 6, 7200, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2427, '10-NOV-99', 'direct', 149, 7, 9055, 163, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2428, '10-NOV-99', 'direct', 116, 8, 14685.8, NULL, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2429, '10-NOV-99', 'direct', 117, 9, 50125, 154, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2430, '02-OCT-99', 'direct', 101, 8, 29669.9, 159, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2431, '14-SEP-98', 'direct', 102, 1, 5610.6, 163, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2437, '01-SEP-98', 'direct', 103, 4, 13550, 163, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2438, '01-SEP-99', 'direct', 104, 0, 5451, 154, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2439, '31-AUG-99', 'direct', 105, 1, 22150.1, 159, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2441, '01-AUG-00', 'direct', 106, 5, 2075.2, 160, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2442, '28-JUL-90', 'direct', 107, 9, 52471.9, 154, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2443, '28-JUL-90', 'direct', 108, 0, 3646, 154, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2444, '28-JUL-99', 'direct', 109, 1, 77727.2, 155, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2445, '28-JUL-90', 'direct', 144, 8, 5537.8, 158, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2448, '19-JUN-99', 'direct', 145, 5, 1388, 158, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2449, '14-JUN-99', 'direct', 146, 6, 86, 155, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2450, '12-APR-99', 'direct', 147, 3, 1636, 159, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2451, '18-DEC-99', 'direct', 148, 7, 10474.6, 154, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2452, '07-OCT-99', 'direct', 149, 5, 12589, 159, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2453, '05-OCT-99', 'direct', 116, 0, 129, 153, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2456, '08-NOV-98', 'direct', 117, 0, 3878.4, 163, NULL); 
INSERT INTO all_orders ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_ID, ORDER_STATUS, ORDER_TOTAL,
SALES_REP_ID, PROMOTION_ID ) VALUES ( 
2457, '01-NOV-99', 'direct', 118, 5, 21586.2, 159, NULL); 
commit;
 
