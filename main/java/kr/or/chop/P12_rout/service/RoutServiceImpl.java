package kr.or.chop.P12_rout.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.chop.P12_rout.dao.RoutDAO;
import kr.or.chop.P12_rout.dto.RoutDTO;
import kr.or.chop.P12_rout.dto.RoutDetailDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class RoutServiceImpl implements RoutService {

	@Autowired
	RoutDAO routDAO;

	@Override
	public int selectRoutCount(RoutDTO routDTO) {
		return routDAO.selectRoutCount(routDTO);
	}

	@Override
	public List<RoutDTO> selectRoutList(RoutDTO routDTO, PageInfo page) {

		return routDAO.selectRoutList(routDTO, page);
	}

	@Override
	public List<RoutDTO> selectRoutItemList() {
		return routDAO.selectRoutItemList();
	}

	@Override
	public List<RoutDetailDTO> selectProcessList() {
		return routDAO.selectProcessList();
	}

	@Override
	@Transactional
	public void insertRoutWithDetail(RoutDTO routDTO, String[] routDtlProcList) {

		routDAO.insertRout(routDTO);

		String routId = routDTO.getRoutId();

		if (routDtlProcList == null) {
			return;
		}

		for (int i = 0; i < routDtlProcList.length; i++) {

			RoutDetailDTO detailDTO = new RoutDetailDTO();

			detailDTO.setRoutDtlRout(routId);
			detailDTO.setRoutDtlProc(routDtlProcList[i]);
			detailDTO.setRoutDtlStep(i + 1);

			routDAO.insertRoutDetail(detailDTO);
		}
	}

	@Override
	public RoutDTO selectRoutDetail(String routId) {
		return routDAO.selectRoutDetail(routId);
	}

	@Override
	public List<RoutDetailDTO> selectRoutDetailList(String routId) {
		return routDAO.selectRoutDetailList(routId);
	}

	@Override
	@Transactional
	public void updateRoutWithDetail(RoutDTO routDTO, String[] routDtlProcList) {

		routDAO.updateRout(routDTO);

		routDAO.deleteRoutDetail(routDTO.getRoutId());

		if (routDtlProcList == null) {
			return;
		}

		for (int i = 0; i < routDtlProcList.length; i++) {

			RoutDetailDTO detailDTO = new RoutDetailDTO();

			detailDTO.setRoutDtlRout(routDTO.getRoutId());
			detailDTO.setRoutDtlProc(routDtlProcList[i]);
			detailDTO.setRoutDtlStep(i + 1);

			routDAO.insertRoutDetail(detailDTO);
		}
	}

	@Override
	public void deleteRout(String routId) {
		routDAO.deleteRout(routId);
	}
}