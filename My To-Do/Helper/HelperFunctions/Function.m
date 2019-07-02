//
//  Common.m
//

#import "Function.h"

@implementation Function

#pragma mark - dictionary functions
#pragma mark -
+(NSString *) getStringFromObject:(NSString *) key fromDictionary:(NSDictionary *) values
{
    if (![[values objectForKey:key] isKindOfClass:[NSNull class]])
        return  [values objectForKey:key];
    else
        return @"";
}
+(NSString *) getStringForKey:(NSString *) key fromDictionary:(NSDictionary *) values
{
    if (![[values objectForKey:key] isKindOfClass:[NSNull class]])
        return  [values objectForKey:key];
    else
        return @"";
}

+(int) getIntegerForKey:(NSString *) key fromDictionary:(NSDictionary *) values
{
    if (![[values objectForKey:key] isKindOfClass:[NSNull class]])
        return  (int)[[values objectForKey:key]integerValue];
    else
        return 0;
}

+(double) getDoubleForKey:(NSString *) key fromDictionary:(NSDictionary *) values
{
    if (![[values objectForKey:key] isKindOfClass:[NSNull class]])
        return  [[values objectForKey:key]doubleValue];
    else
        return 0;
}
#pragma mark - string functions
#pragma mark -

+ (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet forString:(NSString *)string
{
    NSUInteger location = 0;
    NSUInteger length = [string length];
    unichar charBuffer[length];
    [string getCharacters:charBuffer];
    
    for (location = 0; location < length; location++)
    {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    
    return [string substringWithRange:NSMakeRange(location, length - location)];
}

+ (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet forString:(NSString *)string
{
    NSUInteger location = 0;
    NSUInteger length = [string length];
    unichar charBuffer[length];
    [string getCharacters:charBuffer];
    
    for (length=0; length > 0; length--)
    {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    
    return [string substringWithRange:NSMakeRange(location, length - location)];
}

+ (BOOL ) stringIsEmpty:(NSString *) aString
{
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - UserDefaults
#pragma mark -
#pragma mark - Defaults String Values

+ (void)setStringValueToUserDefaults:(NSString *)strValue ForKey:(NSString *)strKey
{
    if ([NSUserDefaults standardUserDefaults]) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", strValue] forKey:strKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSString *)getStringValueFromUserDefaults_ForKey:(NSString *)strKey
{
    NSString *s = nil;
    if ([NSUserDefaults standardUserDefaults]) {
        s =[[NSUserDefaults standardUserDefaults] valueForKey:strKey];
    }
    return s;
}

#pragma mark - Defaults Integer Values

+ (void)setIntegerValueToUserDefaults:(int)intValue ForKey:(NSString *)intKey
{
    if ([NSUserDefaults standardUserDefaults]) {
        [[NSUserDefaults standardUserDefaults] setInteger:intValue forKey:intKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (int)getIntegerValueFromUserDefaults_ForKey:(NSString *)intKey
{
    int i = 0;
    if ([NSUserDefaults standardUserDefaults]) {
        i = (int) [[NSUserDefaults standardUserDefaults] integerForKey:intKey];
    }
    return i;
}

#pragma mark - Defaults Boolean Values

+ (void)setBooleanValueToUserDefaults:(bool)booleanValue ForKey:(NSString *)booleanKey
{
    if ([NSUserDefaults standardUserDefaults]) {
        [[NSUserDefaults standardUserDefaults] setBool:booleanValue forKey:booleanKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (bool)getBooleanValueFromUserDefaults_ForKey:(NSString *)booleanKey
{
    bool b = false;
    if ([NSUserDefaults standardUserDefaults]) {
        b = [[NSUserDefaults standardUserDefaults] boolForKey:booleanKey];
    }
    return b;
}

#pragma mark - Defaults Object Values

+ (void)setObjectValueToUserDefaults:(id)idValue ForKey:(NSString *)strKey
{
    if ([NSUserDefaults standardUserDefaults]) {
        [[NSUserDefaults standardUserDefaults] setObject:idValue forKey:strKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (id)getObjectValueFromUserDefaults_ForKey:(NSString *)strKey
{
    id obj = nil;
    if ([NSUserDefaults standardUserDefaults]) {
        obj =[[NSUserDefaults standardUserDefaults] objectForKey:strKey];
    }
    
    return obj;
}
#pragma mark - View controller methods
//When get stuck with issues like popover as main view or tabbars as main view or having many subviews then refer this link here: http://stackoverflow.com/questions/6131205/iphone-how-to-find-topmost-view-controller

+ (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

+ (NSString *)randomStringWithLength:(int)len {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:len];
    
    for (int i = 0; i < len; i++) {
        [randomString
         appendFormat:@"%C", [letters characterAtIndex:arc4random() %
                              [letters length]]];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
    [formatter setLocale:[NSLocale systemLocale]];
    NSString *str = [formatter stringFromDate:[NSDate new]];
    NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    str = [[str componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
    [randomString appendString:str];
    return randomString;
}


+(NSString*)encodedStringtoSend:(NSString*)mystr
{
    //pr code
    /*NSData *data = [mystr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *strValue = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return strValue;*/
    
    //milan code
    /*NSData *data = [mystr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *strValue = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return strValue;*/
    
    //my code
    return [[mystr dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
}

+(NSString *) getDateTOString:(NSDate *)date withFormat:(NSString *)originalFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =originalFormat;
    return [formatter stringFromDate:date];
}

+(NSDate *) getStringTODate:(NSString *)date withFormat:(NSString *)originalFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =originalFormat;
    return [formatter dateFromString:date];
}

+ (NSDate *)dateString:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = fromFormat;
    NSDate *originalDate=[formatter dateFromString:date];
    formatter.dateFormat = toFormat;
    return [formatter dateFromString:[formatter stringFromDate:originalDate]];
}

+ (NSString *)stringDate:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = fromFormat;
    NSDate *originalDate=[formatter dateFromString:date];
    formatter.dateFormat = toFormat;
    return [formatter stringFromDate:originalDate];
}

+ (NSString *)relativeDateStringForDate:(NSDate *)date
{
    NSCalendarUnit units = NSCalendarUnitDay | NSCalendarUnitWeekOfYear |
    NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units
                                                                   fromDate:date
                                                                     toDate:[NSDate date]
                                                                    options:0];
    
    if (components.year > 0) {
        return [Function getDateTOString:date withFormat:@"d MMMM yyyy"];
        //return [NSString stringWithFormat:@"%ld yrs ago", (long)components.year];
    } else if (components.month > 0) {
        return [Function getDateTOString:date withFormat:@"d MMMM yyyy"];
       // return [NSString stringWithFormat:@"%ld mon ago", (long)components.month];
    } else if (components.weekOfYear > 0) {
        return [Function getDateTOString:date withFormat:@"d MMMM yyyy"];
        //return [NSString stringWithFormat:@"%ldw ago", (long)components.weekOfYear];
    } else if (components.day > 0) {
        if (components.day > 1) {
            NSString *strDate = [Function getDateTOString:date withFormat:@"d MMMM yyyy"];
            return strDate;
           // return [NSString stringWithFormat:@"%ldd ago", (long)components.day];
        } else {
            return @"Yesterday";
        }
    } else {
        NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date toDate:[NSDate date] options:0];
        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:date];
        NSString *timestampString;
        if(interval < 30) timestampString = [NSString stringWithFormat:@"just now"];
        else if (interval < 60) timestampString = [NSString stringWithFormat:@"%ld secs ago" ,(long)today.second];
        else if (interval < 60 * 60) timestampString = [NSString stringWithFormat:@"%ld mins ago" ,(long)today.minute];
        else if (interval < 60 * 60 * 24) timestampString = [NSString stringWithFormat:@"%ld hrs ago" ,(long)today.hour];
        else timestampString = [Function getDateTOString:date withFormat:@"d MMMM yyyy"];//[NSString stringWithFormat:@"%ldd ago" ,(long)today.day];
        return timestampString;
    }
    
    
}

@end
