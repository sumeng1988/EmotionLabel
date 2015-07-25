//
//  ViewController.m
//  EmotionLabel
//
//  Created by sumeng on 3/2/15.
//  Copyright (c) 2015 sumeng. All rights reserved.
//

#import "ViewController.h"
#import "EmotionInfo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *originLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 0)];
    originLbl.layer.borderColor = [[UIColor redColor] CGColor];
    originLbl.layer.borderWidth = 1;
    originLbl.numberOfLines = 0;
    originLbl.font = [UIFont systemFontOfSize:17];
    originLbl.textColor = [UIColor blackColor];
    originLbl.text = @"origin: hello[hi], nice to meet you[smile]";
    [originLbl sizeToFit];
    [self.view addSubview:originLbl];
    
    UILabel *emotionLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 200, 0)];
    emotionLbl.layer.borderColor = [[UIColor redColor] CGColor];
    emotionLbl.layer.borderWidth = 1;
    emotionLbl.numberOfLines = 0;
    emotionLbl.font = [UIFont systemFontOfSize:17];
    emotionLbl.textColor = [UIColor blackColor];
    emotionLbl.attributedText = [EmotionInfo attributedString:@"convert: hello[hi], nice to meet you[smile]"];
    [emotionLbl sizeToFit];
    [self.view addSubview:emotionLbl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
