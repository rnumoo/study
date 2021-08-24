package study.notice.service;

public class SearchVO {
	/** 페이지사이즈(페이지 번호 10개 단위로 표시) */
	private int pageSize = 10;
	/** 현재페이지 */
	private int pageIndex = 1;
	/** 페이징 SQL 조건절에 사용되는 시작 행번호(0부터 시작) */
	private int firstIndex = 1;
	/** 페이지당 레코드 개수(한 페이지에 보여질 최대 글 수) */
	private int recordCountPerPage = 10;
	/** 검색종류1 */
	private String searchCnd1="";
	/** 검색종류2 */
	private String searchCnd2="";
	/** 검색종류3 */
	private String searchCnd3="";
	/** 검색어 */
	private String searchWrd="";
	
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getFirstIndex() {
		return firstIndex;
	}
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex > 0?firstIndex:0;
	}
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	public String getSearchCnd1() {
		return searchCnd1;
	}
	public void setSearchCnd1(String searchCnd1) {
		this.searchCnd1 = searchCnd1;
	}
	public String getSearchCnd2() {
		return searchCnd2;
	}
	public void setSearchCnd2(String searchCnd2) {
		this.searchCnd2 = searchCnd2;
	}
	public String getSearchCnd3() {
		return searchCnd3;
	}
	public void setSearchCnd3(String searchCnd3) {
		this.searchCnd3 = searchCnd3;
	}
	public String getSearchWrd() {
		return searchWrd;
	}
	public void setSearchWrd(String searchWrd) {
		this.searchWrd = searchWrd;
	}
}
