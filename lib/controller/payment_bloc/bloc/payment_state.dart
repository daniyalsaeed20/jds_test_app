part of 'payment_bloc.dart';

class PaymentState extends Equatable {
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
  PaymentState({
    this.status = PaymentStatus.unknown,
    this.paymentCounter = 1,
    this.totalPayment = 8,
    this.prices = const [8],
    required this.packages,
    this.index = 0,
  });

  PaymentState.unknown() : this(
    packages: [Package(description: 'description', pickup: 'pickup', delivery: 'delivery')]
  );
  PaymentState.addPayment({
    required int value,
    required int totalPayment,
    required List<int> prices,
    required List<Package> packages,
  }) : this(
          status: PaymentStatus.addPayment,
          paymentCounter: value,
          packages: packages,
          prices: prices,
          totalPayment: totalPayment,
        );

  PaymentState.removePayment({
    required int value,
    required int totalPayment,
    required List<int> prices,
    required List<Package> packages,
    required int index,
  }) : this(
          status: PaymentStatus.removePayment,
          paymentCounter: value,
          packages: packages,
          prices: prices,
          totalPayment: totalPayment,
          index: index,
        );

  @override
  List<Object> get props => [
        status,
        paymentCounter,
        packages,
        prices,
        totalPayment,
        index,
      ];
}
