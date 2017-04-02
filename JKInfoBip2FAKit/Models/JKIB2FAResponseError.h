//
//  JKIB2FAPinFail.h
//  JKInfoBip2FAKit
//
//  Created by Jose Aponte on 3/22/17.
//  Copyright © 2017 jappsku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKIB2FAResponseError : NSObject

/// ID of an error
@property (nonatomic, strong) NSString *messageId;

/// A short description of the error.
@property (nonatomic, strong) NSString *text;

-(instancetype)initWithResponse:(NSDictionary*) response;

@end
