class User
{
  String? id;
  String? createdAt;
  String? name;
  String? avator;

  User.fromJSON(Map<String,dynamic>json)
  {
    id=json["id"];
    createdAt=json["createdAt"];
    name=json["name"];
    avator=json["avator"];
  }
}

/*
  {
        "id": "25",
        "createdAt": "2019-02-16T19:30:48.101Z",
        "name": "Leif McCullough",
        "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/nickfratter/128.jpg"
    },
*/