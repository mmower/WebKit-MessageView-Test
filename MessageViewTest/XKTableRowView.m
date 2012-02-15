//
//  XKTableRowView.m
//  MessageViewTest
//
//  Created by Matt Mower on 14/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XKTableRowView.h"

@implementation XKTableRowView

//- (void)drawSelectionInRect:(NSRect)dirtyRect {
//  NSRect selectionRect = NSInsetRect( [self bounds], 5.5, 5.5 );
//  [[NSColor colorWithCalibratedWhite:0.72 alpha:1.0] setStroke];
//  [[NSColor colorWithCalibratedWhite:0.82 alpha:1.0] setFill];
//  NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:selectionRect xRadius:10.0 yRadius:10.0];
//  [path fill];
//  [path stroke];
//}


//- (void)drawBackgroundInRect:(NSRect)dirtyRect {
//  [[self backgroundColor] set];
//  NSRectFill( [self bounds] );
//  
////  if( _mouseInside ) {
//    NSGradient *gradient = [[NSGradient alloc] initWithColors:[NSArray arrayWithObjects:[NSColor whiteColor],[NSColor blackColor],[NSColor whiteColor],nil]];
//    [gradient drawInRect:[self bounds] angle:0.0];
////  }
//}


//- (void)updateTrackingAreas {
//  [super updateTrackingAreas];
//  
//  if( _trackingArea == nil ) {
//    _trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect options:NSTrackingActiveWhenFirstResponder|NSTrackingMouseEnteredAndExited owner:self userInfo:nil];
//  }
//  if( ![[self trackingAreas] containsObject:_trackingArea] ) {
//    [self addTrackingArea:_trackingArea];
//  }
//}
//
//
//- (void)mouseEntered:(NSEvent *)theEvent {
//  _mouseInside = YES;
//  [self setNeedsDisplay:YES];
//}
//
//
//- (void)mouseExited:(NSEvent *)theEvent {
//  _mouseInside = YES;
//  [self setNeedsDisplay:NO];
//}

@end
