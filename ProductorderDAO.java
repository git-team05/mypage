package team05.productorder;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team05.product.ProductDTO;
import team05.review.ReviewDAO;

public class ProductorderDAO {

	// 생성자 싱글톤
	private static ProductorderDAO instance = new ProductorderDAO();
	private ProductorderDAO() {};
	public static ProductorderDAO getInstance() { return instance; }
		
	// 커넥션 연결
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 주문정보 db에 저장
	public void insertProOrder(ProductorderDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "insert into productorder values(productorder_seq,?,?,?,?,?,?,?,?,?,?,default,default,sysdate";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getProNum());
			pstmt.setInt(2, dto.getQuantity());
			pstmt.setInt(3, dto.getOrderTotal());
			pstmt.setString(4, dto.getId());
			pstmt.setString(5, dto.getReceiver());
			pstmt.setString(6, dto.getRecZipcode());
			pstmt.setString(7, dto.getRecAddress());
			pstmt.setString(8, dto.getRecAddressDetail());
			pstmt.setString(9, dto.getRecPhone());
			pstmt.setString(10, dto.getRecEmail());
			int result = pstmt.executeUpdate();
			System.out.println("주문:" + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
			if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
		}
	}
	// id, proNum에 맞는 주문정보 가져오기
		public ProductorderDTO getProOrder(String id, int proNum) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ProductorderDTO dto = null;
			try {
				conn = getConnection();
				String sql = "select * form productorder where id=? and proNum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, proNum);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto = new ProductorderDTO();
					dto.setReceiver(rs.getString("receiver"));
					dto.setRecAddress(rs.getString("recAddress"));
					dto.setRecAddressDetail(rs.getString("recAddressDetail"));
					dto.setRecPhone(rs.getString("recPhone"));
					dto.setOrderTotal(rs.getInt("orderTotal"));
				}
				
			}
			catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace(); }
				if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace(); }
				if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace(); }
			}
			return dto;
		}
		// MypayCount 주문수
		public int getMypayCount(String id) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int result = 0;
			System.out.println(id);
			try {
				conn = getConnection();
				String sql = "select count(*) from productorder where id=? and paycon='finish'";
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
		// 나의 주문 내용 보여주기
	      public List getMypayment(String id) {
	         Connection conn = null;
	         PreparedStatement pstmt = null;
	         ResultSet rs = null;
	         List payList = null;
	         
	         try {
	            conn = getConnection();
	            String sql = "select o.*, p.proname, p.thumbimg from product p, productorder o "
	            		+ "where p.pronum = o.pronum and id=? and o.delcon = 'delSoon' and o.paycon = 'finish' "
	            		+ "order by o.ordernum desc";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, id);
	            rs = pstmt.executeQuery();
	            if(rs.next()) {
	               payList = new ArrayList();
	               do {
	                  MypaymentDTO dto = new MypaymentDTO();
	                  dto.setOrderNum(rs.getInt("orderNum"));
	                  dto.setProNum(rs.getInt("proNum"));
	                  dto.setQuantity(rs.getInt("quantity"));
	                  dto.setOrderTotal(rs.getInt("orderTotal"));
	                  dto.setId(rs.getString("id"));
	                  dto.setReceiver(rs.getString("receiver"));
	                  dto.setRecZipcode(rs.getString("recZipcode"));
	                  dto.setRecAddress(rs.getString("recAddress"));
	                  dto.setRecAddressDetail(rs.getString("recAddressDetail"));
	                  dto.setRecPhone(rs.getString("recPhone"));
	                  dto.setRecEmail(rs.getString("recEmail"));
	                  dto.setDelCon(rs.getString("delCon"));
	                  dto.setPayCon(rs.getString("payCon"));
	                  dto.setReg(rs.getTimestamp("reg"));
	                  dto.setProName(rs.getString("proName"));
	                  dto.setThumbImg(rs.getString("thumbImg"));
	                  payList.add(dto);
	               } while(rs.next());
	            }
	         }catch (Exception e) {
	            e.printStackTrace();
	         }finally {
	             if(rs != null)try{rs.close();}catch(Exception e) {e.printStackTrace();}
	               if(pstmt != null)try{pstmt.close();}catch(Exception e) {e.printStackTrace();}
	               if(conn != null)try{conn.close();}catch(Exception e) {e.printStackTrace();}
	         }
	         return payList;
	      }
		
		// orderNum 받아서 해당 주문 상세 정보 띄워주기.
	    public ProductorderDTO getmyorderCheck(int orderNum) {
	    	Connection conn = null;
	    	PreparedStatement pstmt = null;
	    	ResultSet rs = null;
	    	ProductorderDTO myorderCheck = null;
	    	 
	    	try {
	    		conn = getConnection();
	    		String sql = "select * from productorder where ordernum=?";
	    		pstmt = conn.prepareStatement(sql);
	    		pstmt.setInt(1, orderNum);
	    		rs = pstmt.executeQuery();
	    		
	    		if(rs.next()) {
	    			myorderCheck = new ProductorderDTO();
	    			myorderCheck.setOrderNum(orderNum);
	    			myorderCheck.setProNum(rs.getInt("proNum"));
	    			myorderCheck.setQuantity(rs.getInt("quantity"));
	    			myorderCheck.setOrderTotal(rs.getInt("orderTotal"));
	    			myorderCheck.setId(rs.getString("id"));
	    			myorderCheck.setReceiver(rs.getString("receiver"));
	    			myorderCheck.setRecZipcode(rs.getString("recZipcode"));
	    			myorderCheck.setRecAddress(rs.getString("recAddress"));
	    			myorderCheck.setRecAddressDetail(rs.getString("recAddressDetail"));
	    			myorderCheck.setRecPhone(rs.getString("recPhone"));
	    			myorderCheck.setRecEmail(rs.getString("recEmail"));
	    			myorderCheck.setDelCon(rs.getString("delCon"));
	    			myorderCheck.setPayCon(rs.getString("payCon"));
	    			myorderCheck.setReg(rs.getTimestamp("reg"));

	    		}
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	} finally {
	    		if(rs != null) try {rs.close();} catch (Exception e) {e.printStackTrace();}
				if(pstmt != null) try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
				if(conn != null) try {conn.close();} catch (Exception e) {e.printStackTrace();}	
	    	}
	    	
	    	return myorderCheck;
	    }
		
	 // 주문 취소하기 버튼을 누르면 데이터가 삭제되는것이 아니라 productorder Table의 paycon과 delcon이 cancel로 변경됨.
	 // orderNum 받아서 변경해주기.
	 // update productorder set delcon='cancel', paycon='cancel' where ordernum=?  
	    public int updateMyCancel(int orderNum) {
	         Connection conn = null;
	         PreparedStatement pstmt = null;
	         int result = -1;
	         
	         try {
	            conn = getConnection();
	            String sql = "update productorder set paycon='cancel' where ordernum=?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, orderNum);
	            result = pstmt.executeUpdate();
	            System.out.println("mycancel update :" + result);
	         } catch(Exception e) {
	            e.printStackTrace();
	         } finally {
	            if(pstmt != null) try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
	              if(conn != null) try {conn.close();} catch (Exception e) {e.printStackTrace();}
	         }
	         return result;
	      }
		// 내가 주문 취소한 갯수 count
	    public int getMycancelCount(String id) {
	    	Connection conn = null;
	    	PreparedStatement pstmt = null;
	    	ResultSet rs = null;
	    	int result = 0;
	    	System.out.println(id);
	    	
	    	try {
	    		conn = getConnection();
	    		String sql = "select count(*) from productorder where id=? and paycon='cancel'";
	    		pstmt = conn.prepareStatement(sql);
	    		pstmt.setString(1, id);
	    		rs = pstmt.executeQuery();
	    		if(rs.next()) {
	    			result = rs.getInt(1);
	    			System.out.println(result);
	    		}
	    	}catch(Exception e) {
	    		e.printStackTrace();
	    	}finally {
	    		if(rs!=null) try {rs.close();} catch(Exception e) {e.printStackTrace();}
				if(pstmt!=null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
				if(conn!=null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
	    	}
	    	return result;
	    }
	    
	    
		// 마이페이지 - 주문 취소 페이지에서 취소 내역 보여쥬기 paycon = 'cancel' 인걸로 보여주기
	    public List getMycancel(String id) {
	         Connection conn = null;
	         PreparedStatement pstmt = null;
	         ResultSet rs = null;
	         List mycancelList = null;
	     
	         try {
	        	 conn = getConnection();
	        	 String sql = "select o.*, p.proname, p.thumbimg from product p, productorder o "
		            		+ "where p.pronum = o.pronum and id=? and o.paycon ='cancel' "
		            		+ "order by o.ordernum desc";
	        	 pstmt = conn.prepareStatement(sql);
	        	 pstmt.setString(1, id);
	        	 rs = pstmt.executeQuery();
	        	 if(rs.next()) {
	        		 mycancelList = new ArrayList();
	        		 do {
	        			 MypaymentDTO dto = new MypaymentDTO();
	        			 dto.setOrderNum(rs.getInt("orderNum"));
		                 dto.setProNum(rs.getInt("proNum"));
		                 dto.setQuantity(rs.getInt("quantity"));
		                 dto.setOrderTotal(rs.getInt("orderTotal"));
		                 dto.setId(rs.getString("id"));
		                 dto.setReceiver(rs.getString("receiver"));
		                 dto.setRecZipcode(rs.getString("recZipcode"));
		                 dto.setRecAddress(rs.getString("recAddress"));
		                 dto.setRecAddressDetail(rs.getString("recAddressDetail"));
		                 dto.setRecPhone(rs.getString("recPhone"));
		                 dto.setRecEmail(rs.getString("recEmail"));
		                 dto.setDelCon(rs.getString("delCon"));
		                 dto.setPayCon(rs.getString("payCon"));
		                 dto.setReg(rs.getTimestamp("reg"));
		                 dto.setProName(rs.getString("proName"));
		                 dto.setThumbImg(rs.getString("thumbImg"));
		                 mycancelList.add(dto);
	        		 }while(rs.next());
	        	 }
	         } catch (Exception e) {
	        	 e.printStackTrace();
	         } finally {
	        	 if(rs!=null) try {rs.close();} catch(Exception e) {e.printStackTrace();}
	        	 if(pstmt!=null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
	        	 if(conn!=null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
	         }
	         return mycancelList;
	    }
	 // 상품이름 가져오는 메소드
	 		public String getProName(int proNum) {
	 			Connection conn = null;
	 			PreparedStatement pstmt = null;
	 			ResultSet rs = null;
	 			String proName = null;
	 			
	 			try {
	 				conn = getConnection();
	 				String sql = "select * from product where proNum=?";
	 				pstmt = conn.prepareStatement(sql);
	 				pstmt.setInt(1, proNum);
	 				rs = pstmt.executeQuery();
	 				if(rs.next()) {
	 					proName = rs.getString(1);
	 				}
	 				
	 			} catch (Exception e) {
	 				e.printStackTrace();
	 			} finally {
	 				if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	 				if(pstmt != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	 				if(conn != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	 			}
	 			
	 			return proName;
	 		}
	 		
		// 나의 주문중 배송중 인것의 수  paycon='finish' & delcon='shipping' count 메서드
		public int getMyshippingCount(String id) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int result = 0;
			System.out.println("shipping id : " + id);
			
			try {
				conn = getConnection();
				String sql = "select count(*) from productorder where id=? and paycon='finish' and delcon='delivery'";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
					System.out.println("shipping result :" + result);
				} 
			}catch(Exception e) {
					e.printStackTrace();
			} finally {
				if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	 			if(pstmt != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	 			if(conn != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			}
			return result;
		}
		// 배송중 리스트		 
		public List getMyshipping(String id) {
			Connection conn = null;
			PreparedStatement pstmt =null;
			ResultSet rs = null;
			List shippingList = null;
			
			try {
				conn = getConnection();
				String sql = "select o.*, p.proname, p.thumbimg from product p, productorder o "
	            		+ "where p.pronum = o.pronum and id=? and o.delcon = 'delivery' and o.paycon = 'finish' "
	            		+ "order by o.ordernum desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					shippingList = new ArrayList();
					do {
						MypaymentDTO dto = new MypaymentDTO();
						 dto.setOrderNum(rs.getInt("orderNum"));
		                  dto.setProNum(rs.getInt("proNum"));
		                  dto.setQuantity(rs.getInt("quantity"));
		                  dto.setOrderTotal(rs.getInt("orderTotal"));
		                  dto.setId(rs.getString("id"));
		                  dto.setReceiver(rs.getString("receiver"));
		                  dto.setRecZipcode(rs.getString("recZipcode"));
		                  dto.setRecAddress(rs.getString("recAddress"));
		                  dto.setRecAddressDetail(rs.getString("recAddressDetail"));
		                  dto.setRecPhone(rs.getString("recPhone"));
		                  dto.setRecEmail(rs.getString("recEmail"));
		                  dto.setDelCon(rs.getString("delCon"));
		                  dto.setPayCon(rs.getString("payCon"));
		                  dto.setReg(rs.getTimestamp("reg"));
		                  dto.setProName(rs.getString("proName"));
		                  dto.setThumbImg(rs.getString("thumbImg"));
		                  shippingList.add(dto);
					} while(rs.next());
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	 			if(pstmt != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	 			if(conn != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			}
			return shippingList;
		}
		// 내 주문중 배송완료 갯수 count   
		public int getMyshipsentCount(String id) {
			Connection conn = null;
			PreparedStatement pstmt =null;
			ResultSet rs = null;
			int result = 0;
			System.out.println("shipsent id:" + id);
			
			try {
				conn = getConnection();
				String sql = "select count(*) from productorder "
						+ "where id=? and paycon ='finish' and delcon='delFinish'";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
					System.out.println("shipsent result : " + result);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	 			if(pstmt != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	 			if(conn != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			}
			return result;
		} 
		// 배송완료 리스트
		public List getMyshipsent(String id) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs =null;
			List shipsentList = null;
			try {
				conn = getConnection();
				String sql = "select o.*, p.proname, p.thumbimg from product p, productorder o "
	            		+ "where p.pronum = o.pronum and id=? and o.delcon = 'delFinish' and o.paycon = 'finish' "
	            		+ "order by o.ordernum desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					shipsentList = new ArrayList();
					do {
						MypaymentDTO dto = new MypaymentDTO();
						dto.setOrderNum(rs.getInt("orderNum"));
		                  dto.setProNum(rs.getInt("proNum"));
		                  dto.setQuantity(rs.getInt("quantity"));
		                  dto.setOrderTotal(rs.getInt("orderTotal"));
		                  dto.setId(rs.getString("id"));
		                  dto.setReceiver(rs.getString("receiver"));
		                  dto.setRecZipcode(rs.getString("recZipcode"));
		                  dto.setRecAddress(rs.getString("recAddress"));
		                  dto.setRecAddressDetail(rs.getString("recAddressDetail"));
		                  dto.setRecPhone(rs.getString("recPhone"));
		                  dto.setRecEmail(rs.getString("recEmail"));
		                  dto.setDelCon(rs.getString("delCon"));
		                  dto.setPayCon(rs.getString("payCon"));
		                  dto.setReg(rs.getTimestamp("reg"));
		                  dto.setProName(rs.getString("proName"));
		                  dto.setThumbImg(rs.getString("thumbImg"));
		                  shipsentList.add(dto);
					} while(rs.next());
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	 			if(pstmt != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	 			if(conn != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			}
 			return shipsentList;
		}
		// 환불내역 count
		public int getMyrefundCount(String id) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int result = 0;
			
			try {
				conn =getConnection();
				String sql = "select count(*) from productorder where id=? and paycon ='refund'";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
					System.out.println("refund result :" + result);
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	 			if(pstmt != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	 			if(conn != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			}
			return result;
		}
		
		// 환불 내역 LISt
		public List getMyrefund(String id) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List myrefundList = null;
			try {
				conn = getConnection();
				String sql = "select o.*, p.proname, p.thumbimg from product p, productorder o "
	            		+ "where p.pronum = o.pronum and id=? and o.delcon = 'delFinish' and o.paycon = 'refund' "
	            		+ "order by o.ordernum desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					myrefundList = new ArrayList();
					do {
						MypaymentDTO dto = new MypaymentDTO();
						dto.setOrderNum(rs.getInt("orderNum"));
		                  dto.setProNum(rs.getInt("proNum"));
		                  dto.setQuantity(rs.getInt("quantity"));
		                  dto.setOrderTotal(rs.getInt("orderTotal"));
		                  dto.setId(rs.getString("id"));
		                  dto.setReceiver(rs.getString("receiver"));
		                  dto.setRecZipcode(rs.getString("recZipcode"));
		                  dto.setRecAddress(rs.getString("recAddress"));
		                  dto.setRecAddressDetail(rs.getString("recAddressDetail"));
		                  dto.setRecPhone(rs.getString("recPhone"));
		                  dto.setRecEmail(rs.getString("recEmail"));
		                  dto.setDelCon(rs.getString("delCon"));
		                  dto.setPayCon(rs.getString("payCon"));
		                  dto.setReg(rs.getTimestamp("reg"));
		                  dto.setProName(rs.getString("proName"));
		                  dto.setThumbImg(rs.getString("thumbImg"));
		                  myrefundList.add(dto);
					} while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	 			if(pstmt != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
	 			if(conn != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			}
			return myrefundList;
		}
		
		
		
}