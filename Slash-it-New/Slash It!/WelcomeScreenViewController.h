//
//  WelcomeScreenViewController.h
//  Screen
//
//  Created by iceking on 3/8/14.
//  Copyright (c) 2014 iceking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeScreenViewController : UIViewController
{
    NSTimer *SwitchTimer;
    
    
}
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, retain) NSTimer *SwitchTimer;


@end
