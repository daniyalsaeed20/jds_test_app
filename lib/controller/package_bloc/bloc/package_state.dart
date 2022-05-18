// ignore_for_file: must_be_immutable

part of 'package_bloc.dart';

class PackageState extends Equatable {
  /* -------------------------------------------------------------------------- */
  /*                                  Variables                                 */
  /* -------------------------------------------------------------------------- */
  PackageStatus status;
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
    this.status = PackageStatus.unknown,
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
          status: PackageStatus.increment,
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
          status: PackageStatus.decrement,
          packageCounter: value,
          packageDeliveryAddressController: packageDeliveryAddressController,
          packageDescriptionController: packageDescriptionController,
          packagePickUpAddressController: packagePickUpAddressController,
          index: index,
        );

  PackageState.onEdit({
    required List<TextEditingController> packageDescriptionController,
    required List<TextEditingController> packagePickUpAddressController,
    required List<TextEditingController> packageDeliveryAddressController,
    required int value,
  }) : this(
          packageCounter: value,
          status: PackageStatus.onEdit,
          packageDeliveryAddressController: packageDeliveryAddressController,
          packageDescriptionController: packageDescriptionController,
          packagePickUpAddressController: packagePickUpAddressController,
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
