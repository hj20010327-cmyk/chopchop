package kr.or.chop.P12_rout.service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
	public List<RoutDetailDTO> selectWpTypeList() {
		return routDAO.selectWpTypeList();
	}

	@Override
	@Transactional
	public void insertRoutWithDetail(RoutDTO routDTO, RoutDetailDTO detailDTO) {

		routDAO.insertRout(routDTO);

		String routId = routDTO.getRoutId();

		String[] procNameList = detailDTO.getProcNameList();
		String[] procContentList = detailDTO.getProcContentList();
		int[] procWpTypeList = detailDTO.getProcWpTypeList();

		if (procNameList == null || procWpTypeList == null) {
			return;
		}

		for (int i = 0; i < procNameList.length; i++) {

			RoutDetailDTO procDTO = new RoutDetailDTO();
			procDTO.setProcName(procNameList[i]);
			procDTO.setProcContent(getArrayValue(procContentList, i));
			procDTO.setProcWpType(procWpTypeList[i]);

			routDAO.insertProcess(procDTO);

			RoutDetailDTO routDetailDTO = new RoutDetailDTO();
			routDetailDTO.setRoutDtlRout(routId);
			routDetailDTO.setRoutDtlProc(procDTO.getProcId());
			routDetailDTO.setRoutDtlStep(i + 1);

			routDAO.insertRoutDetail(routDetailDTO);
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
	public void updateRoutWithDetail(RoutDTO routDTO, RoutDetailDTO detailDTO) {

		String routId = routDTO.getRoutId();

		List<RoutDetailDTO> oldDetailList = routDAO.selectRoutDetailList(routId);

		routDAO.updateRout(routDTO);

		routDAO.deleteRoutDetail(routId);

		String[] procIdList = detailDTO.getProcIdList();
		String[] procNameList = detailDTO.getProcNameList();
		String[] procContentList = detailDTO.getProcContentList();
		int[] procWpTypeList = detailDTO.getProcWpTypeList();

		Set<String> usedProcIdSet = new HashSet<String>();

		if (procNameList != null && procWpTypeList != null) {

			for (int i = 0; i < procNameList.length; i++) {

				RoutDetailDTO procDTO = new RoutDetailDTO();
				procDTO.setProcId(getArrayValue(procIdList, i));
				procDTO.setProcName(procNameList[i]);
				procDTO.setProcContent(getArrayValue(procContentList, i));
				procDTO.setProcWpType(procWpTypeList[i]);

				if (procDTO.getProcId() != null && !procDTO.getProcId().trim().equals("")) {
					routDAO.updateProcess(procDTO);
				} else {
					routDAO.insertProcess(procDTO);
				}

				usedProcIdSet.add(procDTO.getProcId());

				RoutDetailDTO routDetailDTO = new RoutDetailDTO();
				routDetailDTO.setRoutDtlRout(routId);
				routDetailDTO.setRoutDtlProc(procDTO.getProcId());
				routDetailDTO.setRoutDtlStep(i + 1);

				routDAO.insertRoutDetail(routDetailDTO);
			}
		}

		for (RoutDetailDTO oldDetail : oldDetailList) {
			String oldProcId = oldDetail.getProcId();

			if (oldProcId != null && !usedProcIdSet.contains(oldProcId)) {
				routDAO.deleteProcess(oldProcId);
			}
		}
	}

	@Override
	@Transactional
	public void deleteRout(String routId) {

		List<RoutDetailDTO> detailList = routDAO.selectRoutDetailList(routId);

		for (RoutDetailDTO detail : detailList) {
			if (detail.getProcId() != null) {
				routDAO.deleteProcess(detail.getProcId());
			}
		}

		routDAO.softDeleteRoutDetail(routId);
		routDAO.deleteRout(routId);
	}

	private String getArrayValue(String[] arr, int index) {

		if (arr == null || index >= arr.length) {
			return null;
		}

		return arr[index];
	}
}