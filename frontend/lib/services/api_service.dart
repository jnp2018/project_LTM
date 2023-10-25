import 'dart:convert';

import 'package:http/http.dart' as http;

//TODO place holder api service, change if needed
class ApiService {

  Map<String,String> defautlHeader = {
     "content-type": "application/json",
  };
  //read https://pub.dev/packages/http for more info


  Future<http.Response> get(String path, Map<String,String>? header) async {
    defautlHeader.addAll(header ?? {});
    return await http.get(
      Uri.parse(path),
      headers: defautlHeader,
    );
  }

  Future<http.Response> put(String path, Map<String,dynamic> data, Map<String,String>? header ) async {
    defautlHeader.addAll(header ?? {});
    return await http.put(
       Uri.parse(path),
      headers: defautlHeader,
      body: jsonEncode(data)
    );
  }
  Future<http.Response> post(String path, Map<String,dynamic> data ,Map<String,String>? header) async {
    defautlHeader.addAll(header ?? {});
    return await http.post(
      Uri.parse(path),
      headers: defautlHeader,
      body: jsonEncode(data),
    );
  }
  Future<http.Response> delete(String path,Map<String,dynamic> body ,Map<String,String>? header) async {
    print(jsonEncode(body));
    defautlHeader.addAll(header ?? {});
    return await http.delete(
      Uri.parse(path),
      headers: defautlHeader,
      body: jsonEncode(body)
    );
  }

  Future<http.Response> patch(String path,Map<String,dynamic> body ,Map<String,String>? header) async {
    defautlHeader.addAll(header ?? {});
    return await http.patch(
      Uri.parse(path),
      headers: defautlHeader,
      body: jsonEncode(body)
    );
  }

}