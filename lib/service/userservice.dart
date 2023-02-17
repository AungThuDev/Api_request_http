import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jsonpagination/const.dart';
import 'package:jsonpagination/model/user.dart';



class UserService
{
  static var shared=UserService();
  //https://5b5cb0546a725000148a67ab.mockapi.io/api/v1/users?page=4&lilmit=20


  Future<List<User>> fetchUser({int page=1,int limit=TOTALPAGEITEM}) async
  {
    List<User> users=[];
    try
    {
    //final String url=APIBASEURL +"users?page="+page.toString()+"&limit="+limit.toString();
    var _path="/api/v1/users";
    Map<String,String> _param={
      "page":page.toString(),
      "limit":limit.toString()
    };
    var uri=Uri.https(APIBASEURL, _path,_param);
    var response=await get(uri,headers: {
      HttpHeaders.acceptHeader:"application/json",
      HttpHeaders.contentTypeHeader:"application/json",
      HttpHeaders.authorizationHeader:"Bear 123456"
    });

    if(response.statusCode==200)
    {
      List<dynamic> arrayJson=jsonDecode(response.body);
      for (var json in arrayJson)
      {
        var user=User.fromJSON(json);
        users.add(user);
      }
      return users;
    }
    else{
      return users;
    }
    return users;
    }catch(e)
    {
      print(e);
      return users;
    }
  }
}