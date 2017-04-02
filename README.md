# JKInfoBip2FAKit

[![CI Status](http://img.shields.io/travis/joseboavita@gmail.com/JKInfoBip2FAKit.svg?style=flat)](https://travis-ci.org/joseboavita@gmail.com/JKInfoBip2FAKit)
[![Version](https://img.shields.io/cocoapods/v/JKInfoBip2FAKit.svg?style=flat)](http://cocoapods.org/pods/JKInfoBip2FAKit)
[![License](https://img.shields.io/cocoapods/l/JKInfoBip2FAKit.svg?style=flat)](http://cocoapods.org/pods/JKInfoBip2FAKit)
[![Platform](https://img.shields.io/cocoapods/p/JKInfoBip2FAKit.svg?style=flat)](http://cocoapods.org/pods/JKInfoBip2FAKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Before to run the example project, your should configure a couple of parameters:

- InfoBipAppToken key
In the `JKInfoBip2FAKit-Info.plist` file, you need to replace `your-app-token` value for your own API key generated in the [infobip](https://dev.infobip.com/docs/api-key-create) platform

- APPLICATION_ID
Add your application id generated in the [infobip](https://dev.infobip.com/docs/application-create) platform

- MESSAGE_ID 
Addd your message id generated in the [infobop](https://dev.infobip.com/docs/message-create) platform


## Requirements

You need to have an account in [infobip site](https://dev.infobip.com/docs/api-key-create) platform and generate an API key


## Installation and Configuration

JKInfoBip2FAKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JKInfoBip2FAKit"
```

- Configure in the `NSAppTransportSecurity` the domain `infobip.com` in your application

```plist
<key>NSAppTransportSecurity</key>
<dict>
	<key>NSExceptionDomains</key>
	<dict>
		<key>infobip.com</key>
	<dict>
		<key>NSIncludesSubdomains</key>
		<true/>
		<key>NSExceptionAllowsInsecureHTTPLoads</key>
		<true/>
		<key>NSExceptionRequiresForwardSecrecy</key>
		<true/>
		<key>NSExceptionMinimumTLSVersion</key>
		<string>TLSv1.2</string>
		<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
		<false/>
		<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
		<true/>
		<key>NSThirdPartyExceptionMinimumTLSVersion</key>
		<string>TLSv1.2</string>
		<key>NSRequiresCertificateTransparency</key>
		<false/>
	</dict>
</dict>
```

- In the application plist file `AppName-Info.plist` add the key `InfoBipAppToken` and the value should be your API Key e.g. `App xxxxxxxxxxxxxxxxxxxxxx`

- Create an Application in [infobip](https://dev.infobip.com/docs/application-create) platform.

- Create an Message in [infobop](https://dev.infobip.com/docs/message-create) platform.

After than, use these ids in your application to send request to `infobip`


## Usage

Import `JKIB2FARequest.h` in your controller header file

```objectivec
#import <JKInfoBip2FAKit/JKIB2FARequest.h>
```

Add the delegate `JKIB2FARequestDelegate`

### Functions

To use every function you need to create an instance of JKIB2FARequest and asign the delegate to get the results.

```objectivec
JKIB2FARequest *request = [JKIB2FARequest new];
request.delegate = self;
```

#### Send SMS

```objectivec
JKIB2FAPinBody *body = [JKIB2FAPinBody new];
#warning change for your test application ID configured in InfoBip
body.applicationId = APPLICATION_ID;//@"your-config-applicationID";
  
#warning change for your test message ID configured in InfoBip
body.messageId = MESSAGE_ID;//@"your-config-messageID";
  
// This parameter should contains the country calling code + phone number
// remember to NOT include the sign (+), this parameter only can contains numbers
#warning change for your test phone number
body.to = _textFieldPhoneNumber.text;
  
[request sendSmsWithPinBody:body];
```

To get the result implement the follow delegate methods

```objectivec
-(void)sendSmsWithPinBodyDidFinishSuccessful:(JKIB2FAPinResult *)pinResult
{
	if (pinResult.smsStatus == SmsStatusMessageSent)
  {
    NSLog(@"message send successful");
    pinId = pinResult.pinId;
  }
  else
  {
    // You can use pinResult.ncStatus to know the reason why the message was not sent
    NSLog(@"message not send becouse ncStatus");
  }
}
```

```objectivec
-(void)sendSmsWithPinBodyDidFinishFailure:(JKIB2FAResponseError *)responseError statusCode:(NSInteger)statusCode
{
	// You can use the responseError.text to see message information about the problem
  // and use the statusCode to know the http status code
}
```

#### Resend SMS

```objectivec  
// the parameter is the pinID generated when your send a sms code
// whith methods sendSmsWithPinBody:
[request resendSmsCodeWithPinId:pinId];
```

To get the result implement the follow delegate methods

```objectivec
-(void)resendSmsCodeWithPinIdDidFinishSuccessful:(JKIB2FAPinResult *)pinResult
{
  if (pinResult.smsStatus == SmsStatusMessageSent)
  {
    NSLog(@"message resend successful");
    pinId = pinResult.pinId;
  }
  else
  {
    // You can use pinResult.ncStatus to know the reason why the message was not sent
    NSLog(@"message not resend becouse ncStatus");
  }
}
```

```objectivec
-(void)resendSmsCodeWithPinIdDidFinishFailure:(JKIB2FAResponseError *)responseError statusCode:(NSInteger)statusCode
{
  // You can use the responseError.text to see message information about the problem
  // and use the statusCode to know the http status code
}
```

#### Verify Pin Code

```objectivec
// this method need two parameters, the first is the PinID generated when your send a sms code
// whith methods sendSmsWithPinBody:
// The second parameter is the pin code that user receive in the sms message.
[request verifySmsCodeWithPinId:pinId andCode:_textFieldPinCode.text];
```

```objectivec
-(void)verifySmsCodeWithPinIdDidFinishSuccessful:(JKIB2FAPinVerifyResult *)pinVerifyResult
{
  if (pinVerifyResult.verified)
  {
    // The pin code is valid and the phone number was verified
  }
  else
  {
    // You can use pinVerifyResult.pinError to know the problem
  }
}
```

```objectivec
-(void)verifySmsCodeWithPinIdDidFinishFailure:(JKIB2FAResponseError *)responseError statusCode:(NSInteger)statusCode
{
  // You can use the responseError.text to see message information about the problem
  // and use the statusCode to know the http status code
}
```


## Author

Jose Aponte

## License

JKInfoBip2FAKit is available under the MIT license. See the LICENSE file for more info.
