package kr.or.chop.P08_stock.dao;

import java.util.List;

import kr.or.chop.P08_stock.dto.StockDTO;
import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface StockDAO {

	List<StockDTO> selectStockList(StockDTO stockDTO, PageInfo pageInfo);

    int selectStockTotalCount(StockDTO stockDTO);

    int selectStockSafeCount();

    int selectStockWarningCount();

    int selectStockDangerCount();
	
    StockDTO selectStockDetail(String stockId);

    List<IoDTO> selectStockIoList(String stockId, PageInfo pageInfo);
    
}
