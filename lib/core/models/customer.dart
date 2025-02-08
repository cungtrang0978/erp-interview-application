class Customer {
  final int customerId;
  final String name;
  final String? contactPerson;
  final String? email;
  final String? phone;
  final String? billingAddress;
  final String? shippingAddress;
  final String? taxId;
  final double? creditLimit;
  final String? paymentTerms;

  const Customer({
    required this.customerId,
    required this.name,
    this.contactPerson,
    this.email,
    this.phone,
    this.billingAddress,
    this.shippingAddress,
    this.taxId,
    this.creditLimit,
    this.paymentTerms,
  });

  // Convert JSON to Customer Object
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerId: int.tryParse(json['customer_id'] ?? '') ?? 0,
      name: json['name'] ?? '',
      contactPerson: json['contact_person'],
      email: json['email'],
      phone: json['phone'],
      billingAddress: json['billing_address'],
      shippingAddress: json['shipping_address'],
      taxId: json['tax_id'],
      creditLimit: double.tryParse(json['credit_limit'] ?? '') ?? 0.0,
      paymentTerms: json['payment_terms'],
    );
  }

  // CopyWith Method to create a modified copy of the object
  Customer copyWith({
    int? customerId,
    String? name,
    String? contactPerson,
    String? email,
    String? phone,
    String? billingAddress,
    String? shippingAddress,
    String? taxId,
    double? creditLimit,
    String? paymentTerms,
  }) {
    return Customer(
      customerId: customerId ?? this.customerId,
      name: name ?? this.name,
      contactPerson: contactPerson ?? this.contactPerson,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      billingAddress: billingAddress ?? this.billingAddress,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      taxId: taxId ?? this.taxId,
      creditLimit: creditLimit ?? this.creditLimit,
      paymentTerms: paymentTerms ?? this.paymentTerms,
    );
  }

  // Convert Object to String for Debugging
  @override
  String toString() {
    return 'Customer(customerId: $customerId, name: $name, email: $email, phone: $phone)';
  }
}
