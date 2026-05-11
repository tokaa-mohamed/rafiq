import 'package:flutter/material.dart';

class VideoCategoryEntity {
  final String title;
  final String description;
  final IconData icon; 
  final Color color;

  VideoCategoryEntity({
    required this.title, 
    required this.description, 
    required this.icon,
    required this.color,
  });
}