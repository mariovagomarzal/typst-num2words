/// Tests for Catalan number-to-words conversion.
#import "/src/lib.typ": converters
#import "/tests/utils.typ": check

#let convert = converters.ca

// Cardinals.
#check(
  convert,
  (
    // Basic 0–19 (one-word forms; 16–19 are irregular single words).
    (0, "zero"),
    (1, "u"),
    (2, "dos"),
    (5, "cinc"),
    (9, "nou"),
    (10, "deu"),
    (11, "onze"),
    (15, "quinze"),
    (16, "setze"),
    (17, "disset"),
    (18, "divuit"),
    (19, "dinou"),
    (20, "vint"),
    // 21–29 (joined with "-i-").
    (21, "vint-i-u"),
    (22, "vint-i-dos"),
    (26, "vint-i-sis"),
    (29, "vint-i-nou"),
    // 30–99 (hyphenated, no "i").
    (30, "trenta"),
    (31, "trenta-u"),
    (32, "trenta-dos"),
    (45, "quaranta-cinc"),
    (60, "seixanta"),
    (69, "seixanta-nou"),
    (99, "noranta-nou"),
    // Hundreds.
    (100, "cent"),
    (101, "cent u"),
    (110, "cent deu"),
    (121, "cent vint-i-u"),
    (145, "cent quaranta-cinc"),
    (199, "cent noranta-nou"),
    (200, "dos-cents"),
    (245, "dos-cents quaranta-cinc"),
    (300, "tres-cents"),
    (500, "cinc-cents"),
    (700, "set-cents"),
    (900, "nou-cents"),
    (999, "nou-cents noranta-nou"),
    // Thousands. "mil" stands alone (no "un mil"); apocopation kicks in
    // when "u" precedes "mil".
    (1000, "mil"),
    (1001, "mil u"),
    (1021, "mil vint-i-u"),
    (1100, "mil cent"),
    (2000, "dos mil"),
    (21000, "vint-i-un mil"),
    (31000, "trenta-un mil"),
    (100000, "cent mil"),
    (101000, "cent un mil"),
    (121000, "cent vint-i-un mil"),
    (500500, "cinc-cents mil cinc-cents"),
    (999999, "nou-cents noranta-nou mil nou-cents noranta-nou"),
    // Millions and beyond (long scale).
    (1000000, "un milió"),
    (1000001, "un milió u"),
    (1001000, "un milió mil"),
    (2000000, "dos milions"),
    (21000000, "vint-i-un milions"),
    (100000000, "cent milions"),
    (100000500, "cent milions cinc-cents"),
    (1000000000, "mil milions"),
    (2000000000, "dos mil milions"),
    (1000000000000, "un bilió"),
    (1001000000000, "un bilió mil milions"),
    // Negative numbers.
    (-1, "menys u"),
    (-100, "menys cent"),
    (-1000, "menys mil"),
    (-7, "negatiu set", arguments(negative: "negatiu")),
  ),
  form: "cardinal",
)

// Cardinals — apocopated (masculine only).
#check(
  convert,
  (
    (1, "un"),
    (2, "dos"),
    (5, "cinc"),
    (15, "quinze"),
    (21, "vint-i-un"),
    (22, "vint-i-dos"),
    (31, "trenta-un"),
    (32, "trenta-dos"),
    (45, "quaranta-cinc"),
    (101, "cent un"),
    (121, "cent vint-i-un"),
    (200, "dos-cents"),
    (245, "dos-cents quaranta-cinc"),
    (1000, "mil"),
    (1001, "mil un"),
    (21000, "vint-i-un mil"),
    (1000000, "un milió"),
    (1000001, "un milió un"),
    (-1, "menys un"),
  ),
  form: "cardinal",
  apocopated: true,
)

