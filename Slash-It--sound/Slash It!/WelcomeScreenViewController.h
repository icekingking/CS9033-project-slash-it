//
//  WelcomeScreenViewController.h
//  Screen
//
//  Created by iceking on 3/8/14.
//  Copyright (c) 2014 iceking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global_variable.h"

@interface WelcomeScreenViewController : UIViewController
{
    NSTimer *SwitchTimer;
    Global_variable * temp;
}

@property (nonatomic, retain) NSTimer *SwitchTimer;

@end
