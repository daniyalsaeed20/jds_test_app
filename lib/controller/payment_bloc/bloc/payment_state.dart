// ignore_for_file: must_be_immutable

part of 'payment_bloc.dart';

class PaymentState extends Equatable {
  /* -------------------------------------------------------------------------- */
  /*                                  variables                                 */
  /* -------------------------------------------------------------------------- */

  final PaymentStatus status;
  final int paymentCounter;
  final int totalPayment;
  final int index;

  String code;
  String message;
  String heading;

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
    this.code = 'No Code',
    this.message = 'No Message',
    this.heading = 'No Heading',
  });

  PaymentState.unknown()
      : this(packages: [
          Package(
              description: 'description',
              pickup: 'pickup',
              delivery: 'delivery')
        ]);
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

  PaymentState.payNow({
    required int value,
    required int totalPayment,
    required List<int> prices,
    required List<Package> packages,
  }) : this(
          status: PaymentStatus.payNow,
          paymentCounter: value,
          packages: packages,
          prices: prices,
          totalPayment: totalPayment,
        );

  PaymentState.payNowResponse({
    required String code,
    required String message,
    required String heading,
    required PaymentStatus status,
    /* ---------------------------------- extra --------------------------------- */
    required int value,
    required int totalPayment,
    required List<int> prices,
    required List<Package> packages,
  }) : this(
          status: status,
          code: code,
          message: message,
          heading: heading,
          packages: packages,
          /* ---------------------------------- extra --------------------------------- */
          paymentCounter: value,
          prices: prices,
          totalPayment: totalPayment,
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
