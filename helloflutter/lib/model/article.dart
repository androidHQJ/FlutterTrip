import 'package:json_annotation/json_annotation.dart';

///注意这里引用到了一个article.g.dart没有产生的文件，
/// 我们通过flutter packages pub run build_runner build命令就会生成这个文件
///
/// flutter packages pub run build_runner build //使用 build_runner 生成 .g.dart 文件
///flutter packages pub run build_runner wacth //监控生成文件，如果有改动时自动生成/更新 .g.dart 文件

///还没有生成.g.dart文件或者报错的运行下面的命令
///flutter packages pub run build_runner build --delete-conflicting-outputs//删除并重新创建.g.dart文件
///没有生成的再运行一下
///flutter packages pub run build_runner build

part 'article.g.dart';

///Flutter下是禁用反射！！

//@JsonSerializable() 这是表示告诉编译器这个类是需要生成Model类的
//FieldRename.snake 表示json字段下划线分割类型如：article_id
@JsonSerializable(fieldRename: FieldRename.snake, checked: true)
class Article {
  final int articleId;
  final String articleTitle;
  final String articleLikn;

  Article(this.articleId, this.articleTitle, this.articleLikn);

  ///添加工厂方法
  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  toMap() {}
}