import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:untitled4/Model/Word.dart';
import 'package:http/http.dart' as http;

import '../Model/User.dart';
import '../Model/Users.dart';
class userservice {
  Future<Users> fetchuserid(int? id) async {
    print("fetch called");
    String url="https://10.0.2.2:7193/api/Users/1GetByUserWithOtherId";
    final uri= Uri.parse(url);
    final response=await http.get(uri);
    if (response.statusCode == 200) {
      // API yanıtı başarılı ise
      final dynamic pasa = json.decode(response.body);
      // Her bir Map'ı Words nesnesine dönüştürün
      final dynamic userla= Users.fromJson(pasa);
      print("completed");
      return userla;
    } else {
      // Hata durumu ile başa çıkma
      throw Exception('Failed to load data from the API');
    }

  }
  Future<void> UpdateUser(Users user) async {
    var request={
    "userId": user.userId?.toInt(),
      "avatarId": user.userId!.toInt(),
      "username": user.username.toString(),
      "password": user.password.toString(),
      "name": user.name.toString(),
      "surname": user.surname.toString(),
      "birthDate": DateFormat('yyyy-MM-dd').format(user.birthDate!),
      "phone": user.phone.toString(),
      "description": user.description.toString(),
      "scoreId":user.userId!.toInt(),
      "status": user.status,
      "wordCounterId": user.userId!.toInt(),
    };
    print("fetch called");
    String url="https://10.0.2.2:7193/api/Users/UpdateUser";
    final uri= Uri.parse(url);
    final response=await http.put(uri, body:jsonEncode(request),headers: {
      'Content-Type': 'application/json', // Content-Type başlığını ekleyin
    },
    );
    if (response.statusCode == 200) {
      // API yanıtı başarılı ise
      print("completed");

    } else {
      // Hata durumu ile başa çıkma
      throw Exception('Failed to load data from the API');
    }

  }
  Future<List<Words>?>? deleteWords(int? id) async{
    print("fetch called");
    String url="https://10.0.2.2:7193/api/word/deleteword?id=$id";
    final uri= Uri.parse(url);
    final response=await http.delete(uri);
    if(response.statusCode==200){
      print("basarili");
      return null;
    }
    else
      throw Exception('Failed to delete data from the API');
  }
  Future<List<Words>?>? updateWords(int? id) async{
    print("fetch called");
    String url="https://10.0.2.2:7193/api/word/updatewordshowcounter?id=$id";
    final uri= Uri.parse(url);
    final response=await http.put(uri);
    if(response.statusCode==200){
      print("basarili");
      return null;
    }
    else
      throw Exception('Failed to update data from the API');
  }

}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
