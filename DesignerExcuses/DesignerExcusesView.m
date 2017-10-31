//
//  DesignerExcusesView.m
//  DesignerExcuses
//
//  Created by Thomas Eilmsteiner on 01/03/17.
//  Copyright © 2017 Thomas Eilmsteiner. All rights reserved.
//

#import "DesignerExcusesView.h"

@interface DesignerExcusesView()

@property NSUserDefaults *defaults;

@end

NSString *kLastFetchedQuote = @"kLastFetchedQuote";
NSArray *quoteList = nil;

@implementation DesignerExcusesView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];

    CGRect newFrame = self.label.frame;
    CGFloat height = [_label.stringValue sizeWithAttributes:@{NSFontAttributeName: _label.font}].height;
    newFrame.size.height = height;
    newFrame.origin.y = (NSHeight(self.bounds) - height) / 2;
    _label.frame = newFrame;
    
    CGFloat redValue = arc4random_uniform(255) / 255.0;
    CGFloat greenValue = arc4random_uniform(255) / 255.0;
    CGFloat blueValue = arc4random_uniform(255) / 255.0;
    NSColor *color = [NSColor colorWithCalibratedRed:redValue green:greenValue blue:blueValue alpha:1];
    
    [color setFill];
    NSRectFill(rect);
}

