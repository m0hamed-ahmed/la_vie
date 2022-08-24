class ApiConstance {
  static const String baseUrl = 'https://lavie.orangedigitalcenteregypt.com';

  static const String loginPath = '$baseUrl/api/v1/auth/signin';
  static const String registerPath = '$baseUrl/api/v1/auth/signup';
  static const String updateUserPath = '$baseUrl/api/v1/user/me';
  static const String getPlantsPath = '$baseUrl/api/v1/plants';
  static const String getToolsPath = '$baseUrl/api/v1/tools';
  static const String getSeedsPath = '$baseUrl/api/v1/seeds';
  static const String getDiscussionForumsPath = '$baseUrl/api/v1/forums';
  static const String createPostPath = '$baseUrl/api/v1/forums';
  static const String getBlogsPath = '$baseUrl/api/v1/products/blogs';
}