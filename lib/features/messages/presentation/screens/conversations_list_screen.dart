/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../domain/entities/conversation.dart';
import '../../providers/conversation_providers.dart';
import '../../data/models/user_model.dart';

class ConversationsListScreen extends ConsumerStatefulWidget {
  final String currentUserId;

  const ConversationsListScreen({
    super.key,
    required this.currentUserId,
  });

  @override
  ConsumerState<ConversationsListScreen> createState() => _ConversationsListScreenState();
}

class _ConversationsListScreenState extends ConsumerState<ConversationsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    ref.read(searchQueryProvider.notifier).state = '';
    ref.read(isSearchingProvider.notifier).state = false;
    FocusScope.of(context).unfocus();
  }

  void _onSearchChanged(String value) {
    ref.read(searchQueryProvider.notifier).state = value.trim();
  }

  void _startSearch() {
    ref.read(isSearchingProvider.notifier).state = true;
    Future.delayed(const Duration(milliseconds: 100), () {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider);
    final conversationsAsync = ref.watch(conversationsListProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final searchResultsAsync = ref.watch(searchResultsProvider(searchQuery));
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          autofocus: true,
          textDirection: TextDirection.ltr, // للإيميلات
          decoration: InputDecoration(
            hintText: 'Enter exact email...',
            hintStyle: TextStyle(color: Colors.grey.shade500),
            border: InputBorder.none,
            filled: true,
            fillColor: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 16,
          ),
          onChanged: _onSearchChanged,
        )
            : Text(
          loc.messages,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        leading: isSearching
            ? IconButton(
          icon: Icon(Icons.close, color: isDark ? Colors.white : Colors.black),
          onPressed: _clearSearch,
        )
            : const BackButton(),
        actions: [
          if (!isSearching)
            IconButton(
              icon: Icon(Icons.search, color: isDark ? Colors.white : Colors.black),
              onPressed: _startSearch,
            ),
        ],
      ),
      body: isSearching
          ? _buildSearchResults(searchResultsAsync, searchQuery, theme, isDark, loc)
          : _buildConversationsList(conversationsAsync, theme, isDark, loc),
    );
  }

  Widget _buildConversationsList(
      AsyncValue<List<Conversation>> conversationsAsync,
      ThemeData theme,
      bool isDark,
      AppLocalizations loc,
      ) {
    return conversationsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              loc.failedToLoadConversations,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => ref.invalidate(conversationsListProvider),
              child: Text(loc.tryAgain),
            ),
          ],
        ),
      ),
      data: (conversations) {
        final filteredConversations = conversations.where((conv) {
          return conv.otherPartyId != widget.currentUserId;
        }).toList();

        if (filteredConversations.isEmpty) {
          return _buildEmptyState(loc);
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(conversationsListProvider);
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: ListView.builder(
            itemCount: filteredConversations.length,
            itemBuilder: (context, index) {
              final conversation = filteredConversations[index];
              return _buildConversationTile(conversation, theme, isDark, loc);
            },
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(
      AsyncValue<List<UserModel>> searchResultsAsync,
      String searchQuery,
      ThemeData theme,
      bool isDark,
      AppLocalizations loc,
      ) {
    if (searchQuery.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Enter email to search',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return searchResultsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        String errorMsg = error.toString();
        if (errorMsg.contains('403')) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 48, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'Access Denied',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          );
        }
        return Center(
          child: Text('Error: $error'),
        );
      },
      data: (users) {
        final filteredUsers = users.where((user) => user.id != widget.currentUserId).toList();

        if (filteredUsers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_off, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'User not found',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            final user = filteredUsers[index];
            return _buildUserTile(user, theme, isDark);
          },
        );
      },
    );
  }

  Widget _buildConversationTile(
      Conversation conversation,
      ThemeData theme,
      bool isDark,
      AppLocalizations loc,
      ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
        child: Text(
          conversation.otherPartyName.isNotEmpty
              ? conversation.otherPartyName[0].toUpperCase()
              : '?',
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        conversation.otherPartyName,
        style: TextStyle(
          fontWeight: conversation.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        conversation.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatTime(conversation.lastMessageTime),
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
            ),
          ),
          if (conversation.unreadCount > 0) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${conversation.unreadCount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      onTap: () async {
        await context.push('/chat', extra: {
          "currentUserId": widget.currentUserId,
          "otherUserId": conversation.otherPartyId,
          "name": conversation.otherPartyName,
          "role": "parent",
          "avatarUrl": "",
        });
        ref.invalidate(conversationsListProvider);
      },
    );
  }

  Widget _buildUserTile(UserModel user, ThemeData theme, bool isDark) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
        child: Text(
          user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        user.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.email,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          if (user.role != null)
            Container(
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                user.role!,
                style: TextStyle(
                  fontSize: 10,
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
      trailing: Icon(
        Icons.chat_bubble_outline,
        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
        size: 20,
      ),
      onTap: () async {
        _clearSearch();

        await context.push('/chat', extra: {
          "currentUserId": widget.currentUserId,
          "otherUserId": user.id,
          "name": user.name,
          "role": user.role ?? 'User',
          "avatarUrl": "",
        });

        ref.invalidate(conversationsListProvider);
      },
    );
  }

  Widget _buildEmptyState(AppLocalizations loc) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            loc.noConversationsYet,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap search to find a user',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(time.year, time.month, time.day);

    if (date == today) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (date == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return '${time.day}/${time.month}';
    }
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../domain/entities/conversation.dart';
import '../../providers/conversation_providers.dart';
import '../../data/models/user_model.dart';

class ConversationsListScreen extends ConsumerStatefulWidget {
  final String currentUserId;

  const ConversationsListScreen({
    super.key,
    required this.currentUserId,
  });

  @override
  ConsumerState<ConversationsListScreen> createState() => _ConversationsListScreenState();
}

class _ConversationsListScreenState extends ConsumerState<ConversationsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    ref.read(searchQueryProvider.notifier).state = '';
    ref.read(isSearchingProvider.notifier).state = false;
    FocusScope.of(context).unfocus();
  }

  void _onSearchChanged(String value) {
    ref.read(searchQueryProvider.notifier).state = value.trim();
  }

  void _startSearch() {
    ref.read(isSearchingProvider.notifier).state = true;
    Future.delayed(const Duration(milliseconds: 100), () {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider);
    final conversationsAsync = ref.watch(conversationsListProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final searchResultsAsync = ref.watch(searchResultsProvider(searchQuery));
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      appBar: isSearching
          ? AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 60.h,
        leading: IconButton(
          icon: Icon(Icons.close, color: isDark ? Colors.white : Colors.black),
          onPressed: _clearSearch,
        ),
        title: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          autofocus: true,
          // ✅ Auto Direction (يدعم العربي والإنجليزي)
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          textAlign: isRtl ? TextAlign.right : TextAlign.left,
          decoration: InputDecoration(
            hintText: loc.searchByEmail,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            border: InputBorder.none,
            filled: true,
            fillColor: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            prefixIcon: isRtl
                ? null
                : Icon(Icons.search, size: 20, color: Colors.grey.shade500),
            suffixIcon: isRtl
                ? Icon(Icons.search, size: 20, color: Colors.grey.shade500)
                : null,
          ),
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 16,
          ),
          onChanged: _onSearchChanged,
        ),
      )
          : AppMainAppBar(
        title: loc.messages,
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: isDark ? Colors.white : Colors.black),
            onPressed: _startSearch,
            tooltip: loc.search,
          ),
        ],
      ),
      body: isSearching
          ? _buildSearchResults(searchResultsAsync, searchQuery, theme, isDark, loc, isRtl)
          : _buildConversationsList(conversationsAsync, theme, isDark, loc, isRtl),
    );
  }

  Widget _buildConversationsList(
      AsyncValue<List<Conversation>> conversationsAsync,
      ThemeData theme,
      bool isDark,
      AppLocalizations loc,
      bool isRtl,
      ) {
    return conversationsAsync.when(
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              loc.loading,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              loc.failedToLoadConversations,
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => ref.invalidate(conversationsListProvider),
              child: Text(loc.tryAgain),
            ),
          ],
        ),
      ),
      data: (conversations) {
        final filteredConversations = conversations.where((conv) {
          return conv.otherPartyId != widget.currentUserId;
        }).toList();

        if (filteredConversations.isEmpty) {
          return _buildEmptyState(loc, isRtl);
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(conversationsListProvider);
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: ListView.builder(
            itemCount: filteredConversations.length,
            itemBuilder: (context, index) {
              final conversation = filteredConversations[index];
              return _buildConversationTile(conversation, theme, isDark, loc, isRtl);
            },
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(
      AsyncValue<List<UserModel>> searchResultsAsync,
      String searchQuery,
      ThemeData theme,
      bool isDark,
      AppLocalizations loc,
      bool isRtl,
      ) {
    if (searchQuery.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              loc.enterEmailToSearch,
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (searchQuery.length < 2) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              loc.typeAtLeast2Characters,
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return searchResultsAsync.when(
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              loc.loading,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
      error: (error, stack) {
        String errorMsg = error.toString();

        // ✅ تحقق من 403 أولاً
        if (errorMsg.contains('403')) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 48, color: Colors.red.shade300),
                const SizedBox(height: 16),
                Text(
                  loc.accessDenied, // تأكدي إن دي موجودة في الملف
                  style: TextStyle(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Please check server permissions',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        // ✅ عرض الخطأ بسلام (بدون substring عشان منع الـ RangeError)
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'Error Occurred',
                style: TextStyle(color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Flexible( // استخدام Flexible عشان لو النص طويل مش يخرج برا الشاشة
                child: Text(
                  errorMsg, // نعرض الـ Error كاملاً
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
      data: (users) {
        final filteredUsers = users.where((user) => user.id != widget.currentUserId).toList();

        if (filteredUsers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_off, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  loc.userNotFound,
                  style: TextStyle(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  loc.tryDifferentEmail,
                  style: TextStyle(color: Colors.grey.shade500),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            final user = filteredUsers[index];
            return _buildUserTile(user, theme, isDark, loc, isRtl);
          },
        );
      },
    );
  }

  Widget _buildConversationTile(
      Conversation conversation,
      ThemeData theme,
      bool isDark,
      AppLocalizations loc,
      bool isRtl,
      ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
        child: Text(
          conversation.otherPartyName.isNotEmpty
              ? conversation.otherPartyName[0].toUpperCase()
              : '?',
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        conversation.otherPartyName,
        style: TextStyle(
          fontWeight: conversation.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
        ),
        textAlign: isRtl ? TextAlign.right : TextAlign.left,
      ),
      subtitle: Text(
        conversation.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: isRtl ? TextAlign.right : TextAlign.left,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatTime(conversation.lastMessageTime, loc),
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
            ),
          ),
          if (conversation.unreadCount > 0) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${conversation.unreadCount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      onTap: () async {
        await context.push('/chat', extra: {
          "currentUserId": widget.currentUserId,
          "otherUserId": conversation.otherPartyId,
          "name": conversation.otherPartyName,
          "role": "parent",
          "avatarUrl": "",
        });
        ref.invalidate(conversationsListProvider);
      },
    );
  }

  Widget _buildUserTile(
      UserModel user,
      ThemeData theme,
      bool isDark,
      AppLocalizations loc,
      bool isRtl,
      ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
        child: Text(
          user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        user.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
        textAlign: isRtl ? TextAlign.right : TextAlign.left,
      ),
      subtitle: Column(
        crossAxisAlignment: isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            user.email,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
            textAlign: isRtl ? TextAlign.right : TextAlign.left,
          ),
          if (user.role != null)
            Container(
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _translateRole(user.role!, loc),
                style: TextStyle(
                  fontSize: 10,
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
      trailing: Icon(
        Icons.chat_bubble_outline,
        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
        size: 20,
      ),
      onTap: () async {
        _clearSearch();

        await context.push('/chat', extra: {
          "currentUserId": widget.currentUserId,
          "otherUserId": user.id,
          "name": user.name,
          "role": user.role ?? 'User',
          "avatarUrl": "",
        });

        ref.invalidate(conversationsListProvider);
      },
    );
  }

  Widget _buildEmptyState(AppLocalizations loc, bool isRtl) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            loc.noConversationsYet,
            style: TextStyle(color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            loc.tapSearchToFindUser,
            style: TextStyle(color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _translateRole(String role, AppLocalizations loc) {
    switch (role.toLowerCase()) {
      case 'teacher':
        return loc.teacher;
      case 'parent':
        return loc.parent;
      case 'admin':
        return loc.admin;
      case 'super admin':
      case 'superadmin':
        return loc.superAdmin;
      default:
        return role;
    }
  }

  String _formatTime(DateTime time, AppLocalizations loc) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(time.year, time.month, time.day);

    if (date == today) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (date == today.subtract(const Duration(days: 1))) {
      return loc.yesterday;
    } else {
      return '${time.day}/${time.month}';
    }
  }
}