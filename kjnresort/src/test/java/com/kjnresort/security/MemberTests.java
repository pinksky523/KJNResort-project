package com.kjnresort.security;

import java.sql.*;
import java.util.*;

import javax.sql.DataSource;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
                              "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class MemberTests {
   
   @Setter(onMethod_ = @Autowired)
   private PasswordEncoder pwencoder;
   // PasswordEncoder를 구현한 CustomNoOpPasswordEncoder의 메소드를 이용할 수 있음
   
   @Setter(onMethod_ = @Autowired)
   private DataSource ds;
   
//   @Test
   public void testInsertMember() {
      
      String query = "insert into "
            + "member(id, pw, name, phoneNumber, birth, adress"
            + "memberPhoneSecond, memberPhoneThird, memberBirth, memberEmail, memberEmailSecond, memberRegDate) "
            + "values(?, ?, ?, ?, ?, ?, ?, sysdate, ?, ?, sysdate)";
      
      try(Connection con = ds.getConnection(); 
            PreparedStatement pstmt = con.prepareStatement(query)) {
         for(int i=0; i<100; i++) {
            pstmt.setString(2, pwencoder.encode("1111"));
            if(i<100) {
               pstmt.setString(1, "member"+i);
               pstmt.setString(3, "일반사용자"+i);
               pstmt.setString(4, "test주소");
               pstmt.setString(5, "010");
               pstmt.setString(6, "4189");
               pstmt.setString(7, "5485");
               pstmt.setString(8, "ywc412");
               pstmt.setString(9,"naver.com");
            }
            pstmt.executeUpdate();
         }
      } catch(Exception e) {
         e.printStackTrace();
      }
   }
   
//   @Test
   public void testInsertAuth() {
      String query = "insert into auth (memberid, memberauth) values(?, ?)";
         
         try(Connection con = ds.getConnection(); 
               PreparedStatement pstmt = con.prepareStatement(query)) {
            for(int i=0; i<100; i++) {
               if(i<100) {
                  pstmt.setString(1, "member"+i);
                  pstmt.setString(2, "ROLE_MEMBER");
               }
               pstmt.executeUpdate();
            }
         } catch(Exception e) {
            e.printStackTrace();
         }
   }
}
   