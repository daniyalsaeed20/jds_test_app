import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jds_test_app/model/package_model.dart';

part 'payment_event.dart';
part 'payment_state.dart';

enum PaymentStatus { addPayment, removePayment, unknown }

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  /* -------------------------------------------------------------------------- */
  /*                                  Variables                                 */
  /* -------------------------------------------------------------------------- */

  final _counterPaymentController = StreamController<PaymentStatus>();
  late StreamSubscription<PaymentStatus> _counterPaymentSubscription;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */
  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */
  PaymentBloc() : super(PaymentState.unknown()) {
    on<PaymentIncrementEvent>(_paymentIncrementEvent);
    _counterPaymentSubscription = status.listen(
      (status) => add(
        PaymentIncrementEvent(
          packages:[
            Package(
              description: 'description',
              pickup: 'pickup',
              delivery: 'delivery',
            )
          ], 
          status:status,
        //   totalPayment: 8,
        //   paymentCounter: 1,
        //   prices: [8],
          
        //  index:  0,
        ),
      ),
    );
  }

  Stream<PaymentStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield PaymentStatus.unknown;
    yield* _counterPaymentController.stream;
  }

  _paymentIncrementEvent(
      PaymentIncrementEvent event, Emitter<PaymentState> emit) {
    switch (event.status) {
      case PaymentStatus.addPayment:
        return emit(
          PaymentState.addPayment(
            value: event.paymentCounter + 1,
            packages: event.packages,
            prices: event.prices,
            totalPayment: event.prices.fold<int>(
                0, (previousValue, element) => previousValue + element),
          ),
        );
      case PaymentStatus.removePayment:
        state.packages.removeAt(event.index);
        state.prices.removeAt(event.index);
        return emit(PaymentState.removePayment(
          value: event.paymentCounter + 1,
          packages: state.packages,
          prices: state.prices,
          totalPayment: state.prices.fold<int>(
              0, (previousValue, element) => previousValue + element),
          index: event.index,
        ));
      default:
        return emit(PaymentState.unknown());
    }
  }

  @override
  Future<void> close() {
    _counterPaymentSubscription.cancel();
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
