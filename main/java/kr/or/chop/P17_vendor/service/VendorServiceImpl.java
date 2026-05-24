package kr.or.chop.P17_vendor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P17_vendor.dao.VendorDAO;
import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.P17_vendor.dto.VendorIoDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class VendorServiceImpl implements VendorService {

	@Autowired
	private VendorDAO vendorDAO;

	@Override
	public List<VendorDTO> selectVendorList(VendorDTO search, PageInfo pageInfo) {
		return vendorDAO.selectVendorList(search, pageInfo);
	}

	@Override
	public int selectVendorCount(VendorDTO search) {
		return vendorDAO.selectVendorCount(search);
	}

	@Override
	public int insertVendor(VendorDTO vendor) {
		return vendorDAO.insertVendor(vendor);
	}

	@Override
	public VendorDTO selectVendorDetail(String vendorId) {
		return vendorDAO.selectVendorDetail(vendorId);
	}

	@Override
	public int updateVendor(VendorDTO vendor) {
		return vendorDAO.updateVendor(vendor);
	}

	@Override
	public int deleteVendor(String vendorId) {
		return vendorDAO.deleteVendor(vendorId);
	}

	@Override
	public int selectVendorIoCount(String vendorId) {
		return vendorDAO.selectVendorIoCount(vendorId);
	}

	@Override
	public List<VendorIoDTO> selectVendorIoList(String vendorId, PageInfo pageInfo) {
		return vendorDAO.selectVendorIoList(vendorId, pageInfo);
	}

	@Override
	public List<VendorDTO> selectVendorTypeSummary() {
		return vendorDAO.selectVendorTypeSummary();
	}
}