//
//  NSMutableArray+Extension.m
//  runtime
//
//  Created by cao hua on 2021/11/17.
//

#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Extension)

+ (void)load {
    // 类簇: NSString , NSArray, NSDictionary,真实类型是其他类型
    // 报错: *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSArrayM insertObject:atIndex:]: object cannot be nil'
//    *** First throw call stack:
    // 所以知道真实类型应该是 __NSArrayM 类型
    Class cls = NSClassFromString(@"__NSArrayM");
    Method method1 = class_getInstanceMethod(cls, @selector(insertObject:atIndex:));
    Method method2 = class_getInstanceMethod(cls, @selector(jh_insertObject:atIndex:));
    method_exchangeImplementations(method1, method2);
}

- (void)jh_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
        NSLog(@"拦截到空对象添加");
        return;
    }
    [self jh_insertObject:anObject atIndex:index];
}
@end
