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
