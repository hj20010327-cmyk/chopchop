package kr.or.chop.common.pagination;

public class Pagination {

    public static PageInfo getPageInfo(
            int listCount,
            int currentPage,
            int pageLimit,
            int boardLimit) {

        // 전체 페이지 수
    	int maxPage =
    		    (int)Math.ceil((double)listCount / boardLimit);

    		if(maxPage == 0) {
    		    maxPage = 1;
    		}

        // 시작 페이지
        int startPage =
                (currentPage - 1) / pageLimit * pageLimit + 1;

        // 끝 페이지
        int endPage =
                startPage + pageLimit - 1;

        // 끝 페이지 보정
        if(endPage > maxPage) {
            endPage = maxPage;
        }

        // 조회 시작 rownum
        int startRow =
                (currentPage - 1) * boardLimit + 1;

        // 조회 끝 rownum
        int endRow =
                startRow + boardLimit - 1;

        return new PageInfo(
                currentPage,
                listCount,
                pageLimit,
                boardLimit,
                maxPage,
                startPage,
                endPage,
                startRow,
                endRow
        );
    }
}