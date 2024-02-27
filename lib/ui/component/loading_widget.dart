
import 'dart:io'; // Import the dart:io library

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double size;
  const LoadingWidget({super.key,  this.size=36.0});

  @override
  Widget build(BuildContext context) {
    return  Center(child: SizedBox(

      width: size,
      height: size,
      child: Platform.isIOS ? const CupertinoActivityIndicator(
        color: Colors.green,
      )
          : const CircularProgressIndicator(
        color: Colors.red,
      )

    ),);
  }
}
