<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctxPath = request.getContextPath(); // MyMVC
%>

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/js/buy/buygame.js"></script>





<style>

/* 버튼 관련 라디오 */
  input[type="radio"] {
  	display: none;
  }
  
  body > div.row.mx-auto > div.col-4 > div > div.table-responsive > table > tbody > tr:nth-child(1) > td:nth-child(1) > label
  ,body > div.row.mx-auto > div.col-4 > div > div.table-responsive > table > tbody > tr:nth-child(2) > td:nth-child(1) > label
  ,body > div.row.mx-auto > div.col-4 > div > div.table-responsive > table > tbody > tr:nth-child(3) > td:nth-child(1) > label {
  
  text-align: left;
  
  }

  .custom-transparent-button {
    background-color: transparent;
    border: none;
    width: 250px;
  }

  .custom-transparent-button:focus {
    outline: none; /* 클릭 포커스 효과 제거 */
  }

  .custom-transparent-button:active {
    opacity: 0.5; /* 클릭 시 투명도 조절 (0.5은 예시, 필요에 따라 조절 가능) */
  }
  
   .custom-transparent-button.active {
    border-left:  solid 10px #007bff !important; /* 클릭된 버튼의 배경 색상을 지정 */
    color: #fff; /* 클릭된 버튼의 텍스트 색상을 지정 */
  }
/* 버튼 관련 라디오 */


a>i{

    color: white;
    font-size:20pt;
    font-weight: bold;  
}


div.imgsm img {
	width: 100%;
	height: 150px;
}

div.carousel-item.active img,
div.carousel-item img {
	
	/* border: solid 1px white; */
	width: 1000px; 
	height: 500px;
	

}

.game_logo{
	width: 75px;
	height: 75px;

}

li.btn{

	width:100%;
	height: 50px;
	color:white;
	text-align: center; 
	font-weight:bold;
	font-size: 16pt;

}

tr.price{
	height: 70px;
	border-bottom: 1px solid rgba(192, 192, 192, 0.5);

}

td.per{
	text-align: right;
	vertical-align: bottom !important;
} 
td.per>span{
	
	background-color:#00FF00;
	color:black;
	font-weight:bold;
	font-size: 14pt;
	border-radius: 5px;
	width:1%;
	
}

span.opttitle{
	
	font-weight:bold;
	font-size: 16pt;
	font-weight:bold;
	color:white;
}

span.panmaeprice{
	
	font-weight:bold;
	font-size: 16pt;
	font-weight:bold;
	color:#00FF00;

}

span.saleprice{
	
	text-decoration: line-through;
	color:#ccc;
	font-size: 14pt;
	font-weight:bold;
} 

td#error {
  vertical-align: middle;
  text-align: center; /* 텍스트를 수평 중앙에 배치하기 위해서 */
  color: red;
 
  font-size: 14pt;
  font-weight:bold;
}


</style>






<%-- <br><br><br><br><br><br><br><br><br>
구매해야할 제품번호 : ${requestScope.imgsetno} --%>
<%-- 
   <div>
       ${requestScope.제품번호VO.jepumname}
   </div>
--%>


<jsp:include page="header_shop.jsp" />
<%-- 전체 --%>

