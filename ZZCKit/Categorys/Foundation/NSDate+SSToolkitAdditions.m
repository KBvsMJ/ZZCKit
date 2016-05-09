//
//  NSDate+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "NSDate+SSToolkitAdditions.h"
#import "NSDateFormatter+SSToolkitAdditions.h"

#include <time.h>

#pragma mark -
#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (SSToolkitAdditions)

#pragma mark Relative Dates

+ (NSDate *) ss_dateWithDaysFromNow: (NSInteger) days {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SS_DATE_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) ss_dateWithDaysBeforeNow: (NSInteger) days {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - SS_DATE_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) ss_dateTomorrow {
    
    return [NSDate ss_dateWithDaysFromNow:1];
}

+ (NSDate *) ss_dateYesterday {
    
    return [NSDate ss_dateWithDaysBeforeNow:1];
}

+ (NSDate *) ss_dateWithHoursFromNow: (NSInteger) dHours {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SS_DATE_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) ss_dateWithHoursBeforeNow: (NSInteger) dHours {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - SS_DATE_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) ss_dateWithMinutesFromNow: (NSInteger) dMinutes {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SS_DATE_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) ss_dateWithMinutesBeforeNow: (NSInteger) dMinutes {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - SS_DATE_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark Comparing Dates

- (BOOL) ss_isEqualToDateIgnoringTime: (NSDate *) aDate {
    
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    return ((components1.year == components2.year) && (components1.month == components2.month) && (components1.day == components2.day));
}

- (BOOL) ss_isToday {
    
    return [self ss_isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) ss_isTomorrow {
    
    return [self ss_isEqualToDateIgnoringTime:[NSDate ss_dateTomorrow]];
}

- (BOOL) ss_isYesterday {
    
    return [self ss_isEqualToDateIgnoringTime:[NSDate ss_dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) ss_isSameWeekAsDate: (NSDate *) aDate {
    
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfMonth != components2.weekOfMonth) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < SS_DATE_WEEK);
}

- (BOOL) ss_isThisWeek {
    
    return [self ss_isSameWeekAsDate:[NSDate date]];
}

- (BOOL) ss_isNextWeek {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SS_DATE_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self ss_isSameWeekAsDate:newDate];
}

- (BOOL) ss_isLastWeek {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - SS_DATE_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self ss_isSameWeekAsDate:newDate];
}

- (BOOL) ss_isSameMonthAsDate: (NSDate *) aDate {
    
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) ss_isThisMonth {
    
    return [self ss_isSameMonthAsDate:[NSDate date]];
}

- (BOOL) ss_isSameYearAsDate: (NSDate *) aDate {
    
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL) ss_isThisYear {
    
    return [self ss_isSameWeekAsDate:[NSDate date]];
}

- (BOOL) ss_isNextYear {
    
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL) ss_isLastYear {
    
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL) ss_isEarlierThanDate: (NSDate *) aDate {
    
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) ss_isLaterThanDate: (NSDate *) aDate {
    
    return ([self compare:aDate] == NSOrderedDescending);
}

#pragma mark Roles
- (BOOL) ss_isTypicallyWeekend {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    if ((components.weekday == 1) || (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) ss_isTypicallyWorkday {
    
    return ![self ss_isTypicallyWeekend];
}

#pragma mark Adjusting Dates

- (NSDate *) ss_dateByAddingDays: (NSInteger) dDays {
    
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + SS_DATE_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) ss_dateBySubtractingDays: (NSInteger) dDays {
    
    return [self ss_dateByAddingDays: (dDays * -1)];
}

- (NSDate *) ss_dateByAddingHours: (NSInteger) dHours {
    
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + SS_DATE_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) ss_dateBySubtractingHours: (NSInteger) dHours {
    
    return [self ss_dateByAddingHours: (dHours * -1)];
}

- (NSDate *) ss_dateByAddingMinutes: (NSInteger) dMinutes {
    
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + SS_DATE_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) ss_dateBySubtractingMinutes: (NSInteger) dMinutes {
    
    return [self ss_dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *) ss_dateAtStartOfDay {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDateComponents *) ss_componentsWithOffsetFromDate: (NSDate *) aDate {
    
    NSDateComponents *dTime = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark Retrieving Intervals

- (NSInteger) ss_minutesAfterDate: (NSDate *) aDate {
    
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / SS_DATE_MINUTE);
}

- (NSInteger) ss_minutesBeforeDate: (NSDate *) aDate {
    
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / SS_DATE_MINUTE);
}

- (NSInteger) ss_hoursAfterDate: (NSDate *) aDate {
    
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / SS_DATE_HOUR);
}

- (NSInteger) ss_hoursBeforeDate: (NSDate *) aDate {
    
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / SS_DATE_HOUR);
}

