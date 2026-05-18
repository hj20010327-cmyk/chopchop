package kr.or.chop.P08_stock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P08_stock.dao.StockDAO;
import kr.or.chop.P08_stock.dto.StockDTO;
import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class StockServiceImpl implements StockService {

	@Autowired
	StockDAO stockDAO;

	@Override
	public List<StockDTO> selectStockList(StockDTO stockDTO, PageInfo pageInfo) {
		return stockDAO.selectStockList(stockDTO, pageInfo);
	}

	@Override
	public int selectStockTotalCount(StockDTO stockDTO) {
		return stockDAO.selectStockTotalCount(stockDTO);
	}

	@Override
	public int selectStockSafeCount() {
		return stockDAO.selectStockSafeCount();
	}

	@Override
	public int selectStockWarningCount() {
		return stockDAO.selectStockWarningCount();
	}

	@Override
	public int selectStockDangerCount() {
		return stockDAO.selectStockDangerCount();
	}
	
	@Override
	public StockDTO selectStockDetail(String stockId) {
	    return stockDAO.selectStockDetail(stockId);
	}

	@Override
	public List<IoDTO> selectStockIoList(String stockId, PageInfo pageInfo) {
	    return stockDAO.selectStockIoList(stockId, pageInfo);
	}

}
