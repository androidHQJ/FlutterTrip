import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class StartUpApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
//    return _buildNormal();
    return _buildRandomWords();
  }

  Widget _buildNormal(){
    final wordPair=new WordPair.random();
    return new MaterialApp(
      title: "Welcome to Flutter",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Welcome to Flutter"),
        ),
        body: new Center(
          child: new Text(wordPair.asPascalCase),
        ),
      ),
    );
  }

  //配置ThemeData类轻松更改应用程序的主题
  Widget _buildRandomWords(){
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.white
      ),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords>{
  //保存建议的单词对
  final _suggestions=<WordPair>[];
  //存储用户喜欢（收藏）的单词对
  final _saved=new Set<WordPair>();
  //增大字体大小
  final biggerFot=const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.list),
              onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved(){
    //添加Navigator.push调用，这会使路由入栈（以后路由入栈均指推入到导航管理器的栈）
    Navigator.of(context).push(
      //添加MaterialPageRoute及其builder
      new MaterialPageRoute(
          builder: (context){
            //添加生成ListTile行的代码
            final titles=_saved.map(
                (pair){
                  return new ListTile(
                    title: new Text(
                      pair.asPascalCase,
                      style: biggerFot,
                    ),
                  );
                }
            );

            //ListTile的divideTiles()方法在每个ListTile之间添加1像素的分割线。
            // 该 divided 变量持有最终的列表项。
            final divided=ListTile
                .divideTiles(
                  context: context,
                  tiles: titles
                )
                .toList();

            return new Scaffold(
              appBar: new AppBar(
                title: new Text('Saved Suggestions'),
              ),
              body: new ListView(
                children: divided,
              ),
            );
          }
      )
    );

  }

  //构建显示建议单词对的ListView
  Widget _buildSuggestions(){
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
      // 在偶数行，该函数会为单词对添加一个ListTile row.
      // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
      // 注意，在小屏幕上，分割线看起来可能比较吃力。
      itemBuilder:(context,i){
          // 在每一列之前，添加一个1像素高的分隔线widget
          if(i.isOdd) return new Divider();

        // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
        // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
        var index=i~/2;
        // 如果是建议列表中最后一个单词对
        if(index>=_suggestions.length){
          // ...接着再生成10个单词对，然后添加到建议列表
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  //生成显示行
  Widget _buildRow(WordPair pair){
    //检查确保单词对还没有添加到收藏夹中
    final alreadySaved=_saved.contains(pair);

    return new ListTile(
      title: new Text(
          pair.asPascalCase,
          style:biggerFot,
      ),
      trailing: new Icon(
        alreadySaved? Icons.favorite:Icons.favorite_border,
        color: alreadySaved?Colors.red:null
      ),
      onTap: (){
        //调用setState() 会为State对象触发build()方法，从而导致对UI的更新
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
    );
  }
}