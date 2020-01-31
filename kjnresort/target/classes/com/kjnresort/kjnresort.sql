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
    CONSTRAINT pk_replyNo PRIMARY KEY(replyNo)
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

--admin 계정으로 create view 권한 부여해줘야됨
-- conn /as sysdba
-- GRANT CREATE VIEW TO team1;
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


--아래부터는 mapper test junit 실행 후 실행할것
-- 공지사항 리스트 테스트 정보
Insert into t_notice(noticeno, id, title, content, regdate, viewcnt, topcheck) 
values(seq_t_notice.nextval,'admin','공지사항 Top Check 제목 1','공지사항 내용',sysdate,0,1);
Insert into t_notice(noticeno, id, title, content, regdate, viewcnt, topcheck) 
values(seq_t_notice.nextval,'admin','공지사항 Top Check 제목 2','공지사항 내용',sysdate,0,1);
Insert into t_notice(noticeno, id, title, content, regdate, viewcnt, topcheck) 
values(seq_t_notice.nextval,'admin','공지사항 Top Check 제목 3','공지사항 내용',sysdate,0,1);
Insert into t_notice(noticeno, id, title, content, regdate, viewcnt, topcheck) 
values(seq_t_notice.nextval,'admin','공지사항 Top Check 제목 4','공지사항 내용',sysdate,0,1);
Insert into t_notice(noticeno, id, title, content, regdate, viewcnt, topcheck) 
values(seq_t_notice.nextval,'admin','공지사항 Top Check 제목 5','공지사항 내용',sysdate,0,1);
Insert into t_notice(noticeno, id, title, content, regdate, viewcnt, topcheck) 
values(seq_t_notice.nextval,'admin','공지사항 제목 1','공지사항 내용',sysdate,0,0);
Insert into t_notice(noticeno, id, title, content, regdate, viewcnt, topcheck) 
values(seq_t_notice.nextval,'admin','공지사항 제목 2','공지사항 내용',sysdate,0,0);
Insert into t_notice(noticeno, id, title, content, regdate, viewcnt, topcheck) 
values(seq_t_notice.nextval,'admin','공지사항 제목 3','공지사항 내용',sysdate,0,0);
Insert into t_notice(noticeno, id, title, content, regdate, viewcnt, topcheck) 
values(seq_t_notice.nextval,'admin','공지사항 제목 4','공지사항 내용',sysdate,0,0);
Insert into t_notice(noticeno, id, title, content, regdate, viewcnt, topcheck) 
values(seq_t_notice.nextval,'admin','공지사항 제목 5','공지사항 내용',sysdate,0,0);

-- 지원공고 리스트 테스트 정보
Insert into t_recruit(recruitno, id, title, content, status, deadline)
values(SEQ_T_RECRUIT.nextval,'admin','17/18 강사채용','18년 2월 28일까지 근무하실 강사를 채용합니다. 많이 지원해 주세요.', '마감', '18/01/31');
Insert into t_recruit(recruitno, id, title, content, status, deadline)
values(SEQ_T_RECRUIT.nextval,'admin','18/19 강사채용','19년 2월 28일까지 근무하실 강사를 채용합니다. 많이 지원해 주세요.', '마감', '19/01/31');
Insert into t_recruit(recruitno, id, title, content, status, deadline)
values(SEQ_T_RECRUIT.nextval,'admin','19/20 강사채용','20년 2월 28일까지 근무하실 강사를 채용합니다. 많이 지원해 주세요.', '진행중', '20/01/31');

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

insert into t_ticket
values ('both', 110000);

-- 남구 부분 끝

 delete from t_condo_reserve;
BEGIN
    FOR I IN 1..30
    LOOP
      insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user50','P','20/01/10',0,101,'2020/01/11','2020/01/12',1,100000,0);
    END LOOP;
END;
/

 BEGIN
    FOR I IN 1..100
    LOOP
      insert into t_qna values(seq_t_qna.nextval,'C','user5','문의 합니다. 정말 궁금해요 ','문의합니다. 궁금하네요 . 답변꼭 주세요 내일 모레 출발입니다.',sysdate,'','','N');  
    END LOOP;
