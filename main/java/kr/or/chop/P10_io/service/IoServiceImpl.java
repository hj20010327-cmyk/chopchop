package kr.or.chop.P10_io.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P10_io.dao.IoDAO;
import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class IoServiceImpl implements IoService {

	@Autowired
    IoDAO ioDAO;

    @Override
    public List<IoDTO> selectIoList(IoDTO ioDTO, PageInfo pageInfo) {
        return ioDAO.selectIoList(ioDTO, pageInfo);
    }
    
    @Override
    public IoDTO selectIoDetail(String ioId) {
        return ioDAO.selectIoDetail(ioId);
    }
    
    @Override
    public void insertIo(IoDTO ioDTO) {
        ioDAO.insertIo(ioDTO);
    }
	
    @Override
    public List<ItemDTO> selectItemListByType(String itemType) {
        return ioDAO.selectItemListByType(itemType);
    }
    
    @Override
    public List<VendorDTO> selectVendorList() {
        return ioDAO.selectVendorList();
    }

	@Override
	public List<LotDTO> selectLotListByItem(String itemId) {
		return ioDAO.selectLotListByItem(itemId);
	}
    
    
    
}
