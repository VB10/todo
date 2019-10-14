import 'package:flutter/material.dart';
import 'package:todoapp/ui/shared/styles/text_styles.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageURL;

  const CustomCard({Key key, this.title, this.subtitle, this.imageURL})
      : assert(imageURL != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: ListTile(
        title: Text(this.title,style: titleStyle,),
        subtitle: Text(this.subtitle),
        trailing: imagePlace,
      ),
    );
  }

  Widget get imagePlace {
    return imageURL.isEmpty
        ? Container(
            width: 100,
            child: Placeholder(),
          )
        : Image.network(imageURL);
  }
}
