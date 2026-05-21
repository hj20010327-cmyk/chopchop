package kr.or.chop.P01_login.service;

import java.security.SecureRandom;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.chop.P01_login.dao.LoginDAO;
import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.common.util.Sha256Util;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	LoginDAO loginDAO;
	@Autowired
    private JavaMailSender mailSender;

	@Override
	public EmpDTO selectEmp(EmpDTO chkEmpDTO) {
		return loginDAO.selectEmp(chkEmpDTO);
	}

	@Override
	public void sendTempPw(EmpDTO empDTO, String tempPw) throws Exception {
		MimeMessage message = mailSender.createMimeMessage();

        MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
        
        System.out.println(empDTO.getEmpEmail());

        helper.setFrom("chopfood03@gmail.com");
        helper.setTo(empDTO.getEmpEmail());
        helper.setSubject("[CHOP FOOD] 임시 비밀번호 안내");

        String content = ""
            + "<div style='font-family: Arial, sans-serif;'>"
            + "<h2>임시 비밀번호 안내</h2>"
            + "<p>요청하신 임시 비밀번호는 아래와 같습니다.</p>"
            + "<div style='padding: 15px; background-color: #f5f5f5; "
            + "font-size: 20px; font-weight: bold; margin: 15px 0;'>"
            + tempPw
            + "</div>"
            + "<p>로그인 후 반드시 비밀번호를 변경해 주세요.</p>"
            + "</div>";

        helper.setText(content, true);

        mailSender.send(message);
	}
	
	@Override
	@Transactional
    public boolean issueTempPw(EmpDTO empDTO) {
		
        // 1. 사원번호 + 이메일 일치 확인
        int count = loginDAO.checkEmpEmail(empDTO);
        System.out.println("count: " + count);

        if (count == 0) {
            return false;
        }

        // 2. 임시 비밀번호 생성
        String tempPw = createTempPw();
        // 2-1. 비밀번호 암호화
        String encTempPw = Sha256Util.encrypt(tempPw);
        empDTO.setEmpPw(encTempPw);

        // 3. DB 비밀번호 변경
        int updateResult = loginDAO.updateTempPw(empDTO);

        if (updateResult == 0) {
            throw new RuntimeException("임시 비밀번호 DB 업데이트 실패");
        }

        // 4. 이메일 발송
        try {
            sendTempPw(empDTO, tempPw);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("임시 비밀번호 이메일 발송 실패", e);
        }

        return true;
    }

	
    private String createTempPw() {

        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%";
        SecureRandom random = new SecureRandom();

        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < 10; i++) {
            int index = random.nextInt(chars.length());
            sb.append(chars.charAt(index));
        }

        return sb.toString();
    }

	@Override
	public int updatePw(EmpDTO loginUser) {
		String encPw = Sha256Util.encrypt(loginUser.getEmpPw());
		loginUser.setEmpPw(encPw);
		
		return loginDAO.updatePw(loginUser);
	}

	
}
