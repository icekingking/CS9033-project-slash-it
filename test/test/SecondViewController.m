//
//  SecondViewController.m
//  test
//
//  Created by iceking on 3/7/14.
//  Copyright (c) 2014 iceking. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ViewController *view = [segue destinationViewController];
    [view passinput:self.textbox.text];
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
