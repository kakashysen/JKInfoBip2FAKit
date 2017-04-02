//
//  JKIB2FAPinResult.m
//  JKInfoBip2FAKit
//
//  Created by Jose Aponte on 3/22/17.
//  Copyright © 2017 jappsku. All rights reserved.
//

#import "JKIB2FAPinResult.h"

@implementation JKIB2FAPinResult

-(instancetype)initWithResponse:(NSDictionary *)response
{
  if (self = [super init])
  {
    if (response)
    {
      if ([response objectForKey:@"pinId"])
      {
        self.pinId = [response objectForKey:@"pinId"];
      }
      
      if ([response objectForKey:@"to"])
      {
        self.to = [response objectForKey:@"to"];
      }
      
      if ([response objectForKey:@"ncStatus"])
      {
        NSString *ncstatus = [response objectForKey:@"ncStatus"];
        if ([ncstatus isEqualToString:@"NC_NOT_CONFIGURED"])
        {
          self.ncStatus = NcStatusNotConfigured;
        }
        else if ([ncstatus isEqualToString:@"NC_DESTINATION_UNKNOWN"])
        {
          self.ncStatus = NcStatusDestinationUnknown;
        }
        else if ([ncstatus isEqualToString:@"NC_DESTINATION_REACHABLE"])
        {
          self.ncStatus = NcStatusDestinationReachable;
        }
        else if ([ncstatus isEqualToString:@"NC_DESTINATION_NOT_REACHABLE"])
        {
          self.ncStatus = NcStatusDestinationNotReachable;
        }
        else
        {
          self.ncStatus = NcStatusUnknown;
        }
      }
      
      if ([response objectForKey:@"smsStatus"])
      {
        NSString* status = [response objectForKey:@"smsStatus"];
          if ([status isEqualToString:@"MESSAGE_SENT"])
          {
              self.smsStatus = SmsStatusMessageSent;
          }
          else
          {
              self.smsStatus = SmsStatusMessageNotSent;
          }
      }
    }
  }
  return self;
}

@end
