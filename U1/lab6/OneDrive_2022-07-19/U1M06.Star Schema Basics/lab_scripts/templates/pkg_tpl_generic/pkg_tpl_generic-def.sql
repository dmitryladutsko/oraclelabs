--DROP PACKAGE pkg_etl_clients_dw;

CREATE OR REPLACE PACKAGE pkg_etl_clients_dw
AS  
   /**
    * Write a description for this function here.
    *
    * @param     p_a     describe parameter p_a here, prefix p_ for parameter
    * @param     p_b     describe parameter p_b here, prefix p_ for parameter
    * @throw     e_template
    * @return            describe valid values and/or type of result here
    */
    
    procedure load_cls_clients;
    
END pkg_etl_clients_dw;
/