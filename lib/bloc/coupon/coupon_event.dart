import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CouponEvent extends Equatable {
  const CouponEvent();
}

class PostCoupon extends CouponEvent {
  const PostCoupon(this.coupon);

  final String coupon;
  @override
  List<Object?> get props => [];
}
