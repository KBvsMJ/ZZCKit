//
//  DDLAppMacros.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//



//应用委托
#define kAppDelegate                    ((AppDelegate *)[UIApplication sharedApplication].delegate)

//设备平台相关
#define isIPad                          (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isIPhone                        (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


//系统版本,语言, AppName, App版本
#define kSystemVersion                  ([[UIDevice currentDevice] systemVersion])
#define kCurrentLanguage                ([[NSLocale preferredLanguages] objectAtIndex:0])
#define kAPPName                        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define kAPPVersion                     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


//设备屏幕尺寸
#define kScreenWidth                    ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight                   ([UIScreen mainScreen].bounds.size.height)


//系统版本和当前系统语言
#define IOS9_OR_LATER                   ([[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending)
#define IOS8_OR_LATER                   ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)
#define IOS7_OR_LATER                   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)


//屏幕尺寸大小
#define IS_IPHONE_5_5                   ( fabs( ( double )kScreenHeight - ( double )736 ) < DBL_EPSILON )
#define IS_IPHONE_4_7                   ( fabs( ( double )kScreenHeight - ( double )667 ) < DBL_EPSILON )
#define IS_IPHONE_4_0                   ( fabs( ( double )kScreenHeight - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_3_5                   ( fabs( ( double )kScreenHeight - ( double )480 ) < DBL_EPSILON )


//颜色
#define RGBCOLOR(r,g,b)                 [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a)              [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBHEX(hex)                     RGBCOLOR((float)((hex & 0xFF0000) >> 16),(float)((hex & 0xFF00) >> 8),(float)(hex & 0xFF))
#define RGBAHEX(hex, a)                 RGBACOLOR((float)((hex & 0xFF0000) >> 16),(float)((hex & 0xFF00) >> 8),(float)(hex & 0xFF), a)

//字体
#define SystemFont(size)                [UIFont systemFontOfSize:size]
#define BoldSystemFont(size)            [UIFont boldSystemFontOfSize:size]

//空对象
#define isNullObj(x)                    (!x || [x isKindOfClass:[NSNull class]])
#define isEmptyString(x)                (isNullObj(x) || [x isEqual:@""] || [x isEqual:@"(null)"])


//创建View
#define createView(Class)                       [[Class alloc] init]
#define createViewWithFrame(Class, frame)       [[Class alloc] initWithFrame:frame]
#define createButton                            [UIButton buttonWithType:UIButtonTypeCustom]


//以tag读取View
#define kViewByTag(parentView, tag, Class)      (Class *)[parentView viewWithTag:tag]

//读取Xib文件的类
#define kViewByNib(ClassName, owner, index)     [[[NSBundle mainBundle] loadNibNamed:ClassName owner:owner options:nil] objectAtIndex:index]




#pragma mark - weakSelf

#define WEAKSELF    __weak   typeof(self)  weakSelf = self;
#define STRONGSELF  __strong typeof(weakSelf) strongSelf = weakSelf;



#pragma mark - 日志


#ifdef DEBUG

#define DDLogVerbose(fmt, ...)  NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define DDLogInfo(fmt, ...)     NSLog((@"Info: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define DDLogWarn(fmt, ...)     NSLog((@"Warn: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define DDLogError(fmt, ...)    NSLog((@"Error: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#else

#define DDLogVerbose(fmt, ...)  /* */
#define DDLogInfo(fmt, ...)     /* */
#define DDLogWarn(fmt, ...)     /* */
#define DDLogError(fmt, ...)    /* */

#endif




#pragma mark - 单例

#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
    static dispatch_once_t once; \
    static __class * __singleton__; \
    dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
    return __singleton__; \
}





#pragma mark - 合成属性(常用于类别中添加属性)

//C类型，例如int, char, bool, 结构体等等
#ifndef SYNTH_DYNAMIC_PROPERTY_CTYPE
#define SYNTH_DYNAMIC_PROPERTY_CTYPE(_getter_, _setter_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    NSValue *value = [NSValue value:&object withObjCType:@encode(_type_)]; \
    objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
    _type_ cValue = { 0 }; \
    NSValue *value = objc_getAssociatedObject(self, @selector(_setter_:)); \
    [value getValue:&cValue]; \
    return cValue; \
}
#endif


//OC对象( @param association  ASSIGN / RETAIN / COPY / RETAIN_NONATOMIC / COPY_NONATOMIC)
#ifndef SYNTH_DYNAMIC_PROPERTY_OBJECT
#define SYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
    return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif









