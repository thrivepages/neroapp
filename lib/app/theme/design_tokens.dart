
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'dart:math' as math;

Color colorFromHslString(String s) {
  final re = RegExp(r'hsl\((\d+(?:\.\d+)?)\s+(\d+(?:\.\d+)?)%\s+(\d+(?:\.\d+)?)%\)');
  final m = re.firstMatch(s.trim());
  if (m == null) return const Color(0xFF000000);
  final h = double.parse(m.group(1)!);
  final sPerc = double.parse(m.group(2)!) / 100.0;
  final l = double.parse(m.group(3)!) / 100.0;

  final c = (1 - (2 * l - 1).abs()) * sPerc;
  final x = c * (1 - ((h / 60.0) % 2 - 1).abs());
  final m0 = l - c / 2;
  double r=0,g=0,b=0;
  if (0 <= h && h < 60)   { r=c; g=x; b=0; }
  else if (60 <= h && h <120){ r=x; g=c; b=0; }
  else if (120<= h && h<180){ r=0; g=c; b=x; }
  else if (180<= h && h<240){ r=0; g=x; b=c; }
  else if (240<= h && h<300){ r=x; g=0; b=c; }
  else { r=c; g=0; b=x; }
  int to255(double v) => (math.max(0, math.min(1, v + m0)) * 255).round();
  return Color.fromARGB(255, to255(r), to255(g), to255(b));
}

double remOrCalcToPx(String v, {double base = 16}) {
  final trimmed = v.trim();
  if (trimmed.startsWith('calc(') && trimmed.endsWith(')')) {
    final expr = trimmed.substring(5, trimmed.length - 1);
    final m = RegExp(r'([0-9.]+)\s*rem\s*([+\-])\s*([0-9.]+)\s*px').firstMatch(expr);
    if (m != null) {
      final a = double.parse(m.group(1)!);
      final op = m.group(2)!;
      final b = double.parse(m.group(3)!);
      return op == '+' ? (a * base + b) : (a * base - b);
    }
  }
  final m = RegExp(r'([0-9.]+)\s*rem').firstMatch(trimmed);
  if (m != null) return double.parse(m.group(1)!) * base;
  final px = RegExp(r'([0-9.]+)\s*px').firstMatch(trimmed);
  if (px != null) return double.parse(px.group(1)!);
  return 12.0;
}

class DSColorsMode {
  final Map<String, String> map;
  DSColorsMode(this.map);
  Color getColor(String key) => colorFromHslString(map[key] ?? 'hsl(0 0% 0%)');
}

class DSChartsMode {
  final Map<String, String> map;
  DSChartsMode(this.map);
  List<Color> get palette => map.values.map(colorFromHslString).toList();
}

class DesignTokens {
  final DSColorsMode light;
  final DSColorsMode dark;
  final DSChartsMode chartsLight;
  final DSChartsMode chartsDark;
  final Map<String, String> typography;
  final Map<String, String> radii;

  DesignTokens({
    required this.light,
    required this.dark,
    required this.chartsLight,
    required this.chartsDark,
    required this.typography,
    required this.radii,
  });

  static Future<DesignTokens> load() async {
    final raw = await rootBundle.loadString('assets/design-system.json');
    final j = json.decode(raw) as Map<String, dynamic>;
    final colors = j['colors'] as Map<String, dynamic>;
    final charts = (colors['charts'] as Map<String, dynamic>);
    return DesignTokens(
      light: DSColorsMode(Map<String, String>.from(colors['light'] as Map)),
      dark:  DSColorsMode(Map<String, String>.from(colors['dark'] as Map)),
      chartsLight: DSChartsMode(Map<String, String>.from(charts['light'] as Map)),
      chartsDark:  DSChartsMode(Map<String, String>.from(charts['dark'] as Map)),
      typography: Map<String, String>.from(j['typography'] as Map),
      radii: Map<String, String>.from(j['radii'] as Map),
    );
  }
}
