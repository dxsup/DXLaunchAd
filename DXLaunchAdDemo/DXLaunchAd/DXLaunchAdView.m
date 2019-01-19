//
//  DXLaunchAdView.m
//  DXLaunchAd
//
//  Created by Daxin on 2019/1/16.
//  Copyright © 2019 dxsup. All rights reserved.
//

#import "DXLaunchAdView.h"

#define kDXScreenWidth [UIScreen mainScreen].bounds.size.width
#define kDXScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation DXLaunchAdView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *adIV = [[UIImageView alloc] init];
        [self addSubview:adIV];
        _adImageView = adIV;
        
        UIButton *button = [[UIButton alloc] init];
        [self addSubview:button];
        _skipButton = button;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.adImageView setFrame:self.frame];
    [self.skipButton setFrame:CGRectMake(kDXScreenWidth-80, 44, 70, 35)];
}

- (void)setSkipButtonTitleWithCountNum:(NSUInteger)countNum
{
    [self.skipButton setTitle:[NSString stringWithFormat:@"Skip %lu", (unsigned long)countNum] forState:UIControlStateNormal];
}

- (void)setAdImageWithImagePath:(NSString *)imagePath
{
    self.adImageView.image = [UIImage imageNamed:imagePath];
}

@end
