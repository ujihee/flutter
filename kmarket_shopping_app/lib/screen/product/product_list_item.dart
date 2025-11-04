
import 'package:flutter/material.dart';
import 'package:kmarket_shopping_app/config/app_config.dart';
import 'package:kmarket_shopping_app/models/product.dart';
import 'package:kmarket_shopping_app/screen/product/product_view_screen.dart';

class ProductListItem extends StatelessWidget {

  final Product product;

  const ProductListItem({super.key, required this.product});


  @override
  Widget build(BuildContext context) {

    final finalPrice = product.price * (1 - product.discount / 100);

    return GestureDetector(
      onTap: () {

        /*
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('상세 상품 이동')),
        );*/

        // 상품 상세 이동
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ProductViewScreen(product: product,))
        );

      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(6),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.network('${AppConfig.baseUrl}/product/image/${product.thumb120}'),
              ),
              SizedBox(width: 10,),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('상품번호 : ${product.pno}'),
                      Text(
                        product.productName,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text('가격 : ${product.price}(할인율 : ${product.discount}%)',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 16
                        ),
                      ),
                      Text('최종가격 : ${finalPrice.toStringAsFixed(0)}원',
                        style: TextStyle(
                          color: Colors.red
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      );
    }

}
