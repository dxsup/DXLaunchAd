//
//  DXLaunchAdView.h
//  DXLaunchAd
//
//  Created by Daxin on 2019/1/16.
//  Copyright © 2019 dxsup. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DXLaunchAdView : UIView

@property (nonatomic, weak) UIImageView *adImageView;
@property (nonatomic, weak) UIButton *skipButton;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)setSkipButtonTitleWithCountNum:(NSUInteger)countNum;
- (void)setAdImageWithImagePath:(NSString *)imagePath;

@end

NS_ASSUME_NONNULL_END
