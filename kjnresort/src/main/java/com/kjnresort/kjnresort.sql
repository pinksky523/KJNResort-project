
/* Drop Tables */

DROP TABLE t_appliance CASCADE CONSTRAINTS;
DROP TABLE t_condo_reserve CASCADE CONSTRAINTS;
DROP TABLE t_condo CASCADE CONSTRAINTS;
DROP TABLE t_event_attach CASCADE CONSTRAINTS;
DROP TABLE t_event CASCADE CONSTRAINTS;
DROP TABLE t_member_auth CASCADE CONSTRAINTS;
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
	applianceNo number NOT NULL,
	id varchar2(20) NOT NULL,
	recruitNo number NOT NULL,
	career varchar2(800) NOT NULL,
	introduction varchar2(2000) NOT NULL,
	status varchar2(20) NOT NULL,
	regDate date,
	PRIMARY KEY (applianceNo)
);


CREATE TABLE t_condo
(
	roomType varchar2(1) NOT NULL,
	location varchar2(100) DEFAULT 'E/W빌리지',
	building varchar2(100) DEFAULT 'SG빌딩',
	bed varchar2(40) NOT NULL,
	accept number(20) NOT NULL,
	price number NOT NULL,
	PRIMARY KEY (roomType)
);


CREATE TABLE t_condo_reserve
(
	reserveNo number NOT NULL,
	id varchar2(20) NOT NULL,
	roomType varchar2(1) NOT NULL,
	reserveDate date NOT NULL,
	status number(1) DEFAULT 0,
	roomNo number NOT NULL,
	checkIn date NOT NULL,
	checkOut date NOT NULL,
	nights number NOT NULL,
	price number NOT NULL,
	review number(1) DEFAULT 0,
	PRIMARY KEY (reserveNo)
);


CREATE TABLE t_event
(
	eventNo number NOT NULL,
	id varchar2(20) NOT NULL,
	title varchar2(100) NOT NULL,
	eventStart date NOT NULL,
	eventEnd date NOT NULL,
	viewCnt number DEFAULT 0,
	PRIMARY KEY (eventNo)
);


CREATE TABLE t_event_attach
(
	eventNo number NOT NULL,
	uuid varchar2(1000) NOT NULL,
	uploadPath varchar2(500) NOT NULL,
	fileName varchar2(100) NOT NULL
);


CREATE TABLE t_member
(
	id varchar2(20) NOT NULL,
	pw varchar2(100) NOT NULL,
	name varchar2(20) NOT NULL,
	phoneNumber varchar2(15) NOT NULL UNIQUE,
	birth varchar2(20) NOT NULL,
	gender char(1) DEFAULT 'M' NOT NULL,
	address varchar2(200) NOT NULL,
	status number(1) DEFAULT 1 NOT NULL,
	regDate date DEFAULT SYSDATE,
	PRIMARY KEY (id)
);


CREATE TABLE t_member_auth
(
	id varchar2(20) NOT NULL,
	auth varchar2(50) DEFAULT 'ROLE_MEMBER' NOT NULL
);


CREATE TABLE t_notice
(
	noticeNo number NOT NULL,
	id varchar2(20) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	regDate date DEFAULT sysdate,
	viewCnt number DEFAULT 0,
	topCheck number(1) DEFAULT 0,
	PRIMARY KEY (noticeNo)
);


CREATE TABLE t_qna
(
	qnaNo number NOT NULL,
	id varchar2(20) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	regdate date DEFAULT sysdate,
	answer varchar2(4000),
	answerRegDate date,
	PRIMARY KEY (qnaNo)
);


CREATE TABLE t_recruit
(
	recruitno number NOT NULL,
	id varchar2(20) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	regDate date DEFAULT sysdate,
	status varchar2(20) NOT NULL,
	deadLine date NOT NULL,
	PRIMARY KEY (recruitno)
);


CREATE TABLE t_review
(
	reviewNo number NOT NULL,
	id varchar2(20) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	regDate date DEFAULT sysdate,
	viewCnt number DEFAULT 0 NOT NULL,
	category varchar2(40) NOT NULL,
	grade number(10) NOT NULL,
	-- 예약 | 이용권
	useNo number NOT NULL,
	PRIMARY KEY (reviewNo)
);


CREATE TABLE t_review_attach
(
	reviewNo number NOT NULL,
	uuid varchar2(1000) NOT NULL,
	uploadPath varchar2(500) NOT NULL,
	fileName varchar2(100) NOT NULL
);


CREATE TABLE t_review_reply
(
	replyNo number NOT NULL,
	id varchar2(20) NOT NULL,
	reviewNo number NOT NULL,
	reply varchar2(400) NOT NULL,
	replyDate date DEFAULT sysdate,
	PRIMARY KEY (replyNo)
);


CREATE TABLE t_ticket
(
	type varchar2(40) NOT NULL,
	price number NOT NULL,
	PRIMARY KEY (type)
);


CREATE TABLE t_ticket_buy
(
	ticketNo number NOT NULL,
	id varchar2(20) NOT NULL,
	type varchar2(40) NOT NULL,
	buyDate date DEFAULT sysdate,
	liftAmount number NOT NULL,
	toolAmount number NOT NULL,
	status number(1) DEFAULT 0,
	review number(1) DEFAULT 0,
	PRIMARY KEY (ticketNo)
);



/* Create Foreign Keys */

ALTER TABLE t_condo_reserve
	ADD FOREIGN KEY (roomType)
	REFERENCES t_condo (roomType)
;


ALTER TABLE t_event_attach
	ADD FOREIGN KEY (eventNo)
	REFERENCES t_event (eventNo)
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


ALTER TABLE t_member_auth
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
	ADD FOREIGN KEY (recruitNo)
	REFERENCES t_recruit (recruitno)
;


ALTER TABLE t_review_attach
	ADD FOREIGN KEY (reviewNo)
	REFERENCES t_review (reviewNo)
;


ALTER TABLE t_review_reply
	ADD FOREIGN KEY (reviewNo)
	REFERENCES t_review (reviewNo)
;


ALTER TABLE t_ticket_buy
	ADD FOREIGN KEY (type)
	REFERENCES t_ticket (type)
;



/* Comments */

COMMENT ON COLUMN t_review.useNo IS '예약 | 이용권';



