import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
          status,
          1,
          [TextEditingController()],
          [TextEditingController()],
          [TextEditingController()],
          0,
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
        event.packageDeliveryAddressController.add(TextEditingController());
        event.packageDescriptionController.add(TextEditingController());
        event.packagePickUpAddressController.add(TextEditingController());
        return emit(
          PackageState.increment(
            value: event.packageCounter + 1,
            packageDeliveryAddressController:
                event.packageDeliveryAddressController,
            // <TextEditingController>[event.packageDeliveryAddressController + TextEditingController()],
            packageDescriptionController: event.packageDescriptionController,
            packagePickUpAddressController:
                event.packagePickUpAddressController,
          ),
        );
      case CounterStatus.decrement:
      event.packageDeliveryAddressController.removeAt(event.index);
        event.packageDescriptionController.removeAt(event.index);
        event.packagePickUpAddressController.removeAt(event.index);
        return emit(PackageState.decrement(
          value: event.packageCounter - 1,
          packageDeliveryAddressController:
              event.packageDeliveryAddressController,
          packageDescriptionController: event.packageDescriptionController,
          packagePickUpAddressController: event.packagePickUpAddressController,
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
