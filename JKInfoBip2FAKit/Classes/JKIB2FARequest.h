//
//  JKInfoBip2FARequest.h
//  JKInfoBip2FAKit
//
//  Created by Jose Aponte on 3/22/17.
//  Copyright © 2017 jappsku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKIB2FAPinBody.h"
#import "JKIB2FAPinResult.h"
#import "JKIB2FAResponseError.h"
#import "JKIB2FAPinVerifyResult.h"
#import <AFNetworking/AFNetworking.h>
#import <JKInfoBip2FAKit/JKIB2FAApplication.h>

// Base URL
#define URL_INFO_BIP @"https://api.infobip.com/2fa/1/"

// Endpoints
#define ENDPOINT_SEND_SMS @"pin"
#define ENDPOINT_VERIFY_SMS @"pin/:pinId/verify"
#define ENDPOPINT_RESEND_SMS @"pin/:pinId/resend"


@class JKIB2FARequest;

@protocol JKIB2FARequestDelegate<NSObject>;

@optional

/**
 * @param pinResult
 * This paramter can contains next values
 * to - Phone number to which 2FA message was sent.
 * ncStatus - Status of sent Number Lookup.
 * ncStatus ccan have one of the following values:
 * NC_DESTINATION_UNKNOWN, NC_DESTINATION_REACHABLE, NC_DESTINATION_NOT_REACHABLE, NC_NOT_CONFIGURED.
 * If you get NC_NOT_CONFIGURED status, you should contact your account manager for configuring it.
 * SMS will not be sent only if Number Lookup status is NC_NOT_REACHABLE.
 * smsStatus - Can have one of the following values: MESSAGE_SENT, MESSAGE_NOT_SENT.
 * pinId - The Pin ID sent
 *
 */
-(void)sendSmsWithPinBodyDidFinishSuccessful:(JKIB2FAPinResult*) pinResult;

/**
 * @param responseError
 * This object may contains messageId property and text property
 *
 * @param statusCode
 * This are the posibles status codes:
 *
 * 400	Bad Request - The request could not be understood by the server due to malformed syntax or invalid argument.
 *
 * 401	Unauthorized - The request requires user authentication or, if the request included authorization credentials, authorization has been refused for those credentials.
 *
 * 404	Not Found - The requested resource could not be found. This error can be due to a temporary or permanent condition.
 *
 * 429	Too Many Requests - Rate limiting has been applied.
 *
 * 500	Internal Server Error.
 *
 * 503	Service Unavailable - The server is currently unable to handle the request due to a temporary condition which will be alleviated after some delay. You can choose to resend the request again.
 *
 */
-(void)sendSmsWithPinBodyDidFinishFailure:(JKIB2FAResponseError*) responseError statusCode:(NSInteger) statusCode;


/**
 * @param pinVerifyResult
 * This paramter can contains next values
 * pinId - The pinId sent
 * msisdn - Phone number (msisdn) to which 2FA message was sent.
 * verified - true if the verification was successful, false otherwise
 * attemptsRemaining - Number of remaining PIN attempts.
 * pinError - Indicates if any error occurs during PIN verification, can have one of the following values:
 * WRONG_PIN
 * TTL_EXPIRED
 * NO_MORE_PIN_ATTEMPTS
 *
 */
-(void)verifySmsCodeWithPinIdDidFinishSuccessful:(JKIB2FAPinVerifyResult*) pinVerifyResult;

/**
 *
 * @param responseError
 * This object may contains messageId property and text property
 *
 * @param statusCode
 * This are the posibles status codes:
 *
 * 400	Bad Request - The request could not be understood by the server due to malformed syntax or invalid argument.
 *
 * 401	Unauthorized - The request requires user authentication or, if the request included authorization credentials, authorization has been refused for those credentials.
 *
 * 404	Not Found - The requested resource could not be found. This error can be due to a temporary or permanent condition.
 *
 * 429	Too Many Requests - Rate limiting has been applied.
 *
 * 500	Internal Server Error.
 *
 * 503	Service Unavailable - The server is currently unable to handle the request due to a temporary condition which will be alleviated after some delay. You can choose to resend the request again.
 *
 */
-(void)verifySmsCodeWithPinIdDidFinishFailure:(JKIB2FAResponseError*) responseError statusCode:(NSInteger) statusCode;


