part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

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

// void _mapPaymentEventToState(PaymentEvent event) {
//   if (event is AddPaymentEvent) {
//     paymentCounter += 1;
//     totalPayment += 8;
//     prices.add(8);
//   } else {
//     paymentCounter -= 1;
//     totalPayment -= 8;
//     prices.removeAt(selectedIndex);
//   }

//   _inPayment.add(paymentCounter);
// }
