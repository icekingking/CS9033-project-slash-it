//
//  GameScene.h
//  Slash It!
//
//  Created by Savan on 3/23/14.
//  Copyright (c) 2014 Savan Rupani. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Global_variable.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate>{
    Global_variable * temp;
}
@property int touchFlag;
@property int numberOfObjects;
@property NSString *environmentName;
@property NSString *levelName;
@property int activeTouch;
@property int intersectionCount;

-(void) draw;

@end
