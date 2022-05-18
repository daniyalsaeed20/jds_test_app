import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jds_test_app/controller/payment_bloc/bloc/payment_bloc.dart';
import 'package:jds_test_app/model/package_model.dart';
import 'package:jds_test_app/services/payment_services.dart';

part 'package_event.dart';
part 'package_state.dart';

enum CounterStatus { increment, decrement, none }

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  /* -------------------------------------------------------------------------- */
  /*                                  Variables                                 */
  /* -------------------------------------------------------------------------- */

  final _counterStatusController = StreamController<CounterStatus>();

  int packageCounter = 1;
  late int selectedIndex;

  late StreamSubscription<CounterStatus> _counterStatusSubscription;

  late PackageModel packageModel;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */

  List<int> prices = [8];

  List<Package> package = [];

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */
  PackageBloc() : super(PackageState.unknown()) {
    on<PackageIncrementEvent>(_packageIncrementEvent);
    _counterStatusSubscription = status.listen(
      (status) => add(
        PackageIncrementEvent(
          status: status,
        ),
      ),
    );
  }

  Stream<CounterStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield CounterStatus.none;
    yield* _counterStatusController.stream;
  }

  _packageIncrementEvent(
      PackageIncrementEvent event, Emitter<PackageState> emit) {
    switch (event.status) {
      case CounterStatus.increment:
        state.packageDeliveryAddressController.add(TextEditingController());
        state.packageDescriptionController.add(TextEditingController());
        state.packagePickUpAddressController.add(TextEditingController());

        List<Package> packages = [];
        List<int> prices = [];
        for (int i = 0; i < state.packageCounter; i++) {
          packages.add(Package(
            delivery: state.packageDeliveryAddressController[i].text,
            description: state.packageDescriptionController[i].text,
            pickup: state.packagePickUpAddressController[i].text,
          ));
          prices.add(8);
        }

        event.read!<PaymentBloc>().add(
          PaymentIncrementEvent(
            packages: packages,
            status: PaymentStatus.addPayment,
            index: event.index,
            paymentCounter: state.packageCounter,
            prices: prices,
            totalPayment: 0,
          ),
        );

        return emit(
          PackageState.increment(
            value: state.packageCounter + 1,
            packageDeliveryAddressController:
                state.packageDeliveryAddressController,
            packageDescriptionController: state.packageDescriptionController,
            packagePickUpAddressController:
                state.packagePickUpAddressController,
          ),
        );
      case CounterStatus.decrement:
        state.packageDeliveryAddressController.removeAt(event.index);
        state.packageDescriptionController.removeAt(event.index);
        state.packagePickUpAddressController.removeAt(event.index);
        return emit(PackageState.decrement(
          value: state.packageCounter - 1,
          packageDeliveryAddressController:
              state.packageDeliveryAddressController,
          packageDescriptionController: state.packageDescriptionController,
          packagePickUpAddressController: state.packagePickUpAddressController,
          index: event.index,
        ));
      default:
        return emit(PackageState.unknown());
    }
  }

  @override
  Future<void> close() {
    _counterStatusSubscription.cancel();
    return super.close();
  }

  payNow() {
    // package.clear();
    // for (int i = 1; i <= packageCounter; i++) {
    //   package.add(Package(
    //     delivery: packageDeliveryAddressController[i - 1].text,
    //     description: packageDescriptionController[i - 1].text,
    //     pickup: packagePickUpAddressController[i - 1].text,
    //   ));
    // }
    // packageModel = PackageModel(
    //   packages: package,
    // );

    // PaymentServices().payNow(packageModel);
  }
}
