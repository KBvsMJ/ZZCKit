

#import "MTAppLanguage.h"


@implementation MTAppLanguage


/**
 *  当前App语言
 *
 *  @return
 */
+ (NSString *)currentLanguage
{
    NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
    NSString *currentLanguage = [languages firstObject];
    return currentLanguage;
}



/**
 *  比较两个语言是否相同
 *
 *  @param language1 语言1
 *  @param language2 语言2
 *
 *  @return 比较结果
 */
+ (BOOL)isEqualToLanguage1:(NSString*)language1 Language2:(NSString*)language2
{
    return [language1 compare:language2 options:NSCaseInsensitiveSearch] == NSOrderedSame;
}




/**
 *  获取语言类型
 *
 *  @param language 语言
 *
 *  @return 语言类型
 */
+ (MTAppLanguageType)getLanguageTypeWithLanguage:(NSString *)language
{
    MTAppLanguageType type = MTAppLanguageType_Other;
    
    if ([self isEqualToLanguage1:language Language2:@"zh-Hans"]) {
        
        //简体中文
        type = MTAppLanguageType_ZHHANS;
        
    } else if ([self isEqualToLanguage1:language Language2:@"zh-Hant"]) {
        
        //繁体中文
        type = MTAppLanguageType_ZHHANT;
        
    } else if ([self isEqualToLanguage1:language Language2:@"zh-HK"]) {
        
        //香港繁体中文
        type = MTAppLanguageType_ZHHK;
        
    } else if ([language hasPrefix:@"en"]) {
        
        //英文
        type = MTAppLanguageType_EN;
        
    }else if ([self isEqualToLanguage1:language Language2:@"ja"]) {
        
        //日文
        type = MTAppLanguageType_JA;
        
    } else if ([self isEqualToLanguage1:language Language2:@"th"]) {
        
        //泰文
        type = MTAppLanguageType_THAI;
        
    } else if ([self isEqualToLanguage1:language Language2:@"id"]) {
        
        //印尼语
        type = MTAppLanguageType_ID;
        
    } else {
        
        //其他语言
        type = MTAppLanguageType_Other;
    }

    return type;
}



@end
