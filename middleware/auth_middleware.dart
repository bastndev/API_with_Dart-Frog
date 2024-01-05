import 'package:dart_frog/dart_frog.dart';

Middleware bearerAutorizationMiddleware (){
  return (handler){
    return (context){






      return handler(context);
    };
  };
}