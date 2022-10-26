
//import 'package:flutter/material.dart';

import 'dart:math';

class Calc {
  //Наибольший общий делитель
  int nod(int a, int b) {
    int t;
    if (a < b) {
      t = a;
      a = b;
      b = t;
    }

    while (b!=0) {
      a %= b;
      t = a;
      a = b;
      b = t;
    }
    return a;
  }
  //Наименьшее общее кратное
  int nok(int a, int b){
      //вариант 1
      //return  (((a*b).abs()) / nod(a,b)).round();
      //вариант 2
      return  (a / nod(a,b) * b).round();
  }
  //Разложние числа на простые числа
  printSimple(int a){
    int i, k;
    print('Разложение числа '+a.toString()+' на простые числа');
    for(i = 2; i * i <= a; i++) {
      if (a % i==0) {
        //найден множитель числа a

        //определяем степень множителя i
        for(k = 0; a % i==0; k++) {
          a = (a / i).round();
        }
        print(i.toString()+'^'+k.toString());
      }
    }
    if (a > 1) {
      print(a);
    }
  }
//Разложние числа на простые числа
// версия 2. Возвращает коллекцию чисел
  printSimpleV2(int a, List<int> res){
    int i, k;
    for(i = 2; i * i <= a; i++) {
      if (a % i==0) {
        //найден множитель числа a
        res.add(i);
        //определяем степень множителя i
        for(k = 0; a % i==0; k++) {
          a = (a / i).round();
          res.add(i);
        }
      }
    }
    if (a > 1) {
      res.add(a);
    }
  }
  //-------------------------------------------------------------
  // перевод из 10-й в двоичную
  from10To2(int l10){
    int l2=0;
    int lpos = 1;
    while (l10>=2){
      l2 = l2 + l10 % 2 * lpos;
      lpos *= 10;
      l10 = l10 ~/ 2;
    }
    l2 = l2 + l10 % 2 * lpos;
    return l2;

  }
  // перевод из 2-й в 10-ю
  from2To10(int l2){
    int l10 = 0;
    int lpos = 0;
    while (l2 > 0){
      if (l2 % 10 != 0) {
        l10 = l10 + pow(2, lpos).toInt();
      }
      lpos ++;
      l2 = (l2 /10).toInt();
    }
    return l10;
  }
  // поиск в строке чисел
  findNumInString(String s, List<num> res){
    s = s.trim();
    int pos = s.indexOf(' ');
    num? l = 0;
    String sWord;
    while (pos>0){
      // pos = позиция конца слова, это может быть пробел или конец строки
      sWord = s.substring(0,pos);
      s = s.substring(pos+1);
      //print(sWord);
      l = num.tryParse(sWord);
      if (l != null){
        res.add(l);
      }
      pos = s.indexOf(' ');
      if (pos == -1 && s.length > 0) {
        // это последнее слово
        l = num.tryParse(s);
        if (l != null){
          res.add(l);
        }
      }
    }
  }
  //к заданию 4. Групировка по количеству повторений слова в строке. Возвращаем мар
  groupWord(List<String> str, Map<String, int> res){
    str.forEach((e) {
      //ищем ключ
      if (res.containsKey(e)){
        //ключ уже есть
        res.update(e, (value) => value+1);
      } else {
        //ключа ещё нет
        res.putIfAbsent(e, () => 1);
      };
    });
  }
  // к заданию 5. перечень цифр в строке
  groupDigital(List<String> str, Map<String, int> res){
    //Map <String,int> lDig = new Map <String, int>
    Map lDig = {'zero' : 0, 'one' : 1, 'two' : 2, 'three' : 3, 'four' : 4, 'five' : 5, 'six': 6, 'seven' : 7, 'eight' : 8, 'nine' : 9};
    str.forEach((e){
      //ищем ключ
      if (lDig.containsKey(e)) {
        //нашли, значит слово обозначает цифру
        res.putIfAbsent(e, () => lDig[e]);
      }
    });
  }

}
//к заданию 6
class Point{
  num x=0, y=0, z=0;

