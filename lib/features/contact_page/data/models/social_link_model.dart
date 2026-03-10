import '../../domain/entities/social_link.dart';
import 'package:flutter/material.dart';

class SocialLinkModel extends SocialLink {
  const SocialLinkModel({required super.platformName, required super.url});

  IconData get iconData {
    switch (platformName.toLowerCase()) {
      case 'facebook':
        return Icons.facebook;
      case 'instagram':
        return Icons.camera_alt;
      case 'wechat':
        return Icons.wechat;
      case 'location':
        return Icons.location_on;
      default:
        return Icons.link;
    }
  }
}
