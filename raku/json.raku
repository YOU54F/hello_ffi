use JSON::Tiny;

my $pact = from-json '{"consumer":{"name":"pact-perl-ffi"},"interactions":[{"description":"a retrieve Mallory request","request":{"method":"GET","path":"/mallory","query":"name=ron&status=good"},"response":{"body":"That is some good Mallory.","headers":{"Content-Type":"text/html"},"status":200}}],"metadata":{"pact-python":{"ffi":"0.3.15","version":"1.0.0"},"pactRust":{"mockserver":"0.9.5","models":"1.0.0"},"pactSpecification":{"version":"1.0.0"}},"provider":{"name":"Alice Service"}}'.perl();
say $pact;
