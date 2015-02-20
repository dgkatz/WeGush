//
//  dataClass.m
//  WeGush
//
//  Created by Family on 1/17/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "dataClass.h"

@implementation dataClass
@synthesize target;
@synthesize username;
@synthesize gushesList;
@synthesize chosenGush;
@synthesize messageData;
@synthesize gushCount;
@synthesize sponsorInfo;
@synthesize imageURLData;
@synthesize dataVersion;
@synthesize reminderData;
@synthesize quoteAttributeData;
@synthesize quoteData;
static dataClass *instance = nil;


+(dataClass *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [dataClass new];
        }
    }
    return instance;
}
@end
