/// Tests for Turkish (Turkey) number-to-words conversion.
#import "/src/lib.typ": converters
#import "/tests/utils.typ": check

#let convert = converters.tr

// Cardinals.
#check(
  convert,
  (
    // Basic.
    (0, "sıfır"),
    (1, "bir"),
    (2, "iki"),
    (3, "üç"),
    (4, "dört"),
    (5, "beş"),
    (9, "dokuz"),
    (10, "on"),
    (11, "on bir"),
    (12, "on iki"),
    (13, "on üç"),
    (15, "on beş"),
    (19, "on dokuz"),
    // Tens.
    (20, "yirmi"),
    (21, "yirmi bir"),
    (30, "otuz"),
    (42, "kırk iki"),
    (50, "elli"),
    (69, "altmış dokuz"),
    (80, "seksen"),
    (99, "doksan dokuz"),
    // Hundreds.
    (100, "yüz"),
    (101, "yüz bir"),
    (110, "yüz on"),
    (111, "yüz on bir"),
    (199, "yüz doksan dokuz"),
    (200, "iki yüz"),
    (999, "dokuz yüz doksan dokuz"),
    // Thousands and beyond.
    (1000, "bin"),
    (1001, "bin bir"),
    (1010, "bin on"),
    (1100, "bin yüz"),
    (1234, "bin iki yüz otuz dört"),
    (10000, "on bin"),
    (12345, "on iki bin üç yüz kırk beş"),
    (100000, "yüz bin"),
    (1000000, "bir milyon"),
    (1000001, "bir milyon bir"),
    (1234567, "bir milyon iki yüz otuz dört bin beş yüz altmış yedi"),
    (1000000000, "bir milyar"),
    (1000000000000, "bir trilyon"),
    // Negative numbers.
    (-1, "eksi bir"),
    (-42, "eksi kırk iki"),
    (-1000, "eksi bin"),
    (-5, "sıfırın altında beş", arguments(negative: "sıfırın altında")),
  ),
  form: "cardinal",
)

// Ordinals.
#check(
  convert,
  (
    // Irregulars.
    (0, "sıfırıncı"),
    (4, "dördüncü"),
    (14, "on dördüncü"),
    // Regular.
    (1, "birinci"),
    (2, "ikinci"),
    (3, "üçüncü"),
    (5, "beşinci"),
    (6, "altıncı"),
    (7, "yedinci"),
    (8, "sekizinci"),
    (9, "dokuzuncu"),
    (10, "onuncu"),
    (11, "on birinci"),
    (12, "on ikinci"),
    (13, "on üçüncü"),
    (20, "yirminci"),
    (30, "otuzuncu"),
    // Compound.
    (21, "yirmi birinci"),
    (22, "yirmi ikinci"),
    (23, "yirmi üçüncü"),
    (42, "kırk ikinci"),
    (99, "doksan dokuzuncu"),
    (100, "yüzüncü"),
    (101, "yüz birinci"),
    (1000, "bininci"),
    (1000000, "bir milyonuncu"),
  ),
  form: "ordinal",
)

// Years.
#check(
  convert,
  (
    (0, "sıfır"),
    (42, "kırk iki"),
    (800, "sekiz yüz"),
    (1000, "bin"),
    (1900, "bin dokuz yüz"),
    (1901, "bin dokuz yüz bir"),
    (1999, "bin dokuz yüz doksan dokuz"),
    (2000, "iki bin"),
    (2001, "iki bin bir"),
    (2009, "iki bin dokuz"),
    (2010, "iki bin on"),
    (2024, "iki bin yirmi dört"),
    (-1999, "eksi bin dokuz yüz doksan dokuz"),
  ),
  form: "year",
)
