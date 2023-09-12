import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final isLargeScreen = queryData.size.width > 480;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: isLargeScreen ? const LargeWidget() : const SmallWidget(),
    );
  }
}

final persons = <PersonModel>[
  PersonModel('4b6ff4a9-12c9-564b-b2fc-ceda26e7ec84', 'Mildred Maldonado'),
  PersonModel('83fd9bbb-cc0c-5537-8d56-e6d2e3fc4722', 'Ronnie Greer'),
  PersonModel('0532cc9f-7289-589a-95e6-4dba4897bad0', 'Bobby Griffin'),
  PersonModel('0c25af7b-58c5-5b77-a482-4cbe8e6a1380', 'Gerald Franklin'),
  PersonModel('1dd74b65-9a33-578b-8464-1a2e2d285f8c', 'Austin Martin'),
  PersonModel('e7ffa9a1-5f5e-53f2-aa16-7a2d97df6598', 'Jane Jensen'),
  PersonModel('61a0ba0d-f755-563f-acbe-ec1cec3363c3', 'Nelle Riley'),
];

class SmallWidget extends StatelessWidget {
  const SmallWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PersonListWidget(
      onPressed: (person) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonalDetailScreen(
              person: person,
            ),
          ),
        );
      },
    );
  }
}

class PersonalDetailScreen extends StatelessWidget {
  const PersonalDetailScreen({
    super.key,
    required this.person,
  });

  final PersonModel person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(person.name),
      ),
      body: PersonDetailWidget(
        item: person,
      ),
    );
  }
}

class LargeWidget extends StatefulWidget {
  const LargeWidget({super.key});

  @override
  State<LargeWidget> createState() => _LargeWidgetState();
}

class _LargeWidgetState extends State<LargeWidget> {
  PersonModel? _currentPerson;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: PersonListWidget(
            onPressed: (person) {
              setState(() {
                _currentPerson = person;
              });
            },
          ),
        ),
        Expanded(
          flex: 3,
          child: _currentPerson != null
              ? PersonDetailWidget(item: _currentPerson!)
              : const Text('Vui lòng chọn danh sách bên trái'),
        ),
      ],
    );
  }
}

class PersonModel {
  final String id;
  final String name;

  PersonModel(this.id, this.name);
}

class PersonListWidget extends StatelessWidget {
  const PersonListWidget({super.key, this.onPressed});
  final Function(PersonModel)? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(persons[index].name),
            subtitle: Text(persons[index].id),
            onTap: () {
              onPressed?.call(persons[index]);
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: persons.length);
  }
}

class PersonDetailWidget extends StatelessWidget {
  const PersonDetailWidget({super.key, required this.item});

  final PersonModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(item.id),
        Text(item.name),
      ],
    );
  }
}
