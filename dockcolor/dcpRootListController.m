#include "dcpRootListController.h"
#include <spawn.h>
#include <signal.h>

@implementation dcpRootListController

- (void)respringDevice
{
   UIAlertController *vc = [UIAlertController
   alertControllerWithTitle:@"DockColor+ Alert"
   message:@"Would you like to respring your device?"
   preferredStyle:UIAlertControllerStyleAlert];

   UIAlertAction* yesButton = [UIAlertAction
   actionWithTitle:@"Respring"
   style:UIAlertActionStyleDefault
   handler:^(UIAlertAction *action)
   {
      pid_t pid;
      int status;
      const char *argv[] = {"killall", "SpringBoard", NULL};
      posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)argv, NULL);
      waitpid(pid, &status, WEXITED);
   }];

   UIAlertAction* noButton = [UIAlertAction
   actionWithTitle:@"Cancel"
   style:UIAlertActionStyleDefault
   handler:^(UIAlertAction *action) 
   {
		
   }];

   [vc addAction:yesButton];
   [vc addAction:noButton];
   UIViewController *rootView = [[UIApplication sharedApplication].keyWindow rootViewController];
   [rootView presentViewController:vc animated:YES completion:nil];

    NSLog(@"stack: %@", [NSThread callStackSymbols]);
}

- (void)twitterNav
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/ioschrisharris"]];
}

- (void)paypalNav
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=VU58K2NHRLK22"]];
}

- (void)gitNav
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.github.com/ioschris"]];
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

@end
