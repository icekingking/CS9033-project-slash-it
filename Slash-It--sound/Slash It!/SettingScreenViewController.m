//
//  SettingScreenViewController.m
//  Screen
//
//  Created by iceking on 3/8/14.
//  Copyright (c) 2014 iceking. All rights reserved.
//

#import "SettingScreenViewController.h"
#import "HomeScreenViewController.h"
#import "Audio.h"

@interface SettingScreenViewController ()

@end

@implementation SettingScreenViewController

- (IBAction)backbutton:(id)sender {
    HomeScreenViewController *homeScreenViewController = [[HomeScreenViewController alloc] init];
    homeScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreenViewController"];
    
    [self presentViewController:homeScreenViewController animated:YES completion:Nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *backgroundImage = [UIImage imageNamed:@"background.jpg"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view insertSubview:backgroundImageView atIndex:0];
    backgroundImageView.image=backgroundImage;
    optionSingle = [Global_variable singleObj];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentvaluechange:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            optionSingle.gblInt = 0;
            [[Audio sharedInstance] playMainBackgroundMusic:@"background2.mp3"];
            break;
        case 1:
            optionSingle.gblInt = -1;
            [[Audio sharedInstance] pauseMainBackgroundMusic];
        default:
            break;
    }
    
    
    
    
}
@end
