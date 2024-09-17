


import 'package:api_rest_client/services/crud_repository.dart';
import 'package:api_rest_client/services/internal/orm.dart';

class Contact extends ORM<Contact> {
  String? uuid;
  String? email;
  String? firstName;
  String? lastName;
  String? company;



   @override
   void initializeRepository() {
     super.repo = CrudRepository<Contact>(
         fromJson: Contact.fromJson,
         toJson: toJson,
         entryPoint: 'contact');
   }

  Contact({
    this.uuid,
    this.email,
    this.firstName,
    this.lastName,
    this.company,

  }):super(uuid:uuid);


  factory Contact.fromJson(Map<String, dynamic> json) {

    return Contact(
      uuid: json['uuid'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      company: json['company'],
    );
  }

  Map<String, dynamic> toJson([Contact? contact]) {


    contact ??= this;

    return {
      'uuid': contact.uuid,
      'email': contact.email,
      'first_name': contact.firstName,
      'last_name': contact.lastName,
      'company': contact.company,
    };

  }
}