<script>
  $(document).ready(function () {
	  
	let isOrderOK = false;
	// 로그인한 사용자가 해당 제품을 구매한 상태인지 구매하지 않은 상태인지 알아오는 용도.
	// isOrderOK 값이 true 이면   로그인한 사용자가 해당 제품을 구매한 상태이고,
	// isOrderOK 값이 false 이면  로그인한 사용자가 해당 제품을 구매하지 않은 상태로 할 것임.
	  
    $('.custom-transparent-button').click(function () {
      // 모든 버튼에서 'active' 클래스 제거
      $('.custom-transparent-button').removeClass('active');
      // 클릭된 버튼에만 'active' 클래스 추가
      $(this).addClass('active');
    });
    
    /* document.addEventListener("keydown", function (e) {
    	// 모든 키보드 입력을 무시
    	e.preventDefault();
   	}); */
    
   
    // 1 ~ 10 까지
    $("input#spinner").spinner( {
        spin: function(event, ui) {
           if(ui.value > 100) {
              $(this).spinner("value", 10);
              return false;
           }
           else if(ui.value < 1) {
              $(this).spinner("value", 1);
              return false;
           }
        }
     });// end of $("input#spinner").spinner({});----------------    
     
     
	$("button#btnCommentOK").click(function() {
		isOrderOK = true;
		if(${empty sessionScope.loginuser}) {
            alert("제품사용 후기를 작성하시려면 먼저 로그인 하셔야 합니다.");
            return;
        }
		
		/* 
		if(isOrderOK == false) {  
            alert("제품을 구매하셔야만 후기작성이 가능합니다.");
        } */
        else {   
            var commentContents = $("textarea[name=contents]").val().trim();
            
            if(commentContents == "") {
               alert("제품후기 내용을 입력하세요!!");
               return; 
            }
         // 보내야할 데이터를 선정하는 첫번째 방법
         <%-- 
         var queryString = {"fk_userid":'${sessionScope.loginuser.userd}', 
                            "fk_pnum" : '${requestScope.pvo.pnum}',
                            "contents" : $("textarea[name=contents]").val()};
         --%>
         // 보내야할 데이터를 선정하는 두번째 방법
         // jQuery에서 사용하는 것으로써,
         // form태그의 선택자.serialize(); 을 해주면 form 태그내의 모든 값들을 name값을 키값으로 만들어서 보내준다. 
         var queryString = $("form[name=commentFrm]").serialize();
         // console.log(queryString);
         // contents=very%20Good&fk_userid=seoyh&fk_pnum=57
         // %20 은 공백이다.
         
         $.ajax({
            url:"<%= request.getContextPath()%>/shop/reviewRegister.bz",
            type:"POST",
            data:queryString,
            dataType:"JSON",
            success:function(json){ // {"n":1} 또는 {"n":-1} 또는  {"n":0}
               if(json.n == 1) {
                   // 제품후기 등록(insert)이 성공했으므로 제품후기글을 새로이 보여줘야(select) 한다.
                   alert("후기등록성공"); //goCommentListView(); // 제품후기글을 보여주는 함수 호출하기 
                 }
                 else if(json.n == -1)  {
                 // 동일한 제품에 대하여 동일한 회원이 제품후기를 2번 쓰려고 경우 unique 제약에 위배됨 
               // alert("이미 후기를 작성하셨습니다.\n작성하시려면 기존의 제품후기를\n삭제하시고 다시 쓰세요.");
                  swal("이미 후기를 작성하셨습니다.\n작성하시려면 기존의 제품후기를\n삭제하시고 다시 쓰세요.");
               }
                 else  {
                    // 제품후기 등록(insert)이 실패한 경우 
                    alert("제품후기 글쓰기가 실패했습니다.");
                 }
               
               $("textarea['name=contents']").val("").focus();
            },
            error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
         });
      
       }// end of if ~ else -------------------------
       
	}); // end of $("button#btnCommentOK").click(function() 
  
    
  });
  
  function openPopup() {
      
 	   // 너비 800, 높이 480 인 팝업창을 화면 가운데 위치시키기
      const width = 800;
      const height = 480;
      const left = Math.ceil( (window.screen.width - width)/2 );  // 정수로 만듬
      const top = Math.ceil( (window.screen.height - height)/2 );   // 정수로 만듬
      
      popup = window.open("http://localhost:9090/SemiProject/shop/reviewPopup.bz", "imgInfo",
                         `left=\${left}, top=\${top}, width=\${width}, height=\${height}`);
      
 	    
   }// end of function openPopup(src)------------------


    /////////////////////////////////////////////////////////////////////
   // **** 특정제품에 대한 좋아요 등록하기 **** // 
   function golikeAdd(g_code) {
   
      if(${empty sessionScope.loginuser}) {
    	  alert("좋아요 하시려면 로그인이 필요합니다.");
    	  return; // 종료
      }
      
      if(!isOrderOK) { // 해당 제품을 구매하지 않은 경우라면
    	  alert("${requestScope.gameVO.g_name} 제품을 구매하셔야만 좋아요가 가능합니다.");
      }
      else { // 해당 제품을 구매한 경우라면
    	  $.ajax({
              url:"<%= ctxPath%>/shop/likeAdd.bz",
              type:"post",
              data:{"g_code":g_code,
                    "user_id":"${sessionScope.loginuser.user_id}"},
              dataType:"JSON", 
              success:function(json) {
                  // console.log(JSON.stringify(json));
                  // {"msg":"해당제품에\n 좋아요를 클릭하셨습니다."}
                  // 또는
                  // {"msg":"이미 좋아요를 클릭하셨기에\n 두번 이상 좋아요는 불가합니다."}
                    
                  // alert(json.msg);
                  swal(json.msg);
                  goLikeDislikeCount();
              },
              error: function(request, status, error){
                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
              }
           });
      }
      
      
   }// end of golikeAdd(pnum)---------------------------
   
   
   // **** 특정 제품에 대한 좋아요, 싫어요 갯수를 보여주기 **** //
   function goLikeDislikeCount() {

	   $.ajax({
	         url:"<%= ctxPath%>/shop/likeDislikeCount.bz",
	      // type:"GET",
	         data:{"g_code":"${requestScope.gamevo.g_code}"},
	         dataType:"JSON", 
	         success:function(json) {
	            console.log(JSON.stringify(json));
	             // {"likecnt":1, "dislikecnt":0}
	             
	            $("span#likeCnt").html(json.likecnt);
	            $("span#dislikeCnt").html(json.dislikecnt);
	         },
	         error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	         }
	      });    
      
   }// end of function goLikeDislikeCount()-------------------
   
   ///////////////////////////////////////////////////////////// --%>
