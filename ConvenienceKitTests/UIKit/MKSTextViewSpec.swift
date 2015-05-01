//
//  MKSTextViewSpec.swift
//  MakeSchoolNotes
//
//  Created by Benjamin Encz on 2/23/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Quick
import Nimble
import ConvenienceKit

class MKSTextViewSpec: QuickSpec {
  override func spec() {
    var textView: TextView!
    
    beforeEach {
      textView = TextView(frame: CGRectZero, textContainer: nil)
    }
    
    describe("Provides text value") {
      it ("Returns empty text value when dislaying placeholder text") {
        textView.text = ""
        expect(textView.textValue).to(equal(""))
      }

      it ("Returns the text value stored in 'text' if it's not empty") {
        textView.text = "Text Content"
        expect(textView.textValue).to(equal(textView.text))
      }
    }
    
    describe("Shows placeholder text") {
      it ("Shows placeholder text when text is empty") {
        textView.text = ""
        expect(textView.showsPlaceholderText).to(beTrue())
      }
      
      it ("Does not show placeholder when text is non-empty") {
        textView.text = "Text Content"
        expect(textView.showsPlaceholderText).to(beFalse())
      }
      
      it ("Shows placeholder text when changing text to empty") {
        textView.text = "Text Content"
        textView.setValue("", forKeyPath: "text")
        
        NSNotificationCenter.defaultCenter().postNotificationName(UITextViewTextDidEndEditingNotification, object: textView)
        
        expect(textView.showsPlaceholderText).to(beTrue())
      }
      
      it ("Hides placeholder text when editing begins") {
        textView.text = ""

        NSNotificationCenter.defaultCenter().postNotificationName(UITextViewTextDidBeginEditingNotification, object: textView)

        expect(textView.showsPlaceholderText).to(beFalse())
      }
      
      it ("Hides placeholder text when text is non-empty") {
        textView.text = ""
        
        expect(textView.showsPlaceholderText).to(beTrue())
        
        textView.setValue("TestContent", forKeyPath: "text")
        NSNotificationCenter.defaultCenter().postNotificationName(UITextViewTextDidEndEditingNotification, object: textView)
        
        expect(textView.showsPlaceholderText).to(beFalse())
      }
    }
    
    describe("Allows modificiation of placeholder text") {
      it("uses a default placeholder text if none is provided") {
        textView.text = ""
        expect(textView.text).to(equal("Tap to edit"))
      }
      
      it("uses custom placeholder text when provided") {
        textView.placeholderText = "Placeholder!"
        textView.text = ""
        expect(textView.text).to(equal("Placeholder!"))
      }
    }
  }
}
