import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeViewBackground extends StatefulWidget {
  const HomeViewBackground({Key? key}) : super(key: key);

  @override
  State<HomeViewBackground> createState() => _HomeViewBackgroundState();
}

class _HomeViewBackgroundState extends State<HomeViewBackground> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationFlowers;
  late Animation<double> _animationShadow;

  final desktopBackground = Image.asset(
    'assets/img/backgrounds/home_view_background_desktop.png',
    fit: BoxFit.cover,
  );
  final tabletBackground = Image.asset(
    'assets/img/backgrounds/home_view_background_tablet.png',
    fit: BoxFit.cover,
  );

  final mobileBackground = Image.asset(
    'assets/img/backgrounds/home_view_background.png',
    fit: BoxFit.cover,
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _animationFlowers = Tween<double>(
      begin: 0,
      end: 50,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.ease),
      ),
    );

    _animationShadow = Tween<double>(
      begin: 1,
      end: 0.5,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.ease),
      ),
    );

    _controller
      ..forward()
      ..repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    precacheImage(desktopBackground.image, context);
    precacheImage(tabletBackground.image, context);
    precacheImage(mobileBackground.image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => _buildMobile(size),
      tablet: (BuildContext context) => _buildTablet(size),
      desktop: (BuildContext context) => _buildDesktop(size),
    );
  }

  Widget _buildTablet(Size size) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: tabletBackground,
            ),
            Positioned(
              bottom: 80,
              right: -80,
              height: 66,
              child: Transform.scale(
                scale: _animationShadow.value,
                child: const Image(
                  image: AssetImage('assets/img/shadow.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              bottom: 85 + _animationFlowers.value,
              right: -60,
              height: 571,
              child: const Image(
                image: AssetImage('assets/img/flowers.png'),
                fit: BoxFit.fitHeight,
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildDesktop(Size size) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: desktopBackground,
            ),
            Positioned(
              bottom: 80,
              right: 50,
              height: 51,
              child: Transform.scale(
                scale: _animationShadow.value,
                child: const Image(
                  image: AssetImage('assets/img/shadow.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              bottom: 85 + _animationFlowers.value,
              right: 60,
              height: 442,
              child: const Image(
                image: AssetImage('assets/img/flowers.png'),
                fit: BoxFit.fitHeight,
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildMobile(Size size) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: mobileBackground,
            ),
            // Positioned(
            //   bottom: 80,
            //   right: -48,
            //   height: size.width * 0.11,
            //   child: Transform.scale(
            //     scale: _animationShadow.value,
            //     child: const Image(
            //       image: AssetImage('assets/img/shadow.png'),
            //       fit: BoxFit.fitHeight,
            //     ),
            //   ),
            // ),
            // Positioned(
            //   bottom: 85 + _animationFlowers.value,
            //   right: -48,
            //   height: size.height * 0.475,
            //   child: const Image(
            //     image: AssetImage('assets/img/flowers.png'),
            //     fit: BoxFit.fitHeight,
            //   ),
            // )
          ],
        );
      },
    );
  }
}