</script>

<c:if test="${not empty requestScope.gameVO}">

	<div class="row mx-auto" style="width:95%; margin: 6% 0 0 0">
	
	
	    
		<%-- 8분할 --%>	
		<div class="col-8">
		<%-- Bootstrap 그리드 시스템 클래스는 기본적으로 패딩과 간격을 포함하는데, 이로 인해 캐러셀이 왼쪽 끝에 붙이지 않을 수 있습니다. 또한, margin: 0을 명시적으로 지정하면서 간격을 줄여버릴 수도 있습니다. 
		
		--%>
		
			<%-- 캐러셀 시작 --%>
			
			<div id="carousel_slide" class="carousel slide carousel-fade" data-ride="carousel" style="width:95%; margin:0 0 0 0">
		 		
	 		<%-- Bootstrap 캐러셀(Carousel)의 인디케이터(Indicator) --%>
	 		<%-- 현재 표시되는 슬라이드와 그 개수를 나타내며, 사용자가 특정 슬라이드로 직접 이동할 수 있도록 돕는 역할을 합니다. --%>
	 		
	 		<ol class="carousel-indicators">
	            <li data-target="#carousel_slide" data-slide-to="0" class="active"></li>
	             <c:if test="${not empty requestScope.OptiList}">
                        <c:forEach items="${requestScope.OptiList}" varStatus="status">
                                <li data-target="#carouselExampleIndicators" data-slide-to="${status.index+1}"></li>
                        </c:forEach>
                 </c:if>
			</ol>
			
			<%-- Bootstrap 캐러셀(Carousel)의 인디케이터(Indicator) --%>
			<%-- 캐러셀 이너 --%>
				
			<div class="carousel-inner">
	
				<div class="carousel-item active">
					<img src="<%= ctxPath %>/img/tbl_game_product_image/${requestScope.gameVO.g_img_1}" class="img-fluid">
				</div>
			
                <c:if test="${not empty requestScope.OptiList}">
                	<c:forEach var="optvo" items="${requestScope.OptiList}">	
				    	<div class="carousel-item">
                        	<img src="<%= ctxPath%>/img/tbl_game_option/${optvo.imgfile}" class="img-fluid">
                        </div>
                    </c:forEach>
                </c:if>
			
			</div>
			<%-- 캐러셀 이너 끝 --%>
			
			<%--캐러셀(Carousel)의 화살표 컨트롤--%>	
			<a class="carousel-control-prev" href="#carousel_slide" role="button" data-slide="prev">
	            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	            <span class="sr-only">Previous</span>
	        </a>
            
            <a class="carousel-control-next" href="#carousel_slide" role="button" data-slide="next">
            	<span class="carousel-control-next-icon" ariahidden="true"></span>
            	<span class="sr-only">Next</span>
            </a>
			<%--캐러셀(Carousel)의 화살표 컨트롤--%>
			
			
		</div>
			<%-- 캐러셀 끝 --%>
		
		<div class="row mt-3" style="width: 950px;" >	
			
			<div class="col-3 mr-auto imgsm">
				<img src="<%= ctxPath %>/img/tbl_game_product_image/${requestScope.gameVO.g_img_1}" class="img-fluid">
			</div>
			
			<c:if test="${not empty requestScope.OptiList}">
            	<c:forEach var="optvo" items="${requestScope.OptiList}">	
	    			<div class="col-3 mr-auto imgsm">
                    	<img src="<%= ctxPath%>/img/tbl_game_option/${optvo.imgfile}" class="img-fluid">
                    </div>
                </c:forEach>
            </c:if>
				
			<div class="text-white">
				
				<h1>${requestScope.gameVO.g_content}</h1>
				<h5> ${requestScope.gameVO.g_info}</h5>
		
			</div>
		
		</div>		
		
	</div> 
	<%-- 8분할 --%>		
		
    
    <div class="col-4">
    
    <div class="container text-white" style="">
	    <div class="row">	
		    <div class="col-3">
		    	<img class="game_logo" src="<%= ctxPath%>/img/tbl_game_option/logo-d4.png"></img>
		    </div>
		    <div>
				<h2 class="mt-3">${requestScope.gameVO.g_content}</h2>
			    <p>${requestScope.gameVO.fk_s_code} 카테고리가 들어갈것임</p> 
		    </div>
    	</div>
     
    <div class="table-responsive">           
    	<table class="table table-borderless">
        
	        <thead>
	        	<tr class="price">
	            	<th class="h3 text-white">상품 선택</th>
	                <th class="h5 text-right" style="color: #00FF00;">할인</th>
	            </tr>
	        </thead>
          
        	<tbody>
           	
           	
           	
	           <c:if test="${not empty requestScope.OptiList}">
	            	<c:forEach var="optvo" items="${requestScope.OptiList}">
			  			<tr class="price custom-radio">
						    <td>
							    <label class="btn custom-transparent-button">
							    <input type="radio" id="${optvo.opt_name}" name="coinmoney" value="${optvo.opt_sale_price}"/>
							    <span class="opttitle">${optvo.opt_name}</span>
							    <br>
							    <span class="panmaeprice">${optvo.opt_sale_price}</span>
							    <span class="saleprice">${optvo.opt_price}</span>
							    </label>
						    </td>
						    <td class="per">
						      <span>${optvo.fk_g_code}</span>
						    </td>
			 		 	</tr>
	  				</c:forEach>
	  				<%-- <c:if test="${not empty requestScope.gameVO}"> 옵션이 비었을경우 --%>
	  			</c:if>
	  			
	  			<c:if test="${empty requestScope.OptiList}">
	  					<tr class="price custom-radio">
						    <td>
							    <label class="btn custom-transparent-button">
							    <input type="radio" id="${requestScope.gameVO.g_name}" name="coinmoney" value="${requestScope.gameVO.g_price}"/>
							    <span class="opttitle">${requestScope.gameVO.g_name}</span>
							    <br>
							    <span class="panmaeprice">${requestScope.gameVO.g_sale_price}</span>
							    <span class="saleprice">${requestScope.gameVO.g_price}</span>
							    </label>
						    </td>
						    <td class="per">
						      <span>${requestScope.gameVO.g_code}</span>
						    </td>
			 		 	</tr>
			 		 </c:if>
	  			
  			
       	
	            <tr>
	               <td id="error" colspan="3"><br>결제종류에 따른 금액을 선택하세요!!</td>
	            </tr>
             
          </tbody>
        </table>
     </div>
     
     <div class="purchase-btn text-center">
	 	
	 	 <%-- ==== 장바구니 주문 개수 폼 ==== --%>
         <form name="goCartFrm">       
            <ul class="list-unstyled mt-3">
                <li>잔고갯수: <span style="color: maroon; font-weight: bold;">${requestScope.gameVO.g_qty} 개</span></li> 
                <li>
                    <label for="spinner">주문개수&nbsp;</label>
                    <input id="spinner"  name="oqty"   value="1" style="width: 110px;">
                    <input type="hidden" name="g_code" value="${requestScope.gameVO.g_code}" >
                    <input type="hidden" name="paymoney" >
                    <input type="hidden" name="g_qty" value="${requestScope.gameVO.g_qty}">
                </li>
            </ul>
         </form> 
		 <%-- ==== 장바구니 주문 개수 끝 ==== --%> 
		  
	 	<ul class="list-unstyled">
	    	
	    	<li id="purchase" onclick="buygame('<%=ctxPath %>','${sessionScope.loginuser.user_id}')" class="btn btn-primary">
	          &nbsp;<i class="fa-brands fa-square-facebook"></i> 구매하기
	    	</li>
	      	
	      	<li class="btn btn-danger mt-2" onclick="goCart()">
	          	&nbsp;<i class="fa-brands fa-google"></i> 장바구니
	      	</li>
	      		      	
	      	<li class="btn btn-success mt-2">
	          &nbsp;<i class="fa-brands fa-square-x-twitter"></i> 코인구매
	        </li>
	    
	    </ul>
	  
	   <%-- PG(Payment Gateway 결제대행)에 코인금액을 카드(카카오페이등)로 결제후 DB상에 사용자의 코인액을 update 를 해주는 폼이다. --%>

	   <form name="coin_DB_Update_Frm">
		   	<input type="hidden" name="user_id" />
		   	<input type="hidden" name="coinmoney" />	
	   </form>
	  	
	    
	</div>
	
	<ul class="text-white">
     	<li>플레이하려면 인터넷 연결, Battle.net® 계정, Battle.net® 데스크톱 앱이 필요합니다.
     	</li>
		<li>* 탈것은 사용 전 게임 내에서 미리 해제해야 합니다.</li>
		<li>** 디아블로® III 및 월드 오브 워크래프트는 별도 판매되거나 별도 다운로드가 필요합니다.</li>
		<li>***배틀 패스 잠금 해제는 디아블로® IV 시즌 배틀 패스에만 적용됩니다.</li>
		<li><a>시스템 요구사양</a></li>     
     	<li><a>제품 설명</a></li>   
     </ul>
   
   </div>
  
  </div>

