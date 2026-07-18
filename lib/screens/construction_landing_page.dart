import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConstructionLandingPage extends StatefulWidget {
  const ConstructionLandingPage({super.key});

  @override
  State<ConstructionLandingPage> createState() =>
      _ConstructionLandingPageState();
}

class _ConstructionLandingPageState extends State<ConstructionLandingPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isSending = false;

  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _processKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _isDesktopLike(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessageToEmailJS() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email.')),
      );
      return;
    }

    setState(() => _isSending = true);
    try {
      const serviceId = 'service_0ad4xgj';
      const templateId = 'template_lswr46p';
      const publicKey = '_LKo4eXxtb3DpJvCt';

      final uri = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

      final response = await http.post(
        uri,
        headers: {
          'origin': 'https://localhost',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': publicKey,
          'template_params': {'name': name, 'email': email, 'message': message},
        }),
      );

      if (!mounted) return;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message sent successfully!')),
        );
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message. (${response.statusCode})'),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error sending message.')));
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121414),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            _buildAboutSection(),
            _buildServicesSection(),
            _buildProjectsSection(),
            _buildProcessSection(),
            _buildContactSection(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // Helper to check if screen is mobile
  bool _isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  bool _isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 900;
  }

  // IMPROVED: Better grid column calculation for different screen sizes
  int _getGridCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 1; // Mobile: 1 column
    if (width < 900) return 2; // Tablet: 2 columns
    if (width < 1200) return 3; // Small desktop: 3 columns
    return 4; // Large desktop: 4 columns
  }

  Widget _buildHeroSection() {
    final isMobile = _isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuD_kPNdyC37RGqvBty6Jmrl3BflSoi4vYOUEDVAlU8xEE7ZXWMN6xdMPz6B9aAqe1RhFqCHSKK4enZYJTLcZpj4-mF07ri0ihDMQr_xh3QjHr5SK0H_uMGCiQq5iS1YCronX-_5ahTZSzDIQrivfkuP_8z3rVE91hI--JZniXUNjjyhv31L8F9dX-q2lFo0ZucJJDTsbGzyXGg5HX3qOhjF7ISLFNOypgfZx9V5vUSHFvZjYLnhNtdRmg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(13, 14, 15, 0.8)),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 24,
              vertical: isMobile ? 8 : 12,
            ),
            child: Column(
              children: [
                NavigationBar(
                  onProjectsTap: () => _scrollToSection(_projectsKey),
                  onServicesTap: () => _scrollToSection(_servicesKey),
                  onProcessTap: () => _scrollToSection(_processKey),
                  onAboutTap: () => _scrollToSection(_aboutKey),
                  onContactTap: () => _scrollToSection(_contactKey),
                ),
                const SizedBox(height: 80),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 8 : 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'BUILD.',
                              style: TextStyle(
                                fontSize: isMobile ? 54 : 120,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                height: 0.9,
                                letterSpacing: -2.0,
                              ),
                            ),
                            Text(
                              'INNOVATION.',
                              style: TextStyle(
                                fontSize: isMobile ? 54 : 120,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFFE5C07B), // Rich gold/yellow color
                                height: 0.9,
                                letterSpacing: -2.0,
                              ),
                            ),
                            Text(
                              'EXCELLENCE.',
                              style: TextStyle(
                                fontSize: isMobile ? 54 : 120,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                height: 0.9,
                                letterSpacing: -2.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Premium renovation and construction services for residential and commercial spaces. Engineered for legacy, built for today.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 18,
                            color: const Color(0xFFE3BFB2),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // IMPROVED: Using Column for mobile instead of Wrap for better control
                        if (isMobile)
                          Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFE5C07B),
                                    foregroundColor: const Color(0xFF111111),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 18,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('Get a Free Quote'),
                                      SizedBox(width: 8),
                                      Icon(Icons.arrow_outward, size: 18),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    side: const BorderSide(
                                      color: Colors.white70,
                                      width: 1.5,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 18,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  child: const Text('View Our Projects'),
                                ),
                              ),
                            ],
                          )
                        else
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            alignment: WrapAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE5C07B),
                                  foregroundColor: const Color(0xFF111111),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 36,
                                    vertical: 22,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text('Get a Free Quote'),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_outward, size: 20),
                                  ],
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(
                                    color: Colors.white70,
                                    width: 1.5,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 36,
                                    vertical: 22,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                child: const Text('View Our Projects'),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    final isMobile = _isMobile(context);
    final isTablet = _isTablet(context);

    return Container(
      key: _aboutKey,
      color: const Color(0xFF121414),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The Architecture of Trust',
            style: TextStyle(
              color: const Color(0xFFFFB59A),
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'For over two decades, SUFIAN GROUP has redefined the landscape of high-end construction and renovation. We merge uncompromising craftsmanship with reliable innovation to deliver spaces that are as structurally sound as they are visually breathtaking.',
            style: TextStyle(
              color: const Color(0xFFE3BFB2),
              fontSize: isMobile ? 14 : 18,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          // IMPROVED: Better stat cards layout for mobile
          if (isMobile)
            Column(
              children: [
                _statCard('20+', 'Years of Craftsmanship'),
                const SizedBox(height: 16),
                _statCard('150+', 'Projects Completed'),
              ],
            )
          else
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _statCard('20+', 'Years of Craftsmanship'),
                _statCard('150+', 'Projects Completed'),
              ],
            ),
          if (!isMobile) ...[
            const SizedBox(height: 32),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAb-xlUz9d7o1nCM3Q9ABh_dBXG2P9YFvpGMYvZYjRUiXlVGUdt0vCcNvLya4bYITXDs_8dzCld3kS76j4O4JZOTqkgrw60w3CwZFNpHzMqR72qBdqLWsn3BPUVp3-lrMnrvvmrYaQSHYKOfsfLSNK0alYoRlB5HIiRMPw1J9BA98yupSByvBgScX438oGC596HYYfqgrkO1BFkpHRkTY67GiERzwD7FelYUSt1LOk_2gQjAIanOIWN8A',
                height: isTablet ? 300 : 400,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    final isMobile = _isMobile(context);
    final gridCount = _getGridCrossAxisCount(context);

    final services = [
      _ServiceCard(
        icon: Icons.cleaning_services,
        title: 'Strip-Out Services',
        description:
            'Efficient and clean removals, preparing spaces for complete transformation without compromising structural integrity.',
      ),
      _ServiceCard(
        icon: Icons.architecture,
        title: 'Detailed Renovation',
        description:
            'Breath-taking transformations focusing on high-fidelity details and premium material integration.',
      ),
      _ServiceCard(
        icon: Icons.chair,
        title: 'Interior Fit-Out',
        description:
            'Bespoke aesthetics tailored to luxury residential environments, emphasizing comfort and sophisticated design.',
      ),
      _ServiceCard(
        icon: Icons.corporate_fare,
        title: 'Commercial Fit-Out',
        description:
            'Productivity-driven spaces engineered for modern enterprises, blending functionality with corporate identity.',
      ),
    ];

    return Container(
      key: _servicesKey,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/our_services.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0D0E0F).withOpacity(0.6),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 24,
          vertical: isMobile ? 40 : 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Services',
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Precision execution across every phase of the build cycle.',
              style: TextStyle(
                color: const Color(0xFFE3BFB2),
                fontSize: isMobile ? 14 : 18,
              ),
            ),
            const SizedBox(height: 24),
            // IMPROVED: Better aspect ratio for mobile to prevent thin columns
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                // IMPROVED: Adjusted aspect ratio - more square on mobile, wider on desktop
                childAspectRatio: isMobile
                    ? 1.0 // Square cards on mobile
                    : gridCount == 2
                    ? 1.15
                    : 1.05,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) => services[index],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsSection() {
    final isMobile = _isMobile(context);
    final gridCount = _getGridCrossAxisCount(context);

    final projects = [
      _ProjectCard(
        title: 'Luxury Residential Renovation',
        category: 'Residential',
        image:
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&h=300&fit=crop',
      ),
      _ProjectCard(
        title: 'Corporate Office Transformation',
        category: 'Commercial',
        image:
            'https://images.unsplash.com/photo-1497366216548-495f67f42424?w=400&h=300&fit=crop',
      ),
      _ProjectCard(
        title: 'Modern Penthouse Design',
        category: 'Residential',
        image:
            'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400&h=300&fit=crop',
      ),
      _ProjectCard(
        title: 'Industrial Warehouse Conversion',
        category: 'Commercial',
        image:
            'https://images.unsplash.com/photo-1552321554-5fefe8c9ef14?w=400&h=300&fit=crop',
      ),
    ];

    return Container(
      key: _projectsKey,
      color: const Color(0xFF121414),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Projects',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Showcase of our finest construction and renovation work.',
            style: TextStyle(
              color: const Color(0xFFE3BFB2),
              fontSize: isMobile ? 14 : 18,
            ),
          ),
          const SizedBox(height: 24),
          // IMPROVED: Better aspect ratio and layout for project cards
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              // IMPROVED: Landscape aspect ratio for project cards, more square on mobile
              childAspectRatio: isMobile
                  ? 1.2 // 6:5 ratio on mobile - wider than tall
                  : gridCount == 2
                  ? 1.4
                  : 1.0,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) => projects[index],
          ),
        ],
      ),
    );
  }

  Widget _buildProcessSection() {
    final isMobile = _isMobile(context);

    final steps = [
      _ProcessStep(
        number: '01',
        title: 'Consultation',
        description:
            'Initial site assessment and requirement gathering to align vision with structural feasibility.',
      ),
      _ProcessStep(
        number: '02',
        title: 'Planning & Design',
        description:
            'Meticulous blueprint generation, material selection, and timeline establishment.',
      ),
      _ProcessStep(
        number: '03',
        title: 'Construction',
        description:
            'Execution by master craftsmen with rigorous quality control at every milestone.',
      ),
      _ProcessStep(
        number: '04',
        title: 'Delivery',
        description:
            'Final walkthrough, comprehensive site cleanup, and handover of your pristine new space.',
      ),
    ];

    return Container(
      key: _processKey,
      constraints: BoxConstraints(minHeight: isMobile ? 400 : 600),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/our_projects.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF121414).withOpacity(0.7),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 24,
          vertical: isMobile ? 40 : 80,
        ),
        child: Column(
          children: [
            Text(
              'Our Process',
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'A systematic approach to flawless delivery.',
              style: TextStyle(
                color: const Color(0xFFE3BFB2),
                fontSize: isMobile ? 14 : 18,
              ),
            ),
            const SizedBox(height: 24),
            ...steps.map(
              (step) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: step,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    final isMobile = _isMobile(context);

    return Container(
      key: _contactKey,
      color: const Color(0xFF0D0E0F),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Get Your Quote Today',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Transform your vision into reality. Reach out to our team of experts and let\'s discuss your next project. We\'re here to answer all your questions about construction, renovation, and design.',
            style: TextStyle(
              color: const Color(0xFFE3BFB2),
              fontSize: isMobile ? 14 : 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          _buildContactForm(),
          if (!isMobile) ...[
            const SizedBox(height: 32),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF121414),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=500&h=600&fit=crop',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContactInput(
    String label,
    String hint,
    TextEditingController controller, {
    int minLines = 1,
  }) {
    final isMobile = _isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 13 : 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          minLines: minLines,
          maxLines: minLines == 1 ? 1 : null,
          style: TextStyle(color: Colors.white, fontSize: isMobile ? 14 : 16),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: const Color(0xFF717171),
              fontSize: isMobile ? 13 : 14,
            ),
            filled: true,
            fillColor: const Color(0xFF1E2020),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF343535)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFF343535)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFFFB59A)),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildContactForm() {
    final isMobile = _isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactInput(
          'Your Name',
          'Enter your full name',
          _nameController,
        ),
        const SizedBox(height: 14),
        _buildContactInput(
          'Your Email',
          'Enter your email address',
          _emailController,
        ),
        const SizedBox(height: 14),
        _buildContactInput(
          'Your Question',
          'Tell us about your project',
          _messageController,
          minLines: 4,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: isMobile ? double.infinity : null,
          child: ElevatedButton(
            onPressed: _isSending ? null : _sendMessageToEmailJS,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF95E14),
              foregroundColor: const Color(0xFF4F1700),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 0 : 32,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              textStyle: TextStyle(fontSize: isMobile ? 14 : 16),
              minimumSize: isMobile ? const Size(double.infinity, 0) : null,
            ),
            child: _isSending
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF4F1700),
                    ),
                  )
                : const Text('Send Message'),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    final isMobile = _isMobile(context);

    return Container(
      color: const Color(0xFF0D0E0F),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SUFIAN GROUP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Premium construction & renovation\nsolutions for every project.',
                        style: TextStyle(
                          color: Color(0xFFBAB8B7),
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                _footerLinks(['Residential', 'Commercial', 'Industrial']),
                _footerLinks(['Privacy Policy', 'Terms of Service', 'Contact']),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SUFIAN GROUP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Premium construction & renovation solutions for every project.',
                  style: TextStyle(
                    color: Color(0xFFBAB8B7),
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                _footerLinks(['Residential', 'Commercial', 'Industrial']),
                const SizedBox(height: 12),
                _footerLinks(['Privacy Policy', 'Terms of Service', 'Contact']),
              ],
            ),
          const SizedBox(height: 32),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.white.withOpacity(0.1),
          ),
          const SizedBox(height: 16),
          Text(
            '© 2024 SUFIAN GROUP Construction Firm. All rights reserved.',
            style: TextStyle(
              color: const Color(0xFF717171),
              fontSize: isMobile ? 11 : 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label) {
    final isMobile = _isMobile(context);

    return Container(
      width: isMobile ? double.infinity : 180,
      padding: const EdgeInsets.only(left: 14),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Color(0xFFFFB59A), width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFFE3BFB2),
              fontSize: isMobile ? 12 : 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerLinks(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                item,
                style: const TextStyle(color: Color(0xFFBAB8B7), fontSize: 13),
              ),
            ),
          )
          .toList(),
    );
  }
}

