//
//  LScrollText.h
//  ScrollText
//
//  Created by cqtd on 2017/9/4.
//  Copyright © 2017年 cqtd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    ScrollDirectionToptoBottom = -1,
    ScrollDirectionBottomtoTop = 1
}ScrollDirection;

@class LScrollText;
@protocol LScrollTextDelegate <NSObject>
@optional
- (void)scrollText:(LScrollText *)scrollText currentIndex:(NSInteger)index;

@end

@interface LScrollText : UIView

@property (nonatomic,weak) id<LScrollTextDelegate> delegate;

/**
 数据源
 */
@property (nonatomic,strong) NSArray *dataSource;

/**
 滚动方向
 */
@property (nonatomic,assign) ScrollDirection direction;

/**
 字体大小
 */
@property (nonatomic,assign) CGFloat fontSize;

/**
 字体颜色
 */
@property (nonatomic,strong) UIColor *fontColor;

/**
 滚动时间间隔
 */
@property (nonatomic,assign) NSTimeInterval scrollIntervalTime
;

/**
 动画时间
 */
@property (nonatomic,assign) NSTimeInterval animationTime;



/**
 初始化

 @param frame frame
 @param delegate 委托
 @param dataSource 数据
 @param direction 滚动方向
 @param scrollIntervalTime 滚动间隔时间
 @param animation 动画时间
 @return LScrollText
 */
- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id<LScrollTextDelegate>)delegate
                   dataSource:(NSArray *)dataSource
                    Direction:(ScrollDirection)direction
           scrollIntervalTime:(NSTimeInterval)scrollIntervalTime
                animationTime:(NSTimeInterval)animation;
- (void)stop;
- (void)start;
@end
