import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myfolio_client/myfolio_client.dart';
import 'package:myfolio_flutter/utils/app_textstyle.dart';
import 'package:url_launcher/url_launcher.dart';

enum _CardAlignment { left, right, bottom }

class ProjectShowcase extends StatefulWidget {
  final Project project;
  final int index;

  const ProjectShowcase({
    super.key,
    required this.project,
    required this.index,
  });

  @override
  State<ProjectShowcase> createState() => _ProjectShowcaseState();
}

class _ProjectShowcaseState extends State<ProjectShowcase> {
  bool _isHovered = false;

  static const Map<String, String> _projectAssetMap = {
    'Market Intelligence Platform': 'assets/images/news.webp',
    'Freight & Logistics Suite': 'assets/images/logistic.webp',
    'HealthVitals Tracker': 'assets/images/health.webp',
    'Social Engagement Platform': 'assets/images/social.webp',
    'E-Commerce Marketplace': 'assets/images/shopping.webp',
  };

  String get _assetPath {
    return _projectAssetMap[widget.project.title] ??
        'assets/images/${widget.project.title.toLowerCase().replaceAll(' ', '_')}.webp';
  }

  _CardAlignment get _alignment {
    switch (widget.index % 3) {
      case 0:
        return _CardAlignment.left;
      case 1:
        return _CardAlignment.right;
      default:
        return _CardAlignment.bottom;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackgroundImage(),
          _buildGradientOverlay(),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned.fill(
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOut,
        child: Image.asset(
          _assetPath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildPlaceholder(),
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    switch (_alignment) {
      case _CardAlignment.left:
        return Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withValues(alpha: 0.85),
                  Colors.black.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        );
      case _CardAlignment.right:
        return Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Colors.black.withValues(alpha: 0.85),
                  Colors.black.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        );
      case _CardAlignment.bottom:
        return Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.9),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        );
    }
  }

  Widget _buildContent(BuildContext context) {
    final card = _buildGlassCard(context);

    switch (_alignment) {
      case _CardAlignment.left:
        return Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: card,
              ),
            ),
          ),
        );
      case _CardAlignment.right:
        return Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Align(
              alignment: Alignment.centerRight,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: card,
              ),
            ),
          ),
        );
      case _CardAlignment.bottom:
        return Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: card,
            ),
          ),
        );
    }
  }

  Widget _buildGlassCard(BuildContext context) {
    const accent = Color(0xFF00E5FF);
    final project = widget.project;

    final borderSide = _alignment == _CardAlignment.right
        ? const BorderDirectional(end: BorderSide(color: accent, width: 4))
        : _alignment == _CardAlignment.left
        ? const Border(left: BorderSide(color: accent, width: 4))
        : null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(16),
            border:
                borderSide ??
                Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category tag
              if (project.techStack != null && project.techStack!.isNotEmpty)
                Text(
                  project.techStack!.first.toUpperCase(),
                  style: AppTextStyle()
                      .smallBold(color: accent)
                      .copyWith(
                        letterSpacing: 3,
                        fontSize: 11,
                      ),
                ),
              const Gap(12),

              // Title
              Text(
                project.title,
                style: AppTextStyle()
                    .heading(color: Colors.white)
                    .copyWith(fontSize: 28, fontWeight: FontWeight.w800),
              ),
              const Gap(16),

              // Description as bullet points
              ..._buildDescriptionBullets(project.description, accent),
              const Gap(20),

              // Tech chips
              if (project.techStack != null && project.techStack!.isNotEmpty)
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: project.techStack!
                      .map((tech) => _GlassTechChip(tech: tech))
                      .toList(),
                ),
              const Gap(12),

              // View project link
              if (project.projectUrl != null && project.projectUrl!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextButton.icon(
                    onPressed: () => _launchUrl(project.projectUrl!),
                    icon: const Icon(
                      Icons.arrow_outward_rounded,
                      size: 18,
                      color: accent,
                    ),
                    label: Text(
                      'View Project',
                      style: AppTextStyle().mediumBold(color: accent),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDescriptionBullets(String description, Color accent) {
    final sentences = description
        .split(RegExp(r'[.•\n]+'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .take(4)
        .toList();

    if (sentences.isEmpty) return [];

    return sentences.map((sentence) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Icon(Icons.fiber_manual_record, color: accent, size: 8),
            ),
            const Gap(12),
            Expanded(
              child: Text(
                sentence,
                style: AppTextStyle()
                    .medium(color: Colors.white70)
                    .copyWith(height: 1.5),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFF1A1A2E),
      child: const Center(
        child: Icon(
          Icons.image_outlined,
          size: 80,
          color: Colors.white12,
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _GlassTechChip extends StatelessWidget {
  final String tech;
  const _GlassTechChip({required this.tech});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tech,
        style: AppTextStyle()
            .smallBold(color: Colors.white)
            .copyWith(fontSize: 11),
      ),
    );
  }
}
