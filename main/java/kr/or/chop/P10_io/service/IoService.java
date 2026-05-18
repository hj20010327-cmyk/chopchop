package kr.or.chop.P10_io.service;

import java.util.List;

import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface IoService {

	List<IoDTO> selectIoList(IoDTO ioDTO, PageInfo pageInfo);
	
}
