//
//  MovingObject.h
//  Slash It!
//
//  Created by Savan on 4/21/14.
//  Copyright (c) 2014 Savan Rupani. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MovingObject : SKSpriteNode

@property  NSString *type;
@property NSMutableArray *myObjects;
@property int numberOfObjects;
@property  NSNumber *objectSpeed;

-(void)spawnObjects:(NSString*)SetName lName:(NSString*)levelName;
-(void)spawnObjectsWithType:(NSString*)SetName lName:(NSString*)levelName;

@end
