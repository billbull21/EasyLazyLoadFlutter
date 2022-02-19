import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../utils/response_state.dart';

class ListProvider with ChangeNotifier {

  final dio = Dio();
  int pageNumber = 0;
  int lastPageNumber = -1;
  bool isFetchNewData = false;
  final search = TextEditingController();
  final List _dataList = [];
  ResponseState<List> response = ResponseState<List>();

  void _setResponse(ResponseState<List> response){
    this.response = response;
    notifyListeners();
  }

  _setPageNumber(int val) {
    pageNumber = val;
    notifyListeners();
  }

  _setLastPageNumber(int val) {
    lastPageNumber = val;
    notifyListeners();
  }

  _setIsFetchNewData(bool val) {
    isFetchNewData = val;
    notifyListeners();
  }

  Future fetchList({refresh = true}) async {
    try {
      _setLastPageNumber(pageNumber);
      if (refresh) {
        _setResponse(ResponseState.loading<List>());
        _setPageNumber(0);
        _setLastPageNumber(-1);
      } else {
        _setIsFetchNewData(true);
      }
      final res = await dio.get("https://api.instantwebtools.net/v1/passenger?page=$pageNumber&size=10");
      if ((res.data['data'] as List).isNotEmpty) {
        _setPageNumber(pageNumber+1);
      }
      if (refresh) _dataList.clear();
      _dataList.addAll((res.data['data'] as List));
      _setIsFetchNewData(false);
      _setResponse(ResponseState.complete<List>(_dataList));
    } catch (e) {
      print("ERROR FETCH LIST : $e");
      if (refresh) {
        _setResponse(ResponseState.error<List>("$e"));
      } else {
        _setLastPageNumber(pageNumber-1);
        _setIsFetchNewData(false);
      }
    }
  }

}