import 'package:flutter/material.dart';

enum ApiStatus { initial, loading, success, error }

enum Category {
  salary(Icons.money, 'Salary'),
  houseProperty(Icons.house, 'House Property'),
  rentalIncome(Icons.shop, 'Rental Income'),
  abroadIncome(Icons.flight, 'Abroad Income'),
  businessIncome(Icons.business, 'Business Income'),
  otherIncome(Icons.devices_other, 'Other Income');

  final IconData icon;
  final String name;

  const Category(this.icon, this.name);
}
