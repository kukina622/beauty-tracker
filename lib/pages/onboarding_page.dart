import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OnboardingData {
  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.description,
  });
  final String title;
  final String subtitle;
  final String description;
}

@RoutePage()
class OnboardingPage extends HookWidget {
  OnboardingPage({super.key});

  final List<OnboardingData> items = [
    OnboardingData(
      title: '不再忘記保養品的有效期限',
      subtitle: '所有美妝品，一站式管理',
      description: '這款 App 幫你輕鬆記錄所有化妝品與保養品的到期日，避免過期使用，守護肌膚健康。',
    ),
    OnboardingData(
      title: '到期提醒，不錯過每一次使用',
      subtitle: '貼心通知，讓你用得剛剛好',
      description: '我們會在產品即將到期前主動提醒你，確保你能在最佳時機使用每一項美妝品，不浪費每一分錢。',
    ),
    OnboardingData(
      title: '井然有序的收藏管理',
      subtitle: '分類、管理，輕鬆又方便',
      description: '依照品項、品牌或到期日整理你的美妝收藏，從此告別雜亂，找到想用的產品更快速。',
    ),
  ];

  Widget _buildPageViewItem(BuildContext context, OnboardingData item) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              color: const Color(0xFFFFB6B9).withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.spa_outlined,
                size: 120,
                color: const Color(0xFFFF9A9E),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            item.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            item.subtitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFFFF9A9E),
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            item.description,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void toLoginPage(BuildContext context) {
    AutoRouter.of(context).replacePath('/login');
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageViewController = usePageController();
    final ValueNotifier<int> currentItem = useState(0);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageViewController,
                itemCount: items.length,
                onPageChanged: (page) {
                  currentItem.value = page;
                },
                itemBuilder: (context, index) {
                  return _buildPageViewItem(context, items[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      items.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: currentItem.value == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: currentItem.value == index
                              ? const Color(0xFFFF9A9E)
                              : const Color(0xFFE5E0DC),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => toLoginPage(context),
                        child: const Text('跳過'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (currentItem.value < items.length - 1) {
                            pageViewController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            toLoginPage(context);
                          }
                        },
                        child: Text(currentItem.value < items.length - 1 ? '下一步' : '開始'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
