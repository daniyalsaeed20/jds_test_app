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

  final CounterStatus status;
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
