DROP SEQUENCE PKp;
DROP SEQUENCE PKc;
DROP SEQUENCE PKw;
DROP SEQUENCE PKet;
DROP SEQUENCE PKsp;
DROP SEQUENCE PKs;
DROP SEQUENCE PKsc;
DROP SEQUENCE PKst;
DROP SEQUENCE PKt;
DROP SEQUENCE PKe;
DROP SEQUENCE PKeu;
DROP SEQUENCE PKrp;
DROP SEQUENCE PKse;

DROP TABLE patient;
DROP TABLE chip;
DROP TABLE ward;
DROP TABLE equiptype;
DROP TABLE staffposition;
DROP TABLE staff;
DROP TABLE staffchip;
DROP TABLE stafftreatment;
DROP TABLE treatment;
DROP TABLE equipment;
DROP TABLE equipmentusage;
DROP TABLE restperiod;
DROP TABLE sector;


CREATE TABLE patient (
  patientID NUMBER,
  patientfirstname VARCHAR2(50 CHAR),
  patientsurname VARCHAR2(50 CHAR),
  CONSTRAINT patient_pk PRIMARY KEY (patientID)
);

COMMIT;

--CREATE INDEX PKp ON  patient (patientID);

CREATE TABLE chip (
  chipID NUMBER,
  chipnumber NUMBER,
  chipnewactivation TIMESTAMP,
  chipdeactivation TIMESTAMP,
  CONSTRAINT chip_pk PRIMARY KEY (chipID)
);

COMMIT;

--CREATE INDEX PKc ON chip (chipID);

CREATE TABLE ward (
  wardID NUMBER,
  roomnumber NUMBER,
  CONSTRAINT ward_pk PRIMARY KEY (wardID)
);

COMMIT;

--CREATE INDEX PKw ON  ward (wardID);

CREATE TABLE equiptype (
  equiptypeID NUMBER,
  equipmentType VARCHAR2(50 CHAR),
  CONSTRAINT equiptype_pk PRIMARY KEY (equiptypeID)
);

COMMIT;

--CREATE INDEX PKet ON  equiptype (equiptypeID);

CREATE TABLE staffposition (
  staffpositionID NUMBER,
  staffposition VARCHAR2(50 CHAR),
  CONSTRAINT staffposition_pk PRIMARY KEY (staffpositionID)
);

COMMIT;

--CREATE INDEX PKsp ON  staffposition (staffpositionID);

CREATE TABLE staff (
  staffID NUMBER,
  staffFirstname VARCHAR2(50 CHAR),
  staffSurname VARCHAR2(50 CHAR),
  staffpositionID NUMBER,
  CONSTRAINT staff_pk PRIMARY KEY (staffID)
);

COMMIT;

--CREATE INDEX PKs ON  staff (staffID);

--CREATE INDEX FK ON  staff (staffpositionID);

CREATE TABLE staffchip (
  staffchipID NUMBER,
  staffID NUMBER,
  chipID NUMBER,
  CONSTRAINT staffchip_pk PRIMARY KEY (staffchipID)
);

COMMIT;

--CREATE INDEX PKsc ON  staffchip (staffchipID);

--CREATE INDEX FK ON  staffchip (staffID, chipID);

CREATE TABLE stafftreatment (
  stafftreatmentID NUMBER,
  staffID NUMBER,
  treatmentID NUMBER,
  CONSTRAINT stafftreatment_pk PRIMARY KEY (stafftreatmentID)
);

COMMIT;

--CREATE INDEX PKst ON  stafftreatment (stafftreatmentID);

--CREATE INDEX FK ON  stafftreatment (staffID, treatmentID);

CREATE TABLE treatment (
  treatmentID NUMBER,
  patientID NUMBER,
  staffID NUMBER,
  treatmentmethod VARCHAR2(50 CHAR),
  treatmentduration TIMESTAMP,
  CONSTRAINT treatment_pk PRIMARY KEY (treatmentID)
);

COMMIT; 

--CREATE INDEX PKt ON  treatment (treatmentID);

--CREATE INDEX FK ON  treatment (patientID, staffID);

