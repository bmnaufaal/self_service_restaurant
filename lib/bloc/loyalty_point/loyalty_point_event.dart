import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoyaltyPointEvent extends Equatable {
  const LoyaltyPointEvent();
}

class PostLoyaltyPoint extends LoyaltyPointEvent {
  const PostLoyaltyPoint(
    this.discount,
    this.cost,
    this.points,
  );
  final int discount;
  final int cost;
  final int points;

  @override
  List<Object?> get props => [];
}