// Cardinals — feminine.
#check(
  convert,
  (
    // Basic units: only "u"/"dos" change.
    (1, "una"),
    (2, "dues"),
    (3, "tres"),
    (10, "deu"),
    (16, "setze"),
    (21, "vint-i-una"),
    (22, "vint-i-dues"),
    (23, "vint-i-tres"),
    (29, "vint-i-nou"),
    // Tens with trailing "u"/"dos".
    (31, "trenta-una"),
    (32, "trenta-dues"),
    (45, "quaranta-cinc"),
    (91, "noranta-una"),
    // Hundreds: "cent" invariable, "dos-cents" → "dues-centes",
    // others change only the suffix to "-centes".
    (100, "cent"),
    (101, "cent una"),
    (102, "cent dues"),
    (121, "cent vint-i-una"),
    (200, "dues-centes"),
    (222, "dues-centes vint-i-dues"),
    (231, "dues-centes trenta-una"),
    (300, "tres-centes"),
    (500, "cinc-centes"),
    (900, "nou-centes"),
    (999, "nou-centes noranta-nou"),
    // Thousands: full feminine forms before "mil".
    (1000, "mil"),
    (1001, "mil una"),
    (21000, "vint-i-una mil"),
    (31000, "trenta-una mil"),
    (101000, "cent una mil"),
    (200000, "dues-centes mil"),
    (200500, "dues-centes mil cinc-centes"),
    // Millions: scale words are masculine and invariable; only the bottom
    // chunk inherits the feminine flag.
    (1000000, "un milió"),
    (1000001, "un milió una"),
    (1000500, "un milió cinc-centes"),
    (2000000, "dos milions"),
    (21000000, "vint-i-un milions"),
    (100000500, "cent milions cinc-centes"),
  ),
  form: "cardinal",
  gender: "feminine",
)

// Ordinals.
#check(
  convert,
  (
    // 1–9.
    (1, "primer"),
    (2, "segon"),
    (3, "tercer"),
    (4, "quart"),
    (5, "cinquè"),
    (7, "setè"),
    (9, "novè"),
    // 10–19.
    (10, "desè"),
    (11, "onzè"),
    (12, "dotzè"),
    (15, "quinzè"),
    (17, "dissetè"),
    (18, "divuitè"),
    (19, "dinovè"),
    // 20–99 (fused compounds).
    (20, "vintè"),
    (21, "vint-i-unè"),
    (22, "vint-i-dosè"),
    (23, "vint-i-tresè"),
    (24, "vint-i-quatrè"),
    (25, "vint-i-cinquè"),
    (29, "vint-i-novè"),
    (30, "trentè"),
    (31, "trenta-unè"),
    (32, "trenta-dosè"),
    (45, "quaranta-cinquè"),
    (50, "cinquantè"),
    (99, "noranta-novè"),
    // 100–999.
    (100, "centè"),
    (101, "cent primer"),
    (102, "cent segon"),
    (103, "cent tercer"),
    (104, "cent quart"),
    (105, "cent cinquè"),
    (121, "cent vint-i-unè"),
    (200, "dos-centè"),
    (201, "dos-cents primer"),
    (300, "tres-centè"),
    (500, "cinc-centè"),
    (999, "nou-cents noranta-novè"),
    // Negative ordinals (uncommon but supported).
    (-1, "menys primer"),
  ),
  form: "ordinal",
)

// Ordinals — feminine.
#check(
  convert,
  (
    (1, "primera"),
    (2, "segona"),
    (3, "tercera"),
    (4, "quarta"),
    (5, "cinquena"),
    (10, "desena"),
    (11, "onzena"),
    (19, "dinovena"),
    (20, "vintena"),
    (21, "vint-i-unena"),
    (22, "vint-i-dosena"),
    (25, "vint-i-cinquena"),
    (31, "trenta-unena"),
    (100, "centena"),
    (101, "cent primera"),
    (104, "cent quarta"),
    (121, "cent vint-i-unena"),
    (200, "dos-centena"),
    (201, "dos-cents primera"),
    (999, "nou-cents noranta-novena"),
    (-1, "menys primera"),
  ),
  form: "ordinal",
  gender: "feminine",
)

// Special errors.
#assert.eq(
  catch(() => convert(1, form: "ordinal", apocopated: true)),
  "assertion failed: num2words (ca): 'apocopated' is only available for cardinals",
)
#assert.eq(
  catch(() => convert(1, apocopated: true, gender: "feminine")),
  "assertion failed: num2words (ca): 'apocopated' is not available for feminine gender",
)
