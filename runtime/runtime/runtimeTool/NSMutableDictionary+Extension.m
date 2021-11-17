//
//  NSMutableDictionary+Extension.m
//  runtime
//
//  Created by cao hua on 2021/11/17.
//

#import "NSMutableDictionary+Extension.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (Extension)

+ (void)load {
    Class cls = NSClassFromString(@"__NSDictionaryM");
    Method method1 = class_getInstanceMethod(cls, @selector(setObject:forKey:));
    Method method2 = class_getInstanceMethod(cls, @selector(jh_setObject:forKey:));
    
    method_exchangeImplementations(method1, method2);
}


//报错: *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSDictionaryM setObject:forKey:]: key cannot be nil'
- (void)jh_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (aKey == nil) {
        NSLog(@"拦截字典key 为空-- ");
        return;
    }
    
    [self jh_setObject:anObject forKey:aKey];
}

@end