/**
 * @param pinResult
 * This paramter can contains next values
 * to - Phone number to which 2FA message was sent.
 * ncStatus - Status of sent Number Lookup.
 * ncStatus can have one of the following values:
 * NC_DESTINATION_UNKNOWN, NC_DESTINATION_REACHABLE, NC_DESTINATION_NOT_REACHABLE, NC_NOT_CONFIGURED.
 * If you get NC_NOT_CONFIGURED status, you should contact your account manager for configuring it.
 * SMS will not be sent only if Number Lookup status is NC_NOT_REACHABLE.
 * smsStatus - Can have one of the following values: MESSAGE_SENT, MESSAGE_NOT_SENT.
 * pinId - The Pin ID sent
 *
 */
-(void)resendSmsCodeWithPinIdDidFinishSuccessful:(JKIB2FAPinResult*) pinResult;

/**
 *
 * This object may contains messageId property and text property
 *
 * @param statusCode
 * This are the posibles status codes:
 *
 * 400	Bad Request - The request could not be understood by the server due to malformed syntax or invalid argument.
 *
 * 401	Unauthorized - The request requires user authentication or, if the request included authorization credentials, authorization has been refused for those credentials.
 *
 * 404	Not Found - The requested resource could not be found. This error can be due to a temporary or permanent condition.
 *
 * 429	Too Many Requests - Rate limiting has been applied.
 *
 * 500	Internal Server Error.
 *
 * 503	Service Unavailable - The server is currently unable to handle the request due to a temporary condition which will be alleviated after some delay. You can choose to resend the request again.
 *
 */
-(void)resendSmsCodeWithPinIdDidFinishFailure:(JKIB2FAResponseError*) responseError statusCode:(NSInteger) statusCode;

@end

@interface JKIB2FARequest : NSObject<JKIB2FARequestDelegate>

@property (nonatomic, weak) id<JKIB2FARequestDelegate> delegate;

/**
 * @method -sendSmsWithPinBody:
 *
 * @param pinBody
 * This object contains the response of the process
 *
 * @discussion
 * This method allows you to generate and send a PIN code over SMS to provided destination address.
 * When use this method is needed to implement the two methods of JKIB2FARequestDelegate Protocol to get results
 *
 * -(void)sendSmsWithPinBodyDidFinishSuccessful:(JKIB2FAPinResult*) pinResult
 * -(void)sendSmsWithPinBodyDidFinishFailure:(JKIB2FAResponseError*) responseError statusCode:(NSInteger) statusCode
 */
-(void)sendSmsWithPinBody:(JKIB2FAPinBody *) pinBody;


/**
 * @method -verifySmsCodeWithPinId:andCode:
 * 
 * @param pinId
 * The pinId returned by the method -sendSmsWithPinBody: in the parameter JKIB2FAPinBody
 *
 * @param code
 * The code returned by the method -sendSmsWithPinBody: in the parameter JKIB2FAPinBody
 *
 * @discussion
 * This method allows you to verify the PIN sent over SMS.
 * When use this method is needed to implement the two methods of JKIB2FARequestDelegate Protocol to get results
 *
 * -(void)verifySmsCodeWithPinIdDidFinishSuccessful:(JKIB2FAPinVerifyResult*) pinVerifyResult
 * -(void)verifySmsCodeWithPinIdDidFinishFailure:(JKIB2FAResponseError*) responseError statusCode:(NSInteger) statusCode
 */
-(void)verifySmsCodeWithPinId:(NSString*)pinId andCode:(NSString*) code;


/**
 * @method -resendSmsCodeWithPinId:
 *
 * @param pinId
 * The pinId returned by the method -sendSmsWithPinBody: in the parameter JKIB2FAPinBody
 *
 * @discussion
 * This method allows you to resend PIN over SMS.
 * When use this method is needed to implement the two methods of JKIB2FARequestDelegate Protocol to get results
 *
 * -(void)resendSmsCodeWithPinIdDidFinishSuccessful:(JKIB2FAPinResult*) pinResult
 * -(void)resendSmsCodeWithPinIdDidFinishFailure:(JKIB2FAResponseError*) responseError statusCode:(NSInteger) statusCode
 */
-(void)resendSmsCodeWithPinId:(NSString*) pinId;

@end
