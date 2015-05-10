//
//  dataClass.h
//  WeGush
//
//  Created by Family on 1/17/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataClass : NSObject{
    NSString *chosenMessage;
    NSString *chosenGush;
    int chosenIndex;
    NSString *target;
    NSString *username;
    NSMutableArray *imageData;
    NSMutableArray *gushesList;
    NSMutableArray *messageData;
    NSMutableArray *sponsorInfo;
    NSMutableArray *reminderData;
    NSMutableArray *quoteData;
    NSMutableArray *quoteAttributeData;
    int *gushCount;
    NSMutableArray *imageURLData;
    int *dataVersion;
    int twiceADay;
    int doneLoading;
    int totalGushesSent;

    
}
@property(nonatomic,retain)NSString *chosenMessage;
@property(nonatomic,retain)NSString *target;
@property(nonatomic)int *gushCount;
@property (nonatomic)int twiceADay;
@property (nonatomic)int totalGushesSent;
@property (nonatomic)int doneLoading;
@property(nonatomic)int chosenIndex;
@property(nonatomic,retain)NSString *chosenGush;
@property(nonatomic,retain)NSString *username;
@property(nonatomic,retain)NSMutableArray *gushesList;
@property(nonatomic,retain)NSMutableArray *messageData;
@property(nonatomic,retain)NSMutableArray *imageURLData;
@property(nonatomic,retain)NSMutableArray *imageData;
@property(nonatomic,retain)NSMutableArray *sponsorInfo;
@property(nonatomic,retain)NSMutableArray *reminderData;
@property(nonatomic)int *dataVersion;
@property(nonatomic,retain)NSMutableArray *quoteData;
@property(nonatomic,retain)NSMutableArray *quoteAttributeData;







+(dataClass*)getInstance;
@end
