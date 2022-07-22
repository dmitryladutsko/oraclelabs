alter session set current_schema = u_dw_references;
INSERT INTO t_days(
DAY_NAME                    ,  
DAY_NUMBER_IN_WEEK          , 
DAY_NUMBER_IN_MONTH         ,
DAY_NUMBER_IN_YEAR          )
SELECT DAY_NAME             ,  
DAY_NUMBER_IN_WEEK          , 
DAY_NUMBER_IN_MONTH         ,
DAY_NUMBER_IN_YEAR         
FROM cls_days;
