import 'package:bots/core/api_utils.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/data/models/banks_model.dart';
import 'package:bots/presentation/state/account_store.dart';
import 'package:bots/presentation/widgets/error_widget.dart';
import 'package:bots/presentation/widgets/error_widget.dart' as prefix0;
import 'package:bots/presentation/widgets/idle_widget.dart';
import 'package:bots/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    final reactiveModel = Injector.getAsReactive<AccountStore>();
    reactiveModel.setState((state) => state.getBanksInfo(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StateBuilder<AccountStore>(
        models: [Injector.getAsReactive<AccountStore>()],
        builder: (context, reactiveModel) {
          return reactiveModel.whenConnectionState(
            onIdle: () => IdleWidget(),
            onWaiting: () => WaitingWidget(),
            onError: (e) => OnErrorWidget(e.toString()),
            onData: (data) => onDataWidget(data.banksModel.data),
          );
        });
  }

  Widget onDataWidget(List<BankData> banks) {
    return ListView(
      shrinkWrap: true,
      children: List.generate(banks.length, (index) {
        return contactItem(banks[index]);
      }),
    );
  }

  Widget contactItem(BankData bank) {
    Size size = MediaQuery.of(context).size;
    return Parent(
      style: StylesD.cartStyle,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          // crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Column(
              // mainAxisSize: MainAxisSize.max,

              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Txt('اسم البنك: ${bank.name}',
                    style: TxtStyle()
                      ..textColor(ColorsD.main)
                      ..fontFamily('Cairo')),
                Txt('رقم الحساب: ${bank.accoutNumber}'),
                Txt('رقم الأيبان: ${bank.iban}'),
              ],
            ),
            SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                '${APIs.imageBaseUrl}${bank.image}',
                height: size.height / 8.8,
                width: size.width / 4.5,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
