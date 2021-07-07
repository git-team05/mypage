package team05.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team05.productorder.MypaymentDTO;
import team05.productqna.ProductqnaDTO;

public class ReviewDAO {
	
	// 생성자 싱글톤
	private static ReviewDAO instance = new ReviewDAO();
	private ReviewDAO() {};
	public static ReviewDAO getInstance() { return instance; }
	
	// 커넥션 연결
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 상품리뷰 db에 저장
	public void insertProqna(ReviewDTO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "insert into review values (review_seq.nextval,?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getProNum());
			pstmt.setString(2, article.getWriter());
			pstmt.setString(3, article.getTitle());
			pstmt.setInt(4, article.getStar());
			pstmt.setString(5, article.getContent());
			pstmt.setString(6, article.getImg());
			int result = pstmt.executeUpdate();
			System.out.println("리뷰:" + result);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
	}
	
	// 작성 가능한 리뷰의 수 count(배송완료된);
	public int getMyreviewCount1(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		System.out.println(id);
		
		try {
			conn = getConnection();
			String sql = "select count(*) from productorder where id=? and delcon='shipsent'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
				System.out.println(result);
			} 
		} catch (Exception e) {
				e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(Exception e) {e.printStackTrace();}
		    if(pstmt != null)try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
		    if(conn != null)try{conn.close();}catch(Exception e) {e.printStackTrace();}
		} 
		return result;
	}
	
	// 작성 가능한 리뷰 보여주기(배송완료된 친구)
	public List getMyreview1(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List myReviewList = null;
		
		try {
			conn = getConnection();
			String sql = "select o.ordernum, o.pronum, p.proname, p.thumbimg from product p, productorder o where p.pronum = o.pronum and id=? and delcon='shipsent' order by o.ordernum asc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				myReviewList = new ArrayList();
				do {
					MypaymentDTO dto = new MypaymentDTO();
					dto.setOrderNum(rs.getInt("orderNum"));
	                dto.setProNum(rs.getInt("proNum"));
	                dto.setProName(rs.getString("proName"));
	                dto.setThumbImg(rs.getString("thumbImg"));
	                myReviewList.add(dto);
				} while(rs.next());
			}
		} catch ( Exception e) {
			e.printStackTrace();
		} finally {
			 if(rs != null)try{rs.close();}catch(Exception e) {e.printStackTrace();}
             if(pstmt != null)try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
             if(conn != null)try{conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return myReviewList;
	}

	// 작성한 리뷰의 수 count
	public int getMyreviewCount2(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		System.out.println(id);
		try {
			conn = getConnection();
			String sql = "select count(*) from review where writer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
				System.out.println(result);
			}
		} catch( Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(Exception e) {e.printStackTrace();}
	        if(pstmt != null)try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
	        if(conn != null)try{conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	// 내가 작성한 리뷰 보여주기
	public List getMyreview2(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List myReviewList2 = null;
		
		try {
			conn = getConnection();
			String sql = "select * from review where writer=?"; 
					/*
							 * "select B.*, r " + "from (select A.*, rownum r from " +
							 * "(select * from review where writer=? order by num asc) A " +
							 * "order by num asc) B " + "where r >= ? and r <= ?";
							 */
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			myReviewList2 = new ArrayList();
			if(rs.next()) {
				myReviewList2 = new ArrayList();
				do {
					ReviewDTO dto = new ReviewDTO();
					dto.setNum(rs.getInt("num"));
					dto.setProNum(rs.getInt("proNum"));
					dto.setWriter(rs.getString("writer"));
					dto.setTitle(rs.getString("title"));
					dto.setStar(rs.getInt("star"));
					dto.setContent(rs.getString("content"));
					dto.setImg(rs.getString("img"));
					dto.setReg(rs.getTimestamp("reg"));
					myReviewList2.add(dto);
				} while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(Exception e) {e.printStackTrace();}
            if(pstmt != null)try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
            if(conn != null)try{conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return myReviewList2;
	}













}