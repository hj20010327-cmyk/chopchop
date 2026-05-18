package kr.or.chop.P10_io.dao;

import java.util.List;

import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface IoDAO {

	List<IoDTO> selectIoList(IoDTO ioDTO, PageInfo pageInfo);
	
}
