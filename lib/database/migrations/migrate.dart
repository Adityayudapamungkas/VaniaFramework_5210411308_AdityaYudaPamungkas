import 'dart:io';
import 'package:vania/vania.dart';
import 'create_customers.dart';
import 'create_orders.dart';
import 'create_orderitems.dart';
import 'create_productnotes.dart';
import 'create_products.dart';
import 'create_vendors.dart';
import 'create_users.dart';
import 'create_personal_acces_token.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
		 await CreateCustomers().up();
		 await CreateOrders().up();
		 await CreateVendors().up();     
		 await CreateProducts().up();
		 await CreateProductNotes().up();
		 await CreateOrderItems().up();
		 await CreateUsers().up();
		 await CreatePersonalAccesToken().up();
	}

  dropTables() async {
		 await CreatePersonalAccesToken().down();
		 await CreateUsers().down();
		 await CreateOrderItems().down();
		 await CreateProductNotes().down();
		 await CreateProducts().down();
		 await CreateVendors().down();
		 await CreateOrders().down();
		 await CreateCustomers().down();
	 }
}