END;
/
insert into t_qna values(seq_t_qna.nextval,'C','user5','콘도 문의 합니다. 정말 궁금해요 ','문의합니다. 궁금하네요 . 답변꼭 주세요 내일 모레 출발입니다.',sysdate,'','','N');
insert into t_qna values(seq_t_qna.nextval,'S','user2','스키장 문의..코스가 몇개인가요 ','문의합니다. 궁금하네요 . 답변꼭 주세요 내일 모레 출발입니다.',sysdate,'','','N');
insert into t_qna values(seq_t_qna.nextval,'E','user10','픽업서비스는 없나요? ','문의합니다. 궁금하네요 . 답변꼭 주세요 내일 모레 출발입니다.',sysdate,'','','N');
insert into t_qna values(seq_t_qna.nextval,'C','user32','콘도에 안마의자 있나요','문의합니다. 궁금하네요 . 답변꼭 주세요 내일 모레 출발입니다.',sysdate,'','','N');
insert into t_qna values(seq_t_qna.nextval,'S','user1','안전모만 따로 빌리 수 있나요 ','문의합니다. 궁금하네요 . 답변꼭 주세요 내일 모레 출발입니다.',sysdate,'','','N');
insert into t_qna values(seq_t_qna.nextval,'S','user00','보드를 배울수 있는 클래스는 따로 없나요 ','문의합니다. 궁금하네요 . 답변꼭 주세요 내일 모레 출발입니다.',sysdate,'','','N');
insert into t_qna values(seq_t_qna.nextval,'E','user00','리조트에 베스킨라빈스 있나요? ','문의합니다. 궁금하네요 . 답변꼭 주세요 내일 모레 출발입니다.',sysdate,'안녕하세요 고객님 저희 리조트에는 베스킨라빈스가 없습니다. 대신 나뚜루매장이 있습니다. 감사합니다.',sysdate,'Y');
insert into t_qna values(seq_t_qna.nextval,'C','user00','콘도 욕실에 세면 도구 있나요? ','문의합니다. 궁금하네요 . 디럭실 타입이에요.',sysdate,'안녕하세요 고객님 저희 콘도 디럭스 욕실에는 1회용 세면도구 2개가 기본으로 배치되어있습니다. 감사합니다.',sysdate,'Y');  

insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user11','P','20/01/15',0,101,'2020/02/03','2020/02/05',2,200000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user7','P','20/01/14',0,102,'2020/02/03','2020/02/05',2,200000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user12','P','20/01/16',0,103,'2020/02/03','2020/02/05',2,200000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user13','P','20/01/09',0,104,'2020/02/03','2020/02/05',2,200000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user16','P','20/01/08',0,105,'2020/02/03','2020/02/05',2,200000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user17','P','20/01/07',0,106,'2020/02/03','2020/02/05',2,200000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user18','P','20/01/12',0,107,'2020/02/03','2020/02/05',2,200000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user19','P','20/01/13',0,108,'2020/02/03','2020/02/05',2,200000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user20','P','20/01/22',0,109,'2020/02/03','2020/02/05',2,200000,0);

insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user21','D','20/01/15',0,201,'2020/02/06','2020/02/07',1,150000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user31','D','20/01/16',0,202,'2020/02/06','2020/02/07',1,150000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user41','D','20/01/17',0,203,'2020/02/06','2020/02/07',1,150000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user11','D','20/01/18',0,204,'2020/02/06','2020/02/07',1,150000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user9','D','20/01/21',0,205,'2020/02/06','2020/02/07',1,150000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user00','D','20/01/30',0,206,'2020/02/06','2020/02/07',1,150000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user33','D','20/01/14',0,207,'2020/02/06','2020/02/07',1,150000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user42','D','20/01/06',0,208,'2020/02/06','2020/02/07',1,150000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user39','D','20/01/17',0,209,'2020/02/06','2020/02/07',1,150000,0);


insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user39','N','20/01/16',0,301,'2020/02/05','2020/02/07',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user32','N','20/01/11',0,302,'2020/02/05','2020/02/07',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user16','N','20/01/21',0,303,'2020/02/05','2020/02/07',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user3','N','20/01/05',0,304,'2020/02/05','2020/02/07',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user6','N','20/02/01',0,305,'2020/02/05','2020/02/07',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user9','N','20/02/02',0,306,'2020/02/05','2020/02/07',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user12','N','20/01/17',0,307,'2020/02/05','2020/02/07',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user46','N','20/01/31',0,308,'2020/02/05','2020/02/07',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user48','N','20/01/29',0,309,'2020/02/05','2020/02/07',2,400000,0);

insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user3','R','20/01/02',0,401,'2020/02/07','2020/02/10',3,750000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user4','R','20/01/02',0,402,'2020/02/07','2020/02/10',3,750000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user5','R','20/01/03',0,403,'2020/02/07','2020/02/10',3,750000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user6','R','20/02/01',0,404,'2020/02/07','2020/02/10',3,750000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user7','R','20/01/31',0,405,'2020/02/07','2020/02/10',3,750000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user8','R','20/01/14',0,406,'2020/02/07','2020/02/10',3,750000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user9','R','20/01/15',0,407,'2020/02/07','2020/02/10',3,750000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user10','R','20/01/23',0,408,'2020/02/07','2020/02/10',3,750000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user11','R','20/01/14',0,409,'2020/02/07','2020/02/10',3,750000,0);

--

insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user11','P','20/01/19',0,101,'2020/02/14','2020/02/17',3,300000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user12','P','20/01/17',0,102,'2020/02/14','2020/02/17',3,300000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user13','P','20/01/16',0,103,'2020/02/14','2020/02/17',3,300000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user9','D','20/01/18',0,201,'2020/02/14','2020/02/17',3,450000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user23','D','20/01/19',0,202,'2020/02/14','2020/02/17',3,450000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user32','N','20/01/20',0,301,'2020/02/14','2020/02/17',3,600000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user11','N','20/01/16',0,402,'2020/02/14','2020/02/17',3,600000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user11','R','20/01/19',0,401,'2020/02/14','2020/02/17',3,750000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user11','R','20/01/01',0,402,'2020/02/14','2020/02/17',3,750000,0);

