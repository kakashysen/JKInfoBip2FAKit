//
//  JKIB2FAPinResult.h
//  JKInfoBip2FAKit
//
//  Created by Jose Aponte on 3/22/17.
//  Copyright © 2017 jappsku. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SmsStatusMessageSent = 1,
    SmsStatusMessageNotSent = 2,
} SmsStatus;

typedef enum : NSUInteger {
  NcStatusUnknown = -2,
  NcStatusNotConfigured = -1,
  NcStatusDestinationUnknown = 1,
  NcStatusDestinationReachable = 2,
  NcStatusDestinationNotReachable =3,
} NcStatus;

@interface JKIB2FAPinResult : NSObject


/// Sent PIN code ID.
@property (nonatomic, strong) NSString *pinId;

/// Phone number to which 2FA message was sent.
@property (nonatomic, strong) NSString *to;

/// Status of sent Number Lookup.
/// Number Lookup status can have one of the following values: NC_DESTINATION_UNKNOWN, NC_DESTINATION_REACHABLE, NC_DESTINATION_NOT_REACHABLE, NC_NOT_CONFIGURED.
/// If you get NC_NOT_CONFIGURED status, you should contact your account manager for configuring it.
/// SMS will not be sent only if Number Lookup status is NC_NOT_REACHABLE
@property (nonatomic, assign) NcStatus ncStatus;


/// Sent SMS status. Can have one of the following values: MESSAGE_SENT, MESSAGE_NOT_SENT.
@property (nonatomic, assign) SmsStatus smsStatus;


-(instancetype)initWithResponse:(NSDictionary*) response;

@end
