/// Tests for English (American) number-to-words conversion.
#import "/src/lib.typ": converters
#import "/tests/utils.typ": check

#let convert = converters.en

// Cardinals.
#check(
  convert,
  (
    // Basic.
    (0, "zero"),
    (1, "one"),
    (2, "two"),
    (3, "three"),
    (4, "four"),
    (5, "five"),
    (9, "nine"),
    (10, "ten"),
    (11, "eleven"),
    (12, "twelve"),
    (13, "thirteen"),
    (15, "fifteen"),
    (19, "nineteen"),
    // Tens.
    (20, "twenty"),
    (21, "twenty-one"),
    (30, "thirty"),
    (42, "forty-two"),
    (50, "fifty"),
    (69, "sixty-nine"),
    (80, "eighty"),
    (99, "ninety-nine"),
    // Hundreds.
    (100, "one hundred"),
    (101, "one hundred one"),
    (110, "one hundred ten"),
    (111, "one hundred eleven"),
    (199, "one hundred ninety-nine"),
    (200, "two hundred"),
    (999, "nine hundred ninety-nine"),
    // Thousands and beyond.
    (1000, "one thousand"),
    (1001, "one thousand one"),
    (1010, "one thousand ten"),
    (1100, "one thousand one hundred"),
    (1234, "one thousand two hundred thirty-four"),
    (10000, "ten thousand"),
    (12345, "twelve thousand three hundred forty-five"),
    (100000, "one hundred thousand"),
    (1000000, "one million"),
    (1000001, "one million one"),
    (1234567, "one million two hundred thirty-four thousand five hundred sixty-seven"),
    (1000000000, "one billion"),
    (1000000000000, "one trillion"),
    // Negative numbers.
    (-1, "negative one"),
    (-42, "negative forty-two"),
    (-1000, "negative one thousand"),
    (-5, "minus five", arguments(negative: "minus")),
  ),
  form: "cardinal",
)

// Ordinals.
#check(
  convert,
  (
    // Irregulars.
    (0, "zeroth"),
    (1, "first"),
    (2, "second"),
    (3, "third"),
    (5, "fifth"),
    (8, "eighth"),
    (9, "ninth"),
    (12, "twelfth"),
    // Regular.
    (4, "fourth"),
    (6, "sixth"),
    (7, "seventh"),
    (10, "tenth"),
    (11, "eleventh"),
    (13, "thirteenth"),
    (14, "fourteenth"),
    (20, "twentieth"),
    (30, "thirtieth"),
    // Compound.
    (21, "twenty-first"),
    (22, "twenty-second"),
    (23, "twenty-third"),
    (42, "forty-second"),
    (99, "ninety-ninth"),
    (100, "one hundredth"),
    (101, "one hundred first"),
    (1000, "one thousandth"),
    (1000000, "one millionth"),
  ),
  form: "ordinal",
)

// Years.
#check(
  convert,
  (
    (0, "zero"),
    (42, "forty-two"),
    (800, "eight hundred"),
    (1000, "one thousand"),
    (1900, "nineteen hundred"),
    (1901, "nineteen oh one"),
    (1999, "nineteen ninety-nine"),
    (2000, "two thousand"),
    (2001, "two thousand one"),
    (2009, "two thousand nine"),
    (2010, "twenty ten"),
    (2024, "twenty twenty-four"),
    (-1999, "negative nineteen ninety-nine"),
  ),
  form: "year",
)
