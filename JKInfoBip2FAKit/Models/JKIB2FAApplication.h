//
//  JKIB2FApplication.h
//  JKInfoBip2FAKit
//
//  Created by Jose Aponte on 3/22/17.
//  Copyright © 2017 jappsku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKIB2FAApplicationConfig.h"

@interface JKIB2FAApplication : NSObject

@property (nonatomic, strong) NSString *applicationId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) JKIB2FAApplicationConfig *configuration;
@property (nonatomic, assign) BOOL *enabled;
@property (nonatomic, strong) NSString *processId;

@end
