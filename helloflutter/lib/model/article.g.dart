// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return $checkedNew('Article', json, () {
    final val = Article(
        $checkedConvert(json, 'article_id', (v) => v as int),
        $checkedConvert(json, 'article_title', (v) => v as String),
        $checkedConvert(json, 'article_likn', (v) => v as String));
    return val;
  }, fieldKeyMap: const {
    'articleId': 'article_id',
    'articleTitle': 'article_title',
    'articleLikn': 'article_likn'
  });
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'article_id': instance.articleId,
      'article_title': instance.articleTitle,
      'article_likn': instance.articleLikn
    };
