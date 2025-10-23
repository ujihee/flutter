/*
  날짜 : 2025/10/23
  이름 : 우지희
  내용 : Dart 제어문
 */
void main(){

  /////////////////////////////////////
  //조건문
  /////////////////////////////////////

  int number = 10;

  //if
  if (number > 5) {
    print("number는 5보다 큽니다.");
  }

  //if - else
  if (number % 2 == 0) {
    print("$number 는 짝수입니다.");
  } else {
    print("$number 는 홀수입니다.");
  }

  //if - else if - else
  int score = 85;
  if (score >= 90) {
    print("A 학점");
  }else if (score >= 80){
    print("B 학점");
  }else if (score >= 70){
    print("C 학점");
  }else {
    print("F 학점");
  }

  //switch
  switch (score ~/ 10) {
    case 10:
    case 9:
      print("A 입니다.");
      break;
    case 8:
      print("B 입니다.");
      break;
    case 7:
      print("C 입니다.");
      break;
    case 6:
      print("D 입니다.");
      break;
    default:
      print("F 입니다.");
  }
  /////////////////////////////////////
  //반복문
  /////////////////////////////////////
  // for문
  for (int i = 1; i <= 5; i++){
    print("for문 반복: $i");
  }

  //while문
  int j = 1;
  while (j <= 5) {
    print("while문 반복: $j");
    j++;
  }

  //do-while문
  int k = 1;
  do {
    print("do-while문 반복: $k");
    k++;
  }while (k <= 5);

  //break
  int num = 1;
  while (true) {
    if (num % 5 == 0 && num % 7 == 0) {
      print("i가 5라 반복문 종료");
      break; // 반복문 종료
    }
    num++;
  }
  print('num : ${num}');

  //continue
  for(int i = 1; i <=10; i++) {
    if (i % 2 == 0) {
      continue; // 짝수일 때 출력 생략
    }
    print("i = $i"); //홀수만 출력
  }

  //별삼각형
  for(int a=1; a<=10; a++){

    String line = '';

    for(int b=1; b<=a; b++){
      line += '⭐';
    }
    print(line);
  }


}