package kr.or.chop.P12_rout.service;

import java.util.List;

import kr.or.chop.P12_rout.dto.RoutDTO;
import kr.or.chop.P12_rout.dto.RoutDetailDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface RoutService {

	int selectRoutCount(RoutDTO routDTO);

	List<RoutDTO> selectRoutList(RoutDTO routDTO, PageInfo page);

	List<RoutDTO> selectRoutItemList();

	List<RoutDetailDTO> selectWpTypeList();

	void insertRoutWithDetail(RoutDTO routDTO, RoutDetailDTO detailDTO);

	RoutDTO selectRoutDetail(String routId);

	List<RoutDetailDTO> selectRoutDetailList(String routId);

	void updateRoutWithDetail(RoutDTO routDTO, RoutDetailDTO detailDTO);

	void deleteRout(String routId);
}