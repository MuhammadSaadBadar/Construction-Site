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

  Widget _buildHeroSection() {
    return Container(
      height: 800,
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                const NavigationBar(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Crafting Excellence in Every Square Foot.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.1,
                            letterSpacing: -0.02,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Premium renovation and construction services for residential and commercial spaces. Engineered for legacy, built for today.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFE3BFB2),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 36),
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          alignment: WrapAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Scroll to contact section
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF95E14),
                                foregroundColor: const Color(0xFF4F1700),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text('Get a Free Quote'),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(
                                  color: Color(0xFFAA8A7E),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
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
    return Container(
      color: const Color(0xFF121414),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'The Architecture of Trust',
                      style: TextStyle(
                        color: Color(0xFFFFB59A),
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'For over two decades, SUFIAN GROUP has redefined the landscape of high-end construction and renovation. We merge uncompromising craftsmanship with reliable innovation to deliver spaces that are as structurally sound as they are visually breathtaking.',
                      style: TextStyle(
                        color: Color(0xFFE3BFB2),
                        fontSize: 18,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 24,
                      runSpacing: 16,
                      children: [
                        _statCard('20+', 'Years of Craftsmanship'),
                        _statCard('150+', 'Projects Completed'),
                      ],
                    ),
                  ],
                ),
              ),
              if (isWide) ...[
                const SizedBox(width: 32),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuAb-xlUz9d7o1nCM3Q9ABh_dBXG2P9YFvpGMYvZYjRUiXlVGUdt0vCcNvLya4bYITXDs_8dzCld3kS76j4O4JZOTqkgrw60w3CwZFNpHzMqR72qBdqLWsn3BPUVp3-lrMnrvvmrYaQSHYKOfsfLSNK0alYoRlB5HIiRMPw1J9BA98yupSByvBgScX438oGC596HYYfqgrkO1BFkpHRkTY67GiERzwD7FelYUSt1LOk_2gQjAIanOIWN8A',
                      height: 520,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildServicesSection() {
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
      height: 600,
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Our Services',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Precision execution across every phase of the build cycle.',
              style: TextStyle(color: Color(0xFFE3BFB2), fontSize: 18),
            ),
            const SizedBox(height: 32),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.05,
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
      color: const Color(0xFF121414),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Projects',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Showcase of our finest construction and renovation work.',
            style: TextStyle(color: Color(0xFFE3BFB2), fontSize: 18),
          ),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) => projects[index],
          ),
        ],
      ),
    );
  }

  Widget _buildProcessSection() {
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
      constraints: const BoxConstraints(minHeight: 600),
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(
          children: [
            const Text(
              'Our Process',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'A systematic approach to flawless delivery.',
              style: TextStyle(color: Color(0xFFE3BFB2), fontSize: 18),
            ),
            const SizedBox(height: 40),
            ...steps.map(
              (step) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: step,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      color: const Color(0xFF0D0E0F),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 1000;
          return isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Get Your Quote Today',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Transform your vision into reality. Reach out to our team of experts and let\'s discuss your next project. We\'re here to answer all your questions about construction, renovation, and design.',
                            style: TextStyle(
                              color: Color(0xFFE3BFB2),
                              fontSize: 16,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 32),
                          _buildContactForm(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          color: const Color(0xFF121414),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=500&h=600&fit=crop',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Get Your Quote Today',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Transform your vision into reality. Reach out to our team of experts and let\'s discuss your next project. We\'re here to answer all your questions about construction, renovation, and design.',
                      style: TextStyle(
                        color: Color(0xFFE3BFB2),
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildContactForm(),
                    const SizedBox(height: 32),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xFF121414),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
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
                );
        },
      ),
    );
  }

  // ✅ FIXED: Now accepts and uses controllers
  Widget _buildContactInput(
    String label,
    String hint,
    TextEditingController controller, {
    int minLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller, // ✅ Now connected!
          minLines: minLines,
          maxLines: minLines == 1 ? 1 : null,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF717171)),
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

  // ✅ FIXED: Now passes controllers and connects the send function
  Widget _buildContactForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactInput(
          'Your Name',
          'Enter your full name',
          _nameController,
        ),
        const SizedBox(height: 16),
        _buildContactInput(
          'Your Email',
          'Enter your email address',
          _emailController,
        ),
        const SizedBox(height: 16),
        _buildContactInput(
          'Your Question',
          'Tell us about your project',
          _messageController,
          minLines: 4,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _isSending
              ? null
              : _sendMessageToEmailJS, // ✅ Now connected!
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF95E14),
            foregroundColor: const Color(0xFF4F1700),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
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
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      color: const Color(0xFF0D0E0F),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isWide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SUFIAN GROUP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Premium construction & renovation\nsolutions for every project.',
                          style: TextStyle(
                            color: Color(0xFFBAB8B7),
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                    _footerLinks(['Residential', 'Commercial', 'Industrial']),
                    _footerLinks([
                      'Privacy Policy',
                      'Terms of Service',
                      'Contact',
                    ]),
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
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Premium construction & renovation solutions for every project.',
                      style: TextStyle(
                        color: Color(0xFFBAB8B7),
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _footerLinks(['Residential', 'Commercial', 'Industrial']),
                    const SizedBox(height: 16),
                    _footerLinks([
                      'Privacy Policy',
                      'Terms of Service',
                      'Contact',
                    ]),
                  ],
                ),
              const SizedBox(height: 48),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.white.withOpacity(0.1),
              ),
              const SizedBox(height: 24),
              Text(
                '© 2024 SUFIAN GROUP Construction Firm. All rights reserved.',
                style: TextStyle(color: Color(0xFF717171), fontSize: 12),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _statCard(String value, String label) {
    return Container(
      width: 180,
      padding: const EdgeInsets.only(left: 16),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Color(0xFFFFB59A), width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(color: Color(0xFFE3BFB2), fontSize: 14),
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
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                item,
                style: const TextStyle(color: Color(0xFFBAB8B7), fontSize: 14),
              ),
            ),
          )
          .toList(),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'SUFIAN GROUP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 32,
                      children: const [
                        Text(
                          'Projects',
                          style: TextStyle(
                            color: Color(0xFFE3BFB2),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Services',
                          style: TextStyle(
                            color: Color(0xFFE3BFB2),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Process',
                          style: TextStyle(
                            color: Color(0xFFE3BFB2),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'About',
                          style: TextStyle(
                            color: Color(0xFFE3BFB2),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFF95E14), width: 1.5),
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
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF121414),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFFFB59A), size: 40),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(color: Color(0xFFE3BFB2), height: 1.6),
          ),
        ],
      ),
    );
  }
}

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 72,
          height: 72,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF1E2020),
            borderRadius: BorderRadius.circular(36),
            border: Border.all(color: const Color(0xFFFFB59A).withOpacity(0.3)),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Color(0xFFFFB59A),
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(color: Color(0xFFE3BFB2), height: 1.6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.title,
    required this.category,
    required this.image,
  });

  final String title;
  final String category;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              const Color(0xFF000000).withOpacity(0.7),
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF95E14),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
