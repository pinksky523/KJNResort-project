package com.kjnresort.security;
import java.sql.*;
import java.util.*;

import javax.sql.DataSource;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
                              "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class ReviewTests {
   
   @Setter(onMethod_ = @Autowired)
   private DataSource ds;
   
//   @Test
   public void testInsertMember() {
      
      String query = "insert into "
            + "member(memberId, memberPw, memberName, memberAddress, memberPhoneFirst, "
            + "memberPhoneSecond, memberPhoneThird, memberBirth, memberEmail, memberEmailSecond, memberRegDate) "
            + "values(?, ?, ?, ?, ?, ?, ?, sysdate, ?, ?, sysdate)";
      
      try(Connection con = ds.getConnection(); 
            PreparedStatement pstmt = con.prepareStatement(query)) {
         for(int i=0; i<100; i++) {
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
   