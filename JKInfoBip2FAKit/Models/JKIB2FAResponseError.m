//
//  JKIB2FAPinFail.m
//  JKInfoBip2FAKit
//
//  Created by Jose Aponte on 3/22/17.
//  Copyright © 2017 jappsku. All rights reserved.
//

#import "JKIB2FAResponseError.h"

@implementation JKIB2FAResponseError

-(instancetype)initWithResponse:(NSDictionary *)response
{
  if (self = [super init])
  {
    if (response)
    {
      if ([response objectForKey:@"requestError"])
      {
        NSDictionary *requestError = [response objectForKey:@"requestError"];
        if ([requestError objectForKey:@"serviceException"])
        {
          NSDictionary *serviceException = [requestError objectForKey:@"serviceException"];
          if ([serviceException objectForKey:@"messageId"])
          {
            self.messageId = [serviceException objectForKey:@"messageId"];
          }
          if ([serviceException objectForKey:@"text"])
          {
            self.text = [serviceException objectForKey:@"text"];
          }
        }
      }
    }
  }
  return self;
}

@end
