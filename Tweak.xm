#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];

@interface SBDockIconListView : UIView
@end

%hook SBDockIconListView
-(void)layoutSubviews
{
	NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:
                                    [NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.chfreeware.dockcolor.plist"]];
    NSNumber* isEnabled = [prefs objectForKey:@"enabled"];
    NSString* colorString = [prefs objectForKey:@"saveColor"];

    NSArray* subStrings = [colorString componentsSeparatedByString:@":"];
    NSString* finalString = [subStrings objectAtIndex:0];
	finalString = [finalString stringByReplacingOccurrencesOfString:@"#"
                                     withString:@"0x"];
	unsigned colorInt = 0;
	[[NSScanner scannerWithString:finalString] scanHexInt:&colorInt];

	if([isEnabled boolValue] == YES)
	{
		self.backgroundColor = UIColorFromRGB(colorInt);
	}
	else
	{
		%orig;
	}
}
%end
