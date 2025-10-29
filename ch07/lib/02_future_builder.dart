/*
  날짜 : 2025/10/29
  이름 : 우지희
  내용 : FlutterBuilder 비동기 처리 실습
 */
import 'package:flutter/material.dart';

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
          title: const Text('02.FlutterBuilder 비동기 처리 실습'),
        ),
        body: FutureScreen(),
      ),
    );
  }
}

class FutureScreen extends StatefulWidget {
  const FutureScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FutureScreenState();
}

class _FutureScreenState extends State<FutureScreen> {

  // Future 결과 상태 변수
  Future<String>? futureResult;

  // 비동기 처리 함수
  Future<String> fetchData(){
    return Future.delayed(const Duration(seconds: 3), (){
      return '서버에서 가져온 데이터 입니다.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          // FutureBuilder : 비동기 작업의 진행 상태에 따라서 자동으로 UI를 갱신해주는 위젯
          FutureBuilder( // futureresult가 3초 뒤에 반환 1.3초동안 대기 2.결과
              future: futureResult, // future 속성은 비동기 작업의 Future 결과 객체
              builder: (context, snapshot) { // snapshot은 현재 상태와 결과를 담고 있는 결과 객체
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                }else if(snapshot.hasError){
                  return Text('에러발생 : ${snapshot.error}');
                }else if(snapshot.hasData){
                  return Text('결과 : ${snapshot.data}');
                }else {
                  return Text('데이터를 불러오세요.');
                }
              }
          ),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {
            setState(() {
              futureResult = fetchData();
            });

          }, child: const Text('불러오기'))
        ],
      ),
    );
  }
}