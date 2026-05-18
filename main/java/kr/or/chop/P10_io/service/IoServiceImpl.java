package kr.or.chop.P10_io.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P10_io.dao.IoDAO;
import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class IoServiceImpl implements IoService {

	@Autowired
    IoDAO ioDAO;

    @Override
    public List<IoDTO> selectIoList(IoDTO ioDTO, PageInfo pageInfo) {
        return ioDAO.selectIoList(ioDTO, pageInfo);
    }
	
}
