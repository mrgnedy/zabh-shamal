import 'package:bots/core/api_utils.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/data/models/all_services.dart';
import 'package:bots/presentation/widgets/main_page_drawer.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<String> services = [
    'sadsadsa',
    'sdd',
    'saddsdadsaddssssssssssssssssss',
    's',
  ];
  List<String> packages = [
    'sadsadsa',
    'saddsdadsaddssssssssssssssssasasassss',
    'sdd',
    'saddsdadsadd',
    's',
  ];
  String selectedPackage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MainPageDrawer(),
      appBar: AppBar(
        title: Txt('تفاصيل المنتج'),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          productGallery(),
          builCard('  السعر', '${widget.product.price}'),
          builCard('  الرقم', '${widget.product.id}'),
          builCard('  الوزن', '${widget.product.weight}'),
          builCard('  العمر', '${widget.product.age}'),
          buildPackages('التجهيز', packages),
          buildServices('الخدمة', services),
          buildHead('الرأس', services),
          builCard('الخدمة', 'value'),
          builCard('key', 'value'),
          builCard('key', 'value')
        ],
      ),
    );
  }

  ParentStyle cardStyle = StylesD.cartStyle.clone()
    ..margin(all: 10)
    ..padding(all: 0)
    ..height(50)
    ..elevation(1, color: Colors.white);

  Widget builCard(String key, String value) {
    return Container(
      height: 70,
      child: Parent(
          style: cardStyle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(),
              Txt(
                value,
                style: StylesD.txtStyle.clone()..textColor(ColorsD.main),
              ),
              Txt(
                key,
                style: StylesD.txtStyle.clone(),
              ),
            ],
          )),
    );
  }

  Widget buildQuantitiy() {
    return Container();
  }

  Map<String, dynamic> dropDownValues = {};
  Widget buildPackages(String key, List<String> packages) {
    return buildDropDown(key, packages);
  }

  Widget buildServices(String key, List<String> services) {
    return buildDropDown(key, services);
  }

  Widget buildHead(String key, List<String> heads) {
    return buildDropDown(key, heads);
  }

  Widget buildDropDown(String key, List<String> list) {
    return Container(
      height: 70,
      child: Parent(
        style: cardStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Directionality(
              textDirection: TextDirection.rtl,
              child: Expanded(
                // width: 200,
                flex: 4,
                child: DropdownButton(
                    isExpanded: true,
                    underline: Container(),
                    items: List.generate(list.length, (index) {
                      return DropdownMenuItem(
                        value: list[index],
                        child: Txt(
                          list[index],
                          style: StylesD.txtStyle.clone()
                            ..textColor(ColorsD.main)
                            ..alignmentContent.coordinate(0.3, 0),
                        ),
                      );
                    }),
                    hint: Txt(
                      list.first,
                      style: StylesD.txtStyle.clone()..textColor(ColorsD.main),
                    ),
                    value: dropDownValues[key],
                    onChanged: (s) {
                      dropDownValues[key] = s;
                      setState(() {});
                    }),
              ),
            ),
            Expanded(
              flex: 2,
              child: Txt(
                ' $key',
                style: StylesD.txtStyle.clone()..alignmentContent.centerRight(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productGallery() {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              insetAnimationDuration: Duration(seconds: 1),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: Container(
                // tag: widget.tag,
                height: MediaQuery.of(context).size.height / 2,
                child: PhotoView(
                  backgroundDecoration:
                      BoxDecoration(color: Colors.transparent),
                  customSize:
                      Size.fromHeight(MediaQuery.of(context).size.height / 2),
                  heroAttributes: PhotoViewHeroAttributes(
                    tag: 'widget.tag',
                  ),
                  imageProvider: NetworkImage(
                      '${APIs.imageBaseUrl}${widget.product.image}'),
                ),
              ),
            ),
          );
        },
        child: Hero(
            tag: 'widget.tag',
            child: Image.network(
              '${APIs.imageBaseUrl}${widget.product.image}',
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            )),
      );
    });
  }
}
