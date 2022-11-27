Feature: Simple test of Pact FFI
 As a developer planning to use Pact in a language capable of using the FFI
 I want to test the basic loading of Pact FFI
 In order to have confidence in it
 
 Background:
   Given a pact ffi library exists
 
 Scenario: Check MD5
    This scenario verifies the Pact FFI is loaded
   Given we have loaded the Pact FFI
   When I call "pactffi_version"
   Then the output is a semver string