</div>

<hr class="mx-auto" style="background-color: white; width:95%;">


<div class="row mx-auto mt-3" style="width:95%;">
	
	<div class="col-4">
        <div class="h1 text-white">
           상품비교
        </div>
	</div>
	
	<div class="col-8">
	   
		<div class="row mt-3" style="width: 950px;" >	
			
			 <c:if test="${not empty requestScope.OptiList}">
	           	<c:forEach var="optvo" items="${requestScope.OptiList}">
	           		<div class="col-4 mr-auto imgsm">
	            		<img src="<%= ctxPath %>/img/tbl_game_option/${optvo.imgfile}" class="img-fluid">
						<ul class="text-center">
			       			<li><span class="opttitle">${optvo.opt_name}</span></li>
							<li> <span class="panmaeprice">${optvo.opt_sale_price}</span></li>
							<li><span class="saleprice">${optvo.opt_price}</span></li>
							<li id="purchase" class="btn btn-primary">
					          &nbsp;<i class="fa-brands fa-square-facebook"></i> 구매하기
					    	</li>
					    	<li>
					    		<span class="opttitle"> 대충 설명 ㄱㄱ</span>
					    	</li>
						</ul>
	           		</div>
	           	</c:forEach>
	         </c:if>
	          
			
		</div>
	</div>
