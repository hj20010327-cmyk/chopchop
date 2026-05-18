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
import kr.or.chop.P17_vendor.dto.VendorDTO;
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
	public IoDTO selectIoDetail(String ioId) {
	    return sqlSession.selectOne(
	        "mapper.P10_io.selectIoDetail",
	        ioId
	    );
	}
	
	@Override
	public void insertIo(IoDTO ioDTO) {

	    String ioId = null;

	    if ("입고".equals(ioDTO.getIoType())) {

	        ioId = sqlSession.selectOne(
	            "mapper.P10_io.selectInId"
	        );

	    } else if ("출고".equals(ioDTO.getIoType())) {

	        ioId = sqlSession.selectOne(
	            "mapper.P10_io.selectOutId"
	        );
	    }

	    ioDTO.setIoId(ioId);

	    sqlSession.insert(
	        "mapper.P10_io.insertIo",
	        ioDTO
	    );
	}
	
	@Override
	public List<ItemDTO> selectItemListByType(String itemType) {
	    return sqlSession.selectList(
	        "mapper.P10_io.selectItemListByType",
	        itemType
	    );
	}
	
	@Override
	public List<VendorDTO> selectVendorList() {

	    return sqlSession.selectList(
	        "mapper.P10_io.selectVendorList"
	    );
	}
	
	@Override
	public List<LotDTO> selectLotListByItem(String itemId) {
	    return sqlSession.selectList(
	        "mapper.P10_io.selectLotListByItem",
	        itemId
	    );
	}
	
}
