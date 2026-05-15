package kr.or.chop.P17_vendor.dao;

import java.util.List;

import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface VendorDAO {

	int selectVendorCount(VendorDTO vendorDTO);

    List<VendorDTO> selectVendorList(VendorDTO vendorDTO, PageInfo pageInfo);
	
    int insertVendor(VendorDTO vendorDTO);
}
