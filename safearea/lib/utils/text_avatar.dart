String initialName(String name,String lastName){
  var auxName = name.split(" ");
  String a = auxName[0];
  var auxLastName = lastName.split(" ");
  String b = auxLastName[auxLastName.length-1];
  return "${a[0]}${b[0]}";
}