CREATE TABLE equipment (
  equipmentID NUMBER,
  equiptypeID NUMBER,
  chipID NUMBER,
  CONSTRAINT equipment_pk PRIMARY KEY (equipmentID)
);

COMMIT;

--CREATE INDEX PKe ON  equipment (equipmentID);

--CREATE INDEX FK ON  equipment (equiptypeID, chipID);

CREATE TABLE equipmentusage (
  equipmentusageID NUMBER,
  patientID NUMBER,
  equipmentID NUMBER,
  startTime TIMESTAMP,
  endTime TIMESTAMP,
  CONSTRAINT equipmentusage_pk PRIMARY KEY (equipmentusageID)
);

COMMIT;

--CREATE INDEX PKeu ON  equipmentusage (equipmentusageID);

--CREATE INDEX FK ON  equipmentusage (patientID, equipmentID);

CREATE TABLE restperiod (
  restperiodID NUMBER,
  patientID NUMBER,
  chipID NUMBER,
  stayperiod TIMESTAMP,
  dischargeperiod TIMESTAMP,
  CONSTRAINT restperiod_pk PRIMARY KEY (restperiodID)
);

COMMIT;

--CREATE INDEX PKrp ON  restperiod (restperiodID);

--CREATE INDEX FK ON  restperiod (patientID, chipID);

CREATE TABLE sector (
  sectorID NUMBER,
  wardID NUMBER,
  patientID NUMBER,
  CONSTRAINT sector_pk PRIMARY KEY (sectorID)
);

COMMIT;

--CREATE INDEX PKse ON  sector (sectorID);

--CREATE INDEX FK ON  sector (wardID, patientID);


CREATE SEQUENCE PKc START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PKw START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PKet START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PKsp START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PKs START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PKsc START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PKst START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PKt START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PKe START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PKeu START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PKrp START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PKse START WITH 1 INCREMENT BY 1;

COMMIT;

ALTER TABLE staffchip ADD CONSTRAINT staffchip_staff_fk FOREIGN KEY (staffID) REFERENCES staff (staffID);
ALTER TABLE staffchip ADD CONSTRAINT staffchip_chip_fk FOREIGN KEY (chipID) REFERENCES chip (chipID);
ALTER TABLE stafftreatment ADD CONSTRAINT stafftreatment_staff_fk FOREIGN KEY (staffID) REFERENCES staff (staffID);
ALTER TABLE stafftreatment ADD CONSTRAINT stafftreatment_treatment_fk FOREIGN KEY (treatmentID) REFERENCES treatment (treatmentID);
ALTER TABLE staff ADD CONSTRAINT staff_staffposition_fk FOREIGN KEY (staffpositionID) REFERENCES staffposition (staffpositionID);
ALTER TABLE treatment ADD CONSTRAINT treatment_patient_fk FOREIGN KEY (patientID) REFERENCES patient (patientID);
ALTER TABLE treatment ADD CONSTRAINT treatment_staff_fk FOREIGN KEY (staffID) REFERENCES staff (staffID);
ALTER TABLE sector ADD CONSTRAINT sector_ward_fk FOREIGN KEY (wardID) REFERENCES ward (wardID);
ALTER TABLE sector ADD CONSTRAINT sector_patient_fk FOREIGN KEY (patientID) REFERENCES patient (patientID);
ALTER TABLE restperiod ADD CONSTRAINT restperiod_patient_fk FOREIGN KEY (patientID) REFERENCES patient (patientID);
ALTER TABLE restperiod ADD CONSTRAINT restperiod_chip_fk FOREIGN KEY (chipID) REFERENCES chip (chipID);
ALTER TABLE equipment ADD CONSTRAINT equipment_equiptype_fk FOREIGN KEY (equiptypeID) REFERENCES equiptype (equiptypeID);
ALTER TABLE equipment ADD CONSTRAINT equipment_chip_fk FOREIGN KEY (chipID) REFERENCES chip (chipID);
ALTER TABLE equipmentusage ADD CONSTRAINT equipmentusage_patient_fk FOREIGN KEY (patientID) REFERENCES patient (patientID);
ALTER TABLE equipmentusage ADD CONSTRAINT equipmentusage_equipment_fk FOREIGN KEY (equipmentID) REFERENCES equipment (equipmentID);