</div>




<hr style="background-color: white;">

<div class="row mx-auto mt-3" style="width:95%;">
	
	<div class="col-4">
	        <div class="h1 text-white">
	           주요특징
	        </div>
	</div>
	
	<div class="col-8">
	   
	   <div class="row mt-3" style="width: 950px;" >	
		
		<div class="col-4 mr-auto imgsm">
			<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename}" class="img-fluid">
			<ul class="text-center">
       			<li><span class="opttitle">베이직 에디션</span></li>
				<li> <span class="panmaeprice">35,000</span></li>
				<li><span class="saleprice">50,000</span></li>
				<li id="purchase" class="btn btn-primary">
		          &nbsp;<i class="fa-brands fa-square-facebook"></i> 구매하기
		    	</li>
		    	<li>
		    		<i class="btn btn-success mt-3" onclick="openPopup()">제품후기</i>
		    	</li>
		    	<li><span class="opttitle">일반판
일반판에는 디아블로® III 내에서 지급되는 이나리우스 날개 및 이나리우스 멀록 애완동물**, 월드 오브 워크래프트® 내에서 지급되는 격노의 융합체 탈것**이 포함되어 있습니다.
</span>
		    	</li>
			</ul>
		</div>
		
		<div class="col-4 mr-auto imgsm">
			<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename_2}" class="img-fluid">
			<ul class="text-center">
       			<li><span class="opttitle">베이직 에디션</span></li>
				<li> <span class="panmaeprice">35,000</span></li>
				<li><span class="saleprice">50,000</span></li>
				<li id="purchase" class="btn btn-primary">
		          &nbsp;<i class="fa-brands fa-square-facebook"></i> 구매하기
		    	</li>
		    	<li><span class="opttitle">일반판
