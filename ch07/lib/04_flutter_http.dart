/*
  날짜 : 2025/10/29
  이름 : 우지희
  내용 : Flutter HTTP 통신 실습
 */

import 'dart:convert';

import 'package:flutter/material.dart';

// 직접 입력
import 'package:http/http.dart' as http;

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('04.Flutter HTTP 통신 실습'),
        ),
        body: HttpScreen(),
      ),
    );
  }
}

class HttpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HttpScreenState();
}

class _HttpScreenState extends State<HttpScreen> {

  String result = '대기 중...';
  
  Future<void> fetchGet(){

    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');

    // http 의존성 추가 : pub.dev에 http 검색 > http: ^1.5.0 추가
    return http.get(url, headers: {'Content-Type': 'application/json'}).then((response){

      if(response.statusCode == 200){
        //Map<String, dynamic> 이렇게 쓰는게 좋지만 데이터 타입 모르면 var
        var jsonResult = jsonDecode(response.body);

        setState(() {
          result = ' Get 요청 결과 : $jsonResult';
        });
      }else {
        setState(() {
          result = ' Get 결과 코드 : ${response.statusCode}';
        });
      }
    }).catchError((err){
      setState(() {
        result = '에러발생 : $err';
      });
    }).whenComplete((){
      print('통신 완료..');
    });
  }

  Future<void> fetchPost() async {

    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos');

    try{
      final response  = await http.post(url,
          headers: {'Content-Type' : 'application/json'},
          body: jsonEncode({
            "userid" : 100,
            "title" : "Flutter HTTP Post 테스트",
            "completed": false,
          })
      );

      if(response.statusCode == 201) {
        final returnedData = jsonDecode(response.body);
        setState(() {
          result = 'POST 요청 성공 : $returnedData';
        });
      }else {
        setState(() {
          result = 'POST 결과 코드: ${response.statusCode}';
        });
      }
    }catch(err){
      result = 'Post 요청 에러 : $err';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(result),
        Row(
          children: [
            ElevatedButton(onPressed: fetchGet,
                child: const Text('GET 요청하기')
            ),
            ElevatedButton(onPressed: fetchPost,
                child: const Text('POST 요청하기')
            ),
          ],
        )
      ],
    ),
  );
  }
}