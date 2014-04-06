//
//  SettingScreenViewController.h
//  Screen
//
//  Created by iceking on 3/8/14.
//  Copyright (c) 2014 iceking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global_variable.h"

@interface SettingScreenViewController : UIViewController {
    Global_variable * optionSingle;
}

//@property NSInteger switchcheck;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentcontrol;
- (IBAction)segmentvaluechange:(id)sender;

@end
