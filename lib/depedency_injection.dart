import 'data/contact_data.dart';
import 'data/contact_data_imp.dart';
import 'data/contact_data_mock.dart';

class Injector {
   static final _singleton = Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor){
    _flavor = flavor;
  }
  factory Injector(){
    return _singleton;
  }
  Injector._internal();
  ContactRepository get contactRepository{
      switch(_flavor){
        case Flavor.MOCK: return ContactDataMock();
        default:
          return RandomUserRepository();
      }
  }
}

enum Flavor{
  MOCK,PRO
}
