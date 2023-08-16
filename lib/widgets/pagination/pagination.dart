import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFPagination extends StatefulWidget {
  const SFPagination({
    super.key,
    required this.pageController,
    required this.totalPage,
    required this.currentPage,
    required this.itemsPerPage,
    this.width,
    this.height,
    this.indexBoxPadding,
    this.indexBoxMargin,
    this.selectedBoxRadius,
    this.backgroundColor,
    this.selectedBoxColor,
    this.selectedNumberColor,
    this.unselectedNumberColor,
    this.selectedNumberStyle,
    this.unselectedNumberStyle,
    this.previousPageButton,
    this.nextPageButton,
  }): assert(totalPage >= itemsPerPage, "totalPage must be greater than or equal to itemsPerPage"),
      assert(currentPage >= 1, "currentPage must be greater than or equal to 1");

  //페이지 컨트롤러
  final PageController pageController;

  //총 페이지 수
  final int totalPage;

  //현재 표시 중인 페이지를 추적하고 관리하는 변수
  final int currentPage;

  //화면에 보여지는 페이지 항목 수
  final int itemsPerPage;

  //가로 너비
  final double? width;

  //페이지네이션 높이
  final double? height;

  //pugeNumber들 selectedBox와의 패딩
  final EdgeInsetsGeometry? indexBoxPadding;

  //pagination의 상하여백 margin
  final EdgeInsetsGeometry? indexBoxMargin;

  //선택된 페이지넘버 박스의 라운드
  final double? selectedBoxRadius;

  //Pagination 배경색
  final Color? backgroundColor;

  //선택된 페이지넘버 박스의 색
  final Color? selectedBoxColor;

  //선택된 페이지넘버 숫자의 색
  final Color? selectedNumberColor;

  //선택되지 않은 페이지넘버 숫자의 색
  final Color? unselectedNumberColor;

  //선택된 페이지넘버 숫자의 스타일
  final TextStyle? selectedNumberStyle;

  //선택되지 않은 페이지넘버 숫자의 스타일
  final TextStyle? unselectedNumberStyle;

  //이전페이지로 가는 아이콘
  final Widget? previousPageButton;

  //다음페이지로 가는 아이콘
  final Widget? nextPageButton;

  @override
  State<SFPagination> createState() => _SFPaginationState();
}

class _SFPaginationState extends State<SFPagination> {
  late int totalPage = widget.totalPage;
  late int currentPage = widget.currentPage;
  late int itemsPerPage = widget.itemsPerPage;
  late List<int> pageNumbers =
      List.generate(widget.itemsPerPage, (index) => index + 1);

  void onPageSelected(int page) {
    if (page >= 1 && page <= totalPage){
    setState(() {
      currentPage = page;
      getPageNumbers();
    });
    widget.pageController.jumpToPage(page - 1);
    }
  }

  getPageNumbers() {
    var pageIndex = pageNumbers.indexOf(currentPage);
    if (pageIndex == -1) {
      if (currentPage < pageNumbers.first) {
        pageNumbers = pageNumbers.map((e) => e - itemsPerPage).toList();
        if (pageNumbers.first < 1) {
          pageNumbers =
              pageNumbers.map((e) => e + (1 - pageNumbers.first)).toList();
        }
      } else if (currentPage > pageNumbers.last) {
        pageNumbers = pageNumbers.map((e) => e + itemsPerPage).toList();
        if (pageNumbers.last > totalPage) {
          pageNumbers = pageNumbers
              .map((e) => e - (pageNumbers.last - totalPage))
              .toList();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: widget.width ?? MediaQuery.of(context).size.width,
            height: widget.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: currentPage > 1
                      ? () => onPageSelected(currentPage - 1)
                      : null,
                  child: widget.previousPageButton ??
                      Icon(
                        Icons.navigate_before,
                        color: currentPage == 1 ? SFColor.grayScale30 : null,
                      ),
                ),
                Expanded(
                  //IntrinsicHeight 위젯은 자식 위젯의 최소 크기와 최대 크기 사이에서 사용 가능한 모든 공간을 차지하도록 하는 위젯
                  child: IntrinsicHeight(
                    child: Wrap(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: pageNumbers
                              .map((pageNumber) => InkWell(
                                    onTap: () => onPageSelected(pageNumber),
                                    child: Container(
                                      padding: widget.indexBoxPadding ??
                                          const EdgeInsets.all(4),
                                      margin: widget.indexBoxMargin ??
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: currentPage == pageNumber
                                            ? widget.selectedBoxColor ??
                                                SFColor.primary70
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                            widget.selectedBoxRadius ?? 4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "$pageNumber",
                                          style: currentPage == pageNumber
                                              ? (widget.selectedNumberStyle ??
                                                  SFTextStyle.b4B14(
                                                    color: widget
                                                            .selectedNumberColor ??
                                                        Colors.white,
                                                  ))
                                              : (widget.unselectedNumberStyle ??
                                                  SFTextStyle.b4B14(
                                                    color: widget
                                                            .unselectedNumberColor ??
                                                        SFColor.grayScale60,
                                                  )),
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: currentPage < totalPage
                      ? () => onPageSelected(currentPage + 1)
                      : null,
                  child: widget.nextPageButton ??
                      Icon(
                        Icons.navigate_next,
                        color:
                            currentPage == totalPage ? SFColor.grayScale30 : null,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
