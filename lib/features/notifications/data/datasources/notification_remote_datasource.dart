abstract class NotificationRemoteDataSource {
  Future<int> getLatestTaskId();
  Future<int> getLatestMessageId();
}