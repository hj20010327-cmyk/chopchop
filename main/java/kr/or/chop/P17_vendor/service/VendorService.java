package kr.or.chop.P17_vendor.service;

import java.util.List;

import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.P17_vendor.dto.VendorIoDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface VendorService {

    List<VendorDTO> selectVendorList(VendorDTO search, PageInfo pageInfo);

    int selectVendorCount(VendorDTO search);

    int insertVendor(VendorDTO vendor);

    VendorDTO selectVendorDetail(String vendorId);

    int updateVendor(VendorDTO vendor);

    int deleteVendor(String vendorId);

    int selectVendorIoCount(String vendorId);

    List<VendorIoDTO> selectVendorIoList(String vendorId, PageInfo pageInfo);
}