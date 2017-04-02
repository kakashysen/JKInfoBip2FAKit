//
//  JKInfoBip2FARequest.m
//  JKInfoBip2FAKit
//
//  Created by Jose Aponte on 3/22/17.
//  Copyright © 2017 jappsku. All rights reserved.
//

#import "JKIB2FARequest.h"
@implementation JKIB2FARequest
{
  AFHTTPSessionManager *manager;
}

-(instancetype)init
{
  if (self = [super init])
  {
    NSURL *url = nil;
    url = [NSURL URLWithString:URL_INFO_BIP];
    
    manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    AFHTTPRequestSerializer *request  = [AFHTTPRequestSerializer serializer];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"Accept-Charset"];
    
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    if ([infoPlist objectForKey:@"InfoBipAppToken"])
    {
      NSString *infoBipAuthToken = [infoPlist objectForKey:@"InfoBipAppToken"];
      [request setValue:infoBipAuthToken forHTTPHeaderField:@"Authorization"];
    }
    else
    {
      NSLog(@"*************************************************************************************************");
      NSLog(@"***** JKIB2FAKit required a property called 'InfoBipAppToken' with your app token configured in the YourProject-Info.plit *****");
      NSLog(@"*************************************************************************************************");
    }
    
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    [request setValue:language forHTTPHeaderField:@"Accept-Language"];
    
    manager.requestSerializer = request;
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
      if (status == AFNetworkReachabilityStatusNotReachable)
      {
        NSLog(@"API is NOT Reachable");
      }else
      {
        NSLog(@"API is Reachable");
      }
    }];
  }
  return self;
}


-(void)sendSmsWithPinBody:(JKIB2FAPinBody *)pinBody
{
  [manager POST:ENDPOINT_SEND_SMS
     parameters:pinBody.serialize
       progress:^(NSProgress * _Nonnull uploadProgress) {}
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          if ([self.delegate respondsToSelector:@selector(sendSmsWithPinBodyDidFinishSuccessful:)])
          {
            JKIB2FAPinResult *result = [[JKIB2FAPinResult alloc] initWithResponse:responseObject];
            [self.delegate sendSmsWithPinBodyDidFinishSuccessful:result];
          }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          if ([self.delegate respondsToSelector:@selector(sendSmsWithPinBodyDidFinishFailure:statusCode:)])
          {
            NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]
                                                          encoding:NSUTF8StringEncoding];
            NSError *errorParserJson;
            NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:[errResponse dataUsingEncoding:NSUTF8StringEncoding]
                                                                         options:NSJSONReadingAllowFragments
                                                                           error:&errorParserJson];
            NSInteger statusCode = 0;
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            
            if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
              statusCode = httpResponse.statusCode;
            }
            
            if (errorParserJson)
            {
              [self.delegate sendSmsWithPinBodyDidFinishFailure:nil statusCode:statusCode];
            }
            else
            {
              JKIB2FAResponseError *responseError = [[JKIB2FAResponseError alloc] initWithResponse:dictResponse];
              [self.delegate sendSmsWithPinBodyDidFinishFailure:responseError statusCode:statusCode];
            }
          }
        }];
}


-(void)verifySmsCodeWithPinId:(NSString*)pinId andCode:(NSString*) code
{
  NSString *endpointVerifySms = [ENDPOINT_VERIFY_SMS stringByReplacingOccurrencesOfString:@":pinId" withString:pinId];
  
  [manager POST:endpointVerifySms
     parameters:@{@"pin":code}
       progress:^(NSProgress * _Nonnull uploadProgress) {}
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          if ([self.delegate respondsToSelector:@selector(verifySmsCodeWithPinIdDidFinishSuccessful:)])
          {
            JKIB2FAPinVerifyResult *pinVerifyResult = [[JKIB2FAPinVerifyResult alloc] initWithResponse:responseObject];
            [self.delegate verifySmsCodeWithPinIdDidFinishSuccessful:pinVerifyResult];
          }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          if ([self.delegate respondsToSelector:@selector(verifySmsCodeWithPinIdDidFinishFailure:statusCode:)])
          {
            NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]
                                                          encoding:NSUTF8StringEncoding];
            NSError *errorParserJson;
            NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:[errResponse dataUsingEncoding:NSUTF8StringEncoding]
                                                                         options:NSJSONReadingAllowFragments
                                                                           error:&errorParserJson];
            NSInteger statusCode = 0;
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            
            if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
              statusCode = httpResponse.statusCode;
            }
            
            if (errorParserJson)
            {
              [self.delegate verifySmsCodeWithPinIdDidFinishFailure:nil statusCode:statusCode];
            }
            else
            {
              JKIB2FAResponseError *responseError = [[JKIB2FAResponseError alloc] initWithResponse:dictResponse];
              [self.delegate verifySmsCodeWithPinIdDidFinishFailure:responseError statusCode:statusCode];
            }
          }
        }];
}

-(void)resendSmsCodeWithPinId:(NSString *)pinId
{
  NSString *endpointResendSms = [ENDPOPINT_RESEND_SMS stringByReplacingOccurrencesOfString:@":pinId" withString:pinId];
  [manager POST:endpointResendSms
     parameters:nil
       progress:^(NSProgress * _Nonnull uploadProgress) {}
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          if ([self.delegate respondsToSelector:@selector(resendSmsCodeWithPinIdDidFinishSuccessful:)])
          {
            JKIB2FAPinResult *pinResult = [[JKIB2FAPinResult alloc] initWithResponse:responseObject];
            [self.delegate resendSmsCodeWithPinIdDidFinishSuccessful:pinResult];
          }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          if ([self.delegate respondsToSelector:@selector(resendSmsCodeWithPinIdDidFinishFailure:statusCode:)])
          {
            NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]
                                                          encoding:NSUTF8StringEncoding];
            NSError *errorParserJson;
            NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:[errResponse dataUsingEncoding:NSUTF8StringEncoding]
                                                                         options:NSJSONReadingAllowFragments
                                                                           error:&errorParserJson];
            NSInteger statusCode = 0;
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            
            if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
              statusCode = httpResponse.statusCode;
            }
            
            if (errorParserJson)
            {
              [self.delegate resendSmsCodeWithPinIdDidFinishFailure:nil statusCode:statusCode];
            }
            else
            {
              JKIB2FAResponseError *responseError = [[JKIB2FAResponseError alloc] initWithResponse:dictResponse];
              [self.delegate resendSmsCodeWithPinIdDidFinishFailure:responseError statusCode:statusCode];
            }
          }
        }];
}

@end
