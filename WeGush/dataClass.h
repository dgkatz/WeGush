//
//  dataClass.h
//  WeGush
//
//  Created by Family on 1/17/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataClass : NSObject{
    NSString *chosenGush;
    NSString *target;
    NSString *username;
    NSMutableArray *gushesList;
    NSMutableArray *messageData;
    NSMutableArray *sponsorInfo;
    NSMutableArray *reminderData;
    NSMutableArray *quoteData;
    NSMutableArray *quoteAttributeData;
    int *gushCount;
    NSMutableArray *imageURLData;
    int *dataVersion;
    
}
@property(nonatomic,retain)NSString *target;
@property(nonatomic)int *gushCount;
@property(nonatomic,retain)NSString *chosenGush;
@property(nonatomic,retain)NSString *username;
@property(nonatomic,retain)NSMutableArray *gushesList;
@property(nonatomic,retain)NSMutableArray *messageData;
@property(nonatomic,retain)NSMutableArray *imageURLData;
@property(nonatomic,retain)NSMutableArray *sponsorInfo;
@property(nonatomic,retain)NSMutableArray *reminderData;
@property(nonatomic)int *dataVersion;
@property(nonatomic,retain)NSMutableArray *quoteData;
@property(nonatomic,retain)NSMutableArray *quoteAttributeData;







+(dataClass*)getInstance;
@end
