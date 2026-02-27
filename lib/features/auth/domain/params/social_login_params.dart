class SocialLoginParams {
  final String idToken;
  final String provider; // google | apple

  const SocialLoginParams({
    required this.idToken,
    required this.provider,
  });
}