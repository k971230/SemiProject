package game.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import shop.domain.*;
import shop.model.*;

public class WowcarinfoAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String g_code = request.getParameter("g_code");
		
		WowcarinfoDAO wdao = new WowcarinfoDAO_imple();
		
		
		
		// System.out.println(g_code);
		
		try { 
		List<GameCarinfoVO> wciList = wdao.wowCarinfoListSelectAll(g_code);
		
		request.setAttribute("wciList", wciList); 
		//super.setRedirect(false);
		super.setViewPage("/WEB-INF/shop/wowcarinfo.jsp");
		
		
		} catch (SQLException e) { 
			e.printStackTrace(); 
		super.setRedirect(true);
		super.setViewPage(request.getContextPath()+"/error.bz"); }
		

		
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception
	
	

}
