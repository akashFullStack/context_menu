import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_context_menu/app/modules/home/widgets/box_context_menu.dart';
import 'package:smart_context_menu/app/modules/home/widgets/rectangle_area.dart';
import 'package:smart_context_menu/theme/app_theme_data.dart';
import 'package:smart_context_menu/widgets/context_menu.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum MenuPosition { topLeft, topRight, bottomLeft, bottomRight }

class _HomeViewState extends State<HomeView> {
  Set<MenuPosition> openMenus = {};

  void toggleMenu(MenuPosition position) {
    setState(() {
      if (openMenus.contains(position)) {
        openMenus.remove(position);
      } else {
        openMenus.add(position);
      }
    });
  }

  bool isMenuOpen(MenuPosition position) {
    return openMenus.contains(position);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double size = constraints.biggest.shortestSide / 5;
        final bool isCompact = constraints.maxWidth < 600;

        if (isCompact) {
          return Scaffold(
            backgroundColor: const Color(0xFFFBF5F7),
            body: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                buildAdaptiveBox(MenuPosition.topLeft, "Top left", AppThemeData.yellow, size),
                const SizedBox(height: 16),
                buildAdaptiveBox(MenuPosition.topRight, "Top right", AppThemeData.green, size),
                const SizedBox(height: 16),
                buildAdaptiveBox(MenuPosition.bottomLeft, "Bottom left", AppThemeData.purple, size),
                const SizedBox(height: 16),
                buildAdaptiveBox(MenuPosition.bottomRight, "Bottom right", AppThemeData.blue, size),
              ],
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFFFBF5F7),
          body: Stack(
            children: [
              Positioned(left: constraints.maxWidth / 6, top: constraints.maxHeight / 6, child: _buildBox(MenuPosition.topLeft, "Top left", AppThemeData.yellow, size, true)),
              Positioned(right: constraints.maxWidth / 6, top: constraints.maxHeight / 6, child: _buildBox(MenuPosition.topRight, "Top right", AppThemeData.green, size, false)),
              Positioned(left: constraints.maxWidth / 6, bottom: constraints.maxHeight / 6, child: _buildBox(MenuPosition.bottomLeft, "Bottom left", AppThemeData.purple, size, true)),
              Positioned(right: constraints.maxWidth / 6, bottom: constraints.maxHeight / 6, child: _buildBox(MenuPosition.bottomRight, "Bottom right", AppThemeData.blue, size, false)),
            ],
          ),
        );
      },
    );
  }

  /// 2×2 Grid boxes builder
  Widget _buildBox(MenuPosition position, String label, Color color, double size, bool isRightSide) {
    final double menuWidth = 170;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        final showMenu = isMenuOpen(position);

        // Check horizontal overflow
        bool shouldShowLeft = false;
        double rightEdge = size + 8 + menuWidth;
        if (rightEdge > screenWidth / 2) {
          shouldShowLeft = true;
        }

        return Stack(
          clipBehavior: Clip.none,
          children: [
            BoxWithContextMenu(onRightClick: () => toggleMenu(position), child: RectangleArea(label: label, color: color, size: size)),
            if (showMenu)
              Positioned(
                left: shouldShowLeft ? null : size + 8,
                right: shouldShowLeft ? size + 8 : null,
                top: 0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: menuWidth,
                    maxHeight: screenHeight - 16,
                  ),
                  child: ContextMenu(onClose: () => toggleMenu(position)),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buildAdaptiveBox(MenuPosition position, String label, Color color, double size) {
    final double menuWidth = 160;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        final showMenu = isMenuOpen(position);

        bool shouldShowLeft = false;
        double rightEdge = size + 8 + menuWidth;
        if (rightEdge > screenWidth / 2) {
          shouldShowLeft = true;
        }

        return Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              BoxWithContextMenu(onRightClick: () => toggleMenu(position), child: RectangleArea(label: label, color: color, size: size)),
              if (showMenu)
                Positioned(
                  left: shouldShowLeft ? null : size + 8,
                  right: shouldShowLeft ? size + 8 : null,
                  top: 0,
                  child: ConstrainedBox(constraints: BoxConstraints(maxWidth: menuWidth, maxHeight: screenHeight - 16), child: ContextMenu(onClose: () => toggleMenu(position))),
                ),
            ],
          ),
        );
      },
    );
  }
}
