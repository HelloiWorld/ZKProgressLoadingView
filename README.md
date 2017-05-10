# ZKProgressLoadingView

## Easy to use
    #import "LoadingView.h"
    @property (strong, nonatomic) LoadingView *loadingView;

    self.loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 100)];
    [self.view addSubview:self.loadingView];

## Loading Success
![](https://github.com/HelloiWorld/ZKProgressLoadingView/blob/master/ZKProgressLoadingView/LoadingSuccess1.gif) 

    // succeed after 3 seconds 
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loadingView progressFinish];
    }); 

## Loading Success With Mutiple Thread 
![](https://github.com/HelloiWorld/ZKProgressLoadingView/blob/master/ZKProgressLoadingView/LoadingSuccess2.gif) 

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


## Load Failed
![](https://github.com/HelloiWorld/ZKProgressLoadingView/blob/master/ZKProgressLoadingView/LoadFailed.gif)
