package kr.or.chop.P17_vendor.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.P17_vendor.dto.VendorIoDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class VendorDAOImpl implements VendorDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int selectVendorCount(VendorDTO vendorDTO) {
		return sqlSession.selectOne("mapper.P17_vendor.selectVendorCount", vendorDTO);
	}

	@Override
	public List<VendorDTO> selectVendorList(VendorDTO vendorDTO, PageInfo pageInfo) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("vendorDTO", vendorDTO);
		paramMap.put("page", pageInfo);

		return sqlSession.selectList("mapper.P17_vendor.selectVendorList", paramMap);
	}

	@Override
	public int insertVendor(VendorDTO vendorDTO) {
		return sqlSession.insert("mapper.P17_vendor.insertVendor", vendorDTO);
	}

	@Override
	public VendorDTO selectVendorDetail(String vendorId) {
		return sqlSession.selectOne("mapper.P17_vendor.selectVendorDetail", vendorId);
	}

	@Override
	public int updateVendor(VendorDTO vendorDTO) {
		return sqlSession.update("mapper.P17_vendor.updateVendor", vendorDTO);
	}

	@Override
	public int deleteVendor(String vendorId) {
		return sqlSession.update("mapper.P17_vendor.deleteVendor", vendorId);
	}

	@Override
	public List<VendorIoDTO> selectVendorIoList(String vendorId) {
		return sqlSession.selectList("mapper.P17_vendor.selectVendorIoList", vendorId);
	}
}