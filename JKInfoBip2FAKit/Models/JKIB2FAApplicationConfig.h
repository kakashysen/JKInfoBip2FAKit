//
//  JKIB2FApplicationConfig.h
//  JKInfoBip2FAKit
//
//  Created by Jose Aponte on 3/22/17.
//  Copyright © 2017 jappsku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKIB2FAApplicationConfig : NSObject


@property (nonatomic, strong) NSNumber *pintimeToLive;
@property (nonatomic, strong) NSNumber *pinattempts;
@property (nonatomic, strong) NSNumber *verificationAttempts;
@property (nonatomic, strong) NSNumber *verificationIntervalLength;
@property (nonatomic, strong) NSNumber *overallInitiationAttempts;
@property (nonatomic, strong) NSNumber *overallInitiationIntervalLength;
@property (nonatomic, strong) NSNumber *allowMultiplePinVerifications;
@property (nonatomic, strong) NSNumber *deviceVerificationAttempts;
@property (nonatomic, strong) NSNumber *deviceVerificationIntervalLength;


@end
