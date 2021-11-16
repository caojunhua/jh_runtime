//
//  JHPerson.h
//  runtime
//
//  Created by cao hua on 2021/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHPerson : NSObject

@property(assign, nonatomic) int age;
@property(assign, nonatomic) int height;
@property(copy, nonatomic) NSString *name;

+ (void)run;

- (void)run;

- (void)eat;
@end

NS_ASSUME_NONNULL_END
