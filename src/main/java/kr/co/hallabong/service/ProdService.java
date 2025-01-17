package kr.co.hallabong.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hallabong.bean.ProdBean;
import kr.co.hallabong.bean.RevBean;
import kr.co.hallabong.dao.ProdDAO;

@Service
public class ProdService {
	@Autowired
	private ProdDAO prodDAO;
	
	public List<ProdBean> getProdList() {
		return prodDAO.selectProdList();
	}
	
	public ProdBean getProd(String no) {
		return prodDAO.selectProd(no);
	}
	
	public void addProd(ProdBean bean) {
		prodDAO.insertProd(bean);
	}
	
	public void setProd(ProdBean bean) {
		prodDAO.updateProd(bean);
	}
	
	public void removeProd(String no) {
		prodDAO.deleteProd(no);
	}
	
	public List<ProdBean> searchProductList(String name) {
		return prodDAO.searchProductList(name);
	}
	
	public List<ProdBean> getProdInfoPage(String prod_No) {
		List<ProdBean> ProdInfoPage = prodDAO.getProdInfoPage(prod_No);
		return ProdInfoPage;		
	}
	
	public List<RevBean> getReviewList(String prod_No) {
		List<RevBean> ReviewList = prodDAO.getReviewList(prod_No);
		return ReviewList;		
	}
}
