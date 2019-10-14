import 'package:flutter/material.dart';
import 'package:todoapp/core/api_service.dart';
import 'package:todoapp/core/model/product.dart';
import 'package:todoapp/ui/shared/widgets/custom_card.dart';
import 'package:todoapp/ui/view/add_product_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ApiService service = ApiService.getInstance();
  List<Product> productList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hardware Andro"),
      ),
      floatingActionButton: _fabButton,
      body: FutureBuilder<List<Product>>(
        future: service.getProducts(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                productList = snapshot.data;
                return _listView;
              }
              return Center(
                child: Text("Error"),
              );
            default:
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

  Widget get _listView => ListView.separated(
      itemCount: productList.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => dismiss(
          CustomCard(
            title: productList[index].productName,
            subtitle: "${productList[index].money}",
            imageURL: productList[index].imageURL,
          ),
          productList[index].key));

  Widget dismiss(Widget child, String key) {
    return Dismissible(
      child: child,
      key: UniqueKey(),
      secondaryBackground: Center(
        child: Text("Hello"),
      ),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (dismissDirection) async {
        await service.removeProducts(key);
      },
    );
  }

  Widget get _fabButton => FloatingActionButton(
        onPressed: fabPressed,
        child: Icon(Icons.add),
      );

  void fabPressed() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        context: context,
        builder: (context) => bottomSheet);
  }

  Widget get bottomSheet => Container(
        height: 100,
        child: Column(
          children: <Widget>[
            Divider(
              thickness: 2,
              indent: 100,
              endIndent: 100,
              color: Colors.grey,
            ),
            RaisedButton(
              child: Text("Add Product"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddProductView()));
              },
            )
          ],
        ),
      );
}
