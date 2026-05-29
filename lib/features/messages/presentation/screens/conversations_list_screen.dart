import 'dart:async'; // ✅ [تعديل] استيراد dart:async عشان نستخدم Timer للـ polling
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:arak_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:arak_app/core/entities/user.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../domain/entities/conversation.dart';
import '../../data/models/user_model.dart';
import '../../providers/conversation_providers.dart';

class ConversationsListScreen extends ConsumerStatefulWidget {
  final String currentUserId;

  const ConversationsListScreen({
    super.key,
    required this.currentUserId,
  });

  @override
  ConsumerState<ConversationsListScreen> createState() =>
      _ConversationsListScreenState();
}

class _ConversationsListScreenState
    extends ConsumerState<ConversationsListScreen> {
  final TextEditingController _searchController = TextEditingController();

  final FocusNode _searchFocusNode = FocusNode();
  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();

    // ✅ [تعديل] بدء الـ Polling — بيعمل invalidate للـ conversationsListProvider كل 10 ثواني
    // ده بيخلي قائمة المحادثات تتحدث تلقائياً لما تيجي رسائل جديدة من الطرف التاني
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted) {
        ref.invalidate(conversationsListProvider);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();

    _pollingTimer?.cancel();

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

    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        _searchFocusNode.requestFocus();
      },
    );
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
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: isSearching
          ? AppBar(
              backgroundColor: isDark ? Colors.black : Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.transparent,
              toolbarHeight: 60.h,
              leading: IconButton(
                icon: Icon(
                  Icons.close,
                  color: isDark ? Colors.white : Colors.black,
                ),
                onPressed: _clearSearch,
              ),
              title: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                autofocus: true,
                textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                textAlign: isRtl ? TextAlign.right : TextAlign.left,
                decoration: InputDecoration(
                  hintText: loc.searchByEmail,
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                  border: InputBorder.none,
                  filled: true,
                  fillColor:
                      isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  prefixIcon: isRtl
                      ? null
                      : Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.grey.shade500,
                        ),
                  suffixIcon: isRtl
                      ? Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.grey.shade500,
                        )
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
                  icon: Icon(
                    Icons.search,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  onPressed: _startSearch,
                  tooltip: loc.search,
                ),
              ],
            ),
      body: isSearching
          ? _buildSearchResults(
              searchResultsAsync,
              searchQuery,
              theme,
              isDark,
              loc,
              isRtl,
            )
          : _buildConversationsList(
              conversationsAsync,
              theme,
              isDark,
              loc,
              isRtl,
            ),
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
            SizedBox(height: 16.h),
            Text(
              loc.loading,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 16.h),
            Text(
              loc.failedToLoadConversations,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            TextButton(
              onPressed: () {
                ref.invalidate(conversationsListProvider);
              },
              child: Text(loc.tryAgain),
            ),
          ],
        ),
      ),
      data: (conversations) {
        final filteredConversations = conversations
            .where(
              (conv) => conv.otherPartyId != widget.currentUserId,
            )
            .toList();

        if (filteredConversations.isEmpty) {
          return _buildEmptyState(
            loc,
            isRtl,
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(conversationsListProvider);

            await Future.delayed(
              const Duration(milliseconds: 500),
            );
          },
          child: ListView.builder(
            itemCount: filteredConversations.length,
            itemBuilder: (context, index) {
              final conversation = filteredConversations[index];

              return _buildConversationTile(
                conversation,
                theme,
                isDark,
                loc,
                isRtl,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(
    AsyncValue<List<dynamic>> searchResultsAsync,
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
            Icon(
              Icons.search,
              size: 64,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 16.h),
            Text(
              loc.enterEmailToSearch,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return searchResultsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Text(error.toString()),
      ),
      data: (results) {
        // ✅ حذف المستخدم الحالي
        final filteredResults = results.where((item) {
          if (item is UserModel) {
            return item.id != widget.currentUserId;
          }

          if (item is Conversation) {
            return item.otherPartyId != widget.currentUserId;
          }

          return true;
        }).toList();

        if (filteredResults.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_off,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                SizedBox(height: 16.h),
                Text(
                  loc.userNotFound,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: filteredResults.length,
          itemBuilder: (context, index) {
            final item = filteredResults[index];

            if (item is Conversation) {
              return _buildConversationTile(
                item,
                theme,
                isDark,
                loc,
                isRtl,
              );
            } else if (item is UserModel) {
              return _buildUserTile(
                item,
                theme,
                isDark,
                loc,
                isRtl,
              );
            }

            return const SizedBox.shrink();
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
    final userRole = ref.watch(authProvider).user?.role;

    final otherRole = userRole == UserRole.teacher ? 'parent' : 'teacher';

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
          fontWeight: conversation.unreadCount > 0
              ? FontWeight.bold
              : FontWeight.normal,
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
            _formatTime(
              conversation.lastMessageTime,
              loc,
            ),
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade500,
            ),
          ),
          if (conversation.unreadCount > 0) ...[
            SizedBox(height: 4.h),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
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
        await context.push(
          '/chat',
          extra: {
            "currentUserId": widget.currentUserId,
            "otherUserId": conversation.otherPartyId,
            "name": conversation.otherPartyName,
            "role": otherRole,
            "avatarUrl": "",
          },
        );

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
        backgroundColor: theme.colorScheme.secondary.withOpacity(0.1),
        child: Text(
          user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
          style: TextStyle(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        user.name,
        textAlign: isRtl ? TextAlign.right : TextAlign.left,
      ),
      subtitle: Text(
        user.email,
        textAlign: isRtl ? TextAlign.right : TextAlign.left,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.grey.shade400,
      ),
      onTap: () async {
        await context.push(
          '/chat',
          extra: {
            "currentUserId": widget.currentUserId,
            "otherUserId": user.id,
            "name": user.name,
            "role": user.role ?? "parent",
            "avatarUrl": "",
          },
        );
      },
    );
  }

  Widget _buildEmptyState(
    AppLocalizations loc,
    bool isRtl,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16.h),
          Text(
            loc.noConversationsYet,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            loc.tapSearchToFindUser,
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatTime(
    DateTime time,
    AppLocalizations loc,
  ) {
    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final date = DateTime(
      time.year,
      time.month,
      time.day,
    );

    if (date == today) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (date ==
        today.subtract(
          const Duration(days: 1),
        )) {
      return loc.yesterday;
    } else {
      return '${time.day}/${time.month}';
    }
  }
}
