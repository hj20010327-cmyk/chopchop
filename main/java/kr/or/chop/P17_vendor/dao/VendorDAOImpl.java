package kr.or.chop.P17_vendor.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.P17_vendor.dto.VendorIoDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class VendorDAOImpl implements VendorDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	private static final String NAMESPACE = "mapper.P17_vendor.";

	@Override
	public List<VendorDTO> selectVendorList(VendorDTO search, PageInfo pageInfo) {

		Map<String, Object> param = new HashMap<String, Object>();

		param.put("vendorDTO", search);
		param.put("page", pageInfo);

		return sqlSession.selectList(NAMESPACE + "selectVendorList", param);
	}

	@Override
	public int selectVendorCount(VendorDTO search) {
		return sqlSession.selectOne(NAMESPACE + "selectVendorCount", search);
	}

	@Override
	public int insertVendor(VendorDTO vendor) {
		return sqlSession.insert(NAMESPACE + "insertVendor", vendor);
	}

	@Override
	public VendorDTO selectVendorDetail(String vendorId) {
		return sqlSession.selectOne(NAMESPACE + "selectVendorDetail", vendorId);
	}

	@Override
	public int updateVendor(VendorDTO vendor) {
		return sqlSession.update(NAMESPACE + "updateVendor", vendor);
	}

	@Override
	public int deleteVendor(String vendorId) {
		return sqlSession.update(NAMESPACE + "deleteVendor", vendorId);
	}

	@Override
	public int selectVendorIoCount(String vendorId) {
		return sqlSession.selectOne(NAMESPACE + "selectVendorIoCount", vendorId);
	}

	@Override
	public List<VendorIoDTO> selectVendorIoList(String vendorId, PageInfo pageInfo) {

		Map<String, Object> param = new HashMap<String, Object>();

		param.put("vendorId", vendorId);
		param.put("page", pageInfo);

		return sqlSession.selectList(NAMESPACE + "selectVendorIoList", param);
	}

	@Override
	public List<VendorDTO> selectVendorTypeSummary() {
		return sqlSession.selectList(NAMESPACE + "selectVendorTypeSummary");
	}
}