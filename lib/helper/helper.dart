import 'package:shared_preferences/shared_preferences.dart';

class Helper {

static String _accessTokenKey = 'access_token' ;
static String _refreshTokenKey = 'refresh_token';
static String get getUsername => "otaqu";
static String get getPassword =>"qwerty";

static Future<String?> get accessToken async{
  final pref = await SharedPreferences.getInstance();
  var token =    pref.getString(_accessTokenKey);
  print(token);
  return token;
}
static Future<String?> get refreshToken async{
final pref = await SharedPreferences.getInstance();
return pref.getString(_refreshTokenKey);
}

static Future<void> saveTokens(String access, String refresh) async{
  final pref = await SharedPreferences.getInstance();
  print("token $access $refresh");
  pref.setString(_accessTokenKey, access);
  pref.setString(_refreshTokenKey, refresh);

}

static Future<void> clearToken() async{
    final pref = await SharedPreferences.getInstance();
    pref.clear();
}


}