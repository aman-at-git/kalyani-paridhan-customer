part of '../home_page.dart';

class _CustomAppBar extends StatelessWidget {
  final VoidCallback onChatTap;
  final VoidCallback onSearchTap;
  final VoidCallback onNotificationTap;

  const _CustomAppBar({
    Key? key,
    required this.onChatTap,
    required this.onSearchTap,
    required this.onNotificationTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Positioned(
      height: 50,
      left: 0,
      right: 0,
      top: 0,
      child: CustomAppBar(
        context,
        title: 'Kalyani Paridhan',
        centerTitle: false,
        enableLeading: false,
        backgroundColor: theme.backgroundColor,
        actions: [
          IconButton(
            icon: const Icon(FeatherIcons.bell),
            color: theme.iconTheme.color,
            tooltip: 'Notifications',
            onPressed: onNotificationTap,
          ),
          IconButton(
            icon: const Icon(FeatherIcons.search),
            color: theme.iconTheme.color,
            tooltip: AppLocalizations.of(context)!.search,
            onPressed: onSearchTap,
          ),
        ],
      ),
    );
  }
}
