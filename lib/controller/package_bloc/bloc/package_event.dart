// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables

part of 'package_bloc.dart';

abstract class PackageEvent extends Equatable {
  const PackageEvent();

  @override
  List<Object> get props => [];
}

class PackageIncrementEvent extends PackageEvent {
  PackageIncrementEvent({
    required this.status,
    this.index = 0,
    this.read,
  });

  /* -------------------------------------------------------------------------- */
  /*                                  variables                                 */
  /* -------------------------------------------------------------------------- */

  final PackageStatus status;
  final int index;
  var read;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */

  @override
  List<Object> get props => [
        status,
        index,
        read,
      ];
}

class PackageEditingEvent extends PackageEvent {
  PackageEditingEvent({
    required this.status,
    this.read,
  });
  /* -------------------------------------------------------------------------- */
  /*                                  Variables                                 */
  /* -------------------------------------------------------------------------- */

  final PackageStatus status;
  var read;

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */

  @override
  List<Object> get props => [
        status,
        read,
      ];
}

class PackageResetEvent extends PackageEvent {
  PackageResetEvent({
    required this.status,
  });
  /* -------------------------------------------------------------------------- */
  /*                                  Variables                                 */
  /* -------------------------------------------------------------------------- */

  final PackageStatus status;

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
