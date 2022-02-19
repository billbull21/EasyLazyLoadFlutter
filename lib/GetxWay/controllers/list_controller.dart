import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/response_state.dart';

class ListController extends GetxController {

  final dio = Dio();
  int pageNumber = 0;
  int lastPageNumber = -1;
  bool isFetchNewData = false;
  final search = TextEditingController();
  final List _dataList = [];
  ResponseState<List> response = ResponseState<List>();

  void _setResponse(ResponseState<List> response){
    this.response = response;
    update();
  }

  _setPageNumber(int val) {
    pageNumber = val;
    update();
  }

  _setLastPageNumber(int val) {
    lastPageNumber = val;
    update();
  }

  _setIsFetchNewData(bool val) {
    isFetchNewData = val;
    update();
  }


  @override
  void onInit() {
    super.onInit();
    fetchList();
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