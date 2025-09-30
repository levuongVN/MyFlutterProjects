class Tasks {
  late int id;
  late String name;
  late String priority;
  late bool isFavoutite;
  Tasks(this.id, this.name, this.priority, {this.isFavoutite = false});
  @override
  String toString() {
    return '${id.hashCode}, $name, $priority, $isFavoutite'; // display the in4 of class (must hash id for security)
  }
}
