// ✅ Re-export the single source of truth.
// This file is kept so existing imports (e.g. bottom_nav_bar.dart) don't break,
// but unreadNotificationsProvider is defined only in notifications_provider.dart.
export 'notifications_provider.dart' show unreadNotificationsProvider;
