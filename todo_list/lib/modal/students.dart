class Students {
  late String _name; // this is private property
  late int age;
  Students(this._name, this.age); // this constructor

  // getter and setter
  String get getName => _name;

  set setName(String name) {
    _name = name;
  }

  void display() {
    print('This is name of student: $_name');
  }
}

class GoodStudent extends Students {
  // GoodStudent is extended from Students class
  late double score;
  GoodStudent(
    super.name,
    super.age,
    this.score,
  ); // take properties from parent class

  void displayNameOfGoodStudent() {
    display();
    print('his score is $score');
  }
}