- (NSInteger) ss_daysAfterDate: (NSDate *) aDate {
    
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / SS_DATE_DAY);
}

- (NSInteger) ss_daysBeforeDate: (NSDate *) aDate {
    
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / SS_DATE_DAY);
}






#pragma mark Decomposing Dates

- (NSInteger) nearestHour {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + SS_DATE_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:newDate];
    return components.hour;
}

- (NSInteger) hour {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.hour;
}

- (NSInteger) minute {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.minute;
}

- (NSInteger) seconds {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.second;
}

- (NSInteger) day {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.day;
}

- (NSInteger) month {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.month;
}

- (NSInteger) weekOfYear {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.weekOfMonth;
}


// NSDateComponents Weekday 总是从星期日开始，也就是星期天是 1 星期一是 2 ……星期六是 7
////  Sunday:1, Monday:2, Tuesday:3, Wednesday:4, Thursday:5,Friday:6, Saturday:7
//NSLog(@"weekday(星期):%i", dateComponents.weekday);
////  苹果官方不推荐使用week
//NSLog(@"week(该年第几周):%i", dateComponents.week);
//NSLog(@"weekOfYear(该年第几周):%i", dateComponents.weekOfYear);
//NSLog(@"weekOfMonth(该月第几周):%i", dateComponents.weekOfMonth);

- (NSInteger) weekday {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.weekday;
}

- (NSInteger) nthWeekday {
    
    //// e.g. 2nd Tuesday of the month is 2
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.weekdayOrdinal;
}
- (NSInteger) year {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.year;
}







/*距离当前的时间间隔描述*/
- (NSString *)ss_timeIntervalDescription {
    
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < SS_DATE_MINUTE) {
        //1分钟内
        return @"1分钟内";
    } else if (timeInterval < SS_DATE_HOUR) {
        //1小时内
        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / SS_DATE_MINUTE];
    } else if (timeInterval < SS_DATE_DAY) {
        //一天内
        return [NSString stringWithFormat:@"%.f小时前", timeInterval / SS_DATE_HOUR];
    } else if (timeInterval < SS_DATE_MONTH) {
        //30天内
        return [NSString stringWithFormat:@"%.f天前", timeInterval / SS_DATE_DAY];
    } else if (timeInterval < SS_DATE_YEAR) {
        //30天至1年内
        NSDateFormatter *dateFormatter = [NSDateFormatter ss_dateFormatterWithFormat:@"M月d日"];
        return [dateFormatter stringFromDate:self];
    } else {
        //几年前
        return [NSString stringWithFormat:@"%.f年前", timeInterval / SS_DATE_YEAR];
    }
}

