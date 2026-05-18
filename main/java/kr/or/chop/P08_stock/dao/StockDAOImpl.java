package kr.or.chop.P08_stock.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P08_stock.dto.StockDTO;
import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class StockDAOImpl implements StockDAO{

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<StockDTO> selectStockList(StockDTO stockDTO, PageInfo pageInfo) {

		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("itemType", stockDTO.getItemType());
		paramMap.put("stockStatus", stockDTO.getStockStatus());
		paramMap.put("searchKeyword", stockDTO.getSearchKeyword());
		paramMap.put("page", pageInfo);

		return sqlSession.selectList("mapper.P08_stock.selectStockList", paramMap);
	}

	@Override
	public int selectStockTotalCount(StockDTO stockDTO) {
		return sqlSession.selectOne("mapper.P08_stock.selectStockTotalCount", stockDTO);
	}

	@Override
	public int selectStockSafeCount() {
		return sqlSession.selectOne("mapper.P08_stock.selectStockSafeCount");
	}

	@Override
	public int selectStockWarningCount() {
		return sqlSession.selectOne("mapper.P08_stock.selectStockWarningCount");
	}

	@Override
	public int selectStockDangerCount() {
		return sqlSession.selectOne("mapper.P08_stock.selectStockDangerCount");
	}
	
	@Override
	public StockDTO selectStockDetail(String stockId) {
	    return sqlSession.selectOne(
	        "mapper.P08_stock.selectStockDetail",
	        stockId
	    );
	}

	@Override
	public List<IoDTO> selectStockIoList(String stockId, PageInfo pageInfo) {

	    Map<String, Object> paramMap = new HashMap<String, Object>();

	    paramMap.put("stockId", stockId);
	    paramMap.put("page", pageInfo);

	    return sqlSession.selectList(
	        "mapper.P08_stock.selectStockIoList",
	        paramMap
	    );
	}

}
