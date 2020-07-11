//
//  ScriptExamples.swift
//  Extension
//
//  Created by Volodymyr Ostapyshyn on 10.07.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import Foundation

let scriptExamples = [
    (title: "Display an alert",
     example: """
        alert("Page title: " + document.title + "\\nPage url: " + document.URL);
        """
    ),
    (title: "Replace page content",
     example: """
        document.body.innerHTML = '';
        let p = document.createElement('p');
        p.textContent = 'Page content replaced!';
        document.body.appendChild(p);
        """
    ),
    (title: "Split URL",
     example: """
        alert("Protocol: " + window.location.protocol + "\\nHost: " + window.location.host + "\\nPathname: " + window.location.pathname);
        """
    ),
    (title: "Count words in selection",
     example: """
            var t;
            if (window.getSelection) t = window.getSelection();
            else if (document.selection) t = document.selection.createRange();
            if (t.text != undefined) t = t.text;
            if (!t || t == "") {
                a = document.getElementsByTagName("textarea");
                for(i=0; i<a.length; i++) {
                    if(a[i].selectionStart != undefined && a[i].selectionStart != a[i].selectionEnd) {
                        t = a[i].value.substring(a[i].selectionStart, a[i].selectionEnd);
                        break;
                    }
                }
            }
            if(!t || t == "") alert("Please select some text");
            else alert("Word count: " + t.toString().match(/(\\S+)/g).length);
            """)
]
