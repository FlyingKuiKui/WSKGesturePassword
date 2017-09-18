//
//  ViewController.m
//  WSKGesturePassword
//
//  Created by 王盛魁 on 2017/9/18.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "ViewController.h"
#import "WSKGestureRoundView.h"
#import "WSKGesturePasswordService.h"
#import "WSKGestureLineView.h"

@interface ViewController ()<WSKGestureLineViewDelgate>
@property (nonatomic, strong) NSMutableArray *gestureRoundViewArray;
@property (nonatomic, strong) WSKGestureLineView *gestureLineView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGesturePasswordView];

    // Do any additional setup after loading the view, typically from a nib.
}
- (void)setupGesturePasswordView{
    self.gestureRoundViewArray = [NSMutableArray array];
    CGRect frame = self.view.frame;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width/2-160, frame.size.height/2-80, 320, 320)];
    for (int i=0; i<9; i++) {
        NSInteger row = i/3;
        NSInteger col = i%3;
        NSInteger distance = 320/3;
        NSInteger size = distance/1.5;
        NSInteger margin = size/4;
        WSKGestureRoundView *gesturePasswordButton = [[WSKGestureRoundView alloc]initWithFrame:CGRectMake(col*distance+margin, row*distance+margin, size, size)];
        [gesturePasswordButton setTag:i];
        [view addSubview:gesturePasswordButton];
        [self.gestureRoundViewArray addObject:gesturePasswordButton];
    }
    frame.origin.y = 0;
    [self.view addSubview:view];
    self.gestureLineView = [[WSKGestureLineView alloc] initWithFrame:view.frame];
    self.gestureLineView.roundViewArray = self.gestureRoundViewArray;
    self.gestureLineView.delegate = self;
    [self.view addSubview:self.gestureLineView];
}
#pragma mark - WSKGestureLineViewDelegate
- (BOOL)gestureLineView:(WSKGestureLineView *)gestureLineView isSuccessOrErrorPassword:(NSString *)password{
    NSLog(@"resultString:%@",password);
    if (password.length > 4) {
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
