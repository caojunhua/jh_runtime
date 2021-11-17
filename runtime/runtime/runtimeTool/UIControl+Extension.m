//
//  UIControl+Extension.m
//  runtime
//
//  Created by cao hua on 2021/11/17.
//

#import "UIControl+Extension.h"
#import <objc/runtime.h>

@implementation UIControl (Extension)

+ (void)load {
    // 确保只会被调用一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 分类的load方法,程序一加载,就会调用
        Method method1 = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
        Method method2 = class_getInstanceMethod(self, @selector(jh_sendAction:to:forEvent:));
        method_exchangeImplementations(method1, method2);
    });
    
}

- (void)jh_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    NSLog(@"分类拦截点击事件--");
    //做原来的事情
    [self jh_sendAction:action to:target forEvent:event]; // 不会死循环,因为已经交换了方法实现
}

@end
