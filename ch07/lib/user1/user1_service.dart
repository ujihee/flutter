
import 'dart:convert';
import 'dart:developer';

import 'package:ch07/user1/user1.dart';
import 'package:http/http.dart' as http;

class User1Service {
  // API 서비스 클래스
  //static const String baseUrl = 'http://localhost:8080/ch08'; // localhost는 Flutter 에뮬레이터 자신이기 때문에 이거 안됨
  static const String baseUrl = 'http://10.0.2.2:8080/ch08'; // Android 에뮬레이터에서는 로컬 시스템 주소가 10.0.2.2 임

  // GET: 모든 사용자 조회, 서버 요청이 끝날 때까지 기다리지 않고 바로 Future를 반환
  Future<List<User1>> getUsers() async {
    try {
      // 일반 콘솔로 출력
      log('here1');
      final response = await http.get(Uri.parse('$baseUrl/user1'));

      log(response.toString());
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);


        return jsonList.map((json) => User1.fromJson(json)).toList();
      } else {
        throw Exception('사용자 목록을 불러오는데 실패했습니다');
      }
    } catch (e) {
      throw Exception('네트워크 에러: $e');
    }
  }

  // GET: 특정 사용자 조회
  Future<User1> getUser(String userid) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/user1/$userid'));

      if (response.statusCode == 200) {
        return User1.fromJson(json.decode(response.body));
      } else {
        throw Exception('사용자를 찾을 수 없습니다');
      }
    } catch (e) {
      throw Exception('네트워크 에러: $e');
    }
  }

  // POST: 새 사용자 생성
  Future<User1> postUser(User1 user1) async {
    try {

      log(user1.toString());


      final response = await http.post(
        Uri.parse('$baseUrl/user1'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user1.toJson()),
      );

      if (response.statusCode == 201) {
        return User1.fromJson(json.decode(response.body));
      } else {
        throw Exception('사용자 생성에 실패했습니다');
      }
    } catch (e) {
      throw Exception('네트워크 에러: $e');
    }
  }

  // PUT: 사용자 정보 수정
  Future<User1> updateUser(User1 user1) async {
    try {
      final response = await http.put(Uri.parse('$baseUrl/user1'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user1.toJson()),
      );
      log('updateUser...1 : ${response.statusCode}');
      if (response.statusCode == 200) {
        log('updateUser...2');
        return User1.fromJson(json.decode(response.body));
      } else {
        log('updateUser...3');
        throw Exception('사용자 수정에 실패했습니다');
      }
    } catch (e) {
      log('updateUser...4');
      throw Exception('네트워크 에러: $e');
    }
  }

  // DELETE: 사용자 삭제, 서버 요청이 끝날 때까지 기다리지 않고 바로 Future를 반환
  Future<void> deleteUser(String userid) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/user1/$userid'));

      if (response.statusCode != 200) {
        throw Exception('사용자 삭제에 실패했습니다');
      }
    } catch (e) {
      throw Exception('네트워크 에러: $e');
    }
  }

}