일반판에는 디아블로® III 내에서 지급되는 이나리우스 날개 및 이나리우스 멀록 애완동물**, 월드 오브 워크래프트® 내에서 지급되는 격노의 융합체 탈것**이 포함되어 있습니다.
</span>
		    	</li>
			</ul>
		</div>
		
		<div class="col-4 mr-auto imgsm">
			<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename_3}" class="img-fluid">
						<ul class="text-center">
       			<li><span class="opttitle">베이직 에디션</span></li>
				<li> <span class="panmaeprice">35,000</span></li>
				<li><span class="saleprice">50,000</span></li>
				<li id="purchase" class="btn btn-primary">
		          &nbsp;<i class="fa-brands fa-square-facebook"></i> 구매하기
		    	</li>
		    	<li><span class="opttitle">일반판
일반판에는 디아블로® III 내에서 지급되는 이나리우스 날개 및 이나리우스 멀록 애완동물**, 월드 오브 워크래프트® 내에서 지급되는 격노의 융합체 탈것**이 포함되어 있습니다.
</span>
		    	</li>
			</ul>
		</div>
		
		</div>
		<div class="row">
		<div class="col-4 mr-auto imgsm">
			<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename_2}" class="img-fluid">
			<ul class="text-center">
       			<li><span class="opttitle">베이직 에디션</span></li>
				<li> <span class="panmaeprice">35,000</span></li>
				<li><span class="saleprice">50,000</span></li>
				
				<li id="purchase" class="btn btn-primary">
		          &nbsp;<i class="fa-brands fa-square-facebook"></i> 구매하기
		    	</li>
		    	
		    	<li><span class="opttitle">일반판
일반판에는 디아블로® III 내에서 지급되는 이나리우스 날개 및 이나리우스 멀록 애완동물**, 월드 오브 워크래프트® 내에서 지급되는 격노의 융합체 탈것**이 포함되어 있습니다.
</span>
		    	</li>
			</ul>
		</div>
		
		</div>
		
			
	</div>
	   	
	</div>

<hr style="background-color: white;">

