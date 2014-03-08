//
//  ViewController.h
//  test
//

//  Copyright (c) 2014 iceking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface ViewController : UIViewController
{
    NSString * user_input;
}
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *label2;

-(void) passinput:(NSString *)input;


@end
