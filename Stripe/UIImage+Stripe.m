//
//  UIImage+Stripe.m
//  Stripe
//
//  Created by Ben Guo on 1/4/16.
//  Copyright © 2016 Stripe, Inc. All rights reserved.
//

#import "UIImage+Stripe.h"

#define FAUXPAS_IGNORED_IN_METHOD(...)

// Dummy class for locating the framework bundle
@interface STPBundleLocator : NSObject
@end
@implementation STPBundleLocator
@end

@implementation UIImage (Stripe)

+ (UIImage *)stp_addIcon {
    return [UIImage stp_safeImageNamed:@"stp_icon_add" templateifAvailable:YES];
}

+ (nonnull UIImage *)stp_largeCardFrontImage {
    return [UIImage stp_safeImageNamed:@"stp_card_form_front" templateifAvailable:YES];
}

+ (nonnull UIImage *)stp_largeCardBackImage {
    return [UIImage stp_safeImageNamed:@"stp_card_form_back" templateifAvailable:YES];
}

+ (UIImage *)stp_applePayCardImage {
    return [UIImage stp_safeImageNamed:@"stp_card_applepay"];
}

+ (UIImage *)stp_amexCardImage {
    return [UIImage stp_brandImageForCardBrand:STPCardBrandAmex];
}

+ (UIImage *)stp_dinersClubCardImage {
    return [UIImage stp_brandImageForCardBrand:STPCardBrandDinersClub];
}

+ (UIImage *)stp_discoverCardImage {
    return [UIImage stp_brandImageForCardBrand:STPCardBrandDiscover];
}

+ (UIImage *)stp_jcbCardImage {
    return [UIImage stp_brandImageForCardBrand:STPCardBrandJCB];
}

+ (UIImage *)stp_masterCardCardImage {
    return [UIImage stp_brandImageForCardBrand:STPCardBrandMasterCard];
}

+ (UIImage *)stp_visaCardImage {
    return [UIImage stp_brandImageForCardBrand:STPCardBrandVisa];
}

+ (UIImage *)stp_unknownCardCardImage {
    return [UIImage stp_brandImageForCardBrand:STPCardBrandUnknown];
}

+ (UIImage *)stp_brandImageForCardBrand:(STPCardBrand)brand {
    FAUXPAS_IGNORED_IN_METHOD(APIAvailability);
    NSString *imageName;
    BOOL templateSupported = [[UIImage new] respondsToSelector:@selector(imageWithRenderingMode:)];
    switch (brand) {
        case STPCardBrandAmex:
            imageName = @"stp_card_amex";
            break;
        case STPCardBrandDinersClub:
            imageName = @"stp_card_diners";
            break;
        case STPCardBrandDiscover:
            imageName = @"stp_card_discover";
            break;
        case STPCardBrandJCB:
            imageName = @"stp_card_jcb";
            break;
        case STPCardBrandMasterCard:
            imageName = @"stp_card_mastercard";
            break;
        case STPCardBrandUnknown:
            imageName = templateSupported ? @"stp_card_placeholder_template" : @"stp_card_placeholder";
            break;
        case STPCardBrandVisa:
            imageName = @"stp_card_visa";
    }
    UIImage *image = [UIImage stp_safeImageNamed:imageName];
    if (brand == STPCardBrandUnknown && templateSupported) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return image;
}

+ (UIImage *)stp_cvcImageForCardBrand:(STPCardBrand)brand {
    NSString *imageName = brand == STPCardBrandAmex ? @"stp_card_cvc_amex" : @"stp_card_cvc";
    return [UIImage stp_safeImageNamed:imageName];
}

+ (UIImage *)stp_safeImageNamed:(NSString *)imageName
            templateifAvailable:(BOOL)templateIfAvailable {
    FAUXPAS_IGNORED_IN_METHOD(APIAvailability);
    BOOL templateSupported = [[UIImage new] respondsToSelector:@selector(imageWithRenderingMode:)];
    UIImage *image;
    if ([[UIImage class] respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
        image = [UIImage imageNamed:imageName inBundle:[NSBundle bundleForClass:[STPBundleLocator class]] compatibleWithTraitCollection:nil];
    }
    image = [UIImage imageNamed:imageName];
    if (templateSupported && templateIfAvailable) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return image;
}

+ (UIImage *)stp_safeImageNamed:(NSString *)imageName {
    return [self stp_safeImageNamed:imageName templateifAvailable:NO];
}

@end

void linkUIImageCategory(void){}
