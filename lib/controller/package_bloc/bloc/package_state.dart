part of 'package_bloc.dart';

class PackageState extends Equatable {
  /* -------------------------------------------------------------------------- */
  /*                                  Variables                                 */
  /* -------------------------------------------------------------------------- */
  CounterStatus status;
  int packageCounter;
  int index;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */

  final List<TextEditingController> packageDescriptionController = [
    TextEditingController()
  ];
  List<TextEditingController> packagePickUpAddressController = [
    TextEditingController()
  ];
  List<TextEditingController> packageDeliveryAddressController = [
    TextEditingController()
  ];

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */
  PackageState({
    this.status = CounterStatus.none,
    this.packageCounter = 1,
    packageDescriptionController,
    packagePickUpAddressController,
    packageDeliveryAddressController,
    this.index = 0,
  });

  PackageState.unknown() : this();
  PackageState.increment({
    required int value,
    required List<TextEditingController> packageDescriptionController,
    required List<TextEditingController> packagePickUpAddressController,
    required List<TextEditingController> packageDeliveryAddressController,
  }) : this(
          status: CounterStatus.increment,
          packageCounter: value,
          packageDescriptionController: packageDescriptionController,
          packageDeliveryAddressController: packageDeliveryAddressController,
          packagePickUpAddressController: packagePickUpAddressController,
        );


  PackageState.decrement({
    required int value,
    required int index,
    required List<TextEditingController> packageDescriptionController,
    required List<TextEditingController> packagePickUpAddressController,
    required List<TextEditingController> packageDeliveryAddressController,
  }) : this(
          status: CounterStatus.decrement,
          packageCounter: value,
          packageDeliveryAddressController: packagePickUpAddressController,
          packageDescriptionController: packageDescriptionController,
          packagePickUpAddressController: packagePickUpAddressController,
          index: index,
        );

  @override
  List<Object> get props => [
        status,
        packageCounter,
        packageDescriptionController,
        packagePickUpAddressController,
        packageDeliveryAddressController,
        index,
      ];
}
