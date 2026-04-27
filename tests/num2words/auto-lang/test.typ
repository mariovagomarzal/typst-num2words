/// Tests that `num2words` produces the expected content inferring the language from the context.
#import "/src/lib.typ": num2words

#set text(lang: "en")

#num2words(0)
#num2words(42)
#num2words(-1)
