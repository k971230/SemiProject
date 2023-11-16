package shop.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import shop.model.ProductDAO;
import shop.model.ProductDAO_imple;

public class LikeAddAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fk_g_code = request.getParameter("fk_g_code");
		String user_id = request.getParameter("user_id");
      
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("fk_g_code", fk_g_code);
		paraMap.put("user_id", user_id);
      
		ProductDAO pdao = new ProductDAO_imple();
      
		int n = pdao.likeAdd(paraMap);
		// n => 1 이라면 정상투표,  n => 0 이라면 중복투표
      
		String msg = "";
      
		if(n==1) {
			msg = "해당제품에\n 좋아요를 클릭하셨습니다.";
		}
		else {
			msg = "이미 좋아요를 클릭하셨기에\n 두번 이상 좋아요는 불가합니다.";
		}
      
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("msg", msg); // {"msg":"해당제품에\n 좋아요를 클릭하셨습니다."}   {"msg":"이미 좋아요를 클릭하셨기에\n 두번 이상 좋아요는 불가합니다."} 
      
		String json = jsonObj.toString(); // "{"msg":"해당제품에\n 좋아요를 클릭하셨습니다."}"   "{{"msg":"이미 좋아요를 클릭하셨기에\n 두번 이상 좋아요는 불가합니다."}}" 
      
		request.setAttribute("json", json);
      
   //   super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
	}

}
