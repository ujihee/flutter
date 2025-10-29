import 'dart:developer';

import 'package:ch07/user1/user1.dart';
import 'package:ch07/user1/user1_service.dart';
import 'package:flutter/material.dart';

// User1 목록
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class User1Modify extends StatefulWidget {

  final String userid; // 전달받은 사용자 아이디

  const User1Modify({super.key, required this.userid});

  @override
  State<User1Modify> createState() => _User1ModifyState();
}

class _User1ModifyState extends State<User1Modify> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _useridController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final User1Service service = User1Service(); // 인스턴스 생성


  @override
  void initState() {
    super.initState();

    log("here...1");
    // 수정 데이터 조회하기
    _loadUser();
  }

  Future<void> _loadUser() async {
    log("here...2");
    try {
      // ⭐⭐⭐ Spring에서 ResponseEntity.status(HttpStatus.FOUND)로 되어 있어서 데이터를 못 가져옴 FOUND -> OK로 해야됨
      User1 user = await service.getUser(widget.userid);
      log("here...3 : $user");

      setState(() {
        _useridController.text = user.userid;
        _nameController.text = user.name;
        _birthController.text = user.birth;
        _ageController.text = user.age.toString();
      });
    } catch (e) {
      _showDialog('조회 실패', '사용자 정보를 불러오는 중 오류가 발생했습니다.\n$e');
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final User1 modifyUser = User1(
      userid: _useridController.text,
      name: _nameController.text,
      birth: _birthController.text,
      age: int.tryParse(_ageController.text) ?? 0,
    );

    try {
      // ⭐⭐⭐ Spring에서 ResponseEntity.status(HttpStatus.ACCEPTED)로 되어 있어서 데이터를 못 가져옴 ACCEPTED -> OK로 해야됨
      User1 modifiedUser = await service.updateUser(modifyUser);

      // 성공
      await _showDialog('수정 성공', '사용자가 성공적으로 수정 되었습니다!\nUserID: ${modifiedUser.userid}');

      // async 이후 context 안전하게 사용하기 위한 처리, _User1RegisterState 객체가 위젯 트리에 없으면 함수 종료
      if (!mounted) return;

      // 성공 후 목록 이동
      Navigator.pop(context, modifiedUser);

    } catch (e) {
      // 실패
      _showDialog('수정 실패', '사용자 수정 중 오류가 발생했습니다.\n$e');
    }
  }

  Future<void> _showDialog(String title, String message) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectBirth() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
      locale: const Locale('ko', 'KR'),
    );
    if (picked != null) {
      setState(() {
        _birthController.text = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User1 수정')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _useridController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'User ID'),
                validator: (value) =>
                value!.isEmpty ? 'User ID를 입력하세요' : null,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: '이름'),
                validator: (value) => value!.isEmpty ? '이름을 입력하세요' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _birthController,
                readOnly: true,
                decoration: const InputDecoration(labelText: '생년월일 (날짜 선택)'),
                onTap: () => _selectBirth(),
                validator: (value) => value!.isEmpty ? '생년월일을 입력하세요' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number, // 숫자 키보드 표시
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
                ],
                decoration: InputDecoration(
                  labelText: '나이 (숫자만 입력)',
                ),
                validator: (value) => value!.isEmpty ? '나이를 입력하세요' : null,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text('취소하기'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('수정하기'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}