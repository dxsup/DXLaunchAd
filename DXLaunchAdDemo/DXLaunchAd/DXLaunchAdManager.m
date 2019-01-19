//
//  DXLaunchAdManager.m
//  DXLaunchAd
//
//  Created by Daxin on 2019/1/14.
//  Copyright © 2019 dxsup. All rights reserved.
//

#import "DXLaunchAdManager.h"
#import <UIKit/UIKit.h>
#import "DXLaunchAdView.h"

@interface DXLaunchAdManager ()
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, weak) DXLaunchAdView *adView;
@end

@implementation DXLaunchAdManager

+ (void)load
{
    [self sharedInstance];
}

+ (instancetype)sharedInstance
{
    static DXLaunchAdManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DXLaunchAdManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            [self showAdvertisement];
            NSLog(@"didFinishLaunching");
        }];
    }
    return self;
}

- (void)showAdvertisement
{
    [self initAdWindow];
    [self setButtonAction];
    [self setTimer];
}

- (void)initAdWindow
{
    UIWindow *adWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    adWindow.rootViewController = [UIViewController new];
//    adWindow.rootViewController.view.backgroundColor = UIColor.clearColor;
//    adWindow.rootViewController.view.userInteractionEnabled = NO;
    
//    adWindow.rootViewController.view.alpha = 1.0;
    adWindow.hidden = NO;
    adWindow.windowLevel = UIWindowLevelStatusBar + 1;

    DXLaunchAdView *adView = [[DXLaunchAdView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [adView setAdImageWithImagePath:@"firstScreenAd.jpeg"];
    
    [adWindow addSubview:adView];
    _adView = adView;
     
    self.window = adWindow;
}

- (void)setButtonAction
{
    [self.adView.skipButton addTarget:self action:@selector(hideAd) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTimer
{
    __block NSUInteger countDownNum = 3;
    __block dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.adView setSkipButtonTitleWithCountNum:countDownNum];
            NSLog(@"%lu", (unsigned long)countDownNum);
            if (countDownNum == 0) {
                if (timer) {
                    dispatch_source_cancel(timer);
                    timer = nil;
                }
                [self hideAd];
                return ;
            }
            countDownNum--;
        });
    });
    dispatch_resume(timer);
}

- (void)hideAd
{
    [self.window.subviews.copy enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    self.window.hidden = YES;
    self.window = nil;
}
@end
