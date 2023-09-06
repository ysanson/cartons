import 'package:fluent_ui/fluent_ui.dart';
import '../widgets/page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with PageMixin {
  bool selected = true;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(title: Text('Cartons')),
      content: const Card(
          child:
              Wrap(alignment: WrapAlignment.center, spacing: 10.0, children: [
        Text(
            'Cartons is a Flutter app to help move and store items in locations.'),
        Text('This app is still under construction.'),
      ])),
    );
  }
}
