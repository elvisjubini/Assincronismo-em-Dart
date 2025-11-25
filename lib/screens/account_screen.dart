

import 'package:dart_assincronismo/models/account.dart';
import 'package:dart_assincronismo/services/account_service.dart';
import 'dart:io';

import 'package:http/http.dart';

class AccountScreen {
  final AccountService _accountService = AccountService();

  void initializeStream() {
    _accountService.streamInfos.listen((event){
      print(event);
    },
    );
    }
  


  void runChatBot() async {

print (" ____    _    _   _  ____ ___    ____  _  ___  _   _ ____   ___  ");
print ("| __ )  / |  | | | |/ ___/ _ |  |  _ || )/ _ || | | |  _ | / _ | ");
print ("|  _ | / _ | |  || | |  | | | | | | | |/| | | | | | | |_) | | | |");
print ("| |_) / ___ || ||  | |__| |_| | | |_| | | |_| | |_| |  _ <| |_| |");
print ("|____/_/   |_|_| |_||____|___/  |____/   |___/ |___/|_| |_||__/ ");
print("");
print("");


    print("Bom dia! Eu sou o Lewis, assistente do Banco d'Ouro!");
    print("");
    print("Que bom te ter aqui com a gente.\n");

    bool isRunning = true;
    while (isRunning) {
      print("Como eu posso te ajudar? (digite o número desejado)");
      print("1 - Ver todas sua contas.");
      print("2 - Adicionar nova conta.");
      print("3 - Sair\n");

      String? input = stdin.readLineSync();

      if (input != null) {
        switch (input) {
          case "1":
            {
              await _getAllAccounts();
              break;
            }
          case "2":
            {
              await _addExampleAccount();
              break;
            }
          case "3":
            {
              isRunning = false;
              print("Te vejo na próxima.😊");
              break;
            }
          default:
            {
              print("Não entendi. Tente novamente.");
            }
        }
      }
    }
  }
     _getAllAccounts() async{
      try{
      List<Account> listAccounts = await _accountService.getAll();
      print(listAccounts);
      } on ClientException catch (ClientException){
        print("Não foi possível alcançar o servidor.");
        print("Tente novamente mais tarde.");
        print(ClientException.message);
        print(ClientException.uri);
    } on Exception {
    print("Não consegui recuperar os dados da conta.");
    print("Tente novamente mais tarde.");
    
    } finally {
    print("${DateTime.now()} | Ocorreu uma tentativa de consulta.");
    }
  
     }

  _addExampleAccount() async {
 
    try {
  Account example = Account(
    id: "ID555",
    name: "Haley",
    lastName: "Chirívia",
    balance: 8001,
    accountType: "Brigadeiro",
  );
  
  await _accountService.addAccount(example);
} on Exception {
  print("Ocorreu um problema ao tentar adicionar");
}
  }
}