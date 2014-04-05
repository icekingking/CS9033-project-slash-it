//
//  EnvironmentScreenViewController.m
//  Screen
//
//  Created by iceking on 3/8/14.
//  Copyright (c) 2014 iceking. All rights reserved.
//

#import "EnvironmentScreenViewController.h"
#import "HomeScreenViewController.h"
#import "LevelScreenViewController.h"
#import "SettingScreenViewController.h"

@interface EnvironmentScreenViewController ()

@end

@implementation EnvironmentScreenViewController


- (IBAction)settingbutton:(id)sender {
    SettingScreenViewController *settingScreenViewController = [[SettingScreenViewController alloc] init];
    settingScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingScreenViewController"];
    
    [self presentViewController:settingScreenViewController animated:YES completion:Nil];
}



- (IBAction)spacebutton:(id)sender {
    LevelScreenViewController *levelScreenViewController = [[LevelScreenViewController alloc] init];
    levelScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LevelScreenViewController"];
    levelScreenViewController.environmentName= @"space";
    [self presentViewController:levelScreenViewController animated:YES completion:Nil];
    
    
}



- (IBAction)waterbutton:(id)sender {
    LevelScreenViewController *levelScreenViewController = [[LevelScreenViewController alloc] init];
    levelScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LevelScreenViewController"];
    levelScreenViewController.environmentName= @"water";
    [self presentViewController:levelScreenViewController animated:YES completion:Nil];
    
    
}


- (IBAction)earthbutton:(id)sender {
    LevelScreenViewController *levelScreenViewController = [[LevelScreenViewController alloc] init];
    levelScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LevelScreenViewController"];
    levelScreenViewController.environmentName= @"earth";
    [self presentViewController:levelScreenViewController animated:YES completion:Nil];
    
    
}


- (IBAction)Backbutton:(id)sender {
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
