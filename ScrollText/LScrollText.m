//
//  LScrollText.m
//  ScrollText
//
//  Created by cqtd on 2017/9/4.
//  Copyright © 2017年 cqtd. All rights reserved.
//

#import "LScrollText.h"
@interface LScrollText()

@property (nonatomic,strong) UILabel *scrollLabel;
@property (nonatomic,strong) dispatch_source_t timmer;;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) BOOL isResume;
@end

@implementation LScrollText

- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id<LScrollTextDelegate>)delegate
                   dataSource:(NSArray *)dataSource
                    Direction:(ScrollDirection)direction
           scrollIntervalTime:(NSTimeInterval)scrollIntervalTime
                animationTime:(NSTimeInterval)animation {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        self.direction = direction;
        self.scrollIntervalTime = scrollIntervalTime;
        self.animationTime = animation;
        self.dataSource = dataSource;
        self.delegate = delegate;
        [self addSubview:self.scrollLabel];
    }
    return self;
}

- (void)stop {
    dispatch_suspend(self.timmer);
    _isResume = NO;
}

- (void)start {
    if (_isResume) {
        return;
    }
    [self scrollAnimation];
    dispatch_resume(self.timmer);
    _isResume = YES;
}


- (void)scrollAnimation {
    if (!self.dataSource.count) return;
    if (!_scrollIntervalTime) {
        _scrollIntervalTime = 2.0;
    }
    dispatch_source_set_timer(self.timmer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * _scrollIntervalTime, 0);
    dispatch_source_set_event_handler(self.timmer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self animationWith:self.index%self.dataSource.count];
        });
    });
}

- (void)animationWith:(NSInteger)index {
    if (!_animationTime) {
        _animationTime = 0.5;
    }
    [UIView animateWithDuration:_animationTime animations:^{
        self.scrollLabel.frame = CGRectMake(0, -_direction * self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        self.scrollLabel.frame = CGRectMake(0, _direction * self.frame.size.height, self.frame.size.width, self.frame.size.height);
        self.index++;
        self.scrollLabel.text = self.dataSource[index];
        [UIView animateWithDuration:_animationTime animations:^{
            self.scrollLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:nil];
    }];

}

- (void)chooseIndex {
    if ([self.delegate respondsToSelector:@selector(scrollText:currentIndex:)]) {
        [self.delegate scrollText:self currentIndex:(self.index-1)%self.dataSource.count];
    }
}

- (UILabel *)scrollLabel {
    if (!_scrollLabel) {
        _scrollLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollLabel.font = [UIFont systemFontOfSize:14];
        _scrollLabel.textColor = [UIColor blackColor];
        _scrollLabel.text = self.dataSource.firstObject;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseIndex)];
        [_scrollLabel addGestureRecognizer:tap];
        _scrollLabel.userInteractionEnabled = YES;
    }
    return _scrollLabel;
}

#pragma getter
- (dispatch_source_t)timmer {
    if (!_timmer) {
        dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timmer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    }
    return _timmer;
}

- (NSInteger)index {
    if (!_index) {
        _index = 1;
    }
    return _index;
}

#pragma setter
- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    _scrollLabel.font = [UIFont systemFontOfSize:fontSize];

}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
}


- (void)setDirection:(ScrollDirection)direction {
    _direction = direction;
}

- (void)setFontColor:(UIColor *)fontColor {
    _fontColor = fontColor;
    _scrollLabel.textColor = fontColor;
}

- (void)setScrollIntervalTime:(NSTimeInterval)scrollIntervalTime {
    _scrollIntervalTime = scrollIntervalTime;
}


- (void)setAnimationTime:(NSTimeInterval)animationTime {
    _animationTime = animationTime;
}
@end
