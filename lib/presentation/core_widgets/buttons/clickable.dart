import 'package:flutter/material.dart';

import '../../../utils/app_extensions/app_extension.dart';

class KClickable extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration reverseDuration;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final void Function(TapDownDetails)? onTapDown;
  final HitTestBehavior hitTestBehavior;
  final bool disabled;
  final bool inkSplash;
  final bool feedbackEnabled;
  final bool opacityEnabled;
  final EdgeInsets? padding;

  const KClickable({
    Key? key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.disabled = false,
    this.hitTestBehavior = HitTestBehavior.translucent,
    this.onTapDown,
    this.feedbackEnabled = true,
    this.duration = const Duration(milliseconds: 120),
    this.reverseDuration = const Duration(milliseconds: 80),
    this.opacityEnabled = true,
    this.inkSplash = false,
    this.padding,
  }) : super(key: key);

  @override
  _KClickableState createState() => _KClickableState();
}

class _KClickableState extends State<KClickable> with TickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: widget.duration,
    reverseDuration: widget.duration,
  );

  late final Animation<double> animation = Tween<double>(begin: 1.0, end: 0.5)
      .animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.linearToEaseOut,
        ),
      );

  @override
  void dispose() {
    if (mounted) {
      animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.disabled
        ? Opacity(
            opacity: 0.3,
            child: Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: widget.child,
            ),
          )
        : !widget.inkSplash
        ? GestureDetector(
            behavior: widget.hitTestBehavior,
            onTap: () async {
              if (widget.feedbackEnabled) {
                KAppX.services.haptics.hapticLight();

                Feedback.forTap(context);
              }

              widget.onPressed?.call();

              await animationController.forward();
              await animationController.reverse();
            },
            onTapCancel: () {
              animationController.reverse();
            },
            onTapDown: (tapDownDetails) {
              if (widget.onTapDown != null) {
                widget.onTapDown!(tapDownDetails);
              }
              animationController.forward();
            },
            onTapUp: (tapUpDetails) {
              animationController.reverse();
            },
            onLongPressStart: (longPressStartDetails) {
              animationController.forward();
            },
            onLongPress: () {
              if (widget.feedbackEnabled) {
                KAppX.services.haptics.hapticMedium();

                Feedback.forLongPress(context);
              }

              widget.onLongPress?.call();

              animationController.reverse();
            },
            child: Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: widget.opacityEnabled
                  ? KAnimatedOpacity(animation: animation, child: widget.child)
                  : widget.child,
            ),
          )
        : Stack(
            children: [
              Padding(
                padding: widget.padding ?? EdgeInsets.zero,
                child: widget.opacityEnabled
                    ? KAnimatedOpacity(
                        animation: animation,
                        child: widget.child,
                      )
                    : widget.child,
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(),
                    child: InkWell(
                      highlightColor: Color(0xFF282B2F),
                      splashColor: Color(0xFF282B2F),
                      onTap: () async {
                        if (widget.feedbackEnabled) {
                          KAppX.services.haptics.hapticLight();

                          Feedback.forTap(context);
                        }

                        widget.onPressed?.call();
                      },
                      onTapDown: (tapDownDetails) {
                        if (widget.onTapDown != null) {
                          widget.onTapDown!(tapDownDetails);
                        }
                      },
                      onLongPress: () {
                        if (widget.feedbackEnabled) {
                          KAppX.services.haptics.hapticMedium();

                          Feedback.forLongPress(context);
                        }

                        widget.onLongPress?.call();
                      },
                      child: Container(),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}

class KAnimatedOpacity extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const KAnimatedOpacity({
    Key? key,
    required this.animation,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: animation, child: child);
  }
}
