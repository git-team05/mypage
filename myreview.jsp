<%@page import="java.text.SimpleDateFormat"%>
<%@page import="team05.review.ReviewDTO"%>
<%@page import="team05.productorder.MypaymentDTO"%>
<%@page import="java.util.List"%>
<%@page import="team05.review.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
	ul.tabs {
			align : centen;
            margin: 0;
            padding: 0;
            float: left;
            list-style: none;
            height: 32px; /*--Set height of tabs--*/
            border-bottom: 1px solid #999;
            border-left: 1px solid #999;
            width: 100%;
        }
        ul.tabs li {
            float: left;
            margin: 0;
            padding: 0;
            height: 31px; /*--Subtract 1px from the height of the unordered list--*/
            line-height: 31px; /*--Vertically aligns the text within the tab--*/
            border: 1px solid #999;
            border-left: none;
            margin-bottom: -1px; /*--Pull the list item down 1px--*/
            overflow: hidden;
            position: relative;
            background: #e0e0e0;
        }
        ul.tabs li a {
            text-decoration: none;
            color: #000;
            display: block;
            font-size: 1.2em;
            padding: 0 20px;
            /*--Gives the bevel look with a 1px white border inside the list item--*/
            border: 1px solid #fff; 
            outline: none;
        }
        ul.tabs li a:hover {
            background: #ccc;
        }
        html ul.tabs li.active, html ul.tabs li.active a:hover  {
             /*--Makes sure that the active tab does not listen to the hover properties--*/
            background: #fff;
            /*--Makes the active tab look like it's connected with its content--*/
            border-bottom: 1px solid #fff; 
        }

        /*Tab Conent CSS*/
        .tab_container {
            border: 1px solid #999;
            border-top: none;
            overflow: hidden;
            clear: both;
            float: left; 
            width: 100%;
            background: #fff;
        }
        .tab_content {
            padding: 20px;
            font-size: 1.2em;
        }
    </style>



    <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {

            //When page loads...
            $(".tab_content").hide(); //Hide all content
            $("ul.tabs li:first").addClass("active").show(); //Activate first tab
            $(".tab_content:first").show(); //Show first tab content

            //On Click Event
            $("ul.tabs li").click(function() {

                $("ul.tabs li").removeClass("active"); //Remove any "active" class
                $(this).addClass("active"); //Add "active" class to selected tab
                $(".tab_content").hide(); //Hide all tab content

                var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
                $(activeTab).fadeIn(); //Fade in the active ID content
                return false;
            });

        });
    </script>
</head>
<% 
	String id = (String)session.getAttribute("memId"); 
	ReviewDAO dao = ReviewDAO.getInstance();
	System.out.println(id);
	// ?????? ????????? ?????? count 
	int count1 = dao.getMyreviewCount1(id); 
	List myReviewList= null;  
	// ?????? ????????? ?????? ?????? ????????????
	if(count1 >0) {
		myReviewList = dao.getMyreview1(id);
		System.out.println("count1 :" + count1);
	}
	
	// ????????? ?????? count
	int count2 = dao.getMyreviewCount2(id); 
	List myReviewList2 = null;
	// ????????? ?????? ?????? ????????????
	if(count2 >0) {
		myReviewList2 = dao.getMyreview2(id);
		System.out.println("count2 :" + count2);
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
%>
 
<body>
	<div>
		<tr>
			<td colspan="2">
				<jsp:include page="mylayoutTop.jsp"></jsp:include>
			</td>
		</tr>
	</div>
	<div>	
		<tr>
			<td width="15%">
		    	<jsp:include page="mylayoutLeft.jsp"></jsp:include>
		    </td>
		</tr>
	</div>
	<div>	    
		<br/>
		<h2 align="center"> ?????? ?????? </h2>		
		<div id="wrapper">    
    	<!--??? ?????? ?????? -->
    		<ul class="tabs" align="center">
		        <li><a href="#tab1">?????? ????????? ??????</a></li>
		        <li><a href="#tab2">????????? ??????</a></li>
		    </ul>
    	<!--??? ????????? ?????? -->
	    	<div class="tab_container">
		        <div id="tab1" class="tab_content">
	    	        <!--Content-->
	    	        <%if(count1 ==0) { %>
	    	        	<table>
	    	        		<tr>
	    	        			<td>?????? ????????? ????????? ????????????.</td>
	    	        		</tr>
	    	        	</table>
					<%} else if(count1 > 0) { %>
						<table>
							<tr>
								<td></td>
								<td>????????????</td>
								<td>????????????</td>
								<td>?????????</td>
							</tr>
							<%for(int i =0; i <myReviewList.size(); i++) {
								MypaymentDTO myReview1 = (MypaymentDTO)myReviewList.get(i);								
							%>
								<tr>
									<td>
										<a href="/team05/product/productContent.jsp?">
										<img src="/team05/imgs/<%=myReview1.getThumbImg() %>" /> </a>
									</td>
									<td><%=myReview1.getOrderNum() %></td>
									<td><%=myReview1.getProNum() %></td>
									<td><%=myReview1.getProName() %></td>
									<td> <button onclick="window.location='/team05/product/productReviewForm.jsp?proNum=<%=myReview1.getProNum() %>'">????????????</td> 
								</tr>
							<%} %>
						</table>
					<%} %>	
	        	</div>
	
		        <div id="tab2" class="tab_content">
		           <!--Content-->
		           <%if(count2 ==0) { %>
	    	        	<table>
	    	        		<tr>
	    	        			<td>????????? ????????? ????????????.</td>
	    	        		</tr>
	    	        	</table>
					<%} else if(count2 > 0) { %>
						<table>
							<tr>
								<td></td>
								<td>????????????</td>
								<td>????????????</td>
								<td>??????</td>
								<td>??????</td>
								<td>??????</td>
								<td>????????? </td>
							</tr>
							<%for(int i =0; i <myReviewList2.size(); i++) {
								ReviewDTO myReview2 = (ReviewDTO)myReviewList2.get(i);								
							%>
								<tr>
									<td>
										<a href="/team05/product/productContent.jsp?">
										<img src="/team05/imgs/<%=myReview2.getImg() %>" /> </a>
									</td>
									<td><%=myReview2.getNum() %></td>
									<td><%=myReview2.getProNum() %></td>
									<td><%=myReview2.getTitle() %></td>
									<td><%=myReview2.getStar() %></td>
									<td><%=myReview2.getContent() %></td>
									<td><%= sdf.format(myReview2.getReg()) %></td>
								</tr>
							<%} %>
						</table>
					<%} %>	
		        </div>
	    	</div>
		</div>
	</div>	
</body>
</html>