import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/screen/member/login_screen.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<StatefulWidget> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('장바구니'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('장바구니는 로그인 후 이용 가능합니다.'),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){
              // 로그인 화면으로 이동
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