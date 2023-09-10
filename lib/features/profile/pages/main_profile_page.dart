import 'package:fisioflex_mobile/core/auth/providers/auth_provider.dart';
import 'package:fisioflex_mobile/features/profile/widgets/profile_option_item.dart';
import 'package:fisioflex_mobile/features/profile/widgets/user_card_widget.dart';
import 'package:fisioflex_mobile/features/profile/widgets/user_info_widget.dart';
import 'package:fisioflex_mobile/widgets/main_title_widget.dart';
import 'package:fisioflex_mobile/widgets/titles_and_subtiles_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainProfilePage extends StatefulHookConsumerWidget {
  const MainProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainProfilePageState();
}

class _MainProfilePageState extends ConsumerState<MainProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ref.watch(authProvider.notifier).getUserByIdentification(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      PageTitle('Perfil', Icons.people_alt_outlined, context),
                      const SizedBox(
                        height: 30,
                      ),
                      UserCardWidget(userModel: snapshot.data),
                      const SizedBox(
                        height: 30,
                      ),
                      UserInfoWidget(userModel: snapshot.data),
                      const SizedBox(
                        height: 30,
                      ),
                      const MainTitleWidget(
                        title: 'Opciones',
                        subtitle: '',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ProfileOptionItem(
                          icon: Icons.settings,
                          title: 'Informacion de perfil',
                          onTap: () {}),
                      const Divider(),
                      ProfileOptionItem(
                          icon: Icons.logout_outlined,
                          title: 'Cerrar sesion',
                          onTap: () {
                            ref.read(authProvider.notifier).logout();
                          }),
                    ],
                  ));
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Mi perfil'),
                ),
                body: const Center(
                  child: Text('No se pudo obtener el usuario'),
                ),
              );
            }
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Mi perfil'),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
