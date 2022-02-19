import 'package:flutter/material.dart';
import 'package:lazy_load_flutter/components/lazy_scroll_view.dart';
import 'package:lazy_load_flutter/providerWay/providers/list_provider.dart';

import '../components/custom_change_notifier.dart';
import '../utils/response_state.dart';

class ListScreenProvider extends StatefulWidget {
  const ListScreenProvider({Key? key}) : super(key: key);

  @override
  State<ListScreenProvider> createState() => _ListScreenProviderState();
}

class _ListScreenProviderState extends State<ListScreenProvider> {

  final ListProvider _listProvider = ListProvider();

  @override
  void initState() {
    super.initState();
    _listProvider.fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LAZY LOAD PROVIDER"),
      ),
      body: RefreshIndicator(
        onRefresh: _listProvider.fetchList,
        child: SafeArea(
          child: CustomChangeNotifier<ListProvider>(
            value: _listProvider,
            builder: (_, prov, __) {
              switch (prov.response.state) {
                case ResponseStates.COMPLETE:
                  return prov.response.data!.isEmpty
                      ? const Center(
                    child: Text("EMPTY!"),
                  )
                      : LazyScrollView(
                    pageNumber: prov.pageNumber,
                    lastPageNumber: prov.lastPageNumber,
                    onUpdateData: () => prov.fetchList(
                      refresh: false,
                    ),
                    isFetchNewData: prov.isFetchNewData,
                    dataList: prov.response.data!,
                    builder: (ctx, i) {
                      return ListTile(
                        title: Text("${prov.response.data![i]['name']} [${i+1}]"),
                      );
                    },
                  );
                case ResponseStates.ERROR:
                  return Center(
                    child: Text("${prov.response.exception}"),
                  );
                case ResponseStates.LOADING:
                default:
                return const Center(child: CircularProgressIndicator.adaptive());
              }
            },
          ),
        ),
      ),
    );
  }
}
