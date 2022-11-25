import 'package:flutter/material.dart';
import 'package:sqlflutter/db/db_admin.dart';
import 'package:sqlflutter/widgets/my_form_widget.dart';
import '../models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TaskModel? taskModel;

  Future<String> getFullName() async {
    return "Manuel Guzman";
  }

  showDialogForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyFormWidget(
          taskModel: taskModel,
        );
      },
    ).then((value) {
      setState(() {});
    });
  }

  deleteTask(int taskId){
    DBAdmin.db.deleteTask(taskId).then((value){
      if(value > 0){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.indigo,
            content: Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.white,),
                SizedBox(width: 10.0,),
                Text("Tarea eliminada"),
              ],
            ),
          ),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          taskModel = null;
          showDialogForm();
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: DBAdmin.db.getTasks(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            List<TaskModel> myTasks = snap.data;
            return ListView.builder(
              itemCount: myTasks.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  // confirmDismiss: (DismissDirection direction) async{
                  //   return true;
                  // },
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    color: Colors.redAccent,
                  ),
                  // secondaryBackground: Text("Hola 2"),
                  onDismissed: (DismissDirection direction) {
                    deleteTask(myTasks[index].id!);
                  },
                  child: ListTile(
                    title: Text(myTasks[index].title),
                    subtitle: Text(myTasks[index].description),
                    trailing: IconButton(
                      onPressed: (){
                        taskModel = myTasks[index];
                        showDialogForm();
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}