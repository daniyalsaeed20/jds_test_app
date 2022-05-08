import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:jds_test_app/controller/package_controller/package_event.dart';
import 'package:jds_test_app/controller/package_controller/payment_event.dart';
import 'package:jds_test_app/model/order_model.dart';
import 'package:jds_test_app/model/package_model.dart';
import 'package:jds_test_app/services/payment_services.dart';

class PackageBloc {
  /* -------------------------------------------------------------------------- */
  /*                                  Variables                                 */
  /* -------------------------------------------------------------------------- */

  int packageCounter = 1;
  int selectedIndex = 0;
  int paymentCounter = 1;
  int totalPayment = 8;

  final _packageCounterStateController = StreamController<int>();
  final _packageCounterEventController = StreamController<PackageEvent>();
  final _paymentStateController = StreamController<int>();
  final _paymentEventController = StreamController<PaymentEvent>();

  late PackageModel packageModel;

  late OrderModel orderModel;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */

  List<TextEditingController> packageDescriptionController = [
    TextEditingController()
  ];
  List<TextEditingController> packagePickUpAddressController = [
    TextEditingController()
  ];
  List<TextEditingController> packageDeliveryAddressController = [
    TextEditingController()
  ];

  List<int> prices = [8];

  List<Package> package = [];

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */

  /* ------------------------------ package state ----------------------------- */

  StreamSink<int> get _inPackageCounter => _packageCounterStateController.sink;
  Stream<int> get outPackageCounter => _packageCounterStateController.stream;
  StreamSink<int> get _inPayment => _paymentStateController.sink;
  Stream<int> get outPayment => _paymentStateController.stream;

  /* ------------------------------ package event ----------------------------- */

  StreamSink<PackageEvent> get packageCounterEventSink =>
      _packageCounterEventController.sink;
  StreamSink<PaymentEvent> get paymentEventSink => _paymentEventController.sink;

  PackageBloc() {
    _packageCounterEventController.stream.listen(_mapPackageEventToState);
    _paymentEventController.stream.listen(_mapPaymentEventToState);
  }

  void _mapPackageEventToState(PackageEvent event) {
    if (event is AddEvent) {
      packageCounter++;
      packageDescriptionController.add(TextEditingController());
      packagePickUpAddressController.add(TextEditingController());
      packageDeliveryAddressController.add(TextEditingController());
    } else {
      packageCounter--;
      packageDescriptionController.removeAt(selectedIndex);
      packagePickUpAddressController.removeAt(selectedIndex);
      packageDeliveryAddressController.removeAt(selectedIndex);
    }

    _inPackageCounter.add(packageCounter);
  }

  void _mapPaymentEventToState(PaymentEvent event) {
    if (event is AddPaymentEvent) {
      paymentCounter += 1;
      totalPayment += 8;
      prices.add(8);
    } else {
      paymentCounter -= 1;
      totalPayment -= 8;
      prices.removeAt(selectedIndex);
    }

    _inPayment.add(paymentCounter);
  }

  void dispose() {
    _packageCounterEventController.close();
    _packageCounterStateController.close();
    _paymentEventController.close();
    _paymentStateController.close();
  }

  payNow() {
    package.clear();
    for (int i = 1; i <= packageCounter; i++) {
      package.add(Package(
        delivery: packageDeliveryAddressController[i - 1].text,
        description: packageDescriptionController[i - 1].text,
        pickup: packagePickUpAddressController[i - 1].text,
      ));
    }
    packageModel = PackageModel(
      packages: package,
    );

    PaymentServices().payNow(packageModel);
  }
}
