class ProviderNotImplementedException extends UnimplementedError {
  final String serviceName;
  ProviderNotImplementedException({required this.serviceName});

  @override
  String? get message => 
  """
    Provider for $serviceName will be implemented in the main function since it depends on some data that is 
    not available at the moment of registration. This exception should never be thrown as the 
    provider should be configured before use. If you catch this exception that means the 
    "overrides" property of the ProviderScope declared in main.dart does not contain an override
    which returns the actual service for this provider. 
  """;
}
