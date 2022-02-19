import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_flutter/GetxWay/controllers/list_controller.dart';
import 'package:lazy_load_flutter/components/lazy_scroll_view.dart';

import '../utils/response_state.dart';

class ListScreenGetx extends StatelessWidget {

  const ListScreenGetx({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LAZY LOAD PROVIDER"),
      ),
      body: GetBuilder<ListController>(
        init: ListController(),
        builder: (ctrl) {
          switch (ctrl.response.state) {
            case ResponseStates.COMPLETE:
              return ctrl.response.data!.isEmpty
                  ? const Center(
                child: Text("EMPTY!"),
              )
                  : LazyScrollView(
                pageNumber: ctrl.pageNumber,
                lastPageNumber: ctrl.lastPageNumber,
                onUpdateData: () => ctrl.fetchList(
                  refresh: false,
                ),
                isFetchNewData: ctrl.isFetchNewData,
                dataList: ctrl.response.data!,
                builder: (ctx, i) {
                  return ListTile(
                    title: Text("${ctrl.response.data![i]['name']} [${i+1}]"),
                  );
                },
              );
            case ResponseStates.ERROR:
              return Center(
                child: Text("${ctrl.response.exception}"),
              );
            case ResponseStates.LOADING:
            default:
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }
}
