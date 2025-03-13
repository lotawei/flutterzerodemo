import 'package:http/http.dart' as http;

class TimeoutClient extends http.BaseClient {
  final http.Client _inner;
  final Duration timeout;

  TimeoutClient(this._inner, this.timeout);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    return await _inner.send(request).timeout(timeout);
  }
}