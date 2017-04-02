//
//  JKIB2FAPinBody.m
//  JKInfoBip2FAKit
//
//  Created by Jose Aponte on 3/22/17.
//  Copyright © 2017 jappsku. All rights reserved.
//

#import "JKIB2FAPinBody.h"

@implementation JKIB2FAPinBody

-(instancetype)initWithTo:(NSString*) to applicationId:(NSString *) applicationId messageId:(NSString*) messageId;
{
    if (self = [super init])
    {
        self.to = to;
        self.applicationId = applicationId;
        self.messageId = messageId;
        self.ncNeeded = YES;
    }
    
    return self;
}

-(NSDictionary *)serialize
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (self.applicationId == nil || self.to == nil || self.messageId == nil )
    {
        return nil;
    }
    
    [dict setObject:self.applicationId forKey:@"applicationId"];
    [dict setObject:self.messageId forKey:@"messageId"];
    [dict setObject:self.to forKey:@"to"];
    
    if (self.from)
    {
        [dict setObject:self.from forKey:@"from"];
    }
    
    if (self.ncNeeded)
    {
        [dict setObject:@YES forKey:@"ncNeeded"];
    }
    else
    {
        [dict setObject:@NO forKey:@"ncNeeded"];
    }
    
    return dict;
}

@end
