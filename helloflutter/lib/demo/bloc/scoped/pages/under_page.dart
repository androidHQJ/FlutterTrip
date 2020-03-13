import 'package:flutter/material.dart';
import 'package:helloflutter/demo/bloc/scoped/blocs/bloc_provider.dart';
import 'package:helloflutter/demo/bloc/scoped/blocs/count_bloc.dart';

///在第二个页面中调用increment
class UnderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Top Page"),
      ),
      body: Center(
        child: _streamBuilder(bloc),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          ///调用increment
          onPressed: () => bloc.increment()),
    );
  }

  Widget _streamBuilder(CountBLoC bloc) {
    return StreamBuilder(
        stream: bloc.stream,
        initialData: bloc.value,
        builder: (context, snapshot) => Text(
              "You hit me: ${snapshot.data} times",
              style: Theme.of(context).textTheme.display1,
            ));
  }
}
