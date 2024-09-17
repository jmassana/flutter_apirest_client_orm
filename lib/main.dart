import 'package:api_rest_client/models/contact_model.dart';
import 'package:flutter/material.dart';

import 'services/response_models/paged_result_model.dart';

Future<void> main() async {

  var contact = Contact(
    firstName: "Jordi",
    lastName: "Massana",
    email: "jmassana@indalter.com",
  );

  //CREATE NEW USER
  Contact savedContact = await contact.save();

  //GET USER
  Contact contactDetail = await contact.get();

  //LIST CONTACTS
  PagedResult<Contact> listContacts = await contact.list();


  //UPDATE USER
  contactDetail.firstName = "Jordi2";
  Contact updatedContact = await contactDetail.update();


  //DELETE USER
  await contactDetail.delete();

  //LIST AVAI


}

