import 'package:flutter/material.dart';

class CustomButtonLoading extends StatelessWidget {
  final bool isLoading;
  final String text;
  final Function()? onClick;

  const CustomButtonLoading({
    Key? key,
    required this.isLoading,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: isLoading ? null : onClick,
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        padding: (isLoading)
            ? EdgeInsets.fromLTRB(10, 10, 10, 10)
            : EdgeInsets.fromLTRB(40, 10, 40, 10),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(isLoading ? 30 : 5),
        ),
        duration: Duration(milliseconds: 400),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
