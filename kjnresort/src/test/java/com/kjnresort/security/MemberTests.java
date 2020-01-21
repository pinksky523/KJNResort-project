package com.kjnresort.security;

import java.sql.*;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
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
            + "t_member(id, pw, name, phoneNumber, birth, address, status)"
            + "values(?, ?, ?, ?, ?, ?, ?)";
      
      try(Connection con = ds.getConnection(); 
            PreparedStatement pstmt = con.prepareStatement(query)) {
        
    	   //관리자계정 기본생성
    	   pstmt.setString(1, "admin");
           pstmt.setString(2, pwencoder.encode("1111"));
           pstmt.setString(3, "관리자");
           pstmt.setString(4, "000-0000-0000");
           pstmt.setString(5, "11/11/11");
           pstmt.setString(6, "서울특별시 마포구 월드컵북로 21 풍성빌딩 4층");
           pstmt.setInt(7, 1);
           pstmt.executeUpdate();
           
           //일반회원 기본생성
           pstmt.setString(1, "user00");
           pstmt.setString(2, pwencoder.encode("1111"));
           pstmt.setString(3, "일반회원");
           pstmt.setString(4, "111-1111-1111");
           pstmt.setString(5, "11/11/11");
           pstmt.setString(6, "서울특별시 마포구 월드컵북로 21 풍성빌딩 4층");
           pstmt.setInt(7, 1);
           pstmt.executeUpdate();
           	
           //정지회원 기본생성
           pstmt.setString(1, "user01");
           pstmt.setString(2, pwencoder.encode("1111"));
           pstmt.setString(3, "정지회원");
           pstmt.setString(4, "222-2222-222");
           pstmt.setString(5, "11/11/11");
           pstmt.setString(6, "서울특별시 마포구 월드컵북로 21 풍성빌딩 4층");
           pstmt.setInt(7, 0);
           pstmt.executeUpdate();
           
      } catch(Exception e) {
         e.printStackTrace();
      }
   }
   
   @Test
   public void testInsertAuth() {
      String query = "insert into t_member_auth (id, auth) values(?, ?)";
         
         try(Connection con = ds.getConnection(); 
               PreparedStatement pstmt = con.prepareStatement(query)) {
           
              //관리자계정에 관리자 권한부여
              pstmt.setString(1, "admin");
              pstmt.setString(2, "ROLE_ADMIN");
              pstmt.executeUpdate();
              pstmt.setString(1, "admin");
              pstmt.setString(2, "ROLE_MEMBER");
              pstmt.executeUpdate();
            
              //일반회원계정에 권한부여
              pstmt.setString(1, "user00");
              pstmt.setString(2, "ROLE_MEMBER");
              pstmt.executeUpdate();
              
              //정지회원계정에 권한부여
              pstmt.setString(1, "user01");
              pstmt.setString(2, "ROLE_MEMBER");
              pstmt.executeUpdate();
              
         } catch(Exception e) {
            e.printStackTrace();
         }
   }
}
   