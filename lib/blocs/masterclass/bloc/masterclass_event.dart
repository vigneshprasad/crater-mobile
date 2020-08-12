part of 'masterclass_bloc.dart';

abstract class MasterclassEvent extends Equatable {
  const MasterclassEvent();
}

class MasterclassGetStarted extends MasterclassEvent {
  @override
  List<Object> get props => [];
}
