//
//  XKAppDelegate.h
//  MessageViewTest
//
//  Created by Matt Mower on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface XKAppDelegate : NSObject <NSApplicationDelegate> {
  NSInteger _previousSelectedRow;
}

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSTableView *tableView;

@end
