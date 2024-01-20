import 'package:employee/constants/common_colors.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SimpleDialog(
        backgroundColor: Colors.black.withOpacity(0.5),
        children: <Widget>[
          Center(
            child: Column(
              children: [
                Text(
                  '$title...',
                  style: const TextStyle(
                    color: CommonColors.whiteColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
