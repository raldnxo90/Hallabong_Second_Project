CREATE TABLE cart (
    cust_id VARCHAR2(20) NOT NULL,
    prod_no VARCHAR2(20) NOT NULL,
    qnty    NUMBER NOT NULL,
    reg_tm  TIMESTAMP DEFAULT SYSTIMESTAMP
);

CREATE TABLE cat (
    no   VARCHAR2(20) DEFAULT 'CAT' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF2'),
    name VARCHAR2(40) NOT NULL
);

ALTER TABLE cat ADD CONSTRAINT cat_pk PRIMARY KEY ( no );

CREATE TABLE cust (
    id      VARCHAR2(20) NOT NULL,
    pw      VARCHAR2(100) NOT NULL,
    name    VARCHAR2(20) NOT NULL,
    email   VARCHAR2(40) NOT NULL,
    tel     VARCHAR2(20) NOT NULL,
    addr    VARCHAR2(100) NOT NULL,
    gender  CHAR(1),
    dob     DATE,
    reg_tm  TIMESTAMP DEFAULT SYSTIMESTAMP,
    quit_tm TIMESTAMP DEFAULT SYSTIMESTAMP,
    sta     VARCHAR2(20) NOT NULL
);

ALTER TABLE cust ADD CONSTRAINT cust_pk PRIMARY KEY ( id );

CREATE TABLE dlvy (
    no        VARCHAR2(20) DEFAULT 'DLVY' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF2'),
    send_name VARCHAR2(20) NOT NULL,
    send_tel  VARCHAR2(20) NOT NULL,
    send_addr VARCHAR2(100) NOT NULL,
    recv_name VARCHAR2(20) NOT NULL,
    recv_tel  VARCHAR2(20) NOT NULL,
    recv_addr VARCHAR2(100) NOT NULL,
    fee       NUMBER NOT NULL,
    reg_tm    TIMESTAMP DEFAULT SYSTIMESTAMP,
    dep_tm    TIMESTAMP DEFAULT SYSTIMESTAMP,
    arr_tm    TIMESTAMP DEFAULT SYSTIMESTAMP,
    sta       VARCHAR2(20) NOT NULL,
    ord_no    VARCHAR2(20) NOT NULL
);

ALTER TABLE dlvy ADD CONSTRAINT dlvy_pk PRIMARY KEY ( no );

CREATE TABLE ord (
    no        VARCHAR2(20) DEFAULT 'ORD' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF2'),
    cust_id   VARCHAR2(20),
    type      VARCHAR2(20) NOT NULL,
    ordr_name VARCHAR2(20) NOT NULL,
    ordr_tel  VARCHAR2(20) NOT NULL,
    ordr_addr VARCHAR2(100) NOT NULL,
    recv_name VARCHAR2(20) NOT NULL,
    recv_tel  VARCHAR2(20) NOT NULL,
    recv_addr VARCHAR2(100) NOT NULL,
    pay_meth  VARCHAR2(20) NOT NULL,
    dlvy_fee  NUMBER NOT NULL,
    cont      VARCHAR2(100),
    reg_tm    TIMESTAMP DEFAULT SYSTIMESTAMP,
    stlm_tm   TIMESTAMP DEFAULT SYSTIMESTAMP,
    sta       VARCHAR2(20)
);

ALTER TABLE ord ADD CONSTRAINT ord_pk PRIMARY KEY ( no );

CREATE TABLE ord_dtl (
    ord_no    VARCHAR2(20) NOT NULL,
    prod_no   VARCHAR2(20) NOT NULL,
    prod_cost NUMBER NOT NULL,
    prod_sp   NUMBER NOT NULL,
    prod_qnty NUMBER NOT NULL
);

CREATE TABLE prod (
    no     VARCHAR2(20) DEFAULT 'PROD' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF2'),
    fs     CHAR(1) NOT NULL,
    name   VARCHAR2(100) NOT NULL,
    cost   NUMBER NOT NULL,
    sp     NUMBER NOT NULL,
    s_img  VARCHAR2(100),
    l_img  VARCHAR2(100),
    cat_no VARCHAR2(20) NOT NULL,
    reg_tm TIMESTAMP DEFAULT SYSTIMESTAMP
);

ALTER TABLE prod ADD CONSTRAINT prod_pk PRIMARY KEY ( no );

CREATE TABLE qa (
    no       VARCHAR2(20) DEFAULT 'QA' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF2'),
    cust_id  VARCHAR2(20) NOT NULL,
    q        VARCHAR2(2000),
    q_reg_tm TIMESTAMP DEFAULT SYSTIMESTAMP,
    a        VARCHAR2(2000),
    a_reg_tm TIMESTAMP DEFAULT SYSTIMESTAMP,
    sta      VARCHAR2(20) NOT NULL
);

ALTER TABLE qa ADD CONSTRAINT qa_pk PRIMARY KEY ( no );

CREATE TABLE rev (
    no      VARCHAR2(20) DEFAULT 'REV' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF2'),
    cust_id VARCHAR2(20) NOT NULL,
    prod_no VARCHAR2(20) NOT NULL,
    cont    VARCHAR2(4000),
    reg_tm  TIMESTAMP DEFAULT SYSTIMESTAMP
);

ALTER TABLE rev ADD CONSTRAINT rev_pk PRIMARY KEY ( no );

CREATE TABLE admin (
    id VARCHAR2(20) NOT NULL,
    pw VARCHAR2(100) NOT NULL
);

ALTER TABLE admin ADD CONSTRAINT admin_pk PRIMARY KEY ( id );

CREATE TABLE noti (
    no     VARCHAR2(20) DEFAULT 'NOTI' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF2'),
    tit    VARCHAR2(100) NOT NULL,
    cont   VARCHAR2(2000),
    reg_tm TIMESTAMP DEFAULT SYSTIMESTAMP
);

ALTER TABLE noti ADD CONSTRAINT noti_pk PRIMARY KEY ( no );

ALTER TABLE cart
    ADD CONSTRAINT cart_cust_fk FOREIGN KEY ( cust_id )
        REFERENCES cust ( id );

ALTER TABLE cart
    ADD CONSTRAINT cart_prod_fk FOREIGN KEY ( prod_no )
        REFERENCES prod ( no );

ALTER TABLE dlvy
    ADD CONSTRAINT dlvy_ord_fk FOREIGN KEY ( ord_no )
        REFERENCES ord ( no );

ALTER TABLE ord
    ADD CONSTRAINT ord_cust_fk FOREIGN KEY ( cust_id )
        REFERENCES cust ( id );

ALTER TABLE ord_dtl
    ADD CONSTRAINT ord_dtl_ord_fk FOREIGN KEY ( ord_no )
        REFERENCES ord ( no );

ALTER TABLE ord_dtl
    ADD CONSTRAINT ord_dtl_prod_fk FOREIGN KEY ( prod_no )
        REFERENCES prod ( no );

ALTER TABLE prod
    ADD CONSTRAINT prod_cat_fk FOREIGN KEY ( cat_no )
        REFERENCES cat ( no );

ALTER TABLE qa
    ADD CONSTRAINT qa_cust_fk FOREIGN KEY ( cust_id )
        REFERENCES cust ( id );

ALTER TABLE rev
    ADD CONSTRAINT rev_cust_fk FOREIGN KEY ( cust_id )
        REFERENCES cust ( id );

ALTER TABLE rev
    ADD CONSTRAINT rev_prod_fk FOREIGN KEY ( prod_no )
        REFERENCES prod ( no );
