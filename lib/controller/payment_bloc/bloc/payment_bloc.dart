import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jds_test_app/model/package_model.dart';
import 'package:jds_test_app/services/payment_services.dart';

part 'payment_event.dart';
part 'payment_state.dart';

enum PaymentStatus {
  addPayment,
  removePayment,
  unknown,
  payNow,
  payNowResponse
}

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  /* -------------------------------------------------------------------------- */
  /*                                  Variables                                 */
  /* -------------------------------------------------------------------------- */

  final _counterPaymentController = StreamController<PaymentStatus>();
  late StreamSubscription<PaymentStatus> _counterPaymentSubscription;

  late Map<String, String> map;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */
  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */
  PaymentBloc() : super(PaymentState.unknown()) {
    on<PaymentIncrementEvent>(_paymentIncrementEvent);
    on<PayNowEvent>(_payNowEvent);
    on<PayNowEventResponse>(_payNowEventResponse);
    on<PaymentResetEvent>(_paymentResetEvent);
    _counterPaymentSubscription = status.listen(
      (status) => add(
        PaymentIncrementEvent(
          packages: [
            Package(
              description: 'description',
              pickup: 'pickup',
              delivery: 'delivery',
            )
          ],
          status: status,
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
            value: event.paymentCounter,
            packages: event.packages,
            prices: event.prices,
            totalPayment: event.prices.fold<int>(
                0, (previousValue, element) => previousValue + element),
          ),
        );
      case PaymentStatus.removePayment:
        return emit(PaymentState.removePayment(
          value: event.paymentCounter - 1,
          packages: event.packages,
          prices: event.prices,
          totalPayment: event.prices.fold<int>(
              0, (previousValue, element) => previousValue + element),
          index: event.index,
        ));
      default:
        return emit(PaymentState.unknown());
    }
  }

  _payNowEvent(PayNowEvent event, Emitter<PaymentState> emit) async {
    List<Package> packages = [];
    for (int i = 0; i < state.paymentCounter; i++) {
      packages.add(Package(
        delivery: state.packages[i].delivery,
        description: state.packages[i].description,
        pickup: state.packages[i].pickup,
      ));
    }
    PackageModel packageModel = PackageModel(
      packages: packages,
    );

    map = await PaymentServices().payNow(
      packageModel: packageModel,
      read: event.read,
    );
  }

  _payNowEventResponse(PayNowEventResponse event, Emitter<PaymentState> emit) {
    if (event.status == PaymentStatus.payNowResponse) {
      return emit(
        PaymentState.payNowResponse(
          code: map['code']!,
          heading: map['heading']!,
          message: map['message']!,
          status: PaymentStatus.payNowResponse,

          /* ---------------------------------- extra --------------------------------- */
          value: state.paymentCounter,
          packages: state.packages,
          prices: state.prices,
          totalPayment: state.prices.fold<int>(
              0, (previousValue, element) => previousValue + element),
        ),
      );
    }
  }

  _paymentResetEvent(PaymentResetEvent event, Emitter<PaymentState> emit) {
    return emit(
      PaymentState.unknown(),
    );
  }

  @override
  Future<void> close() {
    _counterPaymentSubscription.cancel();
    return super.close();
  }
}
