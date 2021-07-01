package team05.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	private static MemberDAO instance = new MemberDAO();
	private MemberDAO() {}
	public static MemberDAO getInstance() {return instance;}
		
	// 커넥션
      private Connection getConnection() throws Exception{
         Context ctx = new InitialContext();
         Context env = (Context)ctx.lookup("java:comp/env");
         DataSource ds = (DataSource)env.lookup("jdbc/orcl");
         return ds.getConnection();
      }
      
      public void insertMember(MemberDTO dto) {
         Connection conn = null;
         PreparedStatement pstmt = null;
         
         
         try {
            conn = getConnection();
            String sql = "insert into member values(?,?,?,?,?,sysdate)"; //values 들어가는 순서
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getPw());
            pstmt.setString(3, dto.getName());
            pstmt.setString(4, dto.getEmail());
            pstmt.setString(5, dto.getPhone());
            
            int result = pstmt.executeUpdate();
            System.out.println(result);
         }catch(Exception e) {
            e.printStackTrace();
            
         }finally {
            if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
            if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
         }   
      } 
      // id,pw 일치 메서드
      // 멤버 회원 ID, PW 일치확인
      public boolean idPwCheck(String id, String pw) {
    	  boolean result = false;
    	  Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
    	  
    	  try {
    		  conn = getConnection();
    		  String sql = "select * from member where id=? and pw=?";
    		  pstmt = conn.prepareStatement(sql);
    		  pstmt. setString(1, id);
    		  pstmt. setString(2, pw);
    		  
    		  rs = pstmt.executeQuery();
    		  if(rs.next()) {
    			  result = true;
    		  }
    	  }catch(Exception e) {
    		  e.printStackTrace();
    	  }finally {
    		  if(rs != null) try {rs.close();} catch(Exception e) {e.printStackTrace();}
    		  if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
              if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
    	  }
    	  return result; 
      }
      
      // 회원 1명 아이디에 저장된 db가져오기
      public MemberDTO getMember(String id) {
    	  Connection conn = null;
    	  PreparedStatement pstmt = null;
    	  ResultSet rs = null;
    	  MemberDTO dto = null;
    	  
    	  try {
    		  conn = getConnection();
    		  String sql = "select * from member where id=?";
    		  pstmt = conn.prepareStatement(sql);
    		  pstmt.setString(1, id);
    		  
    		  rs= pstmt.executeQuery();
    		  if(rs.next()) {
    			  dto = new MemberDTO();
    			  dto.setId(rs.getString("id"));
    			  dto.setPw(rs.getString("pw"));
    			  dto.setName(rs.getString("name"));
    			  dto.setEmail(rs.getString("email"));
    			  dto.setPhone(rs.getString("phone"));
    			  dto.setReg(rs.getTimestamp("reg"));
    			  System.out.println(dto.getId());
    		  }
    	  } catch (Exception e) {
    		  e.printStackTrace();
    	  } finally {
    		  if(rs != null) try {rs.close();} catch (Exception e) {e.printStackTrace();}
  			  if(pstmt != null) try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
  			  if(conn != null) try {conn.close();} catch (Exception e) {e.printStackTrace();}
    	  }
    	  return dto;
      }
      
      // 이메일, 전화번호 회원 정보 수정 메서드
      public int updateMember(MemberDTO dto) {
    	  Connection conn = null;
    	  PreparedStatement pstmt = null;
    	  int result = -1;
    	  try {
    		  conn = getConnection();
    		  String sql = "update member set email=?, phone=? where id=?";
    		  pstmt = conn.prepareStatement(sql);
    		  pstmt.setString(1, dto.getEmail());
    		  pstmt.setString(2, dto.getPhone());
    		  pstmt.setString(3, dto.getId());
    		  result = pstmt.executeUpdate();
    		  System.out.println("dao update result : " + result);
    	  }catch ( Exception e ) {
    		  e.printStackTrace();
    	  }finally {
    		  if(pstmt != null) try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
  			  if(conn != null) try {conn.close();} catch (Exception e) {e.printStackTrace();}
    	  }
    	  return result;
      }
      // g회원 탈퇴 메서드
      public int deleteMember(String id, String pw) {
    	  int result = -1;
    	  Connection conn = null;
    	  PreparedStatement pstmt = null;
    	  ResultSet rs = null;
    	  
    	  try {
    		  conn = getConnection();
    		  String sql = "select pw from member where id=?";
    		  pstmt = conn.prepareStatement(sql);
    		  pstmt.setString(1, id);
    		  
    		  rs=pstmt.executeQuery();
    		  if(rs.next()) {
    			  String dbpw = rs.getString("pw");
    			  if(dbpw.equals(pw)) {
    				  sql = "delete from member where id=?";
    				  pstmt = conn.prepareStatement(sql);
    				  pstmt.setString(1, id);
    				  result = pstmt.executeUpdate();
    			  }else {
    				  result = 0;
    			  }
    		  }
    	  } catch (Exception e) {
    		  e.printStackTrace();
    	  } finally {
    		  if(rs != null) try {rs.close();} catch (Exception e) {e.printStackTrace();}
  			  if(pstmt != null) try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
  			  if(conn != null) try {conn.close();} catch (Exception e) {e.printStackTrace();}
    	  }
    	  System.out.println("dao delete result :" + result);
    	  return result;
      }
      
}