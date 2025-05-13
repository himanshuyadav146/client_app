import 'package:flutter/material.dart';

enum ApiStatus { initial, loading, success, error }

enum Category {
  all(Icons.money, 'Salary'),
  hospitals(Icons.house, 'House Property'),
  clinics(Icons.shop, 'Rental Income'),
  pharmacies(Icons.flight, 'Abroad Income'),
  diagnosticCenters(Icons.business, 'Business Income'),
  labs(Icons.devices_other, 'Other Income');

  final IconData icon;
  final String name;

  const Category(this.icon, this.name);
}
