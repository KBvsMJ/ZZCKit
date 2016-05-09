//
//  NSDate+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SS_DATE_MINUTE      60
#define SS_DATE_HOUR		3600
#define SS_DATE_DAY         86400
#define SS_DATE_WEEK		604800
#define SS_DATE_MONTH       2592000
#define SS_DATE_YEAR		31556926

@interface NSDate (SSToolkitAdditions)

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger weekOfYear;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;


// Relative dates from the current date
+ (NSDate *) ss_dateTomorrow;                                              //明天
+ (NSDate *) ss_dateYesterday;                                             //昨天
+ (NSDate *) ss_dateWithDaysFromNow: (NSInteger) days;                     //几天后
+ (NSDate *) ss_dateWithDaysBeforeNow: (NSInteger) days;                   //几天前
+ (NSDate *) ss_dateWithHoursFromNow: (NSInteger) dHours;                  //几小时后
+ (NSDate *) ss_dateWithHoursBeforeNow: (NSInteger) dHours;                //几小时前
+ (NSDate *) ss_dateWithMinutesFromNow: (NSInteger) dMinutes;              //几分钟后
+ (NSDate *) ss_dateWithMinutesBeforeNow: (NSInteger) dMinutes;            //几分钟前

// Comparing dates
- (BOOL) ss_isEqualToDateIgnoringTime: (NSDate *) aDate;                   //是否是同一天，忽略时间
- (BOOL) ss_isToday;                                                       //是否是今天
- (BOOL) ss_isTomorrow;                                                    //是否是明天
- (BOOL) ss_isYesterday;                                                   //是否是昨天
- (BOOL) ss_isSameWeekAsDate: (NSDate *) aDate;                            //是否是同一个星期
- (BOOL) ss_isThisWeek;                                                    //是否是本周
- (BOOL) ss_isNextWeek;                                                    //是否是下周
- (BOOL) ss_isLastWeek;                                                    //是否是上周
- (BOOL) ss_isSameMonthAsDate: (NSDate *) aDate;                           //是否是同一个月
- (BOOL) ss_isThisMonth;                                                   //是否是本月
- (BOOL) ss_isSameYearAsDate: (NSDate *) aDate;                            //是否是同一年
- (BOOL) ss_isThisYear;                                                    //是否是今年
- (BOOL) ss_isNextYear;                                                    //是否是明年
- (BOOL) ss_isLastYear;                                                    //是否是去年
- (BOOL) ss_isEarlierThanDate: (NSDate *) aDate;                           //是否比某天早
- (BOOL) ss_isLaterThanDate: (NSDate *) aDate;                             //是否比某天晚

// Date roles
- (BOOL) ss_isTypicallyWorkday;
- (BOOL) ss_isTypicallyWeekend;

// Adjusting dates
- (NSDate *) ss_dateByAddingDays: (NSInteger) dDays;                       //加上多少天
- (NSDate *) ss_dateBySubtractingDays: (NSInteger) dDays;                  //减去多少天
- (NSDate *) ss_dateByAddingHours: (NSInteger) dHours;                     //加上多少小时
- (NSDate *) ss_dateBySubtractingHours: (NSInteger) dHours;                //减去多少小时
- (NSDate *) ss_dateByAddingMinutes: (NSInteger) dMinutes;                 //加上多少分钟
- (NSDate *) ss_dateBySubtractingMinutes: (NSInteger) dMinutes;            //减去多少分钟
- (NSDate *) ss_dateAtStartOfDay;

// Retrieving intervals
- (NSInteger) ss_minutesAfterDate: (NSDate *) aDate;
- (NSInteger) ss_minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) ss_hoursAfterDate: (NSDate *) aDate;
- (NSInteger) ss_hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) ss_daysAfterDate: (NSDate *) aDate;
- (NSInteger) ss_daysBeforeDate: (NSDate *) aDate;



//时间描述
- (NSString *)ss_timeIntervalDescription;                      //距离当前的时间间隔描述
- (NSString *)ss_minuteDescription;                            //精确到分钟的日期描述
- (NSString *)ss_formattedTime;                                //标准时间日期描述
- (NSString *)ss_formattedDateDescription;                     //格式化日期描述
- (double)ss_timeIntervalSince1970InMilliSecond;
+ (NSDate *)ss_dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;
+ (NSString *)ss_formattedTimeFromTimeInterval:(long long)time;


//新增
- (NSInteger)ss_daysOnCurrentMonth;                                            //本月有多少天
- (NSDate *)ss_firstDayOnCurrentWeek;                                          //本星期的第一天
- (NSDate *)ss_lastDayOnCurrentWeek;                                           //本星期的最后一天

+ (NSInteger)ss_daysOnYear:(NSInteger)year month:(NSInteger)month;             //某年某月有多少天


//实例化某天
+ (NSDate *)ss_dateWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day
                       Hour:(NSInteger)hour  Minute:(NSInteger)min Second:(NSInteger)sec;


@end














/**
 
 - (id)initWithTimeInterval:(NSTimeInterval)secs sinceDate:(NSDate *)refDate;
 初始化为以refDate为基准，然后过了secs秒的时间
 
 - (id)initWithTimeIntervalSinceNow:(NSTimeInterval)secs;
 初始化为以当前时间为基准，然后过了secs秒的时间
 

 - (NSTimeInterval)timeIntervalSinceDate:(NSDate *)refDate;
 以refDate为基准时间，返回实例保存的时间与refDate的时间间隔
 
 - (NSTimeInterval)timeIntervalSinceNow;
 以当前时间(Now)为基准时间，返回实例保存的时间与当前时间(Now)的时间间隔
 
 - (NSTimeInterval)timeIntervalSince1970;
 以1970/01/01 GMT为基准时间，返回实例保存的时间与1970/01/01 GMT的时间间隔
 
 - (NSTimeInterval)timeIntervalSinceReferenceDate;
 以2001/01/01 GMT为基准时间，返回实例保存的时间与2001/01/01 GMT的时间间隔
 
 */
