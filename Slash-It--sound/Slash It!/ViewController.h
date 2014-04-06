//
//  ViewController.h
//  Slash It!
//

//  Copyright (c) 2014 Savan Rupani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "Global_variable.h"

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>{
    Global_variable * optionSingle;
}
@property (weak, nonatomic) IBOutlet UIButton *resumebutton;
@property (weak, nonatomic) IBOutlet UIButton *environmentbutton;
@property (weak, nonatomic) IBOutlet UIButton *homebutton;
@property (weak, nonatomic) IBOutlet UIButton *gamecenterbutton;
@property (weak, nonatomic) IBOutlet UIButton *settingbutton;
@property (weak, nonatomic) IBOutlet UIButton *pausebutton;

@property NSString *environmentName;
@property NSString *levelName;

/*
@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *swipeLeftRecognizer;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;
*/

@end
