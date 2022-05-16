part of 'package_bloc.dart';

abstract class PackageEvent extends Equatable {
  const PackageEvent();

  @override
  List<Object> get props => [];
}

class PackageIncrementEvent extends PackageEvent {
  PackageIncrementEvent(
    this.status,
    this.packageCounter,
    this.packageDescriptionController,
    this.packagePickUpAddressController,
    this.packageDeliveryAddressController,
    this.index,
  );

  /* -------------------------------------------------------------------------- */
  /*                                  variables                                 */
  /* -------------------------------------------------------------------------- */

  final CounterStatus status;
  final int packageCounter;
  final int index;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */

  List<TextEditingController> packageDescriptionController;
  List<TextEditingController> packagePickUpAddressController;
  List<TextEditingController> packageDeliveryAddressController;

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */

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
