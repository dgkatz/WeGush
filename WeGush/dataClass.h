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
    
}
@property(nonatomic,retain)NSString *target;
@property(nonatomic,retain)NSString *chosenGush;
@property(nonatomic,retain)NSString *username;
@property(nonatomic,retain)NSMutableArray *gushesList;








+(dataClass*)getInstance;
@end
