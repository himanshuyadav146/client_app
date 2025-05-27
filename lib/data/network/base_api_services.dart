abstract class BaseApiServices {
  Future<dynamic> getApi(String url);
  // Future<dynamic> postApi(String url, var data);
  Future postApi(String url,dynamic data, { Map<String, dynamic>? queryParameters});
}
