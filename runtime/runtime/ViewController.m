//
//  ViewController.m
//  runtime
//
//  Created by cao hua on 2021/11/12.
//

#import "ViewController.h"
#import "JHPerson.h"
#import "NSObject+myJson.h"
#import <objc/runtime.h>
#import "JHCar.h"

@interface ViewController ()

@end

@implementation ViewController

void replaceRun() {
    NSLog(@"%s", __func__);
}

void run(id self, SEL _cmd) {
    NSLog(@"_______%@-- %@", self, NSStringFromSelector(_cmd));
}
void jhEat(id self, SEL _cmd) {
    NSLog(@"_______%@-- %@", self, NSStringFromSelector(_cmd));
}

void eat(id self, SEL _cmd) {
    NSLog(@"_______%@-- %@", self, NSStringFromSelector(_cmd));
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    /****************************************************************************************************/
    
    NSDictionary *json = @{
        @"age" : @18,
        @"height" : @180,
        @"name" : @"Rose"
    };
    
    // 1.字典转模型: class_copyIvarList 获取成员列表信息
    
    NSLog(@"1.字典转模型: class_copyIvarList 获取成员列表信息");
    JHPerson *person = [JHPerson jh_objectWithJson:json];
    [person run];
    NSLog(@"-----------------------");
    
    
    /****************************************************************************************************/
    // 2.class_replaceMethod 方法替换
    NSLog(@"2.class_replaceMethod 方法替换");
    JHPerson *person1 = [[JHPerson alloc] init];
    class_replaceMethod([JHPerson class], @selector(run), (IMP)replaceRun, "v");
    
    [person1 run];
    
    NSLog(@"-----------------------");
    /****************************************************************************************************/
    // 3. class_replaceMethod -- imp_implementationWithBlock
    NSLog(@"3. class_replaceMethod -- imp_implementationWithBlock");
    class_replaceMethod([JHPerson class], @selector(run), imp_implementationWithBlock(^{
        NSLog(@"我是交换的block");
    }), "v");
    [person1 run];
    
    NSLog(@"-----------------------");
    /****************************************************************************************************/
    // 4. 方法交换
    NSLog(@"4. 方法交换");
    Method runMethod = class_getInstanceMethod([JHPerson class], @selector(run));
    Method eatMethod = class_getInstanceMethod([JHPerson class], @selector(eat));
    method_exchangeImplementations(runMethod, eatMethod);
    
    [person1 run];
    
    NSLog(@"-----------------------");
    /****************************************************************************************************/
    
    // 5. 给分类对象添加关联方法
//    objc_setAssociatedObject(<#id  _Nonnull object#>, <#const void * _Nonnull key#>, <#id  _Nullable value#>, <#objc_AssociationPolicy policy#>)
    
    /****************************************************************************************************/
    
    // 6.获取isa指向的class: object_getClass
    NSLog(@"6.获取isa指向的class: object_getClass");
    NSLog(@"isa指向的class -- %p %p", object_getClass(person1),[JHPerson class]);
    NSLog(@"isa指向的class -- %p %p", object_getClass([JHPerson class]),[JHPerson class]);
    
    NSLog(@"-----------------------");
    // 7. 修改isa指向的class
    NSLog(@"7. 修改isa指向的class");
    object_setClass(person, [JHCar class]);
    [person run];
    NSLog(@"-----------------------");
    
    // 8. 创建类 objc_allocateClassPair
    NSLog(@"8. 创建类 objc_allocateClassPair");
    Class newClass = objc_allocateClassPair([NSObject class], "JHDog", 0);
    
    // 添加属性 -- 因为属性是readonly,所以要在注册类之前添加
    class_addIvar(newClass, "_age", 4, 1, @encode(int));
    class_addIvar(newClass, "_height", 4, 1, @encode(int));
    
    // 添加方法 -- readwirte,什么时候添加都可以
    class_addMethod(newClass, @selector(run), (IMP)run, "v@:");
    class_addMethod(newClass, @selector(eat), (IMP)eat, "v@:");
    
    // 注册类
    objc_registerClassPair(newClass);
    
    id dog = [[newClass alloc] init];
    
    // 通过kvc赋值
    [dog setValue:@10 forKey:@"_age"];
    [dog setValue:@20 forKey:@"_height"];
    [dog run];
    [dog eat];
    
    NSLog(@"%zd", class_getInstanceSize(newClass));
    NSLog(@"%@ %@", [dog valueForKey:@"_age"], [dog valueForKey:@"_height"]);
    
    NSLog(@"-----------------------");
}


@end
