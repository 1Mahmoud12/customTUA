
import 'package:flutter/material.dart';

abstract class ZakatCalculatorState {}

class ZakatCalculatorInitial extends ZakatCalculatorState {}

class ZakatCalculatorFieldsUpdated extends ZakatCalculatorState {
  final List<TextEditingController> controllers;
  final List<String> currencies;

  ZakatCalculatorFieldsUpdated({
    required this.controllers,
    required this.currencies,
  });
}

class ZakatCalculatorBelowNisab extends ZakatCalculatorState {
  final double totalAmount;
  final double nisab;

  ZakatCalculatorBelowNisab({
    required this.totalAmount,
    required this.nisab,
  });
}

class ZakatCalculatorSuccess extends ZakatCalculatorState {
  final double totalAmount;
  final double zakatAmount;

  ZakatCalculatorSuccess({
    required this.totalAmount,
    required this.zakatAmount,
  });
}