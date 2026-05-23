package kr.or.chop.P10_io.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.P14_warehouse.dto.SecDTO;
import kr.or.chop.P14_warehouse.dto.WHDTO;
import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.P21_manage.dto.AdminDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class IoDAOImpl implements IoDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<IoDTO> selectIoList(IoDTO ioDTO, PageInfo pageInfo) {

		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("ioType", ioDTO.getIoType());
		paramMap.put("startDate", ioDTO.getStartDate());
		paramMap.put("endDate", ioDTO.getEndDate());
		paramMap.put("searchKeyword", ioDTO.getSearchKeyword());
		paramMap.put("page", pageInfo);

		return sqlSession.selectList("mapper.P10_io.selectIoList", paramMap);
	}

	@Override
	public int selectIoCount(IoDTO ioDTO) {

		return sqlSession.selectOne("mapper.P10_io.selectIoCount", ioDTO);
	}

	@Override
	public IoDTO selectIoDetail(String ioId) {
		return sqlSession.selectOne("mapper.P10_io.selectIoDetail", ioId);
	}

	@Override
	public void insertIo(IoDTO ioDTO) {

		String ioId = null;

		if ("IN".equals(ioDTO.getIoType())) {

			ioId = sqlSession.selectOne("mapper.P10_io.selectInId");

		} else if ("OUT".equals(ioDTO.getIoType())) {

			ioId = sqlSession.selectOne("mapper.P10_io.selectOutId");
		}

		ioDTO.setIoId(ioId);

		// 1. 입출고 이력 등록
		sqlSession.insert("mapper.P10_io.insertIo", ioDTO);


		// =========================
		// 입고 처리
		// =========================
		if ("IN".equals(ioDTO.getIoType())) {

			// 2. LOT 생성
			sqlSession.insert("mapper.P10_io.insertLotByIo", ioDTO);

			// 3. 방금 생성된 LOT_ID 가져오기
			String lotId = sqlSession.selectOne("mapper.P10_io.selectLastLotId");

			// 4. DTO에 LOT_ID 세팅
			ioDTO.setIoLot(lotId);

			// 5. IO 테이블에 LOT_ID 연결
			sqlSession.update("mapper.P10_io.updateIoLot", ioDTO);

			// 6. STOCK 증가
			sqlSession.update("mapper.P10_io.plusStockByIo", ioDTO);
		}


		// =========================
		// 출고 처리
		// =========================
		else if ("OUT".equals(ioDTO.getIoType())) {

			// 2. LOT 수량 차감
			int lotResult = sqlSession.update("mapper.P10_io.minusLotFqty", ioDTO);

			if (lotResult == 0) {
				throw new RuntimeException("LOT 수량이 부족합니다.");
			}

			// 3. STOCK 감소
			int stockResult = sqlSession.update("mapper.P10_io.minusStockByIo", ioDTO);

			if (stockResult == 0) {
				throw new RuntimeException("재고 수량이 부족합니다.");
			}
		}
	}

	@Override
	public List<ItemDTO> selectItemListByType(String itemType) {
		return sqlSession.selectList("mapper.P10_io.selectItemListByType", itemType);
	}

	@Override
	public List<VendorDTO> selectVendorList() {

		return sqlSession.selectList("mapper.P10_io.selectVendorList");
	}

	@Override
	public List<VendorDTO> selectVendorByType(String vendorType) {
		return sqlSession.selectList("mapper.P10_io.selectVendorListByType", vendorType);
	}

	@Override
	public List<LotDTO> selectLotListByItem(String itemId) {
		return sqlSession.selectList("mapper.P10_io.selectLotListByItem", itemId);
	}

	@Override
	public void deleteIo(String ioId) {

		sqlSession.update("mapper.P10_io.deleteIo", ioId);

	}

	@Override
	public void updateIo(IoDTO ioDTO) {
		sqlSession.update("mapper.P10_io.updateIo", ioDTO);
	}

	@Override
	public String selectVendorTypeById(String vendorId) {
		return sqlSession.selectOne("mapper.P10_io.selectVendorTypeById", vendorId);
	}

	@Override
	public List<AdminDTO> selectWorkerList(String keyword) {
		return sqlSession.selectList("mapper.P10_io.selectWorkerList", keyword);
	}

	@Override
	public void insertLotByIo(IoDTO ioDTO) {
		sqlSession.insert("mapper.P10_io.insertLotByIo", ioDTO);
	}

	@Override
	public String selectLastLotId() {
		return sqlSession.selectOne("mapper.P10_io.selectLastLotId");
	}

	@Override
	public int minusLotFqty(IoDTO ioDTO) {
		return sqlSession.update("mapper.P10_io.minusLotFqty", ioDTO);
	}

	@Override
	public List<WHDTO> selectWarehouseListByItem(String itemId) {
		return sqlSession.selectList("mapper.P10_io.selectWarehouseListByItem", itemId);
	}

	@Override
	public List<SecDTO> selectWhSecList(String whId) {
		return sqlSession.selectList("mapper.P10_io.selectWhSecList", whId);
	}

	@Override
	public void updateLot(IoDTO ioDTO) {
		sqlSession.update("mapper.P10_io.updateLot", ioDTO);
	}

	@Override
	public void plusStockByIo(IoDTO dto) {

		sqlSession.update("mapper.P10_io.plusStockByIo", dto);
	}

	@Override
	public int minusStockByIo(IoDTO dto) {

		return sqlSession.update("mapper.P10_io.minusStockByIo", dto);
	}

}
