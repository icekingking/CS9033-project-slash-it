//
//  Global_variable.h
//  Slash It!
//
//  Created by iceking on 4/5/14.
//  Copyright (c) 2014 Savan Rupani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global_variable : NSObject {
    int gblInt;
}

@property(nonatomic) int gblInt;

+(Global_variable *) singleObj;

@end
