//
//  ViewController.h
//  Slash It!
//

//  Copyright (c) 2014 Savan Rupani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"
@interface ViewController : UIViewController <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *pausebutton;

@property NSString *levelSetName;
@property NSString *levelName;
@property GameScene *scene;
@property int winningScore;

@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *winScoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *currentScorelbl;




@end
