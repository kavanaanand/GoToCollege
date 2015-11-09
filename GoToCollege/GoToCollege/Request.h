//
//  Request.h
//  GoToCollege
//
//  Created by Kavana Anand on 11/8/15.
//  Copyright © 2015 Kavana Anand. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AFNetworking/AFJSONRequestOperation.h"
#import "UserObjet.h"
#import "CalculateDataObject.h"


typedef enum RequestType
{
    eUserLogin = 1,
    eUniversity,
    eCalculate
}RequestType;


@protocol F2CRequestProtocol;

@interface Request : NSObject<NSURLSessionTaskDelegate> {
    
}
@property (nonatomic,weak) id<F2CRequestProtocol> f2cRequestDelegate;
@property (nonatomic,assign) RequestType requestedType;
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) UserObjet *reqUserObj;
@property (strong, nonatomic) CalculateDataObject *reqCalcObj;
@property (strong, nonatomic) NSMutableData *receivedData;

-(void)requestFeedFromServerFor:(RequestType)reqType withDetails:(UserObjet *)details;
-(void)requestResultsFromServerFor:(RequestType)reqType withDetails:(CalculateDataObject *)details;

@end


@protocol F2CRequestProtocol <NSObject>

-(void)didFailResponse:(NSString *)failResponse withType:(RequestType)reqType;

@optional
-(void)didFinishUniversitiesResponse:(NSArray *)resultArray withType:(RequestType)reqType;
-(void)didFinishResponse:(NSDictionary *)resultDict withType:(RequestType)reqType;

@end