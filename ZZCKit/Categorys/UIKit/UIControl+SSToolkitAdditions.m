//
//  UIControl+SSToolkitAdditions.m
//  
//
//  Created by fdd_zzc on 15/4/28.
//
//

#import "UIControl+SSToolkitAdditions.h"

@implementation UIControl (SSToolkitAdditions)


- (void)ss_removeAllTargets {
    [[self allTargets] enumerateObjectsUsingBlock:^(id object, BOOL *stop) {
        [self removeTarget:object action:NULL forControlEvents:UIControlEventAllEvents];
    }];
}


- (void)ss_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    
    NSSet *targets = [self allTargets];
    for (id currentTarget in targets) {
        NSArray *actions = [self actionsForTarget:currentTarget forControlEvent:controlEvents];
        for (NSString *currentAction in actions) {
            [self removeTarget:currentTarget action:NSSelectorFromString(currentAction) forControlEvents:controlEvents];
        }
    }
    [self addTarget:target action:action forControlEvents:controlEvents];
}

@end
