package team05.productorder;

import java.sql.Timestamp;

public class MypaymentDTO {
	private int orderNum;
	private int proNum;
	private int quantity;
	private int orderTotal;
	private String id;
	private String receiver;
	private String recZipcode;
	private String recAddress;
	private String recAddressDetail;
	private String recPhone;
	private String recEmail;
	private String delCon;
	private String payCon;
	private Timestamp reg;
    private String proName;
    private String thumbImg;
    
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}

	public String getThumbImg() {
		return thumbImg;
	}
	public void setThumbImg(String thumbImg) {
		this.thumbImg = thumbImg;
	}
	
	public int getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}
	public int getProNum() {
		return proNum;
	}
	public void setProNum(int proNum) {
		this.proNum = proNum;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getOrderTotal() {
		return orderTotal;
	}
	public void setOrderTotal(int orderTotal) {
		this.orderTotal = orderTotal;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getRecZipcode() {
		return recZipcode;
	}
	public void setRecZipcode(String recZipcode) {
		this.recZipcode = recZipcode;
	}
	public String getRecAddress() {
		return recAddress;
	}
	public void setRecAddress(String recAddress) {
		this.recAddress = recAddress;
	}
	public String getRecAddressDetail() {
		return recAddressDetail;
	}
	public void setRecAddressDetail(String recAddressDetail) {
		this.recAddressDetail = recAddressDetail;
	}
	public String getRecPhone() {
		return recPhone;
	}
	public void setRecPhone(String recPhone) {
		this.recPhone = recPhone;
	}
	public String getRecEmail() {
		return recEmail;
	}
	public void setRecEmail(String recEmail) {
		this.recEmail = recEmail;
	}
	public String getDelCon() {
		return delCon;
	}
	public void setDelCon(String delCon) {
		this.delCon = delCon;
	}
	public String getPayCon() {
		return payCon;
	}
	public void setPayCon(String payCon) {
		this.payCon = payCon;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
}
