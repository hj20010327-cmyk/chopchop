package kr.or.chop.P07_qc.dao;

import java.util.List;

import kr.or.chop.P07_qc.dto.QcDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface QcDAO {

	int selectQcCount(QcDTO dto);
	List<QcDTO> selectQcList(QcDTO dto, PageInfo pageinfo);
	QcDTO selectQcSummary(QcDTO dto);
	QcDTO selectQcDetail(String qcId);
	int insertQc(QcDTO dto);
	int updateQc(QcDTO dto);
	int deleteQc(String qcId);
	List<QcDTO> selectQcLotList();
	int updateQcResult(QcDTO dto);
	int updateLotByQcResult(QcDTO dto);
	List<QcDTO> selectDefectTypeList();
	List<QcDTO> selectWarehouseListByItem(String itemId);
	List<QcDTO> selectSectionListByWarehouse(String whId);
	int insertDefLog(QcDTO dto);
	List<QcDTO> selectDefLogList(String qcId);
	int deleteDefLog(String qcId);
	int plusStockAvailByQcResult(QcDTO dto);
	int plusStockByQcResult(QcDTO dto);
}
