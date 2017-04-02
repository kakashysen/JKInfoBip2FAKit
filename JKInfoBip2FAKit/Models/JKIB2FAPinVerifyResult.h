//
//  JKIB2FAPinVerifyResult.h
//  JKInfoBip2FAKit
//
//  Created by Jose Aponte on 3/24/17.
//  Copyright © 2017 jappsku. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
  PinErrorUnknown = -1,
  PinErrorWrongPin = 1,
  PinErrorTtlExpired = 2,
  PinErrorNoMorePinAttempts = 3,
} PinError;


@interface JKIB2FAPinVerifyResult : NSObject


/// Sent PIN code ID.
@property (nonatomic, strong) NSString *pinId;


/// Phone number (msisdn) to which 2FA message was sent.
@property (nonatomic, strong) NSString *msisdn;

/// Indicates if the phone number (msisdn) was successfully verified.
@property (nonatomic, assign) BOOL verified;


/// Number of remaining PIN attempts.
@property (nonatomic, assign) NSInteger attemptsRemaining;


/// Indicates if any error occurs during PIN verification.
/// PIN error can have one of the following values:
/// WRONG_PIN
/// TTL_EXPIRED
/// NO_MORE_PIN_ATTEMPTS
@property (nonatomic, assign) PinError pinError;


-(instancetype)initWithResponse:(NSDictionary *)response;

@end
