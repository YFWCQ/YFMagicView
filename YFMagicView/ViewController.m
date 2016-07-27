//
//  ViewController.m
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "ViewController.h"

#import "YFSampleViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)showImageMagicAction:(id)sender {
    
    YFSampleViewController *gameVC = [[YFSampleViewController alloc] init];
    gameVC.gameImage = [UIImage imageNamed:@"YFMVB"];
    
    gameVC.rows = 2;
    gameVC.columns = 3;
    
    [self.navigationController pushViewController:gameVC animated:YES];
    
}
- (IBAction)showTextMagicAction:(id)sender {
    
    YFSampleViewController *gameVC = [[YFSampleViewController alloc] init];
    // 总数 需要是 rows X columns
    gameVC.textArray =[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
    gameVC.gameViewScale = 1.0;
    
    gameVC.rows = 3;
    gameVC.columns = 4;
    
    [self.navigationController pushViewController:gameVC animated:YES];
}


@end
