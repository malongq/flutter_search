//import 'package:flutter/material.dart';
//import 'search.dart';
//
//void main()=>runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: '搜索demo',
//      theme: ThemeData(
//        primarySwatch: Colors.lightBlue
//      ),
//      home: Search(),
//    );
//  }
//}

import 'package:flutter/material.dart';
import 'asset.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '搜索栏实现',
      theme: ThemeData.light(),
      home: Se(),
    );
  }
}

class Se extends StatefulWidget {
  @override
  _SeState createState() => _SeState();
}

class _SeState extends State<Se> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '搜索实现',
          style: Theme.of(context).textTheme.title,
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search,color: Colors.white,size: 30.0,), onPressed: ()=>showSearch(context: context, delegate: NewSe()))
        ],
      ),
    );
  }
}


class NewSe extends SearchDelegate<String> {

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: ()=>query="")
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation), onPressed: ()=> close(context,null));
  }

  @override
  Widget buildResults(BuildContext context) {

    return Container(
      width: 1000.0,
      height: 50.0,
      child: Card(
        color: Colors.white,
        child: Text(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final aa = query.isEmpty
        ? BList//如果是空，但会默认推荐
        : AList.where(//返回搜索结果
            (input)=>input.startsWith(query)
          ).toList();

    return ListView.builder(
      itemCount: aa.length,
      itemBuilder: (context,index)=>ListTile(
        title: RichText(
            text: TextSpan(
              text: aa[index].substring(0,query.length),
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: aa[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                )
              ]
            ),
        ),
      )
    );
  }

}
