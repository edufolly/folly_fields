import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/responsive/responsive_grid.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';




class FourImages extends StatefulWidget {



  const FourImages({super.key});




  @override
  State<FourImages> createState() => _FourImagesState();
}




class _FourImagesState extends State<FourImages> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quatro Imagens')),
      body: const SingleChildScrollView(
        child: ResponsiveGrid(
          margin: EdgeInsets.all(24),
          children: <Responsive>[
            ResponsiveNetworkImage(
              'https://i.imgur.com/7sOAVPL.jpeg',
              minHeight: 320,
              sizeSmall: 12,
              sizeMedium: 6,
              sizeLarge: 3,
            ),
            ResponsiveNetworkImage(
              'https://i.imgur.com/PwLsD8k.jpeg',
              minHeight: 320,
              sizeSmall: 12,
              sizeMedium: 6,
              sizeLarge: 3,
            ),
            ResponsiveNetworkImage(
              'https://i.imgur.com/Y7umFBl.jpeg',
              minHeight: 320,
              sizeSmall: 12,
              sizeMedium: 6,
              sizeLarge: 3,
            ),
            ResponsiveNetworkImage(
              'https://i.imgur.com/UTlVJk5.jpeg',
              minHeight: 300,
              sizeSmall: 12,
              sizeMedium: 6,
              sizeLarge: 3,
            ),
          ],
        ),
      ),
    );
  }
}




class ResponsiveNetworkImage extends ResponsiveStateless {
  final String url;




  const ResponsiveNetworkImage(
    this.url, {
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  });




  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () =>
              FollyDialogs.dialogMessage(context: context, message: 'Tap!'),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                width: 2,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            padding: const EdgeInsets.all(25),
            child: Image.network(url, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
