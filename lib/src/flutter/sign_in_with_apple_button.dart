import 'package:flutter/material.dart';

class SignInWithAppleButton extends StatefulWidget {
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;

  const SignInWithAppleButton({
    super.key,
    this.onTap,
    this.padding,
  });

  @override
  State<StatefulWidget> createState() => _SignInWithAppleButtonState();
}

class _SignInWithAppleButtonState extends State<SignInWithAppleButton> {
  bool disabled = false;

  @override
  Widget build(BuildContext context) => Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: Material(
          elevation: 3.0,
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(2.0)),
          child: Ink.image(
            image: const AssetImage('assets/images/appleid_button_white.png',
                package: 'qrl_common'),
            alignment: Alignment.centerLeft,
            width: 250.0,
            height: 48.0,
            child: InkWell(
              onTap: widget.onTap,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 48.0,
                    right: 24.0,
                  ),
                  child: Text(
                    'Sign in with Apple',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
