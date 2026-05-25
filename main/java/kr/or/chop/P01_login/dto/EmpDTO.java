package kr.or.chop.P01_login.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class EmpDTO {

	private String empId;
	private String empName;
	private String empPw;
	private String empTel;
	private String empEmail;

	private int empDeptno;
	private String empDname;

	private int empAuth;
	private String empAuthName;
	
	private String empFirst;
	private int empInOffice;
	private Date empHiredate;
	
	private String empImg;

}
