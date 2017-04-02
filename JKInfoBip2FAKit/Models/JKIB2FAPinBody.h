//
//  JKIB2FAPinBody.h
//  JKInfoBip2FAKit
//
//  Created by Jose Aponte on 3/22/17.
//  Copyright © 2017 jappsku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKIB2FAPinBody : NSObject


/// Phone number to which 2FA message will be sent. Must be in international format (Example: 41793026727).
@property (nonatomic, strong) NSString *to;


/// 2FA application ID.
@property (nonatomic, strong) NSString *applicationId;

/// ID of 2FA message that will be sent to a phone number.
@property (nonatomic, strong) NSString *messageId;


/// Sender ID in numeric or alphanumeric format. If this parameter is not set,
/// it will be automatically filled from the created message parameter sender.
@property (nonatomic, strong) NSString *from;


/// Indicates if Number Lookup is needed before sending 2FA message.
/// If the parameter value is true, Number Lookup will be requested before sending SMS.
/// If the value is false, SMS will be sent without requesting Number Lookup. Default value is true.
@property (nonatomic, assign) BOOL ncNeeded;


-(instancetype)initWithTo:(NSString*) to applicationId:(NSString *) applicationId messageId:(NSString*) messageId;

-(NSDictionary*) serialize;
@end
