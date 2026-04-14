import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myfolio_client/myfolio_client.dart';
import 'package:myfolio_flutter/utils/app_textstyle.dart';
import 'package:myfolio_flutter/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactTab extends StatefulWidget {
  final User? user;

  const ContactTab({super.key, this.user});

  @override
  State<ContactTab> createState() => _ContactTabState();
}

class _ContactTabState extends State<ContactTab> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) return;

    final recipientEmail = widget.user?.email ?? '';
    final subject = Uri.encodeComponent('Portfolio Contact from $name');
    final body = Uri.encodeComponent('From: $name ($email)\n\n$message');
    final mailtoUri = Uri.parse(
      'mailto:$recipientEmail?subject=$subject&body=$body',
    );

    if (await canLaunchUrl(mailtoUri)) {
      await launchUrl(mailtoUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: isMobile || isTablet
          ? _buildMobile(context)
          : _buildDesktop(context),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 4, child: _buildHeroPanel(context)),
        Expanded(flex: 6, child: _buildFormPanel(context)),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 360, child: _buildHeroPanel(context)),
          _buildFormPanel(context),
        ],
      ),
    );
  }

  Widget _buildHeroPanel(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final email = widget.user?.email ?? '';
    final location = widget.user?.location ?? '';

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A0A0A), Color(0xFF141420)],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Positioned.fill(
            child: Opacity(
              opacity: 0.25,
              child: Image.asset(
                'assets/images/profile_pic.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              ),
            ),
          ),
          // Dark overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF0A0A0A).withValues(alpha: 0.85),
                    const Color(0xFF0A0A0A).withValues(alpha: 0.98),
                  ],
                ),
              ),
            ),
          ),
          // Content
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Accent label
                  Row(
                    children: [
                      Container(width: 40, height: 1, color: primary),
                      const Gap(12),
                      Text(
                        'GET IN TOUCH',
                        style: AppTextStyle()
                            .smallBold(color: primary)
                            .copyWith(letterSpacing: 4, fontSize: 11),
                      ),
                    ],
                  ),
                  const Gap(24),

                  // Headline
                  RichText(
                    text: TextSpan(
                      style: AppTextStyle()
                          .heading(color: Colors.white)
                          .copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w300,
                            height: 1.3,
                          ),
                      children: const [
                        TextSpan(text: "Let's build\n"),
                        TextSpan(
                          text: 'meaningful',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: ' digital\nexperiences'),
                      ],
                    ),
                  ),
                  const Gap(24),

                  // Status badge
                  _PulsingStatusBadge(primary: primary),
                  const Gap(32),

                  // Contact info rows
                  if (email.isNotEmpty)
                    _buildHeroInfoRow(
                      icon: Icons.mail_outline_rounded,
                      text: email,
                      primary: primary,
                    ),
                  if (location.isNotEmpty) ...[
                    const Gap(16),
                    _buildHeroInfoRow(
                      icon: Icons.schedule_rounded,
                      text: location,
                      primary: primary,
                    ),
                  ],
                  const Gap(32),

                  // FAQ section
                  Text(
                    'FREQUENTLY ASKED',
                    style: AppTextStyle()
                        .smallBold(color: Colors.white38)
                        .copyWith(letterSpacing: 3, fontSize: 10),
                  ),
                  const Gap(16),
                  _buildFaqItem(
                    question: 'What is your typical project timeline?',
                    answer:
                        'Most medium-scale projects take between 4-8 weeks from discovery to launch.',
                  ),
                  _buildFaqItem(
                    question: 'Do you work with startups?',
                    answer:
                        'Yes, I specialize in MVP development and helping startups scale their engineering teams.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroInfoRow({
    required IconData icon,
    required String text,
    required Color primary,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: primary, size: 20),
        ),
        const Gap(14),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle()
                .medium(color: Colors.white60)
                .copyWith(fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }

  Widget _buildFaqItem({required String question, required String answer}) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: 12),
        collapsedIconColor: Colors.white30,
        iconColor: Colors.white54,
        title: Text(
          question,
          style: AppTextStyle()
              .small(color: Colors.white70)
              .copyWith(fontWeight: FontWeight.w500),
        ),
        children: [
          Text(
            answer,
            style: AppTextStyle()
                .small(color: Colors.white38)
                .copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildFormPanel(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: isDark ? Colors.transparent : colorScheme.surface,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 24 : 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section heading
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit_note_rounded,
                    color: colorScheme.primary,
                    size: 18,
                  ),
                ),
                const Gap(10),
                Text(
                  'Send a message',
                  style: AppTextStyle()
                      .heading(color: colorScheme.onSurface)
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const Gap(28),
            // Form fields
            _buildFormFields(context, colorScheme, isMobile: isMobile),
            const Gap(24),

            // Send button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _sendMessage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  shadowColor: colorScheme.primary.withValues(alpha: 0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Send Inquiry',
                      style: AppTextStyle()
                          .mediumBold(color: Colors.white)
                          .copyWith(fontSize: 15),
                    ),
                    const Gap(8),
                    const Icon(Icons.arrow_forward_rounded, size: 20),
                  ],
                ),
              ),
            ),
            const Gap(28),
            // Footer
            Center(
              child: Text(
                'BUILT WITH PRECISION  •  AVAILABLE GLOBALLY',
                style: AppTextStyle()
                    .small(color: colorScheme.onSurfaceVariant)
                    .copyWith(
                      fontSize: 9,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields(
    BuildContext context,
    ColorScheme colorScheme, {
    required bool isMobile,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : colorScheme.outline,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : colorScheme.outline,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
      ),
    );

    final textStyle = AppTextStyle().medium(color: colorScheme.onSurface);
    final hintStyle = AppTextStyle().medium(
      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
    );

    Widget nameField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel(context, 'Name'),
        const Gap(8),
        TextField(
          controller: _nameController,
          decoration: inputDecoration.copyWith(
            hintText: 'John Doe',
            hintStyle: hintStyle,
          ),
          style: textStyle,
        ),
      ],
    );

    Widget emailField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel(context, 'Email Address'),
        const Gap(8),
        TextField(
          controller: _emailController,
          decoration: inputDecoration.copyWith(
            hintText: 'john@example.com',
            hintStyle: hintStyle,
          ),
          keyboardType: TextInputType.emailAddress,
          style: textStyle,
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMobile) ...[
          nameField,
          const Gap(20),
          emailField,
        ] else
          Row(
            children: [
              Expanded(child: nameField),
              const Gap(20),
              Expanded(child: emailField),
            ],
          ),
        const Gap(20),
        _buildFieldLabel(context, 'Message'),
        const Gap(8),
        TextField(
          controller: _messageController,
          decoration: inputDecoration.copyWith(
            hintText: 'Tell me about your vision...',
            hintStyle: hintStyle,
          ),
          maxLines: 4,
          style: textStyle,
        ),
      ],
    );
  }

  Widget _buildFieldLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label.toUpperCase(),
        style: AppTextStyle()
            .smallBold(color: Theme.of(context).colorScheme.onSurfaceVariant)
            .copyWith(fontSize: 9, letterSpacing: 2.5),
      ),
    );
  }

  Widget _buildConnectCard(BuildContext context, ColorScheme colorScheme) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : colorScheme.outline,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's Connect",
                  style: AppTextStyle()
                      .heading(color: colorScheme.onSurface)
                      .copyWith(fontSize: 18),
                ),
                const Gap(6),
                Text(
                  'Prefer a face-to-face chat? Schedule a quick 15-minute discovery call.',
                  style: AppTextStyle()
                      .small(color: colorScheme.onSurfaceVariant)
                      .copyWith(height: 1.5),
                ),
              ],
            ),
          ),
          const Gap(16),
          ElevatedButton.icon(
            onPressed: () {
              final email = widget.user?.email ?? '';
              if (email.isNotEmpty) {
                launchUrl(
                  Uri.parse('mailto:$email?subject=Discovery%20Call%20Request'),
                );
              }
            },
            icon: Icon(
              Icons.calendar_today_rounded,
              size: 16,
              color: isDark ? Colors.black : Colors.white,
            ),
            label: Text(
              'Book a Call',
              style: AppTextStyle().smallBold(
                color: isDark ? Colors.black : Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? Colors.white : colorScheme.onSurface,
              foregroundColor: isDark ? colorScheme.onSurface : Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
//  Pulsing "Available" Status Badge
// ═══════════════════════════════════════════

class _PulsingStatusBadge extends StatefulWidget {
  final Color primary;
  const _PulsingStatusBadge({required this.primary});

  @override
  State<_PulsingStatusBadge> createState() => _PulsingStatusBadgeState();
}

class _PulsingStatusBadgeState extends State<_PulsingStatusBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 12,
            height: 12,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _PulsePainter(
                    color: widget.primary,
                    progress: _controller.value,
                  ),
                );
              },
            ),
          ),
          const Gap(12),
          Text(
            'Currently accepting new projects',
            style: AppTextStyle()
                .small(color: Colors.white70)
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _PulsePainter extends CustomPainter {
  final Color color;
  final double progress;

  _PulsePainter({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Outer ring that fades out
    final ringPaint = Paint()
      ..color = color.withValues(alpha: 1.0 - progress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, 6 + (12 * progress), ringPaint);

    // Inner dot that pulses in size
    final dotScale = 0.8 + 0.2 * (1.0 - (2 * (progress - 0.5)).abs());
    final dotPaint = Paint()..color = color;
    canvas.drawCircle(center, 4 * dotScale, dotPaint);
  }

  @override
  bool shouldRepaint(_PulsePainter old) =>
      old.progress != progress || old.color != color;
}
