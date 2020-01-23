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
   
   @Test
   public void testA() {
      
      String query = "insert into "
            + "t_review(reviewNo, id, title, content, category, grade, useno)"
            + "values(seq_t_review.NEXTVAL, ?, ?, ?, ?, ?, ?)";
      
      try(Connection con = ds.getConnection(); 
            PreparedStatement pstmt = con.prepareStatement(query)) {
    	  for(int k=0; k<3; k++) {
    		  pstmt.setString(1, "user"+k);
	         for(int i=0; i<99; i++) {
	            if(i<49) {
	               
	               pstmt.setString(2, "제목----"+i);
	               pstmt.setString(3, "내용----"+i);
	               pstmt.setString(4, "스키");
	               pstmt.setInt(5, 5);
	               pstmt.setInt(6, 0);
	            } else {
		        	pstmt.setString(1, "user"+i);
		            pstmt.setString(2, "제목----"+i);
		            pstmt.setString(3, "내용----"+i);
		            pstmt.setString(4, "콘도");
		            pstmt.setInt(5, 8);
		            pstmt.setInt(6, 1);
	            }
	            pstmt.executeUpdate();
	         }
    	  }
      } catch(Exception e) {
         e.printStackTrace();
      }
   }
   
}
   