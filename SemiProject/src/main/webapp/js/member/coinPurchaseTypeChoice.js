
 let coinmoney = 0; // 충전금액
 
 let optname = "";
 

// 에러 페이지를 가리고 결제 값 및 상품 이름을 가져오는 함수 
 
 $(document).ready(function(){
	 
     $("td#error").hide(); 
	       
   	 $("input:radio[name='coinmoney']").bind("click", function(e){
			
			coinmoney = $(e.target).val(); // 결제 가격
			optname = $(e.target).attr("id");
      		console.log(coinmoney);
    		console.log(optname);
   });
   
 });
   

 
 
 // "충전결제하기" 를 클릭했을 때 이벤트 처리하기 
 function goCoinPayment(ctx_Path , user_id){
	 
 	 const checked_cnt = $("input:radio[name='coinmoney']:checked").length; // 라디오 태그를 하나 이상 입력했는지 확인
 
	 if(checked_cnt==0){
		 // 결제금액을 선택하지 않았을 경우
		 $("td#error").show();
	 }
		 
	 else{
	   
	 	alert(`확인용 부모창의 함수 호출함\n결제금액 : ${coinmoney}원, 사용자id : ${user_id} 상품이름 : ${optname}`);
	   
	    // 포트원(아임포트) 결제 팝업창 띄우기
	    // 코인충전 결제금액 선택하기 팝업창 띄우기
	    const url = `${ctx_Path}/coinPurchaseEnd.bz?coinmoney=${coinmoney}&user_id=${user_id}&optname=${optname}`;  
	
	    //너비 100, 높이 600 인 팝업창을 화면 가운데 위치시키기
	    const width = 1000;
	    const height = 600;
	   
	    console.log("모니터의 넓이 :", window.screen.width);
	    // 모니터의 넓이 : 1920
	    console.log("모니터의 높이 :", window.screen.height);
	    // 모니터의 높이 : 1080
	   
	    const left = Math.ceil((window.screen.width - width)/2) ;
	    const top = Math.ceil(( window.screen.height - height)/2) ;
	    window.open(url, "coinPurchaseTypeChoiceEnd", 
	    			`left=${left}, top=${top}, width=${width}, height=${height}`);   //\을 빼면 저장소인 request.scope로 인식하기 때문에 앞에다 넣어줘야 한다. 변수로 인식해야한다.
	
	 }
		 
	 
 }
 
 
 // ==== DB 상의 tbl_member 테이블에 해당 사용자의 코인금액 및 포인트를 증가(update)시켜주는 함수 === //
 function goCoin_DB_Update(user_id, coinmoney) {
   
 	console.log(`~~ 확인용 userid : ${user_id}, coinmoney : ${coinmoney}원`);
 	
    const frm = document.coin_DB_Update_Frm;
    frm.user_id.value = user_id;
    frm.coinmoney.value = coinmoney;
     
    frm.action = `/SemiProject/member/coinUpdateLoginUser.bz`;
    frm.method="post";
    frm.submit();
   
   
}
	
 
 
 
 
 
 