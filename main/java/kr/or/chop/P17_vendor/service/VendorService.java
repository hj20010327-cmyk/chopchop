package kr.or.chop.P17_vendor.service;

import java.util.List;

import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.P17_vendor.dto.VendorIoDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface VendorService {

	int selectVendorCount(VendorDTO vendorDTO);
	
	List<VendorDTO> selectVendorList(VendorDTO vendorDTO, PageInfo pageInfo);
	
	int insertVendor(VendorDTO vendorDTO);
	
	VendorDTO selectVendorDetail(String vendorId);
	
	int updateVendor(VendorDTO vendorDTO);

	int deleteVendor(String vendorId);
	
	List<VendorIoDTO> selectVendorIoList(String vendorId);
}
