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

  List<TextEditingController> packageDescriptionController;
  List<TextEditingController> packagePickUpAddressController;
  List<TextEditingController> packageDeliveryAddressController;

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */
  PackageState({
    this.status = CounterStatus.none,
    this.packageCounter = 1,
    required this.packageDescriptionController,
    required this.packagePickUpAddressController,
    required this.packageDeliveryAddressController,
    this.index = 0,
  });

  PackageState.unknown()
      : this(
          packageDeliveryAddressController: [TextEditingController()],
          packagePickUpAddressController: [TextEditingController()],
          packageDescriptionController: [TextEditingController()],
        );
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
          packageDeliveryAddressController: packageDeliveryAddressController,
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
