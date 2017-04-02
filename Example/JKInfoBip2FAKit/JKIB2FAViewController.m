//
//  JKIB2FAViewController.m
//  JKInfoBip2FAKit
//
//  Created by joseboavita@gmail.com on 04/01/2017.
//  Copyright (c) 2017 joseboavita@gmail.com. All rights reserved.
//

#import "JKIB2FAViewController.h"

@interface JKIB2FAViewController ()
@property (strong, nonatomic) IBOutlet UITextField *textFieldPinCode;
@property (strong, nonatomic) IBOutlet UITextField *textFieldPhoneNumber;
@property (strong, nonatomic) IBOutlet UILabel *labelStatus;

@end



@implementation JKIB2FAViewController
{
  NSString *pinId;
}


#define APPLICATION_ID @"your-application-id"
#define MESSAGE_ID @"your-message-id"

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Send SMS Pin Code Methods
- (IBAction)sendSmsAction:(UIButton *)sender
{
  JKIB2FARequest *request = [JKIB2FARequest new];
  request.delegate = self;
  
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
  _labelStatus.text = @"Sending sms...";
}

-(void)sendSmsWithPinBodyDidFinishSuccessful:(JKIB2FAPinResult *)pinResult
{
  if (pinResult.smsStatus == SmsStatusMessageSent)
  {
    NSLog(@"message send successful");
    pinId = pinResult.pinId;
    _labelStatus.text = @"message send successful";
  }
  else
  {
    // You can use pinResult.ncStatus to know the reason why the message was not sent
    NSLog(@"message not send becouse ncStatus");
    _labelStatus.text = @"message not send, check ncStatus in code";
  }
}

-(void)sendSmsWithPinBodyDidFinishFailure:(JKIB2FAResponseError *)responseError statusCode:(NSInteger)statusCode
{
  // You can use the responseError.text to see message information about the problem
  // and use the statusCode to know the http status code
  
  _labelStatus.text = [NSString stringWithFormat:@"The process fail - (%ld)",(long)statusCode];
}


#pragma mark - Verify Pin Code Methods
- (IBAction)verifyCodeAction:(UIButton *)sender
{
  JKIB2FARequest *request = [JKIB2FARequest new];
  request.delegate = self;
  
  // this method need two parameters, the first is the PinID generated when your send a sms code
  // whith methods sendSmsWithPinBody:
  // The second parameter is the pin code that user receive in the sms message.
  [request verifySmsCodeWithPinId:pinId andCode:_textFieldPinCode.text];
  _labelStatus.text = @"Checking...";
}

-(void)verifySmsCodeWithPinIdDidFinishSuccessful:(JKIB2FAPinVerifyResult *)pinVerifyResult
{
  if (pinVerifyResult.verified)
  {
    // The pin code is valid and the phone number was verified
    _labelStatus.text = @"phone number verified";
  }
  else
  {
    // You can use pinVerifyResult.pinError to know the problem
    _labelStatus.text = @"phone number NOT verified";
  }
}

-(void)verifySmsCodeWithPinIdDidFinishFailure:(JKIB2FAResponseError *)responseError statusCode:(NSInteger)statusCode
{
  // You can use the responseError.text to see message information about the problem
  // and use the statusCode to know the http status code
  
  _labelStatus.text = [NSString stringWithFormat:@"The process fail - (%ld)",(long)statusCode];
}


#pragma mark - Resend SMS Pin Code Methods
- (IBAction)resendSmsAction:(UIButton *)sender
{
  JKIB2FARequest *request = [JKIB2FARequest new];
  request.delegate = self;
  
  // the parameter is the pinID generated when your send a sms code
  // whith methods sendSmsWithPinBody:
  [request resendSmsCodeWithPinId:pinId];
  _labelStatus.text = @"Resending sms...";
}

-(void)resendSmsCodeWithPinIdDidFinishSuccessful:(JKIB2FAPinResult *)pinResult
{
  if (pinResult.smsStatus == SmsStatusMessageSent)
  {
    NSLog(@"message resend successful");
    _labelStatus.text = @"message resend successful";
  }
  else
  {
    // You can use pinResult.ncStatus to know the reason why the message was not sent
    NSLog(@"message not resend becouse ncStatus");
    _labelStatus.text = @"message not resend, check ncStatus";
  }
}

-(void)resendSmsCodeWithPinIdDidFinishFailure:(JKIB2FAResponseError *)responseError statusCode:(NSInteger)statusCode
{
  // You can use the responseError.text to see message information about the problem
  // and use the statusCode to know the http status code
  
  _labelStatus.text = [NSString stringWithFormat:@"The process fail - (%ld)",(long)statusCode];
}

@end
