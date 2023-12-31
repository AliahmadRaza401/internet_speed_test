import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/wifi_Resut_Model.dart';

class HomeProvider extends ChangeNotifier {
  late BuildContext context;

  init({required BuildContext context}) {
    this.context = context;
  }

  bool loading = false;
  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  final internetSpeedTest = FlutterInternetSpeedTest();

  String dataUnit = '';
  String tranxferType = 'download';
  double transferRate = 0.0;
  double dataCompleteRate = 0.0;
  double? uploadCompleteRate;
  double? downloadComplteRate;
  int homeState = 0;
  bool testDownloadType = false;
  bool testUploadType = false;
  String ipAddress = '';

  double previousDownloadRate = 0.0;
  int consecutiveJumpCount = 0;
  int maxConsecutiveJumpsAllowed = 1;

  checkInterSpeed() {
    internetSpeedTest.startTesting(
      onProgress: (percent, data) {
        log(
          'data.unit ${data.unit} Transfer Type : ${data.type}the transfer rate ${data.transferRate}, the percent $percent',
        );

        // Check if the new rate is significantly higher than the previous one
        if (data.transferRate - previousDownloadRate > 10) {
          consecutiveJumpCount++;
          if (consecutiveJumpCount <= maxConsecutiveJumpsAllowed) {
            // Keep the previous rate and don't update
            print(
                'Ignoring the jump in download rate.___________________________________________________');
            return;
          }
        } else {
          // Reset the consecutive jump count if the rate is reasonable
          consecutiveJumpCount = 0;
          dataUnit = data.unit.toString();
          tranxferType = data.type.toString();
          transferRate = data.transferRate;
        }
        previousDownloadRate = data.transferRate;
        dataCompleteRate = percent;
        notifyListeners();
      },
      onError: (String errorMessage, String speedTestError) {
        print(
            'the errorMessage $errorMessage, the speedTestError $speedTestError');
      },
      onDefaultServerSelectionDone: (Client? clinet) {
        ipAddress = clinet!.ip!;
      },
      onCompleted: (TestResult download, TestResult upload) {
        log("download.transferRate = " + download.transferRate.toString());
        log("Upload.transferRate = " + upload.transferRate.toString());
        log("download.durationInMillis = " +
            download.durationInMillis.toString());
        uploadCompleteRate = upload.transferRate;
        downloadComplteRate = download.transferRate;

        addTODOItem(
          WifiResultModel(
            testDate: DateTime.now(),
            ping: '31',
            dowoloadSpeed: download.transferRate.toStringAsFixed(2),
            uploadSpeed: upload.transferRate.toStringAsFixed(2),
            ipAddress: ipAddress,
          ),
        );
        homeState = 3;
        transferRate = 0.0;
        notifyListeners();
      },
      onDownloadComplete: (TestResult data) {
        testDownloadType = true;
        log('Download is Complete = $data');
        downloadComplteRate = data.transferRate;

        notifyListeners();
      },
      onStarted: () {
        homeState = 1;
        log('Function Start');
      },
      onUploadComplete: (TestResult data) {
        log('Uload Complete  = ${data.transferRate}');
        uploadCompleteRate = data.transferRate;
        testUploadType = true;
        // homeState = 0;
        notifyListeners();
      },
      onDefaultServerSelectionInProgress: () {
        log('Default Server ');
      },
    );
    notifyListeners();
  }

  cleanData() {
    dataUnit = '';
    tranxferType = 'download';
    transferRate = 0.0;
    dataCompleteRate = 0.0;
    // uploadCompleteRate == null;
    homeState = 0;
    testDownloadType = false;
    testUploadType = false;
    notifyListeners();
  }

  // Hive Working Start

  String wifiResultBox = 'wifiResultBox';
  List<WifiResultModel> _todoList = [];
  List<WifiResultModel> get todoList => _todoList;
  List<dynamic> parsedList = [];
  // TODO WORK
  List<double> downloadList = [];
  List<double> uploadList = [];

  seprateTheLists(List<WifiResultModel> list) {
    for (var e in list) {
      downloadList.add(double.parse(e.dowoloadSpeed.toString()));
      uploadList.add(double.parse(e.uploadSpeed.toString()));

      notifyListeners();
    }
  }

  addTODOItem(WifiResultModel product) async {
    var box = await Hive.openBox<WifiResultModel>(wifiResultBox);
    box.add(product);
    notifyListeners();
  }

  getTODOItem() async {
    final box = await Hive.openBox<WifiResultModel>(wifiResultBox);
    _todoList = box.values.toList().reversed.toList();
    // log("Wifi Result length " + _todoList.length.toString());
    downloadList.clear();
    uploadList.clear();
    seprateTheLists(_todoList);
    notifyListeners();
  }

  updateTODOItem(int index, WifiResultModel product) {
    final box = Hive.box<WifiResultModel>(wifiResultBox);
    box.putAt(index, product);
    notifyListeners();
  }

  deleteTODOItem(int index) {
    final box = Hive.box<WifiResultModel>(wifiResultBox);
    box.deleteAt(index);
    log('Value Delete $index');
    getTODOItem();

    notifyListeners();
  }
}
