abstract class BaseApiServices{
  Future<dynamic> getApi(String url);

  // Future<dynamic> postApi(String url, Map<String, dynamic> body);
  Future<dynamic> postApi(String url, var data);
}