import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/models/category.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key});

  @override
  State<StatefulWidget> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {

  late Future<List<Category>> _categories;
  int _selectedIndex = 0;

  Future<List<Category>> _loadCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Category(id: 'C01', name: '의류', subCategories: ['상의', '하의', '아우터']),
      Category(id: 'C02', name: '식품', subCategories: ['과일', '채소', '정육']),
      Category(id: 'C03', name: '가전', subCategories: ['TV', '냉장고', '세탁기']),
      Category(id: 'C04', name: '뷰티', subCategories: ['화장품', '향수', '스킨케어']),
      Category(id: 'C05', name: '생활용품', subCategories: ['청소도구', '욕실용품', '주방용품']),
      Category(id: 'C06', name: '홈인테리어', subCategories: ['가구', '조명', '커튼']),
      Category(id: 'C07', name: '완구/취미', subCategories: ['레고', '보드게임', '프라모델']),
      Category(id: 'C08', name: '반려동물', subCategories: ['사료', '간식', '장난감']),
    ];
  }

   @override
  void initState(){
    super.initState();
      _categories = _loadCategories();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('카테고리'),
      automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Category>>(
          future: _categories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('카테고리 로드 실패: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final categories = snapshot.data!;

              if (categories.isEmpty) {
                return const Center(child: Text('등록된 카테고리가 없습니다.'));
              }
              return Row(
                children: <Widget>[
                  _buildPrimaryCategory(categories),

                  _buildSecondaryCategory(
                      categories[_selectedIndex].subCategories),
                ],
              );
            }
            return const Center(child: Text('카테고리 정보 없음'),);
        },
      )
    );
  }

  // 1차 카테고리 리스트
  Widget _buildPrimaryCategory(List<Category> categories) {
    return Container(
      width: 100,
      color: Colors.grey[200],
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              decoration: BoxDecoration(
                color: _selectedIndex == index ? Colors.white : Colors.grey[200],
                border: const Border(
                  right: BorderSide(color: Colors.blueAccent, width: 2.0),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                categories[index].name,
                style: TextStyle(
                  fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                  color: _selectedIndex == index ? Colors.blueAccent : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // 2차 카테고리 리스트
  Widget _buildSecondaryCategory(List<String> subCategories) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('2차 카테고리', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3,
                ),
                itemCount: subCategories.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(subCategories[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
