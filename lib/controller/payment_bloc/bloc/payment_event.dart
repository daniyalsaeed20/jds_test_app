// ignore_for_file: must_be_immutable, overridden_fields, annotate_overrides, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables

part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent({
    this.paymentCounter = 1,
  });

  final int paymentCounter;

  @override
  List<Object> get props => [];
}

class PaymentIncrementEvent extends PaymentEvent {
  PaymentIncrementEvent({
    required this.status,
    this.paymentCounter = 1,
    this.totalPayment = 8,
    this.prices = const [8],
    required this.packages,
    this.index = 0,
  });

  /* -------------------------------------------------------------------------- */
  /*                                  variables                                 */
  /* -------------------------------------------------------------------------- */

  final PaymentStatus status;
  final int paymentCounter;
  final int totalPayment;
  final int index;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */

  List<int> prices;
  List<Package> packages;

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */

  @override
  List<Object> get props => [
        status,
        paymentCounter,
        totalPayment,
        prices,
        packages,
        index,
      ];
}
class PayNowEvent extends PaymentEvent {
  PayNowEvent({
    required this.status,
    this.paymentCounter = 1,
    this.totalPayment = 8,
    this.prices = const [8],
    required this.packages,
    this.index = 0,
    this.read,
  });

  /* -------------------------------------------------------------------------- */
  /*                                  variables                                 */
  /* -------------------------------------------------------------------------- */

  final PaymentStatus status;
  final int paymentCounter;
  final int totalPayment;
  final int index;
  var read;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */

  List<int> prices;
  List<Package> packages;

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */

  @override
  List<Object> get props => [
        status,
        paymentCounter,
        totalPayment,
        prices,
        packages,
        index,
      ];
}

class PayNowEventResponse extends PaymentEvent {
  PayNowEventResponse({
    required this.status,
  });

  /* -------------------------------------------------------------------------- */
  /*                                  variables                                 */
  /* -------------------------------------------------------------------------- */

  final PaymentStatus status;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */

  @override
  List<Object> get props => [
        status,
      ];
}
class PaymentResetEvent extends PaymentEvent {
  PaymentResetEvent({
    required this.status,
  });

  /* -------------------------------------------------------------------------- */
  /*                                  variables                                 */
  /* -------------------------------------------------------------------------- */

  final PaymentStatus status;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */

  @override
  List<Object> get props => [
        status,
      ];
}
