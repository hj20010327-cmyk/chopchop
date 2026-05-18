package kr.or.chop.P21_manage.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class AdminDTO {

	private String empId;
	private String empName;
	private String empPw;
	private String empTel;
	private String empEmail;
	private int empDeptno;
	private int empAuth;
	private String empFirst;
	private int empInOffice;
	private Date empHiredate;
	
}
