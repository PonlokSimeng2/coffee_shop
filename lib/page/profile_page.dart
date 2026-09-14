import 'package:flutter/material.dart';

/// Standalone, UI-only Profile page — ported from the provided HTML/Tailwind
/// design. No backend/state-management dependencies; wire up your own data
/// and navigation where marked with TODO.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _autoReloadEnabled = true;

  void _openQrSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _QrCodeSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            _buildProfileHeaderCard(),
            const SizedBox(height: 16),
            _buildLoyaltyCard(),
            const SizedBox(height: 16),
            _buildDailyBrewsSection(),
            const SizedBox(height: 16),
            _buildDigitalPassCard(),
            const SizedBox(height: 16),
            _buildAccountOptionsList(),
            const SizedBox(height: 12),
            _buildFooterActions(),
          ],
        ),
      ),
    );
  }

  // ── App bar ────────────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background.withOpacity(0.85),
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            color: AppColors.onSurface,
            onPressed: () {
              // TODO: open notifications
            },
          ),
          Text(
            'Profile',
            style: TextStyle(
              color: AppColors.textLightPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }

  // ── Profile header card ──────────────────────────────────────────────
  Widget _buildProfileHeaderCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 96,
                height: 96,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuC9bJjwM27T6yGfcHNt5HgJuMq6piA3_AurSIgoMziM6TcKYbDT7YfEkl0AWIQF6LyQXO8vrRemAmLhgtoXNokg11Bwvrd_HnyjC83Gz10lp87g0VuV9_FInrTkfncnpojrIj43V7ySky4r4_FMXqqj1C6OsCQ_Htf8X-s73YIczCO7HSmA-3kjMAlAmaNevwMwg6k-vN6K54Rb-C7a--xPBa8SAeABEKPKVVTTcC73R6Fu0kKye_e7uw',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    // TODO: pick / update profile picture
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.edit, color: AppColors.primary, size: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Jane Doe',
                style: TextStyle(
                  color: AppColors.textLightPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.verified, color: AppColors.accent, size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.workspace_premium,
                  color: AppColors.onSecondaryContainer,
                  size: 15,
                ),
                const SizedBox(width: 4),
                Text(
                  'Gold Barista Club',
                  style: TextStyle(
                    color: AppColors.onSecondaryContainer,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'jane.doe@example.com',
            style: TextStyle(color: AppColors.textLightSecondary, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.calendar_today, size: 14, color: AppColors.outline),
              const SizedBox(width: 4),
              Text(
                'Member since Oct 2023',
                style: TextStyle(color: AppColors.outline, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Loyalty & rewards card ───────────────────────────────────────────
  Widget _buildLoyaltyCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ARTISAN LOYALTY',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '120',
                        style: TextStyle(
                          color: AppColors.textLightPrimary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '/ 200 pts',
                        style: TextStyle(
                          color: AppColors.textLightSecondary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.loyalty, color: AppColors.accent, size: 26),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: 0.6,
              minHeight: 10,
              backgroundColor: AppColors.surfaceContainer,
              valueColor: AlwaysStoppedAnimation(AppColors.accent),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.info_outline, size: 15, color: AppColors.accent),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '80 points to your next free handcrafted brew',
                  style: TextStyle(
                    color: AppColors.textLightSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStampCard(),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: redeem rewards flow
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.star, size: 20),
                    label: const Text(
                      'Redeem Rewards',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _openQrSheet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.qr_code_2, size: 22),
                  label: const Text(
                    'Scan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStampCard() {
    const totalStamps = 10;
    const filledStamps = 8;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Free Beverage Stamp Card',
                style: TextStyle(
                  color: AppColors.textLightPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$filledStamps of $totalStamps Stamped',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: totalStamps,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              final isFilled = index < filledStamps;
              final isRewardGoal = index == totalStamps - 1;
              return Container(
                decoration: BoxDecoration(
                  color: isRewardGoal
                      ? AppColors.secondaryContainer
                      : isFilled
                      ? AppColors.accent
                      : AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isRewardGoal ? Icons.redeem : Icons.local_cafe,
                  size: isFilled || isRewardGoal ? 20 : 18,
                  color: isRewardGoal
                      ? AppColors.onSecondaryContainer
                      : isFilled
                      ? AppColors.primary
                      : AppColors.outline,
                ),
              );
            },
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '2 more visits until any size handcrafted drink',
              style: TextStyle(
                color: AppColors.textLightSecondary,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── My Daily Brews carousel ──────────────────────────────────────────
  Widget _buildDailyBrewsSection() {
    final brews = [
      _Brew(
        name: 'Caramel Bliss',
        detail: 'Oat milk, extra shot, light ice',
        price: r'$5.25',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuB1LIDDgPE0XbWxb7OiKuRInygyCjFRGZ6iUh8DrH0C3D96_snaAsm1J4VEUXQ67ArRZ3_m2MY7hQkYMxJm2GgdKP3oEGNwLjHPsl7FbrcwDKScpomV-rzYOmHqLS5CMcSPZVHJd1LakiVRk5PuxcmxXJ6veFD9py3dHdDly2QX_h-90BdGOpDvZwRHbeqNqDUGmN8N3MBtTUiZ3kd9FacEMn3m4i73CUSyLusULRcmtR_UPqssKXJ2_g',
      ),
      _Brew(
        name: 'Matcha Latte',
        detail: 'Almond milk, half sweet',
        price: r'$4.75',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBd9TyFeZyNsy7LmJqHnEUY381UB2ptLXlilX-crMoF-qnJBJDWZp85n3syXMGtk5WOKg97q_VprUvz-gTudqcZiqTmk7hqebHnK3uC2AepgI5bvhFGksaR-PUCGKxKj7jj52ZL38VXzSIZlYpewmzR7Ek1WtyvyBMjR2ahTcMyrqQcZJVMAki1rMb1U1th-2eIUTrmirLspcDwDl5t2gkvqmNBp-6tzGWhGWYTw8n5q2mJv0uUUMt7zQ',
      ),
      _Brew(
        name: 'Butter Croissant',
        detail: 'Served warmed fresh',
        price: r'$3.50',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCPp0I6AH6lLQdZireyAMJMW6cm8qNUDmV2OIO4L6sovvYakTfkZRHj0S_n6-jNKwVt9q382gm5gW9ZcIbdfu0M38zCeC2hCnBUwLS_VJ2ObI_tcnGlh2LlZVVfW1VXvL3zIjQftwakY9dqeNKlnWl-Hr8lRhtNhXliZEgIzyGDnd6QLWBsy7tWYYJBo2vTeBkpPJW1UnRA4A7ohg1rhyqMlUPiaVyywdUI33zMFo_K7xU-j3mWtlQwCw',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Daily Brews',
                    style: TextStyle(
                      color: AppColors.textLightPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Fast 1-tap reorder from Jane's favorites",
                    style: TextStyle(
                      color: AppColors.textLightSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // TODO: customize daily brews
                },
                child: Text(
                  'Customize',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: brews.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => _buildBrewCard(brews[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildBrewCard(_Brew brew) {
    return Container(
      width: 256,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    brew.imageUrl,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brew.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.textLightPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        brew.detail,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.textLightSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        brew.price,
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 36,
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO: reorder this brew
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.surfaceContainerHigh,
                foregroundColor: AppColors.primary,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Reorder', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  // ── Digital pass card ─────────────────────────────────────────────────
  Widget _buildDigitalPassCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.contactless, color: AppColors.primary, size: 22),
                  const SizedBox(width: 6),
                  Text(
                    'Daily Grind Pass',
                    style: TextStyle(
                      color: AppColors.textLightPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.tertiaryFixed,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Active',
                  style: TextStyle(
                    color: AppColors.onTertiaryFixed,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stored Value',
                          style: TextStyle(
                            color: AppColors.primaryFixedDim,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          r'$24.50',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.coffee, color: AppColors.accent, size: 28),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '•••• •••• 8842',
                      style: TextStyle(
                        color: AppColors.primaryFixedDim,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 32,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: add funds
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: AppColors.primary,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.add_circle, size: 16),
                        label: const Text(
                          'Add Funds',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.credit_card,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visa ending in 1234',
                      style: TextStyle(
                        color: AppColors.textLightPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Apple Pay default backup',
                      style: TextStyle(
                        color: AppColors.textLightSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: manage payment methods
                },
                child: Text(
                  'Manage',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.autorenew, color: AppColors.accent, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auto-Reload (\$20 below \$10)',
                        style: TextStyle(
                          color: AppColors.textLightPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Never wait in line with low balance',
                        style: TextStyle(
                          color: AppColors.textLightSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _autoReloadEnabled,
                  onChanged: (value) =>
                      setState(() => _autoReloadEnabled = value),
                  activeColor: Colors.white,
                  activeTrackColor: AppColors.accent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Account options list ─────────────────────────────────────────────
  Widget _buildAccountOptionsList() {
    final items = [
      _AccountOption(
        icon: Icons.receipt_long,
        title: 'Past Orders & Receipts',
        subtitle: '18 lifetime café orders',
      ),
      _AccountOption(
        icon: Icons.storefront,
        title: 'Favorite Pick-Up Café',
        subtitle: 'The Daily Grind - 123 Coffee Bean Ln',
      ),
      _AccountOption(
        icon: Icons.tune,
        title: 'Dietary & Customization Defaults',
        subtitle: 'Oat & Almond Milk, 50% sweetness',
      ),
      _AccountOption(
        icon: Icons.alarm,
        title: 'Notifications & Brew Reminders',
        subtitle: 'Morning coffee chime at 7:30 AM',
      ),
      _AccountOption(
        icon: Icons.confirmation_number,
        title: 'Gift Cards & Promo Vouchers',
        subtitle: '1 voucher ready to apply',
        subtitleColor: AppColors.accent,
        iconBackground: AppColors.secondaryContainer,
        iconColor: AppColors.onSecondaryContainer,
      ),
      _AccountOption(
        icon: Icons.help_outline,
        title: 'App Settings & Support',
        subtitle: 'Privacy, security and live barista chat',
      ),
    ];

    return _Card(
      padding: EdgeInsets.zero,
      child: Column(
        children: items
            .map(
              (item) => InkWell(
                onTap: () {
                  // TODO: navigate to `${item.title}`
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color:
                              item.iconBackground ??
                              AppColors.surfaceContainerHigh,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item.icon,
                          size: 20,
                          color: item.iconColor ?? AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                color: AppColors.textLightPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              item.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color:
                                    item.subtitleColor ??
                                    AppColors.textLightSecondary,
                                fontSize: 12,
                                fontWeight: item.subtitleColor != null
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right, color: AppColors.outline),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // ── Footer actions ────────────────────────────────────────────────────
  Widget _buildFooterActions() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: log out
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.surfaceContainer,
              foregroundColor: AppColors.error,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.logout, size: 20),
            label: const Text(
              'Log Out',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'The Daily Grind v2.4.1 • Crafted with care',
          style: TextStyle(color: AppColors.outline, fontSize: 12),
        ),
      ],
    );
  }
}

// ============================================================================
// QR code bottom sheet
// ============================================================================
class _QrCodeSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardLight,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.outlineVariant,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Scan at Counter',
              style: TextStyle(
                color: AppColors.textLightPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Earn stars and charge your Daily Grind Pass automatically',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textLightSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.outlineVariant.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  // Simplified QR placeholder — swap in a real QR generator
                  // package (e.g. qr_flutter) for a scannable code.
                  Icon(Icons.qr_code_2, size: 180, color: AppColors.primary),
                  const SizedBox(height: 8),
                  Text(
                    'JD-9821-4402',
                    style: TextStyle(
                      color: AppColors.textLightSecondary,
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.brightness_high, size: 18, color: AppColors.accent),
                const SizedBox(width: 6),
                Text(
                  'Screen brightness maximized',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Shared card wrapper
// ============================================================================
class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _Card({required this.child, this.padding = const EdgeInsets.all(20)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ============================================================================
// Small data holders
// ============================================================================
class _Brew {
  final String name;
  final String detail;
  final String price;
  final String imageUrl;

  const _Brew({
    required this.name,
    required this.detail,
    required this.price,
    required this.imageUrl,
  });
}

class _AccountOption {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? subtitleColor;
  final Color? iconBackground;
  final Color? iconColor;

  const _AccountOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.subtitleColor,
    this.iconBackground,
    this.iconColor,
  });
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});
}

// ============================================================================
// Color palette — ported from the Tailwind config in the source design
// ============================================================================
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF321716);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF4A2C2A);
  static const Color primaryFixedDim = Color(0xFFEABCB8);

  static const Color accent = Color(0xFFC69F74);

  static const Color secondary = Color(0xFF785833);
  static const Color secondaryContainer = Color(0xFFFED2A4);
  static const Color onSecondaryContainer = Color(0xFF795934);

  static const Color tertiaryFixed = Color(0xFFCBE9D9);
  static const Color onTertiaryFixed = Color(0xFF052016);

  static const Color background = Color(0xFFFFF8F7);
  static const Color cardLight = Color(0xFFFFFFFF);

  static const Color surface = Color(0xFFFFF8F7);
  static const Color surfaceContainer = Color(0xFFFFE9E7);
  static const Color surfaceContainerLow = Color(0xFFFFF0EF);
  static const Color surfaceContainerHigh = Color(0xFFFFE1DF);
  static const Color surfaceContainerHighest = Color(0xFFFFDAD7);

  static const Color onSurface = Color(0xFF2A1615);
  static const Color onSurfaceVariant = Color(0xFF504443);

  static const Color outline = Color(0xFF827472);
  static const Color outlineVariant = Color(0xFFD4C3C1);

  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);

  static const Color textLightPrimary = Color(0xFF4A2C2A);
  static const Color textLightSecondary = Color(0xFF755957);
}
