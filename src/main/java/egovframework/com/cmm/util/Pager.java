package egovframework.com.cmm.util;

import java.util.HashMap;

public class Pager {

	private int currentPage;
	private int pageSize;
	private int listSize;
	private int totalCount;

	public Pager( int currentPage, int totalCount, int pageSize, int listSize )
	{
		this.currentPage = currentPage;
		this.totalCount = totalCount;
		this.pageSize = pageSize;
		this.listSize = listSize;
	}

	public HashMap<String, Object> toHashMap() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("pageSize", pageSize);
		map.put("listSize", listSize);
		map.put("totalCount", totalCount);
		return map;
	}

}
