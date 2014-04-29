//
//  LevelScreenViewController.h
//  Screen
//
//  Created by iceking on 3/8/14.
//  Copyright (c) 2014 iceking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelScreenViewController : UIViewController
@property NSString *levelSetName;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;

-(void)initWithLevelSetName:(NSString *)env;
@end
