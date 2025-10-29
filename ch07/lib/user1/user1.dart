
class User1 {

  String userid;
  String name;
  String birth;
  int age;

  User1({required this.userid, required this.name, required this.birth, required this.age});

  factory User1.fromJson(Map<String, dynamic> jsonData){
    return User1(
        userid: jsonData['userid'],
        name: jsonData['name'],
      /*
      birth: jsonData['birth'],
      내 db에 birth가 null인게 있어서 계속 오류났음
       */
      birth: jsonData['birth'] ?? '', // ← null-safe 처리
      age: jsonData['age'],
    );
  }
  Map<String, dynamic> toJson(){
    return {
      "userid": userid,
      "name": name,
      "birth": birth,
      "age": age,
    };
  }

  @override
  String toString() {
    return 'User1{userid: $userid, name: $name, birth: $birth, age: $age}';
  }


}