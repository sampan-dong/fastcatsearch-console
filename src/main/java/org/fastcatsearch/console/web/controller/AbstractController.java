package org.fastcatsearch.console.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

public class AbstractController {
	
	protected static Logger logger = LoggerFactory.getLogger(AbstractController.class);
	
	/*
	 * exception페이지로 이동한다.
	 * */
	@ExceptionHandler(Throwable.class)
	public ModelAndView handleAllException(Exception ex) {
 
		ModelAndView model = new ModelAndView("error");
		model.addObject("exception", ex);
		return model;
 
	}
	
	/**
	 * 페이지 네비게이터
	 * @author lupfeliz
	 *
	 */
	protected class PageDivider {
		private int totalRecord;
		private int totalPage;
		private int rowSize;
		private int pageSize;
		public PageDivider(int rowSize, int pageSize) {
			this.rowSize = rowSize;
			this.pageSize = pageSize;
		}
		public void setTotalCount(int totalRecord) {
			this.totalRecord=totalRecord;
			this.totalPage = totalRecord / rowSize + 1;
		}
		public int totalCount() {
			return totalRecord;
		}
		public int totalPage() {
			return totalPage;
		}
		public int currentPage(int rowNumber) {
			return (int)Math.floor((rowNumber+rowSize)/rowSize);
		}
		private int[] rowMargine(int pageNo) {
			int st,ed;
			st=(pageNo-1) * rowSize + 1;
			if(st > totalRecord) st=totalRecord-rowSize+1;
			if(st < 0) { st =0; }
			ed = st + rowSize - 1;
			if(ed > totalRecord) {
				ed = totalRecord;
			}
			return new int[]{st,ed};
		}
		public int rowStart(int pageNo) { return rowMargine(pageNo)[0]; }
		public int rowEnd(int pageNo) { return rowMargine(pageNo)[1]; }
		public int rowSize () { return this.rowSize; }
		public int pageSize () { return this.pageSize; }
		public int[] pageMargine(int pageNo) {
			int st,ed;
			st = (pageNo-1) - ((pageNo-1) % pageSize) + 1;
			ed = st + (pageSize-1);
			if(ed > totalPage) {
				ed = totalPage;
			}
			return new int[] {st,ed};
		}
		public int pageStart(int pageNo) { return pageMargine(pageNo)[0]; }
		public int pageEnd(int pageNo) { return pageMargine(pageNo)[1]; }
	}
}
