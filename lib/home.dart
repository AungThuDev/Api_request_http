import 'package:flutter/material.dart';
import 'package:jsonpagination/const.dart';
import 'package:jsonpagination/model/user.dart';
import 'package:jsonpagination/service/userservice.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User> _users=[];

  //Flags
  bool _isLoading=false;
  bool _noMoreItem=false;
  int _page=1;
  ScrollController? _scrollController;

  void initState()
  {
    super.initState();
    _isLoading=true;
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      print(_scrollController!.position.pixels);
      print(_scrollController!.position.maxScrollExtent);

      if(!_noMoreItem && _scrollController!.position.pixels > (_scrollController!.position.maxScrollExtent-30))
    {
      setState(() {
        _isLoading=true;
        _page++;
        fetchUser();
      });
    }

    },);
    
    fetchUser();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Network"),
      ),

      body: 
      Stack(
        children: [ListView.builder(
          controller: _scrollController,
          itemCount: _users.length,
          itemBuilder: ((context, index) {
          final user=_users[index];
          return Card(
            child:ListTile(
              leading: Icon(Icons.verified_user),
              title: Text("${index+1}. "+"${user.name}"),
            )
          );
        })),
        if(_isLoading)
        Center(child: CircularProgressIndicator(),)
        ]
      ),
    );
  }

  fetchUser()
  {
    var usersFuture=UserService.shared.fetchUser(page: _page);
    usersFuture.then((users){
      
      if(users.length<TOTALPAGEITEM) _noMoreItem=true;
      setState(() {
        _isLoading=false;
        _users.addAll(users);
        print(users);
      });
    });
  }
}



