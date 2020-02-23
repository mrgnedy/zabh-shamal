import 'package:bots/core/api_utils.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/data/models/all_services.dart';
import 'package:bots/data/models/pack_shred_model.dart';
import 'package:bots/data/models/product_model.dart';
import 'package:bots/presentation/router.gr.dart';
import 'package:bots/presentation/state/cart_store.dart';
import 'package:bots/presentation/state/services_store.dart';
import 'package:bots/presentation/widgets/main_page_drawer.dart';
import 'package:bots/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../core/utils.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  String servicess;
  List<Services> services = [];
  List<Services> packages = [];
  List<Services> subServices = [];
  List<Services> subPackages = [];
  String selectedPackage;
  TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() => controllerListner());
    final reactiveModel = Injector.getAsReactive<AllServicesStore>();
    packages = subPackages = List.from(reactiveModel.state.packages);
    // print(packages);
    services = subServices = List.from(reactiveModel.state.shreds);
    servicess = reactiveModel.state.services
        .singleWhere((serv) => serv.id == widget.product.serviceId)
        .name;
    dropDownValues = {
      'التقطيع': services.first.name,
      'التجهيز': packages.first.name,
    };
    print(services);
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MainPageDrawer(),
      appBar: AppBar(
        title: Txt('تفاصيل المنتج'),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: []..addAll([
            productGallery(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                  unselectedLabelColor: ColorsD.main,
                  labelStyle: TextStyle(fontFamily: 'Cairo', fontSize: 18),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorsD.main,
                  ),
                  controller: tabController,
                  tabs: [
                    Tab(child: Txt('مطعم')),
                    Tab(child: Txt('منزل')),
                  ]),
            ),
            buildPrice(widget.product.price.toString(),
                widget.product.priceAfteroffer.toString(), widget.product.type),
            builCard('  الرقم', '${widget.product.id}'),
            builCard('  الوزن', '${widget.product.weight}'),
            builCard('  العمر', '${widget.product.age}'),
            builCard('  النوع', '$servicess'),
            buildPackages('التجهيز', packages),
            buildServices('التقطيع', services),
            // buildHead('الرأس', services),

            buildArrivalTime(),
            buildQuantitiy(),
            buildShaloota(),
            buildRestName(),
            buildNotes(),
            Row(
              children: <Widget>[
                Expanded(child: addToCartBtn()),
                Expanded(
                  child: Parent(
                    style: StylesD.btnOnCardStyle,
                                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Txt('الذهاب الي العربة',
                            gesture: Gestures()
                              ..onTap(() => Router.navigator.pushNamed(Router.cart))),
                        SizedBox(width: 10,),
                        Icon(Icons.shopping_cart, color: Colors.white,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ]),
      ),
    );
  }

  addToCart(ProductModel product) {
    print('Adding to cart..');
    final reactiveModel = Injector.getAsReactive<CartStore>();
    reactiveModel
        .setState((state) => state.addToCart(context, product).then((data) {
              if (data != null)
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Txt('تم الاضافة للعربة'),
                  duration: Duration(milliseconds: 700),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ));
            }));
  }

  controllerListner() {
    subServices = [];
    subPackages = [];
    dropDownValues = {};
    subServices.addAll(services
        .where(
          (serv) => serv.type == 1 - tabController.index,
        )
        .toList());
    subPackages.addAll(packages
        .where((serv) => serv.type == 1 - tabController.index)
        .toList());
    setState(() {});
  }

  Widget addToCartBtn() {
    ProductModel productModel = ProductModel()
      ..products = [
        Products()
          ..arrivalTime = '${arrivalTime.text}'
          ..notes = '${notesCtrler.text}'
          ..orderService = widget.product.serviceId
          ..productId = widget.product.id
          ..power = shaloota.boolToInt()
          ..packageId = packages
              .singleWhere((pack) => pack.name == dropDownValues['التجهيز'],
                  orElse: () => packages.first)
              .id
          ..qty = counter
          ..resturant = '${restCtrler.text}'
          ..shudderId = services
              .singleWhere((serv) => serv.name == dropDownValues['الخدمة'],
                  orElse: () => packages.first)
              .id
      ];
    Widget onIdleWidget = Txt('أضف للعربة',
        style: StylesD.txtOnCardStyle.clone()..background.color(ColorsD.main),
        gesture: Gestures()
          ..onTap(() {
            print('tapped');
            addToCart(productModel);
          }));

    Widget onWaitingWidget = Parent(
      child: WaitingWidget(),
    );

    Widget onErrorWidget = Txt('أضف للعربة',
        style: StylesD.txtOnCardStyle.clone()..background.color(Colors.red),
        gesture: Gestures()..onTap(() => addToCart(productModel)));
    return StateBuilder(
      models: [Injector.getAsReactive<CartStore>()],
      builder: (context, reactiveModel) => reactiveModel.whenConnectionState(
        onIdle: () {
          return onIdleWidget;
        },
        onWaiting: () => onWaitingWidget,
        onError: (e) {
          // Scaffold.of(context).showSnackBar(SnackBar(content: Txt(e)));
          return onErrorWidget;
        },
        onData: (_) {
          // Scaffold.of(context)
          //     .showSnackBar(SnackBar(content: Txt('تم اضافة المنج للعربة')));
          print('حصل');
          return onIdleWidget;
        },
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
                style: StylesD.txtStyle.clone()
                  ..textColor(ColorsD.main)
                  ..textDirection(TextDirection.rtl),
              ),
              Txt(
                key,
                style: StylesD.txtStyle.clone(),
              ),
            ],
          )),
    );
  }

  Widget buildPrice(String price, String priceAfter, int type) {
    return type == 0
        ? builCard('  السعر', '${widget.product.price * counter} ر.س')
        : Container(
            height: 70,
            child: Parent(
                style: cardStyle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Txt('بدلا من $price',
                          style: StylesD.txtStyle.clone()
                            ..textColor(Colors.red)
                            ..textDirection(TextDirection.rtl)
                            ..alignmentContent.centerLeft()),
                    ),
                    Expanded(
                      child: Txt('$priceAfter',
                          style: StylesD.txtStyle.clone()
                            ..textColor(ColorsD.main)
                            ..textDirection(TextDirection.rtl)
                            ..alignment.center()),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Txt('  السعر',
                          style: StylesD.txtStyle.clone()
                            ..alignment.centerRight()),
                    ),
                  ],
                )),
          );
  }

  TextEditingController arrivalTime = TextEditingController(text: '10:00');
  TextEditingController notesCtrler = TextEditingController();
  Widget buildNotes() {
    return Parent(
      style: cardStyle.clone()
        ..minHeight(StylesD.size.height / 9)
        ..height(null),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                  child: TextField(
                textAlign: TextAlign.right,
                controller: notesCtrler,
                maxLines: 3,
              )),
            ),
            SizedBox(
              width: 10,
            ),
            Txt(':ملاحظات',
                style: StylesD.txtStyle.clone()..alignment.topRight()),
          ],
        ),
      ),
    );
  }

  TextEditingController restCtrler = TextEditingController();

  Widget buildRestName() {
    return Visibility(
      visible: tabController.index == 0,
      child: Parent(
        style: cardStyle.clone()
          ..minHeight(StylesD.size.height / 9)
          ..height(null),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                    child: TextField(
                  textAlign: TextAlign.right,
                  controller: restCtrler,
                )),
              ),
              SizedBox(
                width: 10,
              ),
              Txt(':إسم المطعم',
                  style: StylesD.txtStyle.clone()..alignment.topRight()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildArrivalTime() {
    return Visibility(
      visible: tabController.index == 0,
      child: Parent(
        style: cardStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.access_time, color: ColorsD.main),
                  onTap: () async => arrivalTime.text = (await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 10, minute: 0)))
                      .format(context),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: arrivalTime,
                    style: TextStyle(color: ColorsD.main),
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ],
            )),
            Expanded(
              child: Txt('وقت الوصول',
                  style: StylesD.txtStyle.clone()
                    ..alignment.center()
                    ..alignmentContent.centerRight()),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget buildQuantitiy() {
    return Parent(
      style: cardStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[counterBar(context), Txt("الكمية")],
      ),
    );
  }

  bool shaloota = false;
  Widget buildShaloota() {
    return Parent(
      style: cardStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Checkbox(
              activeColor: ColorsD.main,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              value: shaloota,
              onChanged: (s) {
                shaloota = s;
                if (mounted) setState(() {});
              }),
          Txt('شلوطة')
        ],
      ),
    );
  }

  Map<String, dynamic> dropDownValues = {};
  Widget buildPackages(String key, List packages) {
    return buildDropDown(key, subPackages);
  }

  Widget buildServices(String key, List services) {
    return buildDropDown(key, subServices);
  }

  Widget buildHead(String key, List heads) {
    return buildDropDown(key, heads);
  }

  Widget buildDropDown(String key, List<Services> list) {
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
                        value: list[index].name,
                        child: Txt(
                          list[index].name,
                          style: StylesD.txtStyle.clone()
                            ..textColor(ColorsD.main)
                            ..alignmentContent.coordinate(0.3, 0),
                        ),
                      );
                    }),
                    hint: Align(
                      alignment: Alignment.lerp(
                          Alignment.centerRight, Alignment.centerLeft, 0.35),
                      child: Txt(
                        list.first.name,
                        style: StylesD.txtStyle.clone()
                          ..textColor(ColorsD.main),
                      ),
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

  int counter = 1;
  Widget counterBar(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (counter > 1) counter--;
              {
                if (mounted) setState(() {});
                if (mounted) setState(() {});
              }
            },
            child: Icon(
              Icons.remove_circle_outline,
              color: ColorsD.main,
            ),
          ),
          Txt(
            '$counter',
            style: TxtStyle()
              ..textColor(ColorsD.main)
              ..padding(horizontal: 10),
          ),
          GestureDetector(
            onTap: () {
              counter++;
              if (mounted) setState(() {});
            },
            child: Icon(
              Icons.add_circle_outline,
              color: ColorsD.main,
            ),
          ),
        ],
      ),
    );
  }
}

extension BoolParser on bool {
  int boolToInt() {
    return this ? 1 : 0;
  }
}