// IMPROVED: Better Navigation Bar with proper hamburger menu
class NavigationBar extends StatefulWidget {
  final VoidCallback? onProjectsTap;
  final VoidCallback? onServicesTap;
  final VoidCallback? onProcessTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onContactTap;

  const NavigationBar({
    super.key,
    this.onProjectsTap,
    this.onServicesTap,
    this.onProcessTap,
    this.onAboutTap,
    this.onContactTap,
  });

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      // IMPROVED: Added container with padding for better mobile navigation
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'SUFIAN GROUP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              if (isMobile)
                IconButton(
                  icon: Icon(
                    _isMenuOpen ? Icons.close : Icons.menu,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    setState(() {
                      _isMenuOpen = !_isMenuOpen;
                    });
                  },
                ),
              if (!isMobile)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NavLink('Projects', onTap: widget.onProjectsTap),
                        NavLink('Services', onTap: widget.onServicesTap),
                        NavLink('Process', onTap: widget.onProcessTap),
                        NavLink('About', onTap: widget.onAboutTap),
                      ],
                    ),
                  ),
                ),
              if (!isMobile)
                InkWell(
                  onTap: widget.onContactTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFF95E14),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Contact Us',
                      style: TextStyle(
                        color: Color(0xFFF95E14),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // IMPROVED: Animated mobile menu with better styling
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isMobile && _isMenuOpen ? 280 : 0,
            curve: Curves.easeInOut,
            child: SingleChildScrollView(
              child: isMobile && _isMenuOpen
                  ? Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1C1C),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildMobileNavItem('Projects', widget.onProjectsTap),
                          _buildMobileNavItem('Services', widget.onServicesTap),
                          _buildMobileNavItem('Process', widget.onProcessTap),
                          _buildMobileNavItem('About', widget.onAboutTap),
                          const SizedBox(height: 16),
                          InkWell(
                            onTap: () {
                              setState(() => _isMenuOpen = false);
                              if (widget.onContactTap != null)
                                widget.onContactTap!();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFF95E14),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Contact Us',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFF95E14),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  // IMPROVED: Better mobile nav item with tap effect
  Widget _buildMobileNavItem(String title, VoidCallback? onTap) {
    return InkWell(
      onTap: () {
        setState(() {
          _isMenuOpen = false;
        });
        if (onTap != null) onTap();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xFFE3BFB2),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class NavLink extends StatelessWidget {
  final String title;
  final bool isMobile;
  final VoidCallback? onTap;

  const NavLink(this.title, {super.key, this.isMobile = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 12 : 0,
          horizontal: isMobile ? 8 : 12,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: const Color(0xFFE3BFB2),
            fontSize: isMobile ? 16 : 14,
            fontWeight: isMobile ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// IMPROVED: Better ServiceCard with responsive padding
class _ServiceCard extends StatefulWidget {
  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width < 900;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(
          isMobile
              ? 20
              : isTablet
              ? 24
              : 28,
        ),
        decoration: BoxDecoration(
          color: _isHovered ? const Color(0xFF1E2020) : const Color(0xFF121414),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? const Color(0xFFFFB59A).withOpacity(0.5)
                : Colors.white.withOpacity(0.08),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: const Color(0xFFFFB59A).withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: const Color(0xFFFFB59A),
              size: isMobile ? 36 : 40,
            ),
            SizedBox(height: isMobile ? 16 : 20),
            Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 18 : 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: isMobile ? 10 : 12),
            Expanded(
              child: Text(
                widget.description,
                style: TextStyle(
                  color: const Color(0xFFE3BFB2),
                  fontSize: isMobile ? 13 : 14,
                  height: 1.6,
                ),
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// IMPROVED: Better ProcessStep with proper alignment
class _ProcessStep extends StatelessWidget {
  const _ProcessStep({
    required this.number,
    required this.title,
    required this.description,
  });

  final String number;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: isMobile ? 56 : 72,
            height: isMobile ? 56 : 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2020),
              borderRadius: BorderRadius.circular(isMobile ? 28 : 36),
              border: Border.all(
                color: const Color(0xFFFFB59A).withOpacity(0.3),
              ),
            ),
            child: Text(
              number,
              style: TextStyle(
                color: const Color(0xFFFFB59A),
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: isMobile ? 16 : 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 18 : 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: isMobile ? 6 : 8),
                Text(
                  description,
                  style: TextStyle(
                    color: const Color(0xFFE3BFB2),
                    fontSize: isMobile ? 14 : 15,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// IMPROVED: Better ProjectCard with minimum height
class _ProjectCard extends StatefulWidget {
  const _ProjectCard({
    required this.title,
    required this.category,
    required this.image,
  });

  final String title;
  final String category;
  final String image;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        constraints: BoxConstraints(minHeight: isMobile ? 200 : 250),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? const Color(0xFFF95E14).withOpacity(0.8)
                : Colors.white.withOpacity(0.1),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: const Color(0xFFF95E14).withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ]
              : [],
          image: DecorationImage(
            image: NetworkImage(widget.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                const Color(0xFF000000).withOpacity(_isHovered ? 0.9 : 0.7),
              ],
            ),
          ),
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF95E14),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.category,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 11 : 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 8 : 10),
              AnimatedPadding(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.only(bottom: _isHovered ? 8.0 : 0.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 15 : 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
