package kr.or.chop.P13_bom.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P13_bom.dao.BOMDAO;
import kr.or.chop.P13_bom.dto.BOMDTO;
import kr.or.chop.P13_bom.dto.BOMDetailDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class BOMServiceImpl implements BOMService {

	@Autowired
	BOMDAO bomDAO;

	@Override
	public int selectBomCount(BOMDTO bomDTO) {
		return bomDAO.selectBomCount(bomDTO);
	}

	@Override
	public List<BOMDTO> selectBomList(BOMDTO bomDTO, PageInfo page) {
		return bomDAO.selectBomList(bomDTO, page);
	}
	
	@Override
	public BOMDTO selectBomDetail(String bomId) {
	    return bomDAO.selectBomDetail(bomId);
	}

	@Override
	public List<BOMDetailDTO> selectBomDetailList(String bomId) {
	    return bomDAO.selectBomDetailList(bomId);
	}
	
	@Override
	public int insertBom(BOMDTO bomDTO) {
	    return bomDAO.insertBom(bomDTO);
	}
	
	@Override
	public List<BOMDTO> selectFinishItemList() {
		return bomDAO.selectFinishItemList();
	}

	@Override
	public List<BOMDTO> selectMaterialItemList() {
		return bomDAO.selectMaterialItemList();
	}
	
	@Override
	public int insertBomDetail(BOMDetailDTO detailDTO) {
	    return bomDAO.insertBomDetail(detailDTO);
	}
}