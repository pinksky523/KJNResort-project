
/* Drop Tables */

DROP TABLE t_appliance CASCADE CONSTRAINTS;
DROP TABLE t_condo_reserve CASCADE CONSTRAINTS;
DROP TABLE t_condo CASCADE CONSTRAINTS;
DROP TABLE t_event_attach CASCADE CONSTRAINTS;
DROP TABLE t_event CASCADE CONSTRAINTS;
DROP TABLE t_notice CASCADE CONSTRAINTS;
DROP TABLE t_qna CASCADE CONSTRAINTS;
DROP TABLE t_review_attach CASCADE CONSTRAINTS;
DROP TABLE t_review_reply CASCADE CONSTRAINTS;
DROP TABLE t_review CASCADE CONSTRAINTS;
DROP TABLE t_ticket_buy CASCADE CONSTRAINTS;
DROP TABLE t_member CASCADE CONSTRAINTS;
DROP TABLE t_ticket CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE t_appliance
(
	notice_no number NOT NULL,
	id varchar2(15) NOT NULL,
	career varchar2(400) NOT NULL,
	introduction varchar2(2000) NOT NULL,
	status varchar2(20) NOT NULL,
	reg_date date DEFAULT sysdate
);


CREATE TABLE t_condo
(
	room_type varchar2(1) NOT NULL,
	location varchar2(100) DEFAULT 'E/W빌리지',
	building varchar2(100) DEFAULT 'SG빌딩',
	bed varchar2(40) NOT NULL,
	accept number(20) NOT NULL,
	price number NOT NULL,
	PRIMARY KEY (room_type)
);


CREATE TABLE t_condo_reserve
(
	reserve_no number NOT NULL,
	id varchar2(15) NOT NULL,
	room_type varchar2(1) NOT NULL,
	reserve_date date DEFAULT sysdate,
	status number(1) DEFAULT 0,
	room_no number NOT NULL,
	checkin date NOT NULL,
	checkout date NOT NULL,
	nights number NOT NULL,
	price number NOT NULL,
	PRIMARY KEY (reserve_no)
);


CREATE TABLE t_event
(
	event_no number NOT NULL,
	id varchar2(15) NOT NULL,
	title varchar2(100) NOT NULL,
	event_start date NOT NULL,
	event_end date NOT NULL,
	view_cnt number DEFAULT 0,
	PRIMARY KEY (event_no)
);


CREATE TABLE t_event_attach
(
	event_no number NOT NULL,
	uuid varchar2(1000) NOT NULL,
	upload_path varchar2(500) NOT NULL,
	file_name varchar2(100) NOT NULL
);


CREATE TABLE t_member
(
	id varchar2(15) NOT NULL,
	pw varchar2(15) NOT NULL,
	name varchar2(10) NOT NULL,
	phone_number varchar2(13) NOT NULL UNIQUE,
	birth date NOT NULL,
	gender char(1) DEFAULT 'M' NOT NULL,
	address varchar2(200) NOT NULL,
	state char(1) DEFAULT 'O' NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE t_notice
(
	notice_no number NOT NULL,
	id varchar2(15) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	reg_date date DEFAULT sysdate,
	view_cnt number DEFAULT 0,
	top_check number(1) DEFAULT 0,
	PRIMARY KEY (notice_no)
);


CREATE TABLE t_qna
(
	qna_no number NOT NULL,
	id varchar2(15) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	reg_date date DEFAULT sysdate,
	answer varchar2(4000),
	answer_reg_date date DEFAULT sysdate,
	PRIMARY KEY (qna_no)
);


CREATE TABLE t_review
(
	review_no number NOT NULL,
	id varchar2(15) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	reg_date date DEFAULT sysdate,
	view_cnt number DEFAULT 0,
	status varchar2(20) NOT NULL,
	category varchar2(40) NOT NULL,
	grade number(10) NOT NULL,
	PRIMARY KEY (review_no)
);


CREATE TABLE t_review_attach
(
	review_no number NOT NULL,
	uuid varchar2(1000) NOT NULL,
	upload_path varchar2(500) NOT NULL,
	file_name varchar2(100) NOT NULL
);


CREATE TABLE t_review_reply
(
	reply_no number NOT NULL,
	id varchar2(15) NOT NULL,
	review_no number NOT NULL,
	reply varchar2(400) NOT NULL,
	reply_date date DEFAULT sysdate,
	PRIMARY KEY (reply_no)
);


CREATE TABLE t_ticket
(
	type varchar2(40) NOT NULL,
	price number,
	PRIMARY KEY (type)
);


CREATE TABLE t_ticket_buy
(
	ticket_no number NOT NULL,
	id varchar2(15) NOT NULL,
	type varchar2(40) NOT NULL,
	buy_date date DEFAULT sysdate,
	lift_amount number,
	tool_amount number,
	status varchar2(40) NOT NULL,
	review number(1) DEFAULT 0,
	PRIMARY KEY (ticket_no)
);



/* Create Foreign Keys */

ALTER TABLE t_condo_reserve
	ADD FOREIGN KEY (room_type)
	REFERENCES t_condo (room_type)
;


ALTER TABLE t_event_attach
	ADD FOREIGN KEY (event_no)
	REFERENCES t_event (event_no)
;


ALTER TABLE t_appliance
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
;


ALTER TABLE t_condo_reserve
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
;


ALTER TABLE t_event
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
;


ALTER TABLE t_notice
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
;


ALTER TABLE t_qna
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
;


ALTER TABLE t_review
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
;


ALTER TABLE t_review_reply
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
;


ALTER TABLE t_ticket_buy
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
;


ALTER TABLE t_appliance
	ADD FOREIGN KEY (notice_no)
	REFERENCES t_notice (notice_no)
;


ALTER TABLE t_review_attach
	ADD FOREIGN KEY (review_no)
	REFERENCES t_review (review_no)
;


ALTER TABLE t_review_reply
	ADD FOREIGN KEY (review_no)
	REFERENCES t_review (review_no)
;


ALTER TABLE t_ticket_buy
	ADD FOREIGN KEY (type)
	REFERENCES t_ticket (type)
;



