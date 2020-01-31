
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
	name varchar2(20) NOT NULL,
	phoneNumber varchar2(20) NOT NULL,
	address varchar2(200) NOT NULL,
	career varchar2(800) ,
	introduction varchar2(2000) ,
	status varchar2(20) NOT NULL,
	regDate date,
	CONSTRAINT pk_applianceNo PRIMARY KEY(applianceNo)
	
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
	eventStart varchar2(20) NOT NULL,
	eventEnd varchar2(20) NOT NULL,
	viewCnt number DEFAULT 0,
	CONSTRAINT idx_event_eventno PRIMARY KEY(eventno)
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
	phoneNumber varchar2(20) NOT NULL UNIQUE,
	birth varchar2(20) NOT NULL,
	gender char(1) DEFAULT 'M' NOT NULL,
	address varchar2(200) NOT NULL,
	status number(1) DEFAULT 1 NOT NULL,
	regDate date DEFAULT SYSDATE,
	CONSTRAINT idx_member_id PRIMARY KEY(id)
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
	CONSTRAINT pk_noticeNo PRIMARY KEY(noticeNo)
);


CREATE TABLE t_qna
(
	qnaNo number NOT NULL,
	category varchar2(1), 
	id varchar2(20) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(4000) NOT NULL,
	regdate date DEFAULT sysdate,
	answer varchar2(4000),
	answerRegDate date,
	isAnswered char(1),
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
	CONSTRAINT pk_recruitNo PRIMARY KEY(recruitno)
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
	CONSTRAINT pk_reviewNo PRIMARY KEY(reviewNo)
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
	totalPrice number NOT NULL,
	CONSTRAINT pk_ticketNo PRIMARY KEY(ticketNo)
);



/* Create Foreign Keys */

ALTER TABLE t_condo_reserve
	ADD FOREIGN KEY (roomType)
	REFERENCES t_condo (roomType)
	ON DELETE CASCADE
;


ALTER TABLE t_event_attach
	ADD FOREIGN KEY (eventNo)
	REFERENCES t_event (eventNo)
	ON DELETE CASCADE
;


ALTER TABLE t_appliance
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
	ON DELETE CASCADE
;


ALTER TABLE t_condo_reserve
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
	ON DELETE CASCADE
;


ALTER TABLE t_event
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
	ON DELETE CASCADE
;


ALTER TABLE t_member_auth
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
	ON DELETE CASCADE
;


ALTER TABLE t_notice
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
	ON DELETE CASCADE
;


ALTER TABLE t_qna
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
	ON DELETE CASCADE
;


ALTER TABLE t_recruit
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
	ON DELETE CASCADE
;


ALTER TABLE t_review
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
	ON DELETE CASCADE
;


ALTER TABLE t_review_reply
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
	ON DELETE CASCADE
;


ALTER TABLE t_ticket_buy
	ADD FOREIGN KEY (id)
	REFERENCES t_member (id)
	ON DELETE CASCADE
;


ALTER TABLE t_appliance
	ADD FOREIGN KEY (recruitNo)
	REFERENCES t_recruit (recruitno)
	ON DELETE CASCADE
;


ALTER TABLE t_review_attach
	ADD FOREIGN KEY (reviewNo)
	REFERENCES t_review (reviewNo)
	ON DELETE CASCADE
;


ALTER TABLE t_review_reply
	ADD FOREIGN KEY (reviewNo)
	REFERENCES t_review (reviewNo)
	ON DELETE CASCADE
;


ALTER TABLE t_ticket_buy
	ADD FOREIGN KEY (type)
	REFERENCES t_ticket (type)
	ON DELETE CASCADE
;

/* Comments */
COMMENT ON COLUMN t_review.useNo IS '예약 | 이용권';


--수경부분시작
DROP SEQUENCE seq_t_condo_reserve;
CREATE SEQUENCE seq_t_condo_reserve
INCREMENT BY 1
START WITH 1;

insert into t_condo values('P','E/W 빌리지','SG 빌딩 1층','더블1 싱글1',3,100000);
insert into t_condo values('D','E/W 빌리지','SG 빌딩 2층','더블1 싱글3',5,150000);
insert into t_condo values('N','E/W 빌리지','SG 빌딩 3층','더블2 싱글3',7,200000);
insert into t_condo values('R','E/W 빌리지','SG 빌딩 4층','더블3 싱글3',9,250000);

drop view view_condo_reserve;
create or replace view view_condo_reserve as
select roomtype,roomno,checkin,checkout
from t_condo_reserve
where status=0
order by roomno,checkin;

drop sequence seq_t_qna;
create sequence seq_t_qna
INCREMENT BY 1
start with 1;


ALTER TABLE t_condo_reserve DROP PRIMARY KEY;
alter table t_condo_reserve add constraint pk_condo_reserve primary key(reserveno);



ALTER TABLE t_qna DROP PRIMARY KEY;
alter table t_qna add constraint pk_qna primary key(qnano);

--수경부분 끝 


-- 재웅 시작
-- 계정생성은 프로젝트파일 패키지 com.kjnresort.security.MemberTests JUnit으로 생성
-- 내가쓴 리뷰 com.kjnresort.security.ReviewTests JUnit으로 생성

--이벤트 시퀀스
DROP SEQUENCE seq_t_event;
CREATE SEQUENCE seq_t_event
INCREMENT BY 1
START WITH 1
MAXVALUE 9999999999999
MINVALUE 1;

--내가 쓴 리뷰 시퀀스
DROP SEQUENCE seq_t_review;
CREATE SEQUENCE seq_t_review
INCREMENT BY 1
START WITH 1
MAXVALUE 9999999999999
MINVALUE 1;

-- 재웅 끝

-- 태현 부분 시작
DROP SEQUENCE seq_t_appliance;
CREATE SEQUENCE seq_t_appliance
INCREMENT BY 1
START WITH 1;

DROP SEQUENCE seq_t_notice;
CREATE SEQUENCE seq_t_notice
INCREMENT BY 1
START WITH 1;

DROP SEQUENCE seq_t_recruit;
CREATE SEQUENCE seq_t_recruit
INCREMENT BY 1
START WITH 1;

-- 태현 부분 끝

-- 남구 부분 시작

drop sequence seq_t_review_reply;
create sequence seq_t_review_reply
INCREMENT BY 1
START WITH 1;

drop sequence seq_t_review;
create sequence seq_t_review
INCREMENT BY 1
START WITH 1;

drop sequence seq_t_ticket_buy;
create sequence seq_t_ticket_buy
INCREMENT BY 1
START WITH 1;

insert into t_ticket 
values ('lift', 50000);

insert into t_ticket 
values ('tool', 60000);

-- 남구 부분 끝
