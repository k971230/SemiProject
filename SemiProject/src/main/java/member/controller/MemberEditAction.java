package member.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.domain.MemberVO;
import shop.domain.CartVO;
import shop.model.ProductDAO;
import shop.model.ProductDAO_imple;

public class MemberEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) {
		
			String user_id = request.getParameter("user_id");
			System.out.println(user_id);
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			System.out.println("확인용"+loginuser.getUser_id());
			if(loginuser.getUser_id()!=null) {
			// 로그인한 사용자가 자신의 정보를 수정하는 경우
				ProductDAO pdao = new ProductDAO_imple();
				Map<String,String> sumMap = pdao.selectCartSumPricePoint(loginuser.getUser_id());
				List<CartVO> cartList = pdao.selectProductCart(loginuser.getUser_id());
				request.setAttribute("cartList", cartList);
				request.setAttribute("sumMap", sumMap);

			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/mypage.jsp");
		}
		else {
			// 로그인한 사용자가 다른 사용자의 정보를 수정하려는 경우
			// 로그인을 안했으면
			String message = "본인의 회원정보만 수정 가능합니다.!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");	
			
		}
		}
		else {
			// 로그인을 안했으면
			String message = "회원정보를 수정하기 위해서는 먼저 로그인을 하세요!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");	
			
			
		}
		
	}

}
