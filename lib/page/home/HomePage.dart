import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wan_andoird/bottom_app_bar.dart';
import 'package:wan_andoird/net/HttpManager.dart';
import 'package:wan_andoird/page/MainPage.dart';
import 'package:wan_andoird/page/home/HomeBean.dart';
import 'package:wan_andoird/page/home/HomeData.dart';

final List<Product> _products = List<Product>.from(allProducts());
final Map<Product, Order> _shoppingCart = <Product, Order>{};

int _childrenPerBlock = 8;
int _rowsPerBlock = 5;

int _minIndexInRow(int rowIndex) {
  final int blockIndex = rowIndex ~/ _rowsPerBlock;
  return const <int>[0, 2, 4, 6, 7][rowIndex % _rowsPerBlock] +
      blockIndex * _childrenPerBlock;
}

int _maxIndexInRow(int rowIndex) {
  final int blockIndex = rowIndex ~/ _rowsPerBlock;
  return const <int>[1, 3, 5, 6, 7][rowIndex % _rowsPerBlock] +
      blockIndex * _childrenPerBlock;
}

int _rowAtIndex(int index) {
  final int blockCount = index ~/ _childrenPerBlock;
  return const <int>[
        0,
        0,
        1,
        1,
        2,
        2,
        3,
        4
      ][index - blockCount * _childrenPerBlock] +
      blockCount * _rowsPerBlock;
}

int _columnAtIndex(int index) {
  return const <int>[0, 1, 0, 1, 0, 1, 0, 0][index % _childrenPerBlock];
}

int _columnSpanAtIndex(int index) {
  return const <int>[1, 1, 1, 1, 1, 1, 2, 2][index % _childrenPerBlock];
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'HomePage');
  HomeGridDelegate gridDelegate = HomeGridDelegate();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(),
            SliverSafeArea(
                sliver: SliverGrid(
              delegate: SliverChildListDelegate(
                _products.map((Product product) {
                  return _ProductItem(
                    product: product,
                    onPressed: () {
                      String url =
                          "http://wanandroid.com/wxarticle/chapters/json";
                      HttpManager.fetch(url, null, null, null);
                    },
                  );
                }).toList(),
              ),
              gridDelegate: gridDelegate,
            ))
          ],
        ));
  }
}

class HomeGridDelegate extends SliverGridDelegate {
  static double _spacing = 8.0;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    double tileWidth = (constraints.crossAxisExtent - _spacing) / 2.0;
    double tileHeight = 40.0 + 144.0 + 40.0;
    return HomeGridLayout(
      tileWidth: tileWidth,
      tileHeight: tileHeight,
      rowStride: tileHeight + _spacing,
      columnStride: tileWidth + _spacing,
    );
  }

  @override
  bool shouldRelayout(SliverGridDelegate oldDelegate) {
    return false;
  }
}

class HomeGridLayout extends SliverGridLayout {
  HomeGridLayout({
    @required this.tileWidth,
    @required this.tileHeight,
    @required this.rowStride,
    @required this.columnStride,
  });

  final double rowStride;
  final double columnStride;
  final double tileHeight;
  final double tileWidth;

  @override
  double computeMaxScrollOffset(int childCount) {
    if (childCount == 0) {
      return 0.0;
    }
    final int rowCount = _rowAtIndex(childCount - 1) + 1;
    final double rowSpacing = rowStride - tileHeight;
    return rowStride * rowCount - rowSpacing;
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    final int row = _rowAtIndex(index);
    final int column = _columnAtIndex(index);
    final int columnSpan = _columnSpanAtIndex(index);
    return SliverGridGeometry(
      scrollOffset: row * rowStride,
      crossAxisOffset: column * columnStride,
      mainAxisExtent: tileHeight,
      crossAxisExtent: tileWidth + (columnSpan - 1) * columnStride,
    );
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    return _maxIndexInRow(scrollOffset ~/ rowStride);
  }

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    return _minIndexInRow(scrollOffset ~/ rowStride);
  }
}

class _ProductItem extends StatelessWidget {
  const _ProductItem({Key key, @required this.product, this.onPressed})
      : assert(product != null),
        super(key: key);

  final Product product;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Card(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: _ProductPriceItem(product: product),
                ),
                Container(
                  width: 144.0,
                  height: 144.0,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Hero(
                    tag: product.tag,
                    child: Image.asset(
                      product.imageAsset,
                      package: product.imageAssetPackage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: _VendorItem(vendor: product.vendor),
                ),
              ],
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(onTap: onPressed),
            ),
          ],
        ),
      ),
    );
  }
}

abstract class _PriceItem extends StatelessWidget {
  const _PriceItem({Key key, @required this.product})
      : assert(product != null),
        super(key: key);

  final Product product;

  Widget buildItem(BuildContext context, TextStyle style, EdgeInsets padding) {
    BoxDecoration decoration;
    if (_shoppingCart[product] != null)
      decoration = BoxDecoration(color: Theme.of(context).primaryColor);

    return Container(
      padding: padding,
      decoration: decoration,
      child: Text(product.priceString, style: style),
    );
  }
}

class _ProductPriceItem extends _PriceItem {
  const _ProductPriceItem({Key key, Product product})
      : super(key: key, product: product);

  @override
  Widget build(BuildContext context) {
    return buildItem(
      context,
      TextStyle(),
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    );
  }
}

class _VendorItem extends StatelessWidget {
  const _VendorItem({Key key, @required this.vendor})
      : assert(vendor != null),
        super(key: key);

  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.0,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 24.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                vendor.avatarAsset,
                package: vendor.avatarAssetPackage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              vendor.name,
            ),
          ),
        ],
      ),
    );
  }
}
