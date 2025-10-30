import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/screen/member/login_screen.dart';

  class MyTab extends StatefulWidget {
  const MyTab({super.key});

  @override
  State<StatefulWidget> createState() => _MyTabState();
}

  class _MyTabState extends State<MyTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('마이페이지'),),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('로그인이 필요합니다.'),
          const SizedBox(height: 20,),
          ElevatedButton(
              onPressed: (){
                //로그인 화면으로 이동
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LoginScreen())
                );
              },
              child: const Text('로그인 하러 가기'),
            ),
          ],
        ),
      ),
    );
  }
}