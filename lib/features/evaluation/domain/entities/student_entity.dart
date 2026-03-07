import 'package:flutter/material.dart';

class Subject {
  final String name;
  final int score;
  final IconData icon;
  final Color color;

  // ضفنا const هنا
  const Subject({
    required this.name,
    required this.score,
    required this.icon,
    required this.color,
  });

  String get rating {
    if (score >= 85) return 'Excellent';
    if (score >= 75) return 'Very Good';
    if (score >= 60) return 'Good';
    return 'Weak';
  }
}

class Student {
  final String name;
  final String grade;
  final List<Subject> subjects;

  // ضفنا const هنا
  const Student({
    required this.name,
    required this.grade,
    required this.subjects,
  });

  double get overallScore {
    if (subjects.isEmpty) return 0;
    return subjects.fold(0.0, (sum, s) => sum + s.score) / subjects.length;
  }

  String get overallRating {
    double score = overallScore;
    if (score >= 85) return 'Excellent';
    if (score >= 75) return 'Very Good';
    if (score >= 60) return 'Good';
    return 'Weak';
  }
}
