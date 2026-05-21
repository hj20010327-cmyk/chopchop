package kr.or.chop.P12_rout.dao;

import java.util.List;

import kr.or.chop.P12_rout.dto.RoutDTO;
import kr.or.chop.P12_rout.dto.RoutDetailDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface RoutDAO {

	int selectRoutCount(RoutDTO routDTO);

	List<RoutDTO> selectRoutList(RoutDTO routDTO, PageInfo page);

	List<RoutDTO> selectRoutItemList();

	List<RoutDetailDTO> selectWpTypeList();

	int insertProcess(RoutDetailDTO detailDTO);

	int updateProcess(RoutDetailDTO detailDTO);

	int deleteProcess(String procId);

	int insertRout(RoutDTO routDTO);

	int insertRoutDetail(RoutDetailDTO detailDTO);

	RoutDTO selectRoutDetail(String routId);

	List<RoutDetailDTO> selectRoutDetailList(String routId);

	int updateRout(RoutDTO routDTO);

	int deleteRoutDetail(String routId);

	int deleteRout(String routId);

	int softDeleteRoutDetail(String routId);
}