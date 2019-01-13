import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/components/visual_components.dart';
import 'package:flutter_visual_builder/dynamic_widget.dart';

class VisualEditor extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        DragTarget<DynamicWidget>(
          builder: (context, it ,it2) {
            return Container(
                width: 200,
                height: double.infinity,
                alignment: Alignment.center,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RootDraggable(widgetAndSourceCode: testWidget),
                    RootDraggable(widgetAndSourceCode: testWidget2),
                    RootDraggable(widgetAndSourceCode: testWidget3),
                  ],
                )
            );
          },
          onWillAccept: (it) => true,

        ),
        Expanded(child: AppWidget()),
      ],
    );
  }
}


class RootDraggable extends StatelessWidget {

  const RootDraggable({Key key, this.widgetAndSourceCode}) : super(key: key);

  final DynamicWidget widgetAndSourceCode;


  @override
  Widget build(BuildContext context) {
    return Draggable<DynamicWidget>(
      childWhenDragging: widgetAndSourceCode.feedback,
      data: widgetAndSourceCode,
      feedback: widgetAndSourceCode.feedback,
      child: widgetAndSourceCode.feedback,
    );
  }
}


class AppWidget extends StatelessWidget {


  final GlobalKey<VisualRootState> rootKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return VisualRoot(
      key: rootKey,
      child: VisualScaffold(
        properties: [],
        widgetProperties: [],
        floatingActionButton: VisualFloatingActionButton(
            onPressed: (){
              print("Hey!");
            }
        ),
        body: VisualWrapper(
          child: Center(
            child: RaisedButton(onPressed: (){
              String source = rootKey.currentState.buildSourceCode();
              print("Here is the source: \n");
              print(source);
            }),
          ),
        ),
      ),
    );
  }




}