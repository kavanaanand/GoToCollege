//
//  Request.m
//  GoToCollege
//
//  Created by Kavana Anand on 11/8/15.
//  Copyright © 2015 Kavana Anand. All rights reserved.
//

#import "Request.h"

NSString* const kBaseURL      = @"http://localhost:3000";
NSString* const kUniversity   = @"/univdetails";
NSString* const kUserLogin    = @"/userlogin?";
NSString* const kCalculator   = @"/calculator?";

NSString* const kRequestTypeGET         = @"GET";
NSString* const kRequestTypePOST        = @"POST";
NSString* const kResponseTypeJSON       = @"application/json";
NSString* const kAccept                 = @"Accept";

NSString* const kTitle         = @"title";
NSString* const kMessage       = @"message";
NSString* const kError         = @"error";
NSString* const kSuccess       = @"success";


@implementation Request


-(void)requestFeedFromServerFor:(RequestType)reqType withDetails:(UserObjet *)userObj {
    [self setRequestedType:reqType];
    [self setReqUserObj:userObj];
    [self initiateRequest];
}

-(void)requestResultsFromServerFor:(RequestType)reqType withDetails:(CalculateDataObject *)calcObj {
    [self setRequestedType:reqType];
    [self setReqCalcObj:calcObj];
    [self initiateRequest];
}


-(void)initiateRequest
{
    NSURL *url = [NSURL URLWithString:[self getReuqestURL]];
    
    NSMutableURLRequest *request;
    
    request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    [request setHTTPMethod:@"GET"];
    [request setValue:kResponseTypeJSON forHTTPHeaderField:kAccept];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data,
                                                             NSURLResponse *response,
                                                             NSError *error) {
        if ([self requestedType] == eCalculate) {
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [[self f2cRequestDelegate] didFinishUniversitiesResponse:json withType:[self requestedType]];
        } else if ([self requestedType] == eUserLogin) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if ([[json valueForKey:kTitle] isEqualToString:kError]) {
                NSLog(@"ERROR!!!");
                [[self f2cRequestDelegate] didFailResponse:[json valueForKey:kMessage] withType:[self requestedType]];
            } else {
                [[self f2cRequestDelegate] didFinishResponse:nil withType:[self requestedType]];
            }
        } else if([self requestedType] == eUniversity) {
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [[self f2cRequestDelegate] didFinishUniversitiesResponse:json withType:[self requestedType]];
        } else {
            NSLog(@"Wrong Type\n");
        }
    }] resume];
    
}

-(NSString*)getReuqestURL {
    NSString *urlStr =  [[NSString alloc]init];
    
    switch ([self requestedType]) {
        case eUserLogin:
        {
            urlStr = [urlStr stringByAppendingFormat:@"%@%@user=%@&email=%@&income=%@&savings=%@",kBaseURL,kUserLogin,[[self reqUserObj] userName],[[self reqUserObj] userEmail],[[self reqUserObj] userIncome],[[self reqUserObj] userSavings]];
        }
        break;
            
        case eUniversity:
        {
            urlStr = [urlStr stringByAppendingFormat:@"%@%@",kBaseURL,kUniversity];
        }
        break;
        case eCalculate:
        {
            urlStr = [urlStr stringByAppendingFormat:@"%@%@affordable_tution=%@&email=%@&major=%@&no_of_years=%@",kBaseURL,kCalculator,[[self reqCalcObj] userTuitionCost],[[self reqCalcObj] userEmail],[[self reqCalcObj] userMajor],[[self reqCalcObj] userYears]];
        }
        break;
        default:
        {
            NSLog(@"Something is wrong! Feed Type is invalid");
        }
            break;
    }
    NSLog(@"req: %@",urlStr);
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"req: %@",urlStr);
    return urlStr;
}

#pragma mark - Connection Success and Failure methods

-(void)didFinishResponse:(NSData*)inData withFeedType:(RequestType)reqType{
    
    NSError *error =  nil;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:inData options:NSJSONReadingAllowFragments error:&error];
    if([self requestedType] == eUniversity){
        [[self f2cRequestDelegate] didFinishResponse:json withType:reqType];
    }
    else if ([self requestedType] == eUserLogin) {
        [[self f2cRequestDelegate] didFinishResponse:json withType:reqType];
    } else if ([self requestedType] == eCalculate) {
        
    }
}

-(void)didFailResponse:(NSString*)inString withFeedType:(RequestType)reqType{
    
    [[self f2cRequestDelegate] didFailResponse:inString withType:reqType];
}


@end
