import 'package:bots/core/api_utils.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/data/models/all_services.dart';
import 'package:bots/presentation/router.gr.dart';
import 'package:bots/presentation/widgets/main_page_drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class AllProducts extends StatefulWidget {
  final String title;
  final List<Product> products;

  AllProducts({this.title = 'h', this.products});

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
        centerTitle: true,
      ),
      endDrawer: MainPageDrawer(),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            // color: Colors.red,
            child: Wrap(
              direction: Axis.horizontal,
              runSpacing: 0,
              spacing: 0,
              // crossAxisAlignment: WrapCrossAlignment.center,
              // runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              children: List.generate(widget.products.length, (index) {
                Size size = MediaQuery.of(context).size;
                final product = widget.products[index];
                return Container(
                    // color: Colors.green,
                    width: size.width / 2,
                    // height: size.height / 4.5,
                    padding: EdgeInsets.all(10),
                    child: _buildSingleProduct(product));
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleProduct(Product product) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: Colors.yellow,
      width: size.width,
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Router.navigator.pushNamed(Router.productPage, arguments: product);
            },
            child: Container(
              // color: Colors.red,
              height: size.height / 4,
              width: size.width,
              child: Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  Opacity(
                      opacity: 0.1,
                      child: Image.asset(
                        Assets.productBackground,
                        fit: BoxFit.cover,
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                        placeholder: (context, s) => Center(
                              child: CircularProgressIndicator(),
                            ),
                        imageBuilder: (context, imageB)=> Container(
                          height: size.height/4,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            
                            image: DecorationImage(image: imageB, fit: BoxFit.cover, )
                          ),
                        ),
                        imageUrl: '${APIs.imageBaseUrl}${product.image}',
                        // fit: BoxFit.fill,
                        height: size.height / 4,
                        width: size.width,
                        ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Txt(
              '${product.price} ر.س',
              style: TxtStyle()
                ..fontFamily('Cairo')
                ..textDirection(TextDirection.rtl),
            ),
          ),
        ],
      ),
    );
  }
}
