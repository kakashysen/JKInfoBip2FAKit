//
//  JKIB2FAPinVerifyResult.m
//  JKInfoBip2FAKit
//
//  Created by Jose Aponte on 3/24/17.
//  Copyright © 2017 jappsku. All rights reserved.
//

#import "JKIB2FAPinVerifyResult.h"

@implementation JKIB2FAPinVerifyResult

-(instancetype)initWithResponse:(NSDictionary *)response
{
    if (self = [super init])
    {
        if ([response objectForKey:@"pinId"])
        {
            self.pinId = [response objectForKey:@"pinId"];
        }
        if ([response objectForKey:@"msisdn"])
        {
            self.msisdn = [response objectForKey:@"msisdn"];
        }
        if ([response objectForKey:@"verified"])
        {
            self.verified = [[response objectForKey:@"verified"] boolValue];
        }
        if ([response objectForKey:@"attemptsRemaining"])
        {
            self.attemptsRemaining = [[response objectForKey:@"attemptsRemaining"] integerValue];
        }
        if ([response objectForKey:@"pinError"])
        {
            NSString *pinErrorStr = [response objectForKey:@"pinError"];
          if ([pinErrorStr isEqualToString:@"WRONG_PIN"])
          {
            self.pinError = PinErrorWrongPin;
          }
          else if ([pinErrorStr isEqualToString:@"TTL_EXPIRED"])
          {
            self.pinError = PinErrorTtlExpired;
          }
          else if ([pinErrorStr isEqualToString:@"NO_MORE_PIN_ATTEMPTS"])
          {
            self.pinError = PinErrorNoMorePinAttempts;
          }
          else
          {
            self.pinError = PinErrorUnknown;
          }
        }
    }
    return self;
}

@end
