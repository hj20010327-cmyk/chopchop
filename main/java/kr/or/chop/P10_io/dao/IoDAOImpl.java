package kr.or.chop.P10_io.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class IoDAOImpl implements IoDAO {

	@Autowired
    SqlSession sqlSession;

	@Override
    public List<IoDTO> selectIoList(IoDTO ioDTO, PageInfo pageInfo) {

        Map<String, Object> paramMap = new HashMap<String, Object>();

        paramMap.put("ioType", ioDTO.getIoType());
        paramMap.put("startDate", ioDTO.getStartDate());
        paramMap.put("endDate", ioDTO.getEndDate());
        paramMap.put("searchKeyword", ioDTO.getSearchKeyword());
        paramMap.put("page", pageInfo);

        return sqlSession.selectList("mapper.P10_io.selectIoList", paramMap);
    }
	
}
