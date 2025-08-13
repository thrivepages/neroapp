
import 'package:flutter/material.dart';
import 'design_tokens.dart';

ThemeData _themeFrom(DSColorsMode c, DesignTokens tokens, Brightness brightness) {
  final radiusLg = remOrCalcToPx(tokens.radii['lg'] ?? '0.8rem');
  final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLg));

  final cs = ColorScheme(
    brightness: brightness,
    primary: c.getColor('primary'),
    onPrimary: c.getColor('primary-foreground'),
    secondary: c.getColor('secondary'),
    onSecondary: c.getColor('secondary-foreground'),
    surface: c.getColor('card'),
    onSurface: c.getColor('card-foreground'),
    background: c.getColor('background'),
    onBackground: c.getColor('foreground'),
    error: c.getColor('destructive'),
    onError: c.getColor('destructive-foreground'),
  );

  final textThemeBase = brightness == Brightness.dark
      ? Typography.whiteMountainView
      : Typography.blackMountainView;

  // Default to "professional"; can swap to charming/silly/handwritten later
  final fontFamily = tokens.typography['professional'] ?? 'Roboto';

  return ThemeData(
    useMaterial3: true,
    colorScheme: cs,
    fontFamily: fontFamily,
    scaffoldBackgroundColor: c.getColor('background'),
    cardTheme: CardThemeData(surfaceTintColor: Colors.transparent, shape: shape),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(shape: shape),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(remOrCalcToPx(tokens.radii['md'] ?? '0.8rem')),
      ),
      filled: true,
      fillColor: c.getColor('input'),
    ),
    chipTheme: ChipThemeData(
      side: BorderSide(color: c.getColor('border')),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(remOrCalcToPx(tokens.radii['sm'] ?? '0.8rem')),
      ),
    ),
    textTheme: textThemeBase,
  );
}

class AppThemes {
  final ThemeData light;
  final ThemeData dark;
  final List<Color> chartsLight;
  final List<Color> chartsDark;

  AppThemes(this.light, this.dark, this.chartsLight, this.chartsDark);

  static Future<AppThemes> build() async {
    final t = await DesignTokens.load();
    return AppThemes(
      _themeFrom(t.light, t, Brightness.light),
      _themeFrom(t.dark,  t, Brightness.dark),
      t.chartsLight.palette,
      t.chartsDark.palette,
    );
  }
}
