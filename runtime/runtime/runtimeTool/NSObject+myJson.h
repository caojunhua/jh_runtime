//
//  NSObject+myJson.h
//  runtime
//
//  Created by cao hua on 2021/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (myJson)

+ (instancetype)jh_objectWithJson: (NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
