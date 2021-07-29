//
//  NSObject+ORStoryBoard.m
//  RacPractice
//
//  Created by 王玲峰 on 2021/7/28.
//

#import "UIViewController+ORStoryBoard.h"
#import <objc/runtime.h>

@implementation UIViewController (ORStoryBoard)
//返回一个控制器的方法
+ (nullable __kindof UIViewController *)orilme_viewController{
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wundeclared-selector"
    SEL storyboardNameSel = @selector(orilme_storyboardName);// 消除警告
#pragma clang diagnostic pop
    // 仅搜索当前的类方法。项目中目前无复杂的继承关系，所以并无太大关系。可视情况换为[self respondsToSelector:]
    BOOL hasMethod = NO;
    unsigned int methodCount = 0;
    //runtime 获取某个类的方法列表
    Method *methodList = class_copyMethodList(object_getClass(self), &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methodList[i]; //取出方法
        SEL selector = method_getName(method); //方法名
        if (selector == storyboardNameSel) { //对比这个方法名
            //说明这个类能执行这个方法 stroyboardNameSele
            hasMethod = YES;
            break;
        }
    }
    free(methodList);
    if (!hasMethod) {
        return [[self alloc] init];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSString *storyboardName = [self performSelector:storyboardNameSel];
#pragma clang diagnostic pop
    NSBundle *bundle = [NSBundle bundleForClass:self];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
    if (!storyboard) {
        return nil;
    }
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
    return viewController;
}

@end
