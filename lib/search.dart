import 'package:flutter/material.dart';
import 'asset.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '搜索测试喽',
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[//右边显示搜索图标
          IconButton(
            icon: Icon(
              Icons.search,
              size: 35.0,
              color: Colors.white,
            ),
            onPressed: (){
//              print('点击了搜索框');
            showSearch(context: context, delegate: SearchCode());
              Search();
            },
          )
        ],
      ),
    );
  }
}

//todo 下面是搜索
class SearchCode extends SearchDelegate<String>{

  //右侧图标 因为返回时一个widget数组，所以直接是中括号包裹
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(
              Icons.clear
          ),
          onPressed:()=>query=""
      )
    ];
  }

  //左侧图标 因为返回是一个widget，所以直接返回要使用widget即可
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation
        ),
        onPressed: ()=>close(context,null)
    );
  }

  //搜索结果展示
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 1000.0,
      height: 100.0,
      child: Card(
        color: Colors.red,
        child: Text(query),
      ),
    );
  }

  //搜索结果
  @override
  Widget buildSuggestions(BuildContext context) {

    final result = query.isEmpty?BList:AList.where((input)=>input.startsWith(query)).toList();

    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context,index)=>ListTile(
        title: RichText(
          text: TextSpan(
            text: result[index].substring(0,query.length),
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: result[index].substring(query.length),
                  style: TextStyle(color: Colors.grey)
              )
            ]
          )
        ),
      ),
    );
  }

}
