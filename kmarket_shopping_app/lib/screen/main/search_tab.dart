import 'dart:ui';

import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<StatefulWidget> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {

  final List<String> _recentSearches = ['신발', '원피스', '갤럭시 005'];
  final List<String> _suggestedKeywords = ['여름 세일', '캠핑 용품', '데일리룩'];
  final List<String> _popularKeywords = ['청바지', '에어컨', '선글라스'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _buildSearchBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildSectionTitle('최근 검색어'),
              _buildKeywordsChips(_recentSearches, true),
              const Divider(height: 30,),

              _buildSectionTitle('추천 검색어'),
              _buildKeywordsChips(_suggestedKeywords, false),
              const Divider(height: 30,),

              _buildSectionTitle('인기 검색어(실시간)'),
              _buildPopularKeyWordList(_popularKeywords),
            ],
          ),
        ),
      ),
    );
  }
    // 검색바 UI
    Widget _buildSearchBar(){
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10)
        ),
        child: TextField(
          decoration: const InputDecoration(
            hintText: '검색어를 입력하세요',
            border: null,
            icon: Icon(Icons.search, color: Colors.grey,),
            contentPadding: EdgeInsets.symmetric(vertical: 8),
          ),
          onSubmitted: (value){
            // 검색 결과 화면으로 이동 로직
          },
        ),
      );
    }

    // 섹션 제목
  Widget _buildSectionTitle(String title){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 검색어 칩 목록 (최근 검색어, 추천 검색어)
  Widget _buildKeywordsChips(List<String> keywords, bool canDelete){
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: keywords.map((keyword){
        return Chip(
          label: Text(keyword),
          deleteIcon: canDelete ? const Icon(Icons.close, size: 18,) : null,
          onDeleted: canDelete ? (){
            setState(() {
              _recentSearches.remove(keyword);
            });
          }
          :null,
          backgroundColor: Colors.grey[100],
        );
      }).toList(),
    );
  }

  // 인기 검색어 목록
  Widget _buildPopularKeyWordList(List<String> keywords){
    return Column(
      children: List.generate(keywords.length, (index){
        final displayIndex = (index + 1).toString().padLeft(3, '0');
        return ListTile(
          leading: Text(
            '$displayIndex.',
            style: TextStyle(
              fontWeight: index < 3 ? FontWeight.bold : FontWeight.normal,
              color: index < 3 ? Colors.red : Colors.black),
            ),
            title: Text(keywords[index]),
          trailing: const Icon(Icons.arrow_forward_ios, size: 15,),
          onTap: (){

          },
        );
      }),
    );
  }

}