- (void)animateOneFrame
{
    [self fetchNextQuote];
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

- (void) initialize {
    [self setAnimationTimeInterval:0.5];
    _defaults = [NSUserDefaults standardUserDefaults];
    quoteList = @[@"This is what Apple does.",
                           @"It’s a Material Design thing.",
                           @"_____ does it like this, and they have like 500M users.",
                           @"This is how everyone does it. We should do it this way.",
                           @"This is how everyone does it. We shouldn’t do it this way.",
                           @"I wanted to try something different.",
                           @"I saw a design on Tumblr that looks like this.",
                           @"Whitespace looks better. It looks so clean!",
                           @"We’re industry leaders. Sometimes you just have to take risks.",
                           @"That must be an older version you’re seeing.",
                           @"I [got a Masters/did online training/saw a tweet], so trust me on this.",
                           @"I just read* a great article on Medium about this (*saw the title).",
                           @"We’ll just revisit this after the launch (we won’t).",
                           @"Our team loved the design.",
                           @"[The most important stakeholder] loved the design.",
                           @"Dribbble and Behance loved the design.",
                           @"The old man sitting on the couch with me at Starbucks loved the design.",
                           @"We can go with function or form, but not both.",
                           @"We can change it, I’m not married to it (our honeymoon is tomorrow).",
                           @"It’s like Uber, but for [super specific, unrelated B2B software app].",
                           @"It’s like [app no one has heard of], but for [some worse idea].",
                           @"We’ll just put some charts there.",
                           @"It’s a delighter!",
                           @"GIFs are all the rage right now.",
                           @"All the best companies use parallax.",
                           @"Don’t you think it’ll look boring without it?",
                           @"I’m not worried. A dev should be able to implement this pretty easily.",
                           @"But if I make it a PDF then you won’t see the animation…",
                           @"Computers are fast! Page size and load time aren’t an issue anymore.",
                           @"You must not have [that obscure font I used] installed.",
                           @"Microsoft is notorious for bad font rendering. People don’t use Windows.",
                           @"I can’t share TypeKit fonts, so you’ll have to wait until we present it.",
                           @"The sharpness is probably just too high on your screen.",
                           @"We won’t look premium if we don’t use [some obscure font].",
                           @"Too small? How can you not read that?",
                           @"The text is already dark enough. I like it #FAFAFA.",
                           @"Your [TV/phone/monitor/tablet/Palm Pilot] probably isn’t calibrated.",
                           @"The brand palette is too limited for what we want to do.",
                           @"It’s softer on the eyes this way.",
                           @"I wanted it to really stand out. You know…super punchy.",
                           @"It’s the Pantone color of the year!",
                           @"InVision must be acting up.",
                           @"You’re probably looking at a cached version.",
                           @"It must not have synced to [Dropbox/Google Drive].",
                           @"That’s just a bug in Sketch.",
                           @"It screwed up the design when I updated my app.",
                           @"That’s probably a limitation of the app.",
                           @"We’re still on the free version.",
                           @"Sorry, I’ve been updating Adobe applications all day.",
                           @"My design application keeps crashing.",
                           @"Dev must have screwed it up.",
                           @"No one uses IE anyway.",
                           @"That must be a bug in Chrome.",
                           @"That effect should be supported in the latest nightly build of Chrome.",
                           @"Just have dev draw it in CSS.",
                           @"I think this should be really easy with a framework.",
                           @"A user would never do that anyway (they will).",
                           @"Our users all have MacBooks and use Chrome.",
                           @"Oh come on, no one builds Android apps anymore.",
                           @"What do you mean your projector isn’t 4K?",
                           @"You shouldn’t have your screen brightness all the way down.",
                           @"Hmm, it doesn’t look like that on my computer.",
                           @"Isn’t your display retina?",
                           @"Maybe it got caught in your spam.",
                           @"I’m guessing it just looks bad in “Preview” mode.",
                           @"Ah sorry, the file is too big to send. I’ll show you next week.",
                           @"Oh, I sent it to the wrong “Petr Rozhdestvenskiy.",
                           @"I just sent it over (lie). Did it not go through?",
                           @"My colleague was supposed to send it (oh sh*t, I completely forgot).",
                           @"I forgot to add you to that email thread (I didn’t).",
                           @"I’m almost done, but don’t want to spoil it (I haven’t started yet).",
                           @"I’m not worried about that right now.",
                           @"We have it designed on the whiteboard back at the office (I’m stalling).",
                           @"I don’t want to distract you with low-fidelity.",
                           @"It’s not what you asked for and I’m afraid you’ll get mad.",
                           @"It’s taking longer than I thought (again…I haven’t started yet).",
                           @"Sorry, my computer has been really laggy today.",
                           @"Can we do a remote meeting today (so I can work on another project)?",
                           @"I can’t start until I have all of the requirements.",
                           @"I can’t start until research is done.",
                           @"I can’t start until we document all edge-cases.",
                           @"I can’t start until we decide on a color.",
                           @"I can’t start until we decide on a name.",
                           @"I can’t start until all 29 people join the conference call.",
                           @"I was watching the Apple Keynote.",
                           @"We can always iterate on this (we probably won’t).",
                           @"This isn’t the final design (lol, yes it is).",
                           @"We should probably use a hamburger menu.",
                           @"We’re definitely not using a hamburger menu.",
                           @"That wasn’t in the original requirements (I skipped that intentionally).",
                           @"Design rules are meant to be broken.",
                           @"Dev has really been holding me back.",
                           @"You just haven’t seen it done this way before.",
                           @"This is what your napkin sketch looked like, right?",
                           @"I basically just did what my PM told me to do.",
                           @"We’ll work on it next sprint.",
                           @"It’s better than what we have.",
                           @"We’ll just put it in a modal."];
    
    [self configureLabel];
    [self fetchNextQuote];
}

- (void)configureLabel {
    _label = [[NSTextField alloc] initWithFrame:self.bounds];
    _label.autoresizingMask = NSViewWidthSizable;
    _label.alignment = NSCenterTextAlignment;
    
    _label.textColor = [NSColor blackColor];
    _label.font = [NSFont fontWithName:@"Arial" size:(self.preview ? 12.0 : 24.0)];
    
    _label.backgroundColor = [NSColor clearColor];
    [_label setEditable:NO];
    [_label setBezeled:NO];
    
    [self addSubview:_label];
    
    [self setQuote:quoteList[[self getRandomQuoteNr]]];
}

- (void)setQuote:(NSString *) quote {
    _label.stringValue = quote;
    if (quote != nil) {
        _label.stringValue = quote;
        [_defaults setObject:quote forKey:kLastFetchedQuote];
        [_defaults synchronize];
        self.shouldFetchQuote = NO;
        [self setNeedsDisplay:YES];
    }
    
    [self scheduleNextFetch];
}

- (void)scheduleNextFetch {
    double delayInSeconds = 10.0;
    dispatch_time_t fireTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(fireTime, dispatch_get_main_queue(), ^(void){
        self.shouldFetchQuote = YES;
    });
}

- (void) fetchNextQuote {
    @synchronized (self) {
        if (!self.shouldFetchQuote) {
            return;
        }
    }
    
    self.shouldFetchQuote = NO;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setQuote:[quoteList objectAtIndex:[self getRandomQuoteNr]]];
        });
    });
}

- (NSUInteger)getRandomQuoteNr {
    NSUInteger quoteItemNumber = quoteList.count;
    NSUInteger randomQuoteIndex = 0 + arc4random() % (quoteItemNumber - 0);

    return randomQuoteIndex;
}

@end
