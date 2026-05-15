package kr.or.chop.common.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PageInfo {

    // 현재 페이지
    private int currentPage;

    // 전체 게시글 수
    private int listCount;

    // 페이지 버튼 수
    private int pageLimit;

    // 한 페이지당 게시글 수
    private int boardLimit;

    // 전체 페이지 수
    private int maxPage;

    // 시작 페이지
    private int startPage;

    // 끝 페이지
    private int endPage;

    // 조회 시작 rownum
    private int startRow;

    // 조회 끝 rownum
    private int endRow;

    public PageInfo(
            int currentPage,
            int listCount,
            int pageLimit,
            int boardLimit,
            int maxPage,
            int startPage,
            int endPage,
            int startRow,
            int endRow) {

        this.currentPage = currentPage;
        this.listCount = listCount;
        this.pageLimit = pageLimit;
        this.boardLimit = boardLimit;
        this.maxPage = maxPage;
        this.startPage = startPage;
        this.endPage = endPage;
        this.startRow = startRow;
        this.endRow = endRow;
    }
}