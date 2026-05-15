package kr.or.chop.P17_vendor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P17_vendor.dao.VendorDAO;
import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class VendorServiceImpl implements VendorService {

	@Autowired
	private VendorDAO vendorDAO;
	
	@Override
    public int selectVendorCount(VendorDTO vendorDTO) {
        return vendorDAO.selectVendorCount(vendorDTO);
    }

    @Override
    public List<VendorDTO> selectVendorList(
            VendorDTO vendorDTO,
            PageInfo pageInfo) {

        return vendorDAO.selectVendorList(vendorDTO, pageInfo);
    }
    
    @Override
    public int insertVendor(VendorDTO vendorDTO) {
        return vendorDAO.insertVendor(vendorDTO);
    }
	
}
