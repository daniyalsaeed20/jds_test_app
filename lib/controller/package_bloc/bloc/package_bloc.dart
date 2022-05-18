import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jds_test_app/controller/payment_bloc/bloc/payment_bloc.dart';
import 'package:jds_test_app/model/package_model.dart';

part 'package_event.dart';
part 'package_state.dart';

enum PackageStatus { increment, decrement, unknown, onEdit }

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  /* -------------------------------------------------------------------------- */
  /*                                  Variables                                 */
  /* -------------------------------------------------------------------------- */

  final _counterStatusController = StreamController<PackageStatus>();

  int packageCounter = 1;
  late int selectedIndex;

  late StreamSubscription<PackageStatus> _counterStatusSubscription;

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
    on<PackageEditingEvent>(_packageEditingEvent);
    on<PackageResetEvent>(_packageResetEvent);
    _counterStatusSubscription = status.listen(
      (status) => add(
        PackageIncrementEvent(
          status: status,
        ),
      ),
    );
  }

  Stream<PackageStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield PackageStatus.unknown;
    yield* _counterStatusController.stream;
  }

  _packageIncrementEvent(
      PackageIncrementEvent event, Emitter<PackageState> emit) {
    switch (event.status) {
      case PackageStatus.increment:
        state.packageDeliveryAddressController.add(TextEditingController());
        state.packageDescriptionController.add(TextEditingController());
        state.packagePickUpAddressController.add(TextEditingController());

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

      case PackageStatus.decrement:
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
        packages.removeAt(event.index);
        prices.removeAt(event.index);
        event.read!<PaymentBloc>().add(
          PaymentIncrementEvent(
            packages: packages,
            status: PaymentStatus.removePayment,
            index: event.index,
            paymentCounter: state.packageCounter,
            prices: prices,
            totalPayment: 0,
          ),
        );
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

  _packageEditingEvent(PackageEditingEvent event, Emitter<PackageState> emit) {
    emit(
      PackageState.onEdit(
        value: state.packageCounter,
        packageDeliveryAddressController:
            state.packageDeliveryAddressController,
        packageDescriptionController: state.packageDescriptionController,
        packagePickUpAddressController: state.packagePickUpAddressController,
      ),
    );

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

    return event.read!<PaymentBloc>().add(
      PaymentIncrementEvent(
        packages: packages,
        status: PaymentStatus.addPayment,
        paymentCounter: state.packageCounter,
        prices: prices,
        totalPayment: 0,
      ),
    );
  }

  _packageResetEvent(PackageResetEvent event, Emitter<PackageState> emit) {
    emit(
      PackageState.unknown(),
    );
  }

  @override
  Future<void> close() {
    _counterStatusSubscription.cancel();
    return super.close();
  }
}
