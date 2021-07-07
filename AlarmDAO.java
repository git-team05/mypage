package team05.alarm;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team05.product.ProductDTO;
import team05.productorder.MypaymentDTO;
import team05.productorder.ProductorderDTO;

public class AlarmDAO {
	private static AlarmDAO instance = new AlarmDAO();
	private AlarmDAO() {}
	public static AlarmDAO getInstance() { return instance; }
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	public void addAlarm(int proNum, String id) {
		
		System.out.println("pronum : " + proNum);
		System.out.println("id : " + id);
		System.out.println("addalarm method");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			System.out.println("try");

			conn = getConnection();
			
			String sql = "select email from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			System.out.println("before rs");

			rs = pstmt.executeQuery();
			System.out.println("after rs");
			
			if(rs.next()) {
				System.out.println("before update");

				sql = "insert into alarm values(alarm_seq.nextVal, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, proNum);
				pstmt.setString(2, id);
				pstmt.setString(3, rs.getString(1));
				pstmt.executeUpdate();
				System.out.println("after update");

			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
	}
	
	public boolean checkAlarm(int proNum, String id) {
		boolean alarm = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from alarm where proNum=? and id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, proNum);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				alarm = true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
		return alarm;
	}
	
	public void removeAlarm(int proNum, String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "delete from alarm where proNum=? and id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, proNum);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
	}
	
	// 내가 신청한 알람의 수 count 
	public int AlarmCount(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from alarm where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
				System.out.println(result);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			 if(rs != null)try{rs.close();}catch(Exception e) {e.printStackTrace();}
	         if(pstmt != null)try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
	         if(conn != null)try{conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	// 내가 신청한 알람 내역
	public List getMyalarm(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List myalarmList = null;
		try {
			conn= getConnection();
			String sql = "select p.thumbimg, a.pronum, p.proname, p.startdate from alarm a, product p where p.pronum = a.pronum and id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				myalarmList = new ArrayList();
				do {
					MyalarmDTO dto = new MyalarmDTO();
					dto.setThumbImg(rs.getString("thumbImg"));
					dto.setProNum(rs.getInt("proNum"));
					dto.setProName(rs.getString("proName"));
					dto.setStartDate(rs.getString("startDate"));
					myalarmList.add(dto);;
				} while(rs.next());
			}	
		}catch ( Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(Exception e) {e.printStackTrace();}
            if(pstmt != null)try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
            if(conn != null)try{conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return myalarmList;
	}
	
	
	
}
