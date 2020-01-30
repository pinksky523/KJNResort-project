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
   
   @Setter(onMethod_ = @Autowired)
   private DataSource ds;

   @Test
   public void testA() {
      
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
           pstmt.setString(5, "2000-11-11");
           pstmt.setString(6, "서울특별시 마포구 월드컵북로 21 풍성빌딩 4층");
           pstmt.setInt(7, 1);
           pstmt.executeUpdate();
           
           //일반회원 기본생성
           pstmt.setString(1, "user00");
           pstmt.setString(2, pwencoder.encode("1111"));
           pstmt.setString(3, "일반회원");
           pstmt.setString(4, "010-1111-1111");
           pstmt.setString(5, "2020-01-02");
           pstmt.setString(6, "경기도 김포시 풍무동");
           pstmt.setInt(7, 1);
           pstmt.executeUpdate();
           	
           //정지회원 기본생성
           pstmt.setString(1, "user01");
           pstmt.setString(2, pwencoder.encode("1111"));
           pstmt.setString(3, "정지회원");
           pstmt.setString(4, "010-2222-2222");
           pstmt.setString(5, "2012-11-11");
           pstmt.setString(6, "서울특별시 마포구");
           pstmt.setInt(7, 0);
           pstmt.executeUpdate();
           
      } catch(Exception e) {
         e.printStackTrace();
      }
   }
   
   @Test
   public void testB() {
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
   }//END TestB()
   
   
   
   //회원 목록조회를 위한 회원저장
   @Test
   public void testC() {
   
	      String query = "insert into "
	            + "t_member(id, pw, name, phoneNumber, birth, address, status)"
	            + "values(?, ?, ?, ?, ?, ?, ?)";
	      
	      
	      
	      try(Connection con = ds.getConnection(); 
	            PreparedStatement pstmt = con.prepareStatement(query)) {
	         for(int i=0; i<99; i++) {
	            if(i<49) {	//일반회원
	               pstmt.setString(1, "user"+i);
	               pstmt.setString(2, pwencoder.encode("1111"));
	               pstmt.setString(3, "회원이름"+i);
	               pstmt.setString(4, "0" + i + "-0000-0000");
	               pstmt.setString(5, "2011-11-11");
	               pstmt.setString(6, "회원주소 " + i);
	               pstmt.setInt(7, 1);
	            } else {	//정지회원
	               pstmt.setString(1, "user"+i);
	               pstmt.setString(2, pwencoder.encode("1111"));
	               pstmt.setString(3, "회원이름"+i);
	               pstmt.setString(4, "0" + i + "-0000-0000");
	               pstmt.setString(5, "2011-11-11");
	               pstmt.setString(6, "회원주소" + i);
	               pstmt.setInt(7, 0);
	            	
	            }
	            pstmt.executeUpdate();
	         }
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
   }

   
	@Test
	 public void testD() {
	    String query = "insert into t_member_auth(id, auth) values(?, ?)";
	       
	       try(Connection con = ds.getConnection(); 
	             PreparedStatement pstmt = con.prepareStatement(query)) {
	          for(int i=0; i<100; i++) {
	             if(i<99) {
	                pstmt.setString(1, "user"+i);
	                pstmt.setString(2, "ROLE_MEMBER");
	             }
	             pstmt.executeUpdate();
	          }
	       } catch(Exception e) {
	          e.printStackTrace();
	       }
 }

}
   