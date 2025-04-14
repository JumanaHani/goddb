import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// The base class for our colors scheme
/// Make sure that any color's set you need is implement [AppColors]
/// We are going to use this to facilitate the implementation of multiple display mode(light, dark, etc...)
abstract class AppColors {
  Color get blue40;
  Color get blue50;
  Color get blue60;
  Color get blueOpacity15;
  Color get green40;
  Color get green50;
  Color get green60;
  Color get greenOpacity15;
  Color get red40;
  Color get red50;
  Color get red60;
  Color get redOpacity15;
  Color get yellow40;
  Color get yellow50;
  Color get yellow60;
  Color get yellowOpacity15;
  Color get neutrals00;
  Color get neutrals10;
  Color get neutrals20;
  Color get neutrals30;
  Color get neutrals40;
  Color get neutrals50;
  Color get neutrals60;
  Color get neutrals70;
  Color get neutrals80;
  Color get neutrals90;
  Color get neutrals95;
  Color get neutrals100;
  Color get bOpacity10;
  Color get bOpacity60;
  Color get wOpacity60;
  Color get wOpacity40;
}


/// [LightAppColors] serves the light display mode
@Singleton(as: AppColors)
class LightAppColors implements AppColors {

  /// Blue set
  @override
  Color get blue40 => const Color(0xff0485A8);

  @override
  Color get blue50 => const Color(0xff05A7D4);

  @override
  Color get blue60 => const Color(0xffb4e8fa);

  @override
  Color get blueOpacity15 => blue60.withOpacity(.15);


  /// Green set
  @override
  Color get green40 => const Color(0xff068D72);

  @override
  Color get green50 => const Color(0xff00B18F);

  @override
  Color get green60 => const Color(0xff0DCAA4);

  @override
  Color get greenOpacity15 => green60.withOpacity(.15);


  /// Red set
  @override
  Color get red40 => const Color(0xffD03D04);

  @override
  Color get red50 => const Color(0xffFF5620);

  @override
  Color get red60 => const Color(0xffFE805D);

  @override
  Color get redOpacity15 => red60.withOpacity(.15);


  /// Yellow set
  @override
  Color get yellow40 => const Color(0xff614A02);

  @override
  Color get yellow50 => const Color(0xffD2A300);

  @override
  Color get yellow60 => const Color(0xffFFCC43);

  @override
  Color get yellowOpacity15 => yellow50.withOpacity(.15);

  /// Neutrals set
  @override
  Color get neutrals00 => const Color(0xff000000);

  @override
  Color get neutrals10 => const Color(0xff071522);

  @override
  Color get neutrals20 => const Color(0xff0F2D47);

  @override
  Color get neutrals30 => const Color(0xff264661);

  @override
  Color get neutrals40 => const Color(0xff486D8D);

  @override
  Color get neutrals50 =>  const Color(0xff6C92B1);

  @override
  Color get neutrals60 => const Color(0xffA8C5DF);

  @override
  Color get neutrals70 => const Color(0xffC5DAEB);

  @override
  Color get neutrals80 => const Color(0xffD1E1EE);

  @override
  Color get neutrals90 => const Color(0xffDCE8F2);

  @override
  Color get neutrals95 => const Color(0xffEEF5FB);

  @override
  Color get neutrals100 => const Color(0xffFFFFFF);

  @override
  Color get bOpacity10 => neutrals20.withOpacity(.10);

  @override
  Color get bOpacity60 => neutrals20.withOpacity(.60);

  @override
  Color get wOpacity60 => neutrals100.withOpacity(.60);

  @override
  Color get wOpacity40 => neutrals100.withOpacity(.40);
}