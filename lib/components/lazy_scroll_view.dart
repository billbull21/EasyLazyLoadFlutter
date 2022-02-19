import 'package:flutter/material.dart';

class LazyScrollView<T> extends StatelessWidget {
  final int pageNumber, lastPageNumber;
  final VoidCallback onUpdateData;
  final bool isFetchNewData;
  final List<T> dataList;
  final Widget Function(BuildContext context, int index) builder;

  const LazyScrollView(
      {Key? key,
      required this.pageNumber,
      required this.lastPageNumber,
      required this.onUpdateData,
      required this.isFetchNewData,
      required this.dataList,
      required this.builder,
      })
      : super(key: key);

  void _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (pageNumber != lastPageNumber) {
        onUpdateData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scroll) {
        _handleScrollEvent(scroll);
        return true;
      },
      child: Scrollbar(
        child: ListView.builder(
          padding: const EdgeInsets.only(
            left: 8,
            top: 8,
            right: 8,
            bottom: 80,
          ),
          itemCount:
              isFetchNewData ? dataList.length + 1 : dataList.length,
          itemBuilder: (ctx, i) {
            if (i >= dataList.length && isFetchNewData) {
              return const SizedBox(
                height: 60,
                child: Center(child: CircularProgressIndicator.adaptive()),
              );
            }
            return builder(context, i);
          },
        ),
      ),
    );
  }
}
