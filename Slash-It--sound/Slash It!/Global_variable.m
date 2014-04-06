//
//  Global_variable.m
//  Slash It!
//
//  Created by iceking on 4/5/14.
//  Copyright (c) 2014 Savan Rupani. All rights reserved.
//

#import "Global_variable.h"

@implementation Global_variable
{
    Global_variable * anotherSingle;
}

@synthesize gblInt;

+(Global_variable *)singleObj{
    static Global_variable * single = nil;
    
    @synchronized(self){
        if (!single) {
            single = [[Global_variable alloc] init];
        }
    }
    return single;
}

@end