/*精确到分钟的日期描述*/
- (NSString *)ss_minuteDescription {
    
    NSDateFormatter *dateFormatter = [NSDateFormatter ss_dateFormatterWithFormat:@"yyyy-MM-dd"];
    
    NSString *theDay = [dateFormatter stringFromDate:self];                         //日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];            //当前年月日
    if ([theDay isEqualToString:currentDay]) {
        //当天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == SS_DATE_DAY) {
        //昨天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] < SS_DATE_WEEK) {
        //间隔一周内
        [dateFormatter setDateFormat:@"EEEE ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else {
        //一周以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd ah:mm"];
        return [dateFormatter stringFromDate:self];
    }
}



/*标准时间日期描述*/
-(NSString *)ss_formattedTime {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMdd"];
    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(6,2)] intValue]];   //天
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(4,2)] intValue]]; //月
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];  //年
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components]; //今天0点时间
    
    NSInteger hour = [self ss_hoursAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    if (!hasAMPM) { //24小时制
        if (hour <= 24 && hour >= 0) {
            dateFormatter = [NSDateFormatter ss_dateFormatterWithFormat:@"HH:mm"];
        }else if (hour < 0 && hour >= -24) {
            dateFormatter = [NSDateFormatter ss_dateFormatterWithFormat:@"昨天HH:mm"];
        }else {
            dateFormatter = [NSDateFormatter ss_dateFormatterWithFormat:@"yyyy-MM-dd"];
        }
    }else {
        if (hour >= 0 && hour <= 6) {
            dateFormatter = [NSDateFormatter ss_dateFormatterWithFormat:@"凌晨hh:mm"];
        }else if (hour > 6 && hour <=11 ) {
            dateFormatter = [NSDateFormatter ss_dateFormatterWithFormat:@"上午hh:mm"];
        }else if (hour > 11 && hour <= 17) {
            dateFormatter = [NSDateFormatter ss_dateFormatterWithFormat:@"下午hh:mm"];
        }else if (hour > 17 && hour <= 24) {
            dateFormatter = [NSDateFormatter ss_dateFormatterWithFormat:@"晚上hh:mm"];
        }else if (hour < 0 && hour >= -24){
            dateFormatter = [NSDateFormatter ss_dateFormatterWithFormat:@"昨天HH:mm"];
        }else  {
            dateFormatter = [NSDateFormatter ss_dateFormatterWithFormat:@"yyyy-MM-dd"];
        }
        
    }
    
    ret = [dateFormatter stringFromDate:self];
    return ret;
}


/*格式化日期描述*/
- (NSString *)ss_formattedDateDescription {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return @"1分钟内";
    } else if (timeInterval < 3600) {
        //1小时内
        return [NSString stringWithFormat:@"%d分钟前", (int)(timeInterval / 60)];
    } else if (timeInterval < 21600) {
        //6小时内
        return [NSString stringWithFormat:@"%d小时前", (int)(timeInterval / 3600)];
    } else if ([theDay isEqualToString:currentDay]) {
        //当天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"今天 %@", [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {
        //昨天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:self]];
    } else {
        //以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateFormatter stringFromDate:self];
    }
}

- (double)ss_timeIntervalSince1970InMilliSecond {
    double ret;
    ret = [self timeIntervalSince1970] * 1000;
    
    return ret;
}

+ (NSDate *)ss_dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
    
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

+ (NSString *)ss_formattedTimeFromTimeInterval:(long long)time {
    
    return [[NSDate ss_dateWithTimeIntervalInMilliSecondSince1970:time] ss_formattedTime];
}




//当前月一共有多少天
- (NSInteger)ss_daysOnCurrentMonth {
    
    return [NSDate ss_daysOnYear:self.year month:self.month];
}


//某年某月一共有多少天
+ (NSInteger)ss_daysOnYear:(NSInteger)year month:(NSInteger)month {
    
    //判断是否闰年
    BOOL isLeap = NO;
    if ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)) ) {
        isLeap = YES;
    }
    
    NSInteger days = 30;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
        {
            //大月
            days = 31;
            break;
        }
        case 2:
        {
            if (isLeap) {
                days = 29;
            } else {
                days = 28;
            }
            break;
        }
        default:
            days = 30;
            break;
    }
    return days;
}




//根据年月日时分秒初始化NSDate
+ (NSDate *)ss_dateWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day
                    Hour:(NSInteger)hour  Minute:(NSInteger)min Second:(NSInteger)sec {
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    [comps setHour:hour];
    [comps setMinute:min];
    [comps setSecond:sec];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [calendar setTimeZone:timeZone];
    return [calendar dateFromComponents:comps];
}


//本周第一天
- (NSDate *)ss_firstDayOnCurrentWeek {
    
    /********************************************************
     //从星期一到星期日 是一个星期
     if (self.weekday == 1) {
     return [self dateBySubtractingDays:6];
     } else {
     return [self dateBySubtractingDays: self.weekday -2];
     }
     ********************************************************/
    
    //从星期日到星期六 是一个星期
    return [self ss_dateBySubtractingDays: self.weekday -1];
}


//本周最后一天
- (NSDate *)ss_lastDayOnCurrentWeek {
    
    /********************************************************
     //从星期一到星期日 是一个星期
     if (self.weekday == 1) {
     return [self dateByAddingDays:0];
     } else {
     return [self dateByAddingDays: 8 - self.weekday];
     }
     ********************************************************/
    
    //从星期日到星期六 是一个星期
    return [self ss_dateByAddingDays: 7 - self.weekday];
}


@end
