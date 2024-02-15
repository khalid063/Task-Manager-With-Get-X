


///*** NO 1 Work

import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/models/summary_count_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class SummaryCountController extends GetxController {

  SummaryCountModel _summaryCountModel = SummaryCountModel();
  bool _getCountSummaryInProgress = false;

  bool get getCountSummaryInProgress => _getCountSummaryInProgress;

  SummaryCountModel get summaryCountModel => _summaryCountModel;

  ///---------------------------------------- getCountSummary Function (Task Status Count) API Call ---------------------------///

  /// API call start
  Future<bool> getCountSummary() async{
    _getCountSummaryInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.taskStatusCount);
    _getCountSummaryInProgress = false;
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
      update();
      // _getCountSummaryInProgress = false;
      return true;
    }else {

      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Summary Data get Failede!'),),);
      // }
      update();
      return false;

    }

  }

}