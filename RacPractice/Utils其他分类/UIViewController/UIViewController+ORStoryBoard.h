//
//  NSObject+ORStoryBoard.h
//  RacPractice
//
//  Created by 王玲峰 on 2021/7/28.
//

#import <UIKit/UIKit.h>


#define ORStoryboard(SBN) \
+ (NSString *)orilme_storyboardName { \
return @(#SBN); \
}

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ORStoryBoard)
//返回一个控制器的方法
+ (nullable __kindof UIViewController *)orilme_viewController;

+ (NSString *)orilme_storyboardName;

@end

NS_ASSUME_NONNULL_END
