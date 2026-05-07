/// Tests for Spanish number-to-words conversion.
#import "/src/lib.typ": converters
#import "/tests/utils.typ": check

#let convert = converters.es

// Cardinals.
#check(
  convert,
  (
    // Basic 0–29 (one-word forms).
    (0, "cero"),
    (1, "uno"),
    (2, "dos"),
    (5, "cinco"),
    (9, "nueve"),
    (10, "diez"),
    (11, "once"),
    (15, "quince"),
    (16, "dieciséis"),
    (19, "diecinueve"),
    (20, "veinte"),
    (21, "veintiuno"),
    (22, "veintidós"),
    (26, "veintiséis"),
    (29, "veintinueve"),
    // 30–99 (joined with "y").
    (30, "treinta"),
    (31, "treinta y uno"),
    (45, "cuarenta y cinco"),
    (69, "sesenta y nueve"),
    (99, "noventa y nueve"),
    // Hundreds: "cien" alone vs "ciento" before other digits.
    (100, "cien"),
    (101, "ciento uno"),
    (110, "ciento diez"),
    (121, "ciento veintiuno"),
    (199, "ciento noventa y nueve"),
    (200, "doscientos"),
    (500, "quinientos"),
    (700, "setecientos"),
    (900, "novecientos"),
    (999, "novecientos noventa y nueve"),
    // Thousands. "mil" stands alone (no "un mil"); apocopation kicks in
    // when "uno"/"veintiuno" precedes "mil".
    (1000, "mil"),
    (1001, "mil uno"),
    (1021, "mil veintiuno"),
    (1100, "mil cien"),
    (2000, "dos mil"),
    (21000, "veintiún mil"),
    (31000, "treinta y un mil"),
    (100000, "cien mil"),
    (101000, "ciento un mil"),
    (121000, "ciento veintiún mil"),
    (500500, "quinientos mil quinientos"),
    (999999, "novecientos noventa y nueve mil novecientos noventa y nueve"),
    // Millions and beyond (long scale).
    (1000000, "un millón"),
    (1000001, "un millón uno"),
    (1001000, "un millón mil"),
    (2000000, "dos millones"),
    (21000000, "veintiún millones"),
    (100000000, "cien millones"),
    (100000500, "cien millones quinientos"),
    (1000000000, "mil millones"),
    (2000000000, "dos mil millones"),
    (1000000000000, "un billón"),
    (1001000000000, "un billón mil millones"),
    // Negative numbers.
    (-1, "menos uno"),
    (-100, "menos cien"),
    (-1000, "menos mil"),
    (-7, "negativo siete", arguments(negative: "negativo")),
  ),
  form: "cardinal",
)

// Cardinals — feminine.
#check(
  convert,
  (
    // Basic units: only "uno"/"veintiuno" change.
    (1, "una"),
    (2, "dos"),
    (10, "diez"),
    (16, "dieciséis"),
    (21, "veintiuna"),
    (22, "veintidós"),
    (29, "veintinueve"),
    // Tens with trailing "uno".
    (31, "treinta y una"),
    (41, "cuarenta y una"),
    (45, "cuarenta y cinco"),
    (91, "noventa y una"),
    // Hundreds: "cien"/"ciento" invariable, 200–900 take "-cientas".
    (100, "cien"),
    (101, "ciento una"),
    (121, "ciento veintiuna"),
    (200, "doscientas"),
    (231, "doscientas treinta y una"),
    (500, "quinientas"),
    (900, "novecientas"),
    (999, "novecientas noventa y nueve"),
    // Thousands: full feminine forms before "mil" (no apocopation).
    (1000, "mil"),
    (1001, "mil una"),
    (21000, "veintiuna mil"),
    (31000, "treinta y una mil"),
    (101000, "ciento una mil"),
    (200000, "doscientas mil"),
    (200500, "doscientas mil quinientas"),
    // Millions: scale words are masculine and invariable; only the bottom
    // chunk inherits the feminine flag.
    (1000000, "un millón"),
    (1000001, "un millón una"),
    (1000500, "un millón quinientas"),
    (2000000, "dos millones"),
    (21000000, "veintiún millones"),
    (100000500, "cien millones quinientas"),
  ),
  form: "cardinal",
  gender: "feminine",
)

// Ordinals.
#check(
  convert,
  (
    // 1–9.
    (1, "primero"),
    (2, "segundo"),
    (3, "tercero"),
    (4, "cuarto"),
    (5, "quinto"),
    (7, "séptimo"),
    (9, "noveno"),
    // 10–19 (mix of irregular fused forms).
    (10, "décimo"),
    (11, "undécimo"),
    (12, "duodécimo"),
    (13, "decimotercero"),
    (15, "decimoquinto"),
    (17, "decimoséptimo"),
    (18, "decimoctavo"),
    (19, "decimonoveno"),
    // 20–99 (separated form).
    (20, "vigésimo"),
    (21, "vigésimo primero"),
    (22, "vigésimo segundo"),
    (30, "trigésimo"),
    (50, "quincuagésimo"),
    (99, "nonagésimo noveno"),
    // 100–999.
    (100, "centésimo"),
    (101, "centésimo primero"),
    (200, "ducentésimo"),
    (500, "quingentésimo"),
    (999, "noningentésimo nonagésimo noveno"),
    // Negative ordinals (uncommon but supported).
    (-1, "menos primero"),
  ),
  form: "ordinal",
)

// Ordinals — feminine.
#check(
  convert,
  (
    (1, "primera"),
    (2, "segunda"),
    (3, "tercera"),
    (7, "séptima"),
    (10, "décima"),
    (11, "undécima"),
    (12, "duodécima"),
    (13, "decimotercera"),
    (18, "decimoctava"),
    (20, "vigésima"),
    (21, "vigésima primera"),
    (23, "vigésima tercera"),
    (100, "centésima"),
    (101, "centésima primera"),
    (999, "noningentésima nonagésima novena"),
    (-1, "menos primera"),
  ),
  form: "ordinal",
  gender: "feminine",
)

// Ordinals — apocopated (masculine only).
#check(
  convert,
  (
    (1, "primer"),
    (2, "segundo"),
    (3, "tercer"),
    (4, "cuarto"),
    (10, "décimo"),
    (11, "undécimo"),
    (12, "duodécimo"),
    (13, "decimotercer"),
    (14, "decimocuarto"),
    (18, "decimoctavo"),
    (21, "vigésimo primer"),
    (23, "vigésimo tercer"),
    (24, "vigésimo cuarto"),
    (100, "centésimo"),
    (101, "centésimo primer"),
    (103, "centésimo tercer"),
    (200, "ducentésimo"),
  ),
  form: "ordinal",
  apocopated: true,
)

// Special errors.
#assert.eq(
  catch(() => convert(1, form: "ordinal", apocopated: true, gender: "feminine")),
  "assertion failed: num2words (es): 'apocopated' is not available for feminine gender",
)
#assert.eq(
  catch(() => convert(1, apocopated: true)),
  "assertion failed: num2words (es): 'apocopated' is only available for ordinals",
)
