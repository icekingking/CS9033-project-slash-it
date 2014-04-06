//
//  ViewController.m
//  Slash It!
//
//  Created by Savan on 3/14/14.
//  Copyright (c) 2014 Savan Rupani. All rights reserved.
//

#import "ViewController.h"
#import "EnvironmentScreenViewController.h"
#import "SettingScreenViewController.h"
#import "HomeScreenViewController.h"
#import "ViewController.h"
#import "GameCenterScreenViewController.h"
#import "GameScene.h"
#import "Audio.h"
#import "Global_variable.h"

@implementation ViewController{
    GameScene *scene;
    UIImage *backgroundImage;
    UIImageView *backgroundImageView;
}


int status = 0;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    
    // Create and configure the scene.
    scene = [GameScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.levelName = self.levelName;
    scene.environmentName = self.environmentName;
    [scene draw];
    // Present the scene.
    [skView presentScene:scene];
    [[Audio sharedInstance] pauseMainBackgroundMusic];
    optionSingle = [Global_variable singleObj];
    if (optionSingle.gblInt == 0) {
        [[Audio sharedInstance] playBackgroundMusic:@"background.mp3"];
    }
    

}


/*
 In response to a swipe gesture, show the image view appropriately then move the image view in the direction of the swipe as it fades out.
 */


- (IBAction)resumebutton:(id)sender {
    scene.touchFlag = 1;
    
    [backgroundImageView removeFromSuperview];
    if (status == 1) {
        scene.paused = NO;
        status = 0;
        self.homebutton.hidden = YES;
        self.resumebutton.hidden = YES;
        self.environmentbutton.hidden = YES;
        self.settingbutton.hidden = YES;
        self.gamecenterbutton.hidden = YES;
        self.pausebutton.hidden = NO;
        if (optionSingle.gblInt == 0) {
            [[Audio sharedInstance] playBackgroundMusic:@"background.mp3"];
        }
        
        
        
    }
}

- (IBAction)environmentbutton:(id)sender{
    scene.touchFlag = 1;
    
    status = 0;
    EnvironmentScreenViewController *environmentScreenViewController = [[EnvironmentScreenViewController alloc] init];
    environmentScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EnvironmentScreenViewController"];
    
    [self presentViewController:environmentScreenViewController animated:YES completion:Nil];
    if (optionSingle.gblInt == 0) {
        [[Audio sharedInstance] playMainBackgroundMusic:@"background2.mp3"];
    }
}

- (IBAction)homebutton:(id)sender {
    scene.touchFlag = 1;
    status = 0;
    HomeScreenViewController *homeScreenViewController = [[HomeScreenViewController alloc] init];
    homeScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreenViewController"];
    
    [self presentViewController:homeScreenViewController animated:YES completion:Nil];
    if (optionSingle.gblInt == 0) {
        [[Audio sharedInstance] playMainBackgroundMusic:@"background2.mp3"];
    }
}


- (IBAction)settingbutton:(id)sender {
    
    status = 0;
    SettingScreenViewController *settingScreenViewController = [[SettingScreenViewController alloc] init];
    settingScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingScreenViewController"];
    
    [self presentViewController:settingScreenViewController animated:YES completion:Nil];
    if (optionSingle.gblInt == 0) {
        [[Audio sharedInstance] playMainBackgroundMusic:@"background2.mp3"];
    }
}

- (IBAction)gamecenterbutton:(id)sender {
    /*
    status = 0;
    GameCenterScreenViewController *gameCenterScreenViewController = [[GameCenterScreenViewController alloc] init];
    gameCenterScreenViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GameCenterScreenViewController"];
    
    [self presentViewController:gameCenterScreenViewController animated:YES completion:Nil];
    [[Audio sharedInstance] playMainBackgroundMusic:@"background2.mp3"];
     */
}



- (IBAction)pausebutton:(id)sender {
    backgroundImage = [UIImage imageNamed:@"background.jpg"];
    backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view insertSubview:backgroundImageView atIndex:0];
    backgroundImageView.image = backgroundImage;
    scene.touchFlag = 0;
    if (status == 0) {
        scene.paused = YES;
        status = 1;
        self.homebutton.hidden = NO;
        self.resumebutton.hidden = NO;
        self.environmentbutton.hidden = NO;
        self.settingbutton.hidden = NO;
        self.gamecenterbutton.hidden = NO;
        self.pausebutton.hidden = YES;
        [[Audio sharedInstance] pauseBackgroundMusic];
        
        
    }
    
    //SKView *spriteView = (SKView *) self.view;
    //SKScene *currentScene = [spriteView scene];
    
    /*
     [newScene.userData setObject:[currentScene.userData objectForKey:@"score"] forKey:@"score"];
     [spriteView presentScene:newScene];
     */
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}



/*
- (IBAction)takeLeftSwipeRecognitionEnabledFrom:(UISegmentedControl *)aSegmentedControl {
    
    if ([aSegmentedControl selectedSegmentIndex] == 0) {
        [self.view addGestureRecognizer:self.swipeLeftRecognizer];
    }
    else {
        [self.view removeGestureRecognizer:self.swipeLeftRecognizer];
    }
}
*/

/*
 In response to a swipe gesture, show the image view appropriately then move the image view in the direction of the swipe as it fades out.
*/
/*
- (IBAction)showGestureForSwipeRecognizer:(UISwipeGestureRecognizer *)recognizer {
    
	CGPoint location = [recognizer locationInView:self.view];
	NSLog(@"SWIPE GESTURE POINT :: %f %f",location.x,location.y);
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    // Disallow recognition of tap gestures in the segmented control.
    if ((touch.view == self.segmentedControl) && (gestureRecognizer == self.tapRecognizer)) {
        return NO;
    }
    return YES;
}
*/
@end
