-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com


/* *** sample 1 : object creation *** */

/* 1-1 : emp */
CREATE TABLE emp(
  id_emp      VARCHAR2(3),
  st_emp      VARCHAR2(16) NOT NULL,
  CONSTRAINT pk_emp PRIMARY KEY (id_emp)
);


/* 1-2 : category */
CREATE TABLE category(
  id_category VARCHAR2(3),
  st_category VARCHAR2(16) NOT NULL,
  CONSTRAINT pk_category PRIMARY KEY (id_category)
);


/* 1-3 : pc property */
CREATE TABLE props_pc(
  id_pcmodel       VARCHAR2(3),
  st_pcmodel       VARCHAR2(16) NOT NULL,
  nu_cpuspeed      NUMBER(4,0) NOT NULL,
  nu_memorysize    NUMBER(5,0) NOT NULL,
  CONSTRAINT pk_props_comp PRIMARY KEY (id_pcmodel)
);


/* 1-4 : tv property */
CREATE TABLE props_tv(
  id_tvmodel VARCHAR2(3),
  st_tvmodel VARCHAR2(16) NOT NULL,
  nu_displaysize NUMBER(3,0) NOT NULL,
  CONSTRAINT pk_props_tv PRIMARY KEY (id_tvmodel)
);


/* 1-5 : radio property */
CREATE TABLE props_radio(
  id_radiomodel VARCHAR2(3),
  st_radiomodel VARCHAR2(16) NOT NULL,
  fg_frequency  VARCHAR2(1) NOT NULL,
  CONSTRAINT pk_props_radio PRIMARY KEY (id_radiomodel)
);


/* 1-6 : item */
CREATE TABLE item(
  id_item     VARCHAR2(3),
  id_category VARCHAR2(3) NOT NULL,
  id_props    VARCHAR2(3) NOT NULL,
  id_owner    VARCHAR2(2) NOT NULL,
  CONSTRAINT pk_item PRIMARY KEY (id_item)
);


/* 1-7 : fk constraints */
ALTER TABLE item ADD CONSTRAINT fk_item_1 FOREIGN KEY (id_category)
  REFERENCES category (id_category);

ALTER TABLE item ADD CONSTRAINT fk_item_2 FOREIGN KEY (id_owner)
  REFERENCES emp (id_emp);


/* *** sample 2 : data creation *** */
BEGIN
  /* emp */
  INSERT INTO emp VALUES('00', '-');
  INSERT INTO emp VALUES('01', 'Hossaen');
  INSERT INTO emp VALUES('02', 'Hussam');
  INSERT INTO emp VALUES('03', 'Nibal');
  INSERT INTO emp VALUES('04', 'Kawthar');

  /* category */
  INSERT INTO category VALUES('000', '-');
  INSERT INTO category VALUES('001', 'Computer');
  INSERT INTO category VALUES('002', 'Television');
  INSERT INTO category VALUES('003', 'Radio');

  /* pc models */
  INSERT INTO props_pc VALUES('000', '-',                0,    0);
  INSERT INTO props_pc VALUES('001', 'Dell Optilex',    500, 128);
  INSERT INTO props_pc VALUES('002', 'Dell Power Edge', 500, 128);
  INSERT INTO props_pc VALUES('003', 'Compaq Presario', 500, 128);
  INSERT INTO props_pc VALUES('004', 'Compaq Ploriant', 333, 256);
  INSERT INTO props_pc VALUES('005', 'Machintosh iMac', 600, 128);

  /* tv models */
  INSERT INTO props_tv VALUES('000', '-',            0);
  INSERT INTO props_tv VALUES('001', 'Sony WEGA',   32);
  INSERT INTO props_tv VALUES('002', 'Panasonic T', 41);
  INSERT INTO props_tv VALUES('003', 'Aiwa A21',    21);

  /* radio models */
  INSERT INTO props_radio VALUES('000', '-',          '0');
  INSERT INTO props_radio VALUES('001', 'Sony Radio', '1');
  INSERT INTO props_radio VALUES('002', 'Aiwa Radio', '2');

  /* item */
  INSERT INTO item VALUES('000', '000', '000', '00');
  INSERT INTO item VALUES('001', '001', '001', '01');
  INSERT INTO item VALUES('002', '001', '002', '02');
  INSERT INTO item VALUES('003', '001', '003', '03');
  INSERT INTO item VALUES('004', '001', '004', '04');
  INSERT INTO item VALUES('005', '001', '005', '01');
  INSERT INTO item VALUES('006', '001', '001', '02');
  INSERT INTO item VALUES('007', '001', '002', '03');
  INSERT INTO item VALUES('008', '001', '003', '04');
  INSERT INTO item VALUES('009', '002', '001', '01');
  INSERT INTO item VALUES('010', '002', '002', '02');
  INSERT INTO item VALUES('011', '002', '003', '03');
  INSERT INTO item VALUES('012', '002', '002', '04');
  INSERT INTO item VALUES('013', '002', '002', '01');
  INSERT INTO item VALUES('014', '002', '002', '02');
  INSERT INTO item VALUES('015', '003', '001', '03');
  INSERT INTO item VALUES('016', '003', '001', '04');
  INSERT INTO item VALUES('017', '003', '001', '01');
  INSERT INTO item VALUES('018', '003', '002', '02');
  INSERT INTO item VALUES('019', '003', '002', '03');
