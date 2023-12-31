package shop.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import member.domain.MemberVO;
import shop.domain.*;
public interface ProductDAO {

	
	// 카테고리 목록을 조회해오기
	List<CategoryVO> selectCategoryList() throws SQLException;

	// SPEC 목록을 조회해오기
	List<SpecVO> selectSpecList() throws SQLException;

	// 게임코드 채번 해오기
	int getG_codeOfProduct() throws SQLException;

	// tbl_product 테이블에 제품정보 insert 하기
	int productInsert(GameVO gamevo) throws SQLException;

	// tbl_product_imagefile 테이블에 제품의 추가이미지 파일명 insert 하기
	int tbl_product_optinfo_insert(Map<String, String> paraMap) throws SQLException;
	
	
	// 로그인한 사용자의 장바구니 목록을 조회하기
	List<CartVO> selectProductCart(String user_id) throws SQLException;
	
	// 총값
	Map<String, String> selectCartSumPricePoint(String userid) throws SQLException;
	
	// 장바구니 테이블에서 특정제품을 장바구니에서 비우기
	int delCart(String cartno) throws SQLException;
	
	////////////////////////////////////////////////////////////

	// 장바구니 테이블에서 특정제품 수량을 수정하기
	int updateCart(Map<String, String> paraMap) throws SQLException;
	
	// 주문 번호 (시퀀스 seq_tbl_order 값) 을 채번해오는 것
	int get_seq_tbl_order() throws SQLException;
	
	// 하나의 카테고리에 몇개의 게임이있는지 알아오는 것 
	int totalCateGoryCount(String c_code) throws SQLException;
	
	// 카테고리 이름 알아오기
	int CateGoryno(String c_code) throws SQLException;
	
	// 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라(start ~ end) 조회해오기 기준은 일단 스펙 나중에 바꾸자
	List<GameVO> selectByno(Map<String, String> paraMap) throws SQLException;
	
	// ===== Transaction 처리하기 ===== // 
    // 1. 주문 테이블에 입력되어야할 주문전표를 채번(select)하기
    // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
    // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
    // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리)

    // 5. 장바구니 테이블에서 str_cartno_join 값에 해당하는 행들을 삭제(delete)하기(수동커밋처리)
    // >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. <<

    // 6. 회원 테이블에서 로그인한 사용자의 coin 액을 sum_totalPrice 만큼 감하고, point 를 sum_totalPoint 만큼
    // 더하기(update)(수동커밋처리)
    // 7. **** 모든처리가 성공되었을시 commit 하기(commit) ****
    // 8. **** SQL 장애 발생시 rollback 하기(rollback) ****   
	int orderAdd(Map<String, Object> paraMap,Map<String, String> zipMap) throws SQLException;
	
	// 주문한 제품에 대해 email 보내기시 email 내용에 넣을 주문한 제품번호들에 대한 제품정보를 얻어오는 것
	List<GameVO> getJumungameList(String g_noes) throws SQLException;

	// 특정 사용자가 특정 제품에 대해 상품후기를 입력하기(insert) 
	int addReview(PurchaseReviewsVO reviewsvo) throws SQLException;

	
	// 특정 제품의 사용후기를 조회(select)하기
	List<PurchaseReviewsVO> reviewList(String fk_g_code) throws SQLException;

	// 특정 제품의 사용후기를 삭제(delete)하기
	int reviewDel(String review_seq) throws SQLException;

	// 특정 제품의 사용후기를 수정(update)하기
	int reviewUpdate(Map<String, String> paraMap) throws SQLException;
	   
	// tbl_game_product, tbl_game_category JOIN 문
	List<GameVO> CarouselList(String c_code)  throws SQLException;
	
	// 경민이가 한거
	int oneOrderAdd(Map<String, String> paraMap) throws SQLException;
	
	
	// 주문내역 조회
	List<Map<String, String>> getOrderList(Map<String, String> paraMap) throws SQLException;

	// 주문 총 개수 조회
	int getTotalCountOrder(String user_id) throws SQLException;

	// 주문자 정보 조회
	MemberVO odrcodeOwnerMemberInfo(String odrcode)throws SQLException;

	// 배송시작 처리
	int updateDeliverStart(String odrcodePnum) throws SQLException;
		
	// 배송완료 처리
	int updateDeliverEnd(String odrcodePnum) throws SQLException;
	

	


	

}
