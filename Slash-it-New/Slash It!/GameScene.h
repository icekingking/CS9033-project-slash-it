//
//  GameScene.h
//  Slash It!
//
//  Created by Savan on 3/23/14.
//  Copyright (c) 2014 Savan Rupani. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>
@property int numberOfObjects;
@property NSString *levelSetName;
@property NSString *levelName;
@property int drawLineCut;
@property int intersectionCount;
@property int winningScore;
@property int finalScore;
@property int maxScore;
@property int minScore;

@property int numberOfCuts;
@property float finalTime;
@property float gamePaused;
-(void) draw;
@property (nonatomic, copy) void (^goBackToLevel)();
@property (nonatomic, copy) void (^restartLevel)();
@property (nonatomic, copy) void (^changeScore)(float score);

@end
