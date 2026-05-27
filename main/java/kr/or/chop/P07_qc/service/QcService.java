package kr.or.chop.P07_qc.service;

import java.util.List;

import kr.or.chop.P07_qc.dto.QcDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface QcService {

	int selectQcCount(QcDTO dto);

	List<QcDTO> selectQcList(QcDTO dto, PageInfo pageInfo);

	QcDTO selectQcSummary(QcDTO dto);

	QcDTO selectQcDetail(String qcId);

	int insertQc(QcDTO dto);

	int updateQc(QcDTO dto);

	int deleteQc(String qcId);
	
	List<QcDTO> selectQcLotList();
	
	int updateQcResult(QcDTO dto);
	
	List<QcDTO> selectDefectTypeList();
	
	List<QcDTO> selectWarehouseListByItem(String itemId);

	List<QcDTO> selectSectionListByWarehouse(String whId);
	
	List<QcDTO> selectDefLogList(String qcId);
}
