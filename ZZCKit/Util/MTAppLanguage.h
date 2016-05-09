

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, MTAppLanguageType) {
    
    MTAppLanguageType_ZHHANS,               /**< 简体中文 */
    MTAppLanguageType_ZHHANT,               /**< 繁体中文 */
    MTAppLanguageType_ZHHK,                 /**< 香港繁体中文 */
    MTAppLanguageType_EN,                   /**< 英文 */
    MTAppLanguageType_JA,                   /**< 日文 */
    MTAppLanguageType_THAI,                 /**< 泰文 */
    MTAppLanguageType_ID,                   /**< 印尼语 */
    MTAppLanguageType_Other,                /**< 其他 */
};



@interface MTAppLanguage : NSObject


/**
 *  当前App语言
 *
 *  @return
 */
+ (NSString *)currentLanguage;


/**
 *  比较两个语言是否相同
 *
 *  @param language1 语言1
 *  @param language2 语言2
 *
 *  @return 比较结果
 */
+ (BOOL)isEqualToLanguage1:(NSString*)language1 Language2:(NSString*)language2;



/**
 *  获取语言类型
 *
 *  @param language 语言
 *
 *  @return 语言类型
 */
+ (MTAppLanguageType)getLanguageTypeWithLanguage:(NSString *)language;

@end
