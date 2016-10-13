///Include our header file(s)
#import <UIKit/UIKit.h>

//Let's create a macro to convert RGB to a UIColor object
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];

//Initialize the interface to interact with
@interface SBDockIconListView : UIView
@end

//We are hooking into 'SBDockIconListView'
%hook SBDockIconListView

//When our subviews are created, let's do something
-(void)layoutSubviews
{
	//Define the file that holds our prefs
	NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:
                                    [NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.chfreeware.dockcolor.plist"]];

	//Create a NSNumber to hold our boolean value to check if our tweak is enabled
    NSNumber* isEnabled = [prefs objectForKey:@"enabled"];

    //Let's capture the hex value from libcolorpicker
    NSString* colorString = [prefs objectForKey:@"saveColor"];

    //To use our macro, we need to have it in '0xFFFFFF' format so lets remove the alpha
    NSArray* subStrings = [colorString componentsSeparatedByString:@":"];
    NSString* finalString = [subStrings objectAtIndex:0];

    //Now that our string doesn't contain an alpha value, let's replace our # with 0x for our macro to use
	finalString = [finalString stringByReplacingOccurrencesOfString:@"#"
                                     withString:@"0x"];

	//Our macro only accepts an integer value so let's convert it
	unsigned colorInt = 0;
	[[NSScanner scannerWithString:finalString] scanHexInt:&colorInt];

	//If the enabled switch is enabled
	if([isEnabled boolValue] == YES)
	{
		//Set our color
		self.backgroundColor = UIColorFromRGB(colorInt);
	}
	else
	{
		//Otherwise, let's just call the default dock
		%orig;
	}
}
%end