  Point(num px, num py, num pz){
    x = px;
    y = py;
    z = pz;
  }

  //расстоняие до точки в параметре
  num DistanceTo(Point another){
    return sqrt((another.x-this.x)*(another.x-this.x)+
                (another.y-this.y)*(another.y-this.y)+
                (another.z-this.z)*(another.z-this.z));
    //print("X: $x Y: $y Z: $z");
  }
  display(){
    print("X: $x Y: $y Z: $z");
  }

  factory Point.zero(){
    return Point(0, 0, 0);
  }
  factory Point.one(){
    return Point(1, 1, 1);
  }
}
//к заданию 7
//вычисление корня n степени из a
extension ExtKorenNfromA on num {
  num _abs(num x){
    return (x<0)? -x : x;
  }
  num KorenN (int n) {
    num a = this;
    if ((n % 2) == 0) {
      if (a < 0) {
        // n чётное число и a<0, поэтому решение не имеет смысла
        throw Exception('n - чётное число и а<0. Решение не имеет смысла');
        //return 0.0;
      }
    }
    if (n == 0) {
        // n не может быть равно нулю
        throw Exception('n = 0');
        //return 0.0;

    }
    num eps = 0.000000000000001;         //допустимая погрешность
    num root = a / n;           //начальное приближение корня
    num rn = a ;                 //значение корня последовательным делением
    //int lCount = 0;             //число итераций
    num rn1 ;
    while(_abs(root-rn)>= eps ){
      rn1 = 1;
      for (int i = 1; i <n; i++){
        rn1 = rn1 * root;
      }
      rn = root;
      root = rn * (1-1/n) + (1/n) * a/ rn1;
      //lCount++;
    }
    return root;
    //print("root = "+root.toString());
    //print("число итераций = "+lCount.toString());
  }
}
//к заданию 8
class User {
  final String email;

  User(this.email);
}

class AdminUser extends User with GetMailSystem {
  AdminUser(String email) : super (email);
}
class GeneralUser extends User{
  GeneralUser(String email) : super (email);
}

mixin GetMailSystem on User {
  String get getMailSystem =>  email.substring(email.indexOf('@')+1);
}

class UserManager <T extends User>{
  List<T> _stack = [];
  // добавление пользователя
  void push(T item) => _stack.add(item);
  //удаление последнего пользователя
  T pop() => _stack.removeLast();

  //печать всех пользователей
  void printList(){
    _stack.forEach((element) {
      if (element.runtimeType == User) {
        print(element.email);
      }
      if (element.runtimeType == AdminUser) {
        print(element.email.substring(element.email.indexOf('@')+1));
      }
    });
  }
}

//задание 9
//метод трапеций
class TrapezoidRule{
  num _abs(num x){
    return (x<0)? -x : x;
  }

  num calc(Function func, num a, num b, num rtol, int nseg0){
    // Правило трапеций
    // rtol - желаемая относительная точность вычислений
    // nseg0 - начальное число отрезков разбиения"""
    int nseg = nseg0;
    num resOld = 0.0;
    //первоначальный расчёт
    num res = 0.0;
    res = calcRule(func, a, b, nseg);

    num err = max(1,  _abs(res));
    while (err > _abs(rtol * res)) {
      resOld = res;
      nseg *= 2;  // увеличиваем кол-во интервалов в два раза
      res = calcRule(func, a, b, nseg);
      err = _abs(res - resOld);
    }
  return res;
  }
  num calcRule(Function func, num a, num b, int nseg) {
    // nseg - число отрезков разбиения
    num res = 0;
    num dx = _abs(b - a) / nseg;
    for (int i = 0; i < nseg; i++) {
      res += (func(a + i * dx) + func(a + (i+1) * dx)) * 0.5;
    }
    res *= dx;
    return res;
  }
}