<div class="row mx-auto mt-3" style="width:95%;">
	
	<div class="col-4">
	        <div class="h1 text-white">
	           시스템 요구사항
	        </div>
	</div>
	
	<div class="col-8">
	   	<div>
	   			<span class="text-white h3"><i class="fa-brands fa-windows"></i>&nbsp;Windows&nbsp;&&nbsp;</span> 
	   			<span class="text-white h3"><i class="fa-brands fa-apple"></i>&nbsp;MAC</span> 
	   	</div>
	   	
	   	<hr style="background-color: white;">
	   	
		<div class="row">
	   		<div class="col-6">
	   			
	   			<span class="text-white h3"><i class="fa-brands fa-windows"></i>&nbsp;Windows</span> 
	   		
	   		<div class="text-white">
	   			
	   		<div class="row mt-4">
   				<div class="col-6">
		   			<h5>OS</h5>
		   			<span>윈도우® 7 64-bit</span>
	   			</div>
	   				
	   		<div class="col-6">
 				<h5>CPU</h5> 
 				<span>인텔® Core™ i5-760 또는 AMD FX™-8100 또는 그 이상</span>
 				<br>
 
	   		</div>
		   		
		   </div>
   		
   		   <div class="row mt-4">
  				<div class="col-6">
	   			<h5>비디오카드</h5>
	   			<span>윈도우® 7 64-bit</span>
   		   </div>
  				
  		   <div class="col-6">
  		   	   <h5>RAM</h5> 
  			   <span>4 GB RAM (Intel HD Graphics 530의 경우 8GB)</span>
  		   </div>
   		
   		  </div>
		   	
				 		
   		 <div class="row mt-4">
			<div class="col-6">
	 			<h5>저장공간</h5>
	 			<span>70GB 이상의 하드디스크 여유 공간(7200RPM)</span>
			</div>
			
			<div class="col-6">
				<h5>인터넷</h5> 
				<span>광대역 인터넷 연결</span>
			</div>
   		
   		 </div>
		   		
   		 		
   		<div class="row mt-2">
  				<div class="col-6">
	   			<h5>입력장치</h5>
	   			<span>키보드 및 마우스. 그 외의 입력장치는 지원하지 않습니다.</span>
   			</div>
  				
				<div class="col-6">
					<h5>해상도</h5> 
					<span>최소 1024 x 768 디스플레이 해상도</span>
				</div>
   		
   		</div>		   		
	
	   			
	   	</div>
	   		
   		</div>
   		
   		<div class="col-6">
   			<span class="text-white h3"><i class="fa-brands fa-apple"></i>&nbsp;MAC</span>  
			
			<div class="text-white">
   			
   			<div class="row mt-4">
   				<div class="col-6">
		   			<h5>OS</h5>
		   			<span>윈도우® 7 64-bit</span>
	   			</div>
   				
   				<div class="col-6">
   					<h5>CPU</h5> 
   						<span>인텔® Core™ i5-760 또는 AMD FX™-8100 또는 그 이상</span>
   					<br>
   
   				</div>
	   		
	   		</div>
	   		
	   		<div class="row mt-4">
   				<div class="col-6">
		   			<h5>비디오카드</h5>
		   			<span>윈도우® 7 64-bit</span>
	   			</div>
   				
   				<div class="col-6">
   					<h5>RAM</h5> 
   					<span>4 GB RAM (Intel HD Graphics 530의 경우 8GB)</span>
   				</div>
	   		
	   		</div>
	   	
			 		
	   		<div class="row mt-4">
   				<div class="col-6">
		   			<h5>저장공간</h5>
		   			<span>70GB 이상의 하드디스크 여유 공간(7200RPM)</span>
	   			</div>
   				
   				<div class="col-6">
   					<h5>인터넷</h5> 
   					<span>광대역 인터넷 연결</span>
   				</div>
	   		
	   		</div>
	   		
	   		 		
	   		<div class="row mt-2">
   				<div class="col-6">
		   			<h5>입력장치</h5>
		   			<span>키보드 및 마우스. 그 외의 입력장치는 지원하지 않습니다.</span>
	   			</div>
   				
   				<div class="col-6">
   					<h5>해상도</h5> 
   					<span>최소 1024 x 768 디스플레이 해상도</span>
   				</div>
	   		
	   		</div>		   		

   			
   		</div>
				
		</div>
	</div>
	</div>
</div>
</c:if>


<hr style="background-color: gray;">

