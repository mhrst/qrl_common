import 'package:flutter/material.dart';

class SignInWithGoogleButton extends StatefulWidget {
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;

  const SignInWithGoogleButton({
    super.key,
    this.onTap,
    this.padding,
  });

  @override
  State<StatefulWidget> createState() => _SignInWithGoogleButtonState();
}

class _SignInWithGoogleButtonState extends State<SignInWithGoogleButton> {
  bool disabled = false;

  @override
  Widget build(BuildContext context) => Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: Material(
          elevation: 3.0,
          color: const Color.fromARGB(255, 79, 133, 233),
          borderRadius: const BorderRadius.all(Radius.circular(2.0)),
          // color: Colors.grey[800],
          child: Ink.image(
            image: const AssetImage(
                'assets/images/btn_google_light_normal_ios.png',
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
                    'Sign in with Google',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
