import 'package:flutter/material.dart';
import 'package:todoapp/core/api_service.dart';
import 'package:todoapp/core/model/product.dart';

class AddProductView extends StatefulWidget {
  @override
  _AddProductViewState createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  GlobalKey<FormState> formKey = GlobalKey(debugLabel: "formKEy");

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerImage = TextEditingController();
  String validator(val) {
    if (val.isEmpty) {
      return "This area is not accept empty value";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidate: true,
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                    controller: controllerName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Product Name",
                        hasFloatingPlaceholder: true),
                    validator: this.validator),
                TextFormField(
                  controller: controllerPrice,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Price",
                      hasFloatingPlaceholder: true),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "not empty";
                    } else if (int.tryParse(val) == null) {
                      return "pls write number";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controllerImage,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Price",
                      hasFloatingPlaceholder: true),
                  validator: this.validator,
                ),
                RaisedButton.icon(
                  icon: Icon(Icons.send),
                  label: Text("Add"),
                  onPressed: () async {
                    var model = Product(
                        productName: controllerName.text,
                        imageURL: controllerImage.text,
                        money: int.parse(controllerPrice.text));
                    await ApiService.getInstance().addProducts(model);
                    Navigator.pop(context);
                  },
                  shape: StadiumBorder(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