--

insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user11','P','20/01/15',0,101,'2020/02/17','2020/02/20',3,300000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user7','P','20/01/14',0,102,'2020/02/17','2020/02/20',3,300000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user12','P','20/01/16',0,103,'2020/02/17','2020/02/20',3,300000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user13','P','20/01/09',0,104,'2020/02/17','2020/02/20',3,300000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user16','P','20/01/08',0,105,'2020/02/17','2020/02/20',3,300000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user17','P','20/01/07',0,106,'2020/02/17','2020/02/20',3,300000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user18','P','20/01/12',0,107,'2020/02/17','2020/02/20',3,300000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user19','P','20/01/13',0,108,'2020/02/17','2020/02/20',3,300000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user20','P','20/01/22',0,109,'2020/02/17','2020/02/20',3,300000,0);

insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user24','D','20/01/09',0,201,'2020/02/17','2020/02/20',3,450000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user21','D','20/01/08',0,202,'2020/02/17','2020/02/20',3,450000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user19','D','20/01/28',0,203,'2020/02/17','2020/02/20',3,450000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user20','D','20/01/29',0,204,'2020/02/17','2020/02/20',3,450000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user23','D','20/01/30',0,205,'2020/02/17','2020/02/20',3,450000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user24','D','20/01/31',0,206,'2020/02/17','2020/02/20',3,450000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user25','D','20/01/27',0,207,'2020/02/17','2020/02/20',3,450000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user20','D','20/01/27',0,208,'2020/02/17','2020/02/20',3,450000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user32','D','20/01/22',0,209,'2020/02/17','2020/02/20',3,450000,0);


insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user16','N','20/01/16',0,301,'2020/02/19','2020/02/21',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user32','N','20/01/11',0,302,'2020/02/19','2020/02/21',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user16','N','20/01/21',0,303,'2020/02/19','2020/02/21',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user3','N','20/01/05',0,304,'2020/02/19','2020/02/21',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user6','N','20/02/01',0,305,'2020/02/19','2020/02/21',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user9','N','20/02/02',0,306,'2020/02/19','2020/02/21',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user12','N','20/01/17',0,307,'2020/02/19','2020/02/21',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user46','N','20/01/31',0,308,'2020/02/19','2020/02/21',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user48','N','20/01/29',0,309,'2020/02/19','2020/02/21',2,400000,0);

insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user3','R','20/01/02',0,401,'2020/02/19','2020/02/21',2,500000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user4','R','20/01/02',0,402,'2020/02/19','2020/02/21',2,500000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user5','R','20/01/03',0,403,'2020/02/19','2020/02/21',2,500000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user6','R','20/02/01',0,404,'2020/02/19','2020/02/21',2,500000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user7','R','20/01/31',0,405,'2020/02/19','2020/02/21',2,500000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user8','R','20/01/14',0,406,'2020/02/19','2020/02/21',2,500000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user9','R','20/01/15',0,407,'2020/02/19','2020/02/21',2,500000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user10','R','20/01/23',0,408,'2020/02/19','2020/02/21',2,500000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user11','R','20/01/14',0,409,'2020/02/19','2020/02/21',2,500000,0);


insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user00','P','20/01/12',0,101,'2020/02/05','2020/02/06',1,100000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user16','P','20/01/07',0,102,'2020/02/02','2020/02/06',4,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user12','D','20/01/30',0,201,'2020/02/25','2020/02/26',1,150000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user00','N','20/01/30',-1,301,'2020/02/01','2020/02/03',2,400000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user00','R','20/01/25',1,402,'2020/01/28','2020/01/30',2,500000,0);
insert into t_condo_reserve values(seq_t_condo_reserve.nextval,'user00','R','20/01/18',0,402,'2020/01/15','2020/01/16',1,250000,0);

insert into t_ticket_buy values (50, 'user0', 'both', sysdate, 1, 1, 0, 0,  110000)
insert into t_ticket_buy values (51, 'user1', 'both', sysdate, 2, 2, 0, 0,  220000)      
insert into t_ticket_buy values (52, 'user2', 'both', sysdate, 1, 0, 0, 0,  50000)        
insert into t_ticket_buy values (53, 'user3', 'both', sysdate, 0, 1, 0, 0,  60000)
insert into t_ticket_buy values (54, 'user4', 'both', sysdate, 1, 1, 0, 0,  110000)        
insert into t_ticket_buy values (55, 'user5', 'both', sysdate, 1, 1, 0, 0,  110000)    
insert into t_ticket_buy values (56, 'user6', 'both', sysdate, 1, 1, 0, 0,  110000)       
insert into t_ticket_buy values (57, 'user7', 'both', sysdate, 1, 1, 0, 0,  110000)    
insert into t_ticket_buy values (58, 'user8', 'both', sysdate, 1, 1, 0, 0,  110000)        
insert into t_ticket_buy values (59, 'user0', 'both', sysdate, 1, 1, 0, 0,  110000)        
insert into t_ticket_buy values (60, 'user0', 'both', sysdate, 1, 1, 0, 0,  110000)    

commit;
