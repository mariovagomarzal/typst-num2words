/// Tests that `num2words` produces the expected content when passing the language explicitly.
#import "/src/lib.typ": num2words

#num2words(0, lang: "en")
#num2words(42, lang: "en")
#num2words(-1, lang: "en")
