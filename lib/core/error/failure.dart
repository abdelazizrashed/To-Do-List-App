import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{}

class LocalDataFailure implements Failure{
  @override
  List<Object> get props => [];

  @override
  bool get stringify => null;
}