<section>
   <div id="p_tag" class="text-center mt-5 mb-5" style="width: 50%; margin: 0 auto; color: black;">
      <h2 class="mb-4" style="font-weight: bold; color:black;">이용 연령</h2>
      <div class="row ">
      <img class="col-3" src="<%= ctxPath %>/img/로고모음/esports-hsm-5b1ed3fe5cf5d4f8.png" class="mr-1" />
      <img class="col-3" src="<%= ctxPath %>/img/로고모음/esports-hsm-5b1ed3fe5cf5d4f8.png" class="mr-1" />
      <img class="col-3 " src="<%= ctxPath %>/img/로고모음/esports-hsm-5b1ed3fe5cf5d4f8.png" class="mr-1" />
      <img class="col-3 " src="<%= ctxPath %>/img/로고모음/esports-hsm-5b1ed3fe5cf5d4f8.png" class="mr-1" />
      </div>
      <p>정액제 상품</p>
      <p>구매 후 7일 이내에 청약철회가 가능합니다. 다만, 상품을 구매한 지 7일이 지났거나, 서비스의 이용 개시 또는 상품의 일부를 이용한 경우에는 환불신청이 가능합니다.</p>
      <p>(이용금액 및 환불수수료 공제)</p>
      <p>디지털 딜럭스 상품, 사전구매 상품 및 게임 내 콘텐츠/서비스</p>
      <p>구매 후 7일 이내에 청약철회가 가능합니다. 다만, 서비스의 이용을 개시하였거나 상품의 일부를 이용한 경우 청약철회가 제한됩니다.</p>
      <p>제품 구매에 부수하여 보너스로 제공받거나 이벤트나 게임이용 등으로 획득한 상품의 경우에는 환불되지 않습니다</p>
      <hr style="background-color: gray;">
      <p>상품 이용기간: 서비스 종료 시까지</p>
      <p>본 상품은 디지털 다운로드 방식으로 제공되는 상품으로서 구매 즉시 계정에 자동 등록됩니다.</p>
      <p>예약 구매 상품의 경우에는 출시전까지 환불 가능합니다.</p>
      <p>시험사용상품이 제공되거나 구매 후 즉시 서비스의 이용이 개시되는 경우 등 구매 상품의 특성에 따라 청약철회가 제한되는 경우가 있습니다. 게임 플레이를 통해</p>
      <p>획득한 아이템 또는 이를 사용하여 획득한 상품은 환불이 불가능합니다. 환불은 청약 철회일로부터 3일 영업일 이내에 이루어 집니다. 자세한 사항은 <a href="">환불정책</a> 을</p>
      <p>참고해 주세요.</p>
      <p>법정대리인의 동의가 없는 미성년자의 결제는 취소될 수 있습니다.</p>
      <p>선물한 상품은 구매 후 7일 이내에 청약철회가 가능합니다. 다만, 구매 후 수신인이 수령한 경우에는 청약철회가 제한됩니다.</p>
      <p>본 거래는 <a href="">Blizzard 최종 사용자 라이선스 계약</a> 및 판매 시 제공된 조건에 따릅니다. 지불이나 환불과 관련한 문제가 발생한 경우, 해당 계정은 관련 문제가 해결될 때까지 잠시 정지될 수 있습니다.</p>
      <p>청약철회, 환불, 회원탈퇴, 소비자 불만과 관련한 내용은 <a href="">고객지원</a>에 연락해야 합니다.</p>
      <p>본 상품은 구매안전서비스를 제공하지 않습니다. 소비자피해보상은 판매 시 제공된 조건, 약관 및 소비자 분쟁 해결 기준 등 법령에 따릅니다.</p>
      <hr style="background-color: gray;">
      <p>판매자 정보: 김경민 엔터테인먼트 주식 회사</p>
      <p>대표이사: 서영학 | 개인정보 보호책임자: 박승우</p>
      <p>주소: 서울특별시 마포구 월드컵북로 21 풍성빌딩 2,3,4층 쌍용강북교육센터</p>
      <p>연락처: (전화) 02-336-8546~8 (팩스) (02)334-5405 (이메일) zxnm46@daum.net</p>
      <p>사업자 등록 번호: 214-85-29296</p>
      
      <span style="font-weight: bold;" class="mr-2" >배급사</span><img src="<%= ctxPath %>/img/logo-ow2-40a23e181ae5418a.png" class="mr-4" />
      <span style="font-weight: bold;" class="mr-2" >개발사</span><img src="<%= ctxPath %>/img/logo-ow2-40a23e181ae5418a.png" />
      
   </div>
</section>

<%-- ============ 이용 연령 안내 끝 ============ --%>


<jsp:include page="../footer_suc.jsp" />
