package kr.or.chop.P09_lot.controller;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.EnumMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

@Controller
@RequestMapping("/lot")
public class LotQrController {

	@GetMapping("/qr")
	public void qr(
			@RequestParam("secId") String secId,
			HttpServletResponse response
	) throws Exception {

		String qrText = "http://116.36.205.25:8017/chop/warehouse/section/detail?secId=" + URLEncoder.encode(secId, "UTF-8");

		int width = 240;
		int height = 240;

		Map<EncodeHintType, Object> hints = new EnumMap<EncodeHintType, Object>(EncodeHintType.class);
		hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
		hints.put(EncodeHintType.MARGIN, 1);

		QRCodeWriter qrCodeWriter = new QRCodeWriter();

		BitMatrix bitMatrix = qrCodeWriter.encode(
				qrText,
				BarcodeFormat.QR_CODE,
				width,
				height,
				hints
		);

		response.setContentType("image/png");
		response.setHeader("Cache-Control", "no-store");

		OutputStream out = response.getOutputStream();
		MatrixToImageWriter.writeToStream(bitMatrix, "PNG", out);
		out.flush();
	}
}