END;
/

COMMIT;


/* sample 3 : trigger creation *** */
CREATE OR REPLACE TRIGGER item_bi
  BEFORE INSERT ON item
  FOR EACH ROW
DECLARE
  CntRec NUMBER;
BEGIN
  IF :NEW.id_category = '001' THEN   -- computer
    SELECT COUNT(*) cnt INTO CntRec FROM props_pc WHERE id_pcmodel = :NEW.id_props;
    IF CntRec = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Relation Error.  No parent record in table [props_pc]');
    END IF;
  ELSIF :NEW.id_category = '002' THEN  -- tv
    SELECT COUNT(*) cnt INTO CntRec FROM props_tv WHERE id_tvmodel = :NEW.id_props;
    IF CntRec = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Relation Error.  No parent record in table [props_tv]');
    END IF;
  ELSIF :NEW.id_category = '003' THEN  -- radio
    SELECT COUNT(*) cnt INTO CntRec FROM props_radio WHERE id_radiomodel = :NEW.id_props;
    IF CntRec = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Relation Error.  No parent record in table [props_radio]');
    END IF;
  END IF;
END;


/* *** sample 4 : check the trigger. *** */

/* insert pc items */
INSERT INTO item VALUES('pc1', '001', '001', '01');
INSERT INTO item VALUES('pc2', '001', '002', '02');
INSERT INTO item VALUES('pc3', '001', '003', '03');
INSERT INTO item VALUES('pc4', '001', '004', '04');
INSERT INTO item VALUES('pc5', '001', '005', '01');
INSERT INTO item VALUES('pc6', '001', '006', '02');

/* insert tv items */
INSERT INTO item VALUES('tv1', '002', '001', '01');
INSERT INTO item VALUES('tv2', '002', '002', '02');
INSERT INTO item VALUES('tv3', '002', '003', '03');
INSERT INTO item VALUES('tv4', '002', '004', '04');
INSERT INTO item VALUES('tv5', '002', '005', '01');
INSERT INTO item VALUES('tv6', '002', '006', '02');

/* insert radio items */
INSERT INTO item VALUES('rd1', '003', '001', '01');
INSERT INTO item VALUES('rd2', '003', '002', '02');
INSERT INTO item VALUES('rd3', '003', '003', '03');
INSERT INTO item VALUES('rd4', '003', '004', '04');
INSERT INTO item VALUES('rd5', '003', '005', '01');
INSERT INTO item VALUES('rd6', '003', '006', '02');


/* *** sample 5 : activation / deactivation *** */
ALTER TRIGGER item_bi ENABLE;
ALTER TRIGGER item_bi DISABLE;


/* *** sample 6 : FOR EACH ROW option *** */

SET SERVEROUTPUT ON


/* 6-1 : test trigger creation - without 'for each row' option */
CREATE OR REPLACE TRIGGER item_bu
  BEFORE UPDATE ON item
BEGIN
  dbms_output.put_line('>> records are about to be inserted.');
END;
/


/* 6-2 : test trigger creation - with 'for each row' option */
CREATE OR REPLACE TRIGGER item_bu
  BEFORE UPDATE ON item
  FOR EACH ROW
BEGIN
  dbms_output.put_line('>> a record is about to be inserted.');
END;
/


/* 6-3 : update some records */
UPDATE item SET id_owner = '01' WHERE id_owner = '03';


