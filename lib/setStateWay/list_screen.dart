import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_flutter/components/lazy_scroll_view.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int currentPageNumber = 0, lasPageNumber = -1;
  bool isFetchNewData = false;
  List? dataList;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData({refresh = true}) async {
    try {
      setState(() {
        lasPageNumber = currentPageNumber;
      });
      if (refresh) {
        setState(() {
          currentPageNumber = 0;
          lasPageNumber = -1;
        });
      } else {
        setState(() {
          isFetchNewData = true;
        });
      }
      final dio = Dio();
      final response = await dio.get("https://api.instantwebtools.net/v1/passenger?page=$currentPageNumber&size=10");
      final List list = response.data['data'];
      if (list.isNotEmpty) {
        setState(() {
          currentPageNumber += 1;
        });
      }
      if (refresh) {
        dataList?.clear();
        dataList = list;
      } else {
        dataList?.addAll(list);
        setState(() {
          isFetchNewData = false;
        });
      }
    } catch (e) {
      print("ERROR :: $e");
      if (!refresh) {
        setState(() {
          lasPageNumber -= 1;
          isFetchNewData = false;
        });
      }
      // you can put your snackbar / toast here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LAZY LOAD"),
      ),
      body: dataList == null
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : dataList!.isEmpty ? const Text("EMPTY") : LazyScrollView(
              pageNumber: currentPageNumber,
              lastPageNumber: lasPageNumber,
              onUpdateData: () => fetchData(
                refresh: false,
              ),
              isFetchNewData: isFetchNewData,
              dataList: dataList!,
              builder: (ctx, i) {
                return ListTile(
                  title: Text("${dataList![i]['name']} [${i+1}]"),
                );
              },
            ),
    );
  }
}
