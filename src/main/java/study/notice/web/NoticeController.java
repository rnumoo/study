package study.notice.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping(value = "/notice/")
public class NoticeController {
	
	// 공지사항 리스트
	@RequestMapping(value = "/noticeList.do")
	public String noticeList() throws Exception {
		System.out.println("sss");
		return "/study/notice/noticeList";
	}

}
