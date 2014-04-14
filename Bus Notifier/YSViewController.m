//
//  YSViewController.m
//  Bus Notifier
//
//  Created by Wooseong Kim on 2014. 4. 14..
//  Copyright (c) 2014년 Yooii Studios. All rights reserved.
//

#import "YSViewController.h"

@interface YSViewController ()

@end

@implementation YSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Buttons
-(IBAction)registorButtonClicked:(id)sender {
    NSLog(@"registorButtonClicked");
}

-(IBAction)cancelButtonClicked:(id)sender {
    NSLog(@"cancelButtonClicked");
}

@end
