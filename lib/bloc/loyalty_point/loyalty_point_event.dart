import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoyaltyPointEvent extends Equatable {
  const LoyaltyPointEvent();
}

class PostLoyaltyPoint extends LoyaltyPointEvent {
  const PostLoyaltyPoint(this.discount);
  final int discount;

  @override
  List<Object?> get props => [];
}
