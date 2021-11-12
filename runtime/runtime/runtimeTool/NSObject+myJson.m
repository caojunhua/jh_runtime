//
//  NSObject+myJson.m
//  runtime
//
//  Created by cao hua on 2021/11/12.
//

#import "NSObject+myJson.h"
#import <objc/runtime.h>

@implementation NSObject (myJson)


+ (instancetype)jh_objectWithJson:(NSDictionary *)json {
    id obj = [[self alloc] init];
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        // 取出i位置的成员变量
        Ivar ivar = ivars[i];
        NSMutableString *name = [NSMutableString stringWithUTF8String: ivar_getName(ivar)];
        [name deleteCharactersInRange:NSMakeRange(0,1)];
        
        // 设置
        [obj setValue:json[name] forKey:name];
    };
    free(ivars);
    
    return obj;
}



@end
