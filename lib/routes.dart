import 'package:shecker_partners/pages/ai/ai_page.dart';
import 'package:shecker_partners/pages/chat/chat_page.dart';
import 'package:shecker_partners/pages/chatgpt/chatgpt_page.dart';
import 'package:shecker_partners/pages/dictionary/dictionary_page.dart';
import 'package:shecker_partners/pages/scrapy/scrapy_page.dart';
import 'package:shecker_partners/pages/table/contacts_page.dart';
import 'package:shecker_partners/pages/tools/tools_page.dart';
import 'package:shecker_partners/provider/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:shecker_partners/pages/alerts/alert_page.dart';
import 'package:shecker_partners/pages/button/button_page.dart';
import 'package:shecker_partners/pages/form/form_elements_page.dart';
import 'package:shecker_partners/pages/form/form_layout_page.dart';
import 'package:shecker_partners/pages/kanban/kanban_page.dart';
import 'package:shecker_partners/pages/list/list_page.dart';
import 'package:shecker_partners/pages/auth/sign_in/sign_in_page.dart';
import 'package:shecker_partners/pages/auth/sign_up/sign_up_page.dart';
import 'package:shecker_partners/pages/calendar/calendar_page.dart';
import 'package:shecker_partners/pages/chart/chart_page.dart';
import 'package:shecker_partners/pages/crm/crm_page.dart';
import 'package:shecker_partners/pages/dashboard/ecommerce_page.dart';
import 'package:shecker_partners/pages/inbox/index.dart';
import 'package:shecker_partners/pages/invoice/invoice_page.dart';
import 'package:shecker_partners/pages/marketing/marketing_page.dart';
import 'package:shecker_partners/pages/profile/profile_page.dart';
import 'package:shecker_partners/pages/resetpwd/reset_pwd_page.dart';
import 'package:shecker_partners/pages/setting/settings_page.dart';
import 'package:shecker_partners/pages/table/tables_page.dart';
import 'package:provider/provider.dart';

typedef PathWidgetBuilder = Widget Function(BuildContext, String?);

final List<Map<String, Object>> MAIN_PAGES = [
  {'routerPath': '/', 'widget': const MainPage()},
  {'routerPath': '/marketing', 'widget': const MarketingPage()},
  {'routerPath': '/crm', 'widget': const CrmPage()},
  {'routerPath': '/calendar', 'widget': const CalendarPage()},
  {'routerPath': '/profile', 'widget': const ProfilePage()},
  {'routerPath': '/list', 'widget': const ListPage()},
  {'routerPath': '/kanban', 'widget': const KanbanPage()},
  {'routerPath': '/formElements', 'widget': FormElementsPage()},
  {'routerPath': '/formLayout', 'widget': FormLayoutPage()},
  {'routerPath': '/signIn', 'widget': SignInWidget()},
  {'routerPath': '/signUp', 'widget': SignUpWidget(), 'isWhite': true},
  {
    'routerPath': '/resetPwd',
    'widget': const ResetPwdWidget(),
    'isWhite': true
  },
  {'routerPath': '/invoice', 'widget': const InvoicePage()},
  {'routerPath': '/inbox', 'widget': const InboxWidget()},
  {'routerPath': '/tables', 'widget': const TablesPage()},
  {'routerPath': '/settings', 'widget': SettingsPage()},
  {'routerPath': '/basicChart', 'widget': const ChartPage()},
  {'routerPath': '/buttons', 'widget': const ButtonPage()},
  {'routerPath': '/alerts', 'widget': const AlertPage()},
  {'routerPath': '/contacts', 'widget': ContactsPage()},
  {'routerPath': '/chatGpt', 'widget': ChatGptPage()},
  {'routerPath': '/chat', 'widget': ChatPage()},
  {'routerPath': '/scrapy', 'widget': ScrapyPage()},
  {'routerPath': '/dictionary', 'widget': DictionaryPage()},
  {'routerPath': '/tools', 'widget': ToolsPage()},
  {'routerPath': '/ai', 'widget': AIPage()},
];

class RouteConfiguration {
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>(debugLabel: 'Rex');

  static BuildContext? get navigatorContext =>
      navigatorKey.currentState?.context;

  static Route<dynamic>? onGenerateRoute(
    RouteSettings settings,
  ) {
    bool? isLogin = navigatorContext?.read<StoreProvider>().isLogin();

    String path = settings.name!;

    dynamic map =
        MAIN_PAGES.firstWhere((element) => element['routerPath'] == path);
    bool? isWhite = map['isWhite'];
    if (isWhite == null || !isWhite) {
      if (path == '/signIn') {
        if (isLogin != null && isLogin) {
          path = '/';
        }
      } else {
        if (isLogin == null || !isLogin) {
          path = '/signIn';
        }
      }

      map = MAIN_PAGES.firstWhere((element) => element['routerPath'] == path);
    }

    if (map == null) {
      return null;
    }
    Widget targetPage = map['widget'];

    builder(context, match) {
      return targetPage;
    }

    return NoAnimationMaterialPageRoute<void>(
      builder: (context) => builder(context, null),
      settings: settings,
    );
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required super.builder,
    super.settings,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
