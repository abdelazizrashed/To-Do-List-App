import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class TodoTag extends Equatable {
  final String tagName;
  //Todo: see if you can change this to a color instead of int or it is best to stay this way
  final int tagColor;

  TodoTag({
    @required this.tagName,
    @required this.tagColor,
  });

  @override
  List<Object> get props => [tagName, tagColor];
}
