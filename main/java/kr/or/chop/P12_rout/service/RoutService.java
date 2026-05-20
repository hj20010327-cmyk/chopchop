package kr.or.chop.P12_rout.service;

import java.util.List;

import kr.or.chop.P12_rout.dto.RoutDTO;
import kr.or.chop.P12_rout.dto.RoutDetailDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface RoutService {

	/**
	 * 라우팅 목록 수
	 */
	int selectRoutCount(RoutDTO routDTO);

	/**
	 * 라우팅 목록 조회
	 */
	List<RoutDTO> selectRoutList(RoutDTO routDTO, PageInfo page);

	/**
	 * 라우팅 등록용 품목 목록
	 */
	List<RoutDTO> selectRoutItemList();

	/**
	 * 공정 목록
	 */
	List<RoutDetailDTO> selectProcessList();

	/**
	 * 라우팅 등록
	 */
	void insertRoutWithDetail(RoutDTO routDTO, String[] routDtlProcList);

	/**
	 * 라우팅 상세
	 */
	RoutDTO selectRoutDetail(String routId);

	/**
	 * 라우팅 공정 흐름 상세
	 */
	List<RoutDetailDTO> selectRoutDetailList(String routId);

	/**
	 * 라우팅 수정
	 */
	void updateRoutWithDetail(RoutDTO routDTO, String[] routDtlProcList);

	/**
	 * 라우팅 삭제
	 */
	void deleteRout(String routId);
}