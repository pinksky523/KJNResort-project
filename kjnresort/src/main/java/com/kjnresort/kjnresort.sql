<<<<<<< HEAD

/* Drop Tables */

DROP TABLE t_appliance CASCADE CONSTRAINTS;
DROP TABLE t_condo_reserve CASCADE CONSTRAINTS;
DROP TABLE t_condo CASCADE CONSTRAINTS;
DROP TABLE t_event_attach CASCADE CONSTRAINTS;
DROP TABLE t_event CASCADE CONSTRAINTS;
DROP TABLE t_notice CASCADE CONSTRAINTS;
DROP TABLE t_qna CASCADE CONSTRAINTS;
DROP TABLE t_recruit CASCADE CONSTRAINTS;
DROP TABLE t_review_attach CASCADE CONSTRAINTS;
DROP TABLE t_review_reply CASCADE CONSTRAINTS;
DROP TABLE t_review CASCADE CONSTRAINTS;
DROP TABLE t_ticket_buy CASCADE CONSTRAINTS;
DROP TABLE t_member CASCADE CONSTRAINTS;
DROP TABLE t_ticket CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE t_appliance
(
	id varchar2(15) NOT NULL,
	recruitno number NOT NULL,
	career varchar2(800) NOT NULL,
	introduction varchar2(2000) NOT NULL,
	status varchar2(20) NOT NULL,
	regdate date DEFAULT sysdate
);


CREATE TABLE t_condo
(
	roomtype varchar2(1) NOT NULL,
	location varchar2(100) DEFAULT 'E/W빌리지',
	building varchar2(100) DEFAULT 'SG빌딩',
	bed varchar2(40) NOT NULL,
	accept number(20) NOT NULL,
	price number NOT NULL,
	PRIMARY KEY (roomtype)
);


CREATE TABLE t_condo_reserve
(
	reserveno number NOT NULL,
	id varchar2(15) NOT NULL,
	roomtype varchar2(1) NOT NULL,
	reservedate date DEFAULT sysdate,
	status number(1) DEFAULT 0,
	roomno number NOT NULL,
	checkin date NOT NULL,
	checkout date NOT NULL,
	nights number NOT NULL,
	price number NOT NULL,
	review number(1) DEFAULT 0,
	PRIMARY KEY (reserveno)
);


CREATE TABLE t_event
(
	eventno number NOT NULL,
	id varchar2(15) NOT NULL,
	title varchar2(100) NOT NULL,
	eventstart date NOT NULL,
	eventend date NOT NULL,
	viewcnt number DEFAULT 0,
	PRIMARY KEY (eventno)
);


CREATE TABLE t_event_attach
(
	eventno number NOT NULL,
	uuid varchar2(1000) NOT NULL,
	uploadpath varchar2(500) NOT NULL,
	filename varchar2(100) NOT NULL
);


CREATE TABLE t_member
(
	id varchar2(15) NOT NULL,
	pw varchar2(15) NOT NULL,
	name varchar2(10) NOT NULL,
	phonenumber varchar2(13) NOT NULL UNIQUE,
	birth date NOT NULL,
	gender char(1) DEFAULT 'M' NOT NULL,
	address varchar2(200) NOT NULL,
	status number(1) DEFAULT 0 NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE t_notice
(
	noticeno number NOT NULL,
	id varchar2(15) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	regdate date DEFAULT sysdate,
	viewcnt number DEFAULT 0,
	topcheck number(1) DEFAULT 0,
	PRIMARY KEY (noticeno)
);


CREATE TABLE t_qna
(
	qna_no number NOT NULL,
	id varchar2(15) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	regdate date DEFAULT sysdate,
	answer varchar2(4000),
	answerregdate date DEFAULT sysdate,
	PRIMARY KEY (qna_no)
);


CREATE TABLE t_recruit
(
	recruitno number NOT NULL,
	id varchar2(15) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	regdate date DEFAULT sysdate,
	status varchar2(20) NOT NULL,
	deadline date NOT NULL,
	PRIMARY KEY (recruitno)
);


CREATE TABLE t_review
(
	reviewno number NOT NULL,
	id varchar2(15) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	regdate date DEFAULT sysdate,
	viewcnt number DEFAULT 0,
	category varchar2(40) NOT NULL,
	grade number(10) NOT NULL,
	-- 예약 | 이용권
	useno number NOT NULL,
	PRIMARY KEY (reviewno)
);


CREATE TABLE t_review_attach
(
	reviewno number NOT NULL,
	uuid varchar2(1000) NOT NULL,
	uploadpath varchar2(500) NOT NULL,
	filename varchar2(100) NOT NULL
);


CREATE TABLE t_review_reply
(
	reply_no number NOT NULL,
	id varchar2(15) NOT NULL,
	reviewno number NOT NULL,
	reply varchar2(400) NOT NULL,
	replydate date DEFAULT sysdate,
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
	ticketno number NOT NULL,
	id varchar2(15) NOT NULL,
	type varchar2(40) NOT NULL,
	buydate date DEFAULT sysdate,
	liftamount number,
	toolamount number,
	status number(1) NOT NULL,
	review number(1) DEFAULT 0,
	PRIMARY KEY (ticketno)
);



/* Create Foreign Keys */

ALTER TABLE t_condo_reserve
	ADD FOREIGN KEY (roomtype)
	REFERENCES t_condo (roomtype)
;


ALTER TABLE t_event_attach
	ADD FOREIGN KEY (eventno)
	REFERENCES t_event (eventno)
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


ALTER TABLE t_recruit
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
	ADD FOREIGN KEY (recruitno)
	REFERENCES t_recruit (recruitno)
;


ALTER TABLE t_review_attach
	ADD FOREIGN KEY (reviewno)
	REFERENCES t_review (reviewno)
;


ALTER TABLE t_review_reply
	ADD FOREIGN KEY (reviewno)
	REFERENCES t_review (reviewno)
;


ALTER TABLE t_ticket_buy
	ADD FOREIGN KEY (type)
	REFERENCES t_ticket (type)
;



/* Comments */

COMMENT ON COLUMN t_review.useno IS '예약 | 이용권';



=======

/* Drop Tables */

DROP TABLE t_appliance CASCADE CONSTRAINTS;
DROP TABLE t_condo_reserve CASCADE CONSTRAINTS;
DROP TABLE t_condo CASCADE CONSTRAINTS;
DROP TABLE t_event_attach CASCADE CONSTRAINTS;
DROP TABLE t_event CASCADE CONSTRAINTS;
DROP TABLE t_notice CASCADE CONSTRAINTS;
DROP TABLE t_qna CASCADE CONSTRAINTS;
DROP TABLE t_recruit CASCADE CONSTRAINTS;
DROP TABLE t_review_attach CASCADE CONSTRAINTS;
DROP TABLE t_review_reply CASCADE CONSTRAINTS;
DROP TABLE t_review CASCADE CONSTRAINTS;
DROP TABLE t_ticket_buy CASCADE CONSTRAINTS;
DROP TABLE t_member CASCADE CONSTRAINTS;
DROP TABLE t_ticket CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE t_appliance
(
	id varchar2(15) NOT NULL,
	recruitno number NOT NULL,
	career varchar2(800) NOT NULL,
	introduction varchar2(2000) NOT NULL,
	status varchar2(20) NOT NULL,
	regdate date DEFAULT sysdate
);


CREATE TABLE t_condo
(
	roomtype varchar2(1) NOT NULL,
	location varchar2(100) DEFAULT 'E/W빌리지',
	building varchar2(100) DEFAULT 'SG빌딩',
	bed varchar2(40) NOT NULL,
	accept number(20) NOT NULL,
	price number NOT NULL,
	PRIMARY KEY (roomtype)
);


CREATE TABLE t_condo_reserve
(
	reserveno number NOT NULL,
	id varchar2(15) NOT NULL,
	roomtype varchar2(1) NOT NULL,
	reservedate date DEFAULT sysdate,
	status number(1) DEFAULT 0,
	roomno number NOT NULL,
	checkin date NOT NULL,
	checkout date NOT NULL,
	nights number NOT NULL,
	price number NOT NULL,
	review number(1) DEFAULT 0,
	PRIMARY KEY (reserveno)
);


CREATE TABLE t_event
(
	eventno number NOT NULL,
	id varchar2(15) NOT NULL,
	title varchar2(100) NOT NULL,
	eventstart date NOT NULL,
	eventend date NOT NULL,
	viewcnt number DEFAULT 0,
	PRIMARY KEY (eventno)
);


CREATE TABLE t_event_attach
(
	eventno number NOT NULL,
	uuid varchar2(1000) NOT NULL,
	uploadpath varchar2(500) NOT NULL,
	filename varchar2(100) NOT NULL
);


CREATE TABLE t_member
(
	id varchar2(15) NOT NULL,
	pw varchar2(15) NOT NULL,
	name varchar2(10) NOT NULL,
	phonenumber varchar2(13) NOT NULL UNIQUE,
	birth date NOT NULL,
	gender char(1) DEFAULT 'M' NOT NULL,
	address varchar2(200) NOT NULL,
	status number(1) DEFAULT 0 NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE t_notice
(
	noticeno number NOT NULL,
	id varchar2(15) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	regdate date DEFAULT sysdate,
	viewcnt number DEFAULT 0,
	topcheck number(1) DEFAULT 0,
	PRIMARY KEY (noticeno)
);


CREATE TABLE t_qna
(
	qnano number NOT NULL,
	id varchar2(15) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	regdate date DEFAULT sysdate,
	answer varchar2(4000),
	answerregdate date DEFAULT sysdate,
	PRIMARY KEY (qnano)
);


CREATE TABLE t_recruit
(
	recruitno number NOT NULL,
	id varchar2(15) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	regdate date DEFAULT sysdate,
	status varchar2(20) NOT NULL,
	deadline date NOT NULL,
	PRIMARY KEY (recruitno)
);


CREATE TABLE t_review
(
	reviewno number NOT NULL,
	id varchar2(15) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	regdate date DEFAULT sysdate,
	viewcnt number DEFAULT 0,
	category varchar2(40) NOT NULL,
	grade number(10) NOT NULL,
	-- 예약 | 이용권
	useno number NOT NULL,
	PRIMARY KEY (reviewno)
);


CREATE TABLE t_review_attach
(
	reviewno number NOT NULL,
	uuid varchar2(1000) NOT NULL,
	uploadpath varchar2(500) NOT NULL,
	filename varchar2(100) NOT NULL
);


CREATE TABLE t_review_reply
(
	reply_no number NOT NULL,
	id varchar2(15) NOT NULL,
	reviewno number NOT NULL,
	reply varchar2(400) NOT NULL,
	replydate date DEFAULT sysdate,
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
	ticketno number NOT NULL,
	id varchar2(15) NOT NULL,
	type varchar2(40) NOT NULL,
	buydate date DEFAULT sysdate,
	liftamount number,
	toolamount number,
	status number(1) NOT NULL,
	review number(1) DEFAULT 0,
	PRIMARY KEY (ticketno)
);



/* Create Foreign Keys */

ALTER TABLE t_condo_reserve
	ADD FOREIGN KEY (roomtype)
	REFERENCES t_condo (roomtype)
;


ALTER TABLE t_event_attach
	ADD FOREIGN KEY (eventno)
	REFERENCES t_event (eventno)
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


ALTER TABLE t_recruit
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
	ADD FOREIGN KEY (recruitno)
	REFERENCES t_recruit (recruitno)
;


ALTER TABLE t_review_attach
	ADD FOREIGN KEY (reviewno)
	REFERENCES t_review (reviewno)
;


ALTER TABLE t_review_reply
	ADD FOREIGN KEY (reviewno)
	REFERENCES t_review (reviewno)
;


ALTER TABLE t_ticket_buy
	ADD FOREIGN KEY (type)
	REFERENCES t_ticket (type)
;



/* Comments */

COMMENT ON COLUMN t_review.useno IS '예약 | 이용권';



>>>>>>> branch 'master' of https://github.com/jsnow0819/Project.git
