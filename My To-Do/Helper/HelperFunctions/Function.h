//
//  Common.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Function : NSObject
{

}
#pragma mark - dictionary functions
+(NSString *) getStringFromObject:(NSString *) key fromDictionary:(NSDictionary *) values;
+(NSString *) getStringForKey:(NSString *) key fromDictionary:(NSDictionary *) values;

+(int) getIntegerForKey:(NSString *) key fromDictionary:(NSDictionary *) values;
+(double) getDoubleForKey:(NSString *) key fromDictionary:(NSDictionary *) values;

#pragma mark - string functions
+ (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet forString:(NSString *)string;
+ (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet forString:(NSString *)string;
+ (BOOL ) stringIsEmpty:(NSString *) aString;

#pragma mark - User defaults
+ (void)setStringValueToUserDefaults:(NSString *)strValue ForKey:(NSString *)strKey;
+ (NSString *)getStringValueFromUserDefaults_ForKey:(NSString *)strKey;

+ (void)setIntegerValueToUserDefaults:(int)intValue ForKey:(NSString *)intKey;
+ (int)getIntegerValueFromUserDefaults_ForKey:(NSString *)intKey;

+ (void)setBooleanValueToUserDefaults:(bool)booleanValue ForKey:(NSString *)booleanKey;
+ (bool)getBooleanValueFromUserDefaults_ForKey:(NSString *)booleanKey;

+ (void)setObjectValueToUserDefaults:(id)idValue ForKey:(NSString *)strKey;
+ (id)getObjectValueFromUserDefaults_ForKey:(NSString *)strKey;

#pragma mark - View controller methods

+ (UIViewController*) topMostController;

#pragma mark - String Encoding

+ (NSString *)randomStringWithLength:(int)len;

+(NSString*)encodedStringtoSend:(NSString*)mystr;
+(NSString*)parseEncodedStringtoDisplay:(NSString*)mystr;

+(NSString *) getDateTOString:(NSDate *)date withFormat:(NSString *)originalFormat;

+(NSDate *) getStringTODate:(NSString *)date withFormat:(NSString *)originalFormat;

+ (NSDate *)dateString:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat;

+ (NSString *)stringDate:(NSString *)date fromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat;

+ (NSString *)relativeDateStringForDate:(NSDate *)date;
@end
