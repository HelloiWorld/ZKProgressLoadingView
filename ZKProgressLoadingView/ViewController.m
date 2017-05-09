//
//  ViewController.m
//  ZKProgressLoadingView
//
//  Created by pzk on 17/5/8.
//  Copyright © 2017年 Aone. All rights reserved.
//

#import "ViewController.h"
#import "LoadingView.h"
#import "NSTimer+WeakTimer.h"

@interface ViewController ()

@property (strong, nonatomic) LoadingView *loadingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)successClick:(id)sender {
    self.loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 100)];
    [self.view addSubview:self.loadingView];
    __weak typeof(self) weakSelf = self;
    self.loadingView.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES handlerBlock:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.loadingView progressUpdate];
    }];
    // succeed after 3 seconds
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loadingView progressFinish];
    });
}

- (IBAction)failureClick:(id)sender {
    self.loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 100)];
    [self.view addSubview:self.loadingView];
    __weak typeof(self) weakSelf = self;
    self.loadingView.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES handlerBlock:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.loadingView progressUpdate];
    }];
}

- (IBAction)multipleClick:(id)sender {
    self.loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 100)];
    [self.view addSubview:self.loadingView];
    
    dispatch_async(dispatch_queue_create("com.queue.test1", DISPATCH_QUEUE_CONCURRENT), ^{
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"dispatch-1");
        [self.loadingView updateProgressValue:0.4];
    });
    dispatch_async(dispatch_queue_create("com.queue.test2", DISPATCH_QUEUE_CONCURRENT), ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"dispatch-2");
        [self.loadingView updateProgressValue:0.3];
    });
    dispatch_async(dispatch_queue_create("com.queue.test3", DISPATCH_QUEUE_CONCURRENT), ^{
        [NSThread sleepForTimeInterval:4];
        NSLog(@"dispatch-3");
        [self.loadingView updateProgressValue:0.2];
    });
    dispatch_async(dispatch_queue_create("com.queue.test4", DISPATCH_QUEUE_CONCURRENT), ^{
        [NSThread sleepForTimeInterval:8];
        NSLog(@"dispatch-4");
        [self.loadingView updateProgressValue:0.1];
    });
}

@end
