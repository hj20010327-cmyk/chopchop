package kr.or.chop.P13_bom.dao;

import java.util.List;

import kr.or.chop.P13_bom.dto.BOMDTO;
import kr.or.chop.P13_bom.dto.BOMDetailDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface BOMDAO {

	int selectBomCount(BOMDTO bomDTO);
	List<BOMDTO> selectBomList(BOMDTO bomDTO, PageInfo page);
	
	BOMDTO selectBomDetail(String bomId);
	List<BOMDetailDTO> selectBomDetailList(String bomId);
	
	int insertBom(BOMDTO bomDTO);
	List<BOMDTO> selectFinishItemList();
	List<BOMDTO> selectMaterialItemList();
	
	int insertBomDetail(BOMDetailDTO detailDTO);
}