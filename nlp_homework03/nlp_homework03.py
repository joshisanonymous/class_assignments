import pynini

chars = [chr(i) for i in range(1, 91)] + [r"\[", r"\\", r"\]"] + [chr(i) for i in range(94, 256)]
sigma_star = pynini.union(*chars).closure()

numbers = pynini.union("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")

quants_map = pynini.union(
    pynini.transducer(" bbl.", "barrels"),
    pynini.transducer(" cu.", "cubics"),
    pynini.transducer(" doz.", "dozen"),
    pynini.transducer(" fl. oz.", "fluid ounces"),
    pynini.transducer(" ft.", "feet"),
    pynini.transducer(" gal.", "gallons"),
    pynini.transducer(" in.", "inches"),
    pynini.transducer(" kt.", "knots"),
    pynini.transducer(" lb.", "pounds"),
    pynini.transducer(" mi.", "miles"),
    pynini.transducer(" mph", "miles per hour"),
    pynini.transducer(" oz.", "ounces"),
    pynini.transducer(" qt.", "quarts"),
    pynini.transducer(" rpm", "revolutions per minute"),
    pynini.transducer(" tbsp.", "tablespoons"),
    pynini.transducer(" tsp.", "teaspoons"),
    pynini.transducer(" yd.", "yards"),
    pynini.transducer(" B", "bytes"),
    pynini.transducer(" cc", "cubic centimeters"),
    pynini.transducer(" cm", "centimeters"),
    pynini.transducer(" GB", "gigabytes"),
    pynini.transducer(" G", "gigabytes"),
    pynini.transducer(" g", "grams"),
    pynini.transducer(" ha", "hectares"),
    pynini.transducer(" KB", "kilobytes"),
    pynini.transducer(" kg", "kilograms"),
    pynini.transducer(" kl", "kiloliters"),
    pynini.transducer(" km", "kilometers"),
    pynini.transducer("l", "liters"),
    pynini.transducer(" m", "meters"),
    pynini.transducer(" MB", "megabytes"),
    pynini.transducer(" mg", "milligrams"),
    pynini.transducer(" ml", "milliliters"),
    pynini.transducer(" mm", "millimeters"),
    pynini.transducer(" W", "watts"),
    pynini.transducer(" kW", "kilowatts"),
    pynini.transducer(" kWh", "kilowatt-hours"),
)

ones_map = pynini.union(
    pynini.transducer("1", "one "),
    pynini.transducer("2", "two "),
    pynini.transducer("3", "three "),
    pynini.transducer("4", "four "),
    pynini.transducer("5", "five "),
    pynini.transducer("6", "six "),
    pynini.transducer("7", "seven "),
    pynini.transducer("8", "eight "),
    pynini.transducer("9", "nine "),
)

teens_map = pynini.union(
    pynini.transducer("10", "ten "),
    pynini.transducer("11", "eleven "),
    pynini.transducer("12", "twelve "),
    pynini.transducer("13", "thirteen "),
    pynini.transducer("14", "fourteen "),
    pynini.transducer("15", "fifteen "),
    pynini.transducer("16", "sixteen "),
    pynini.transducer("17", "seventeen "),
    pynini.transducer("18", "eighteen "),
    pynini.transducer("19", "nineteen ")
)

tens_map = pynini.union(
    pynini.transducer("2", "twenty "),
    pynini.transducer("3", "thirty "),
    pynini.transducer("4", "forty "),
    pynini.transducer("5", "fifty "),
    pynini.transducer("6", "sixty "),
    pynini.transducer("7", "seventy "),
    pynini.transducer("8", "eighty "),
    pynini.transducer("9", "ninety ")
)

hundreds_map = pynini.union(
    pynini.transducer("1", "one hundred "),
    pynini.transducer("2", "two hundred "),
    pynini.transducer("3", "three hundred "),
    pynini.transducer("4", "four hundred "),
    pynini.transducer("5", "five hundred "),
    pynini.transducer("6", "six hundred "),
    pynini.transducer("7", "seven hundred "),
    pynini.transducer("8", "eight hundred "),
    pynini.transducer("9", "nine hundred ")
)

thousands_map = pynini.union(
    pynini.transducer("1", "one thousand "),
    pynini.transducer("2", "two thousand "),
    pynini.transducer("3", "three thousand "),
    pynini.transducer("4", "four thousand "),
    pynini.transducer("5", "five thousand "),
    pynini.transducer("6", "six thousand "),
    pynini.transducer("7", "seven thousand "),
    pynini.transducer("8", "eight thousand "),
    pynini.transducer("9", "nine thousand ")
)

zero_del = pynini.union(
    pynini.transducer("0", ""),
    pynini.transducer("00", ""),
    pynini.transducer("000", "")
)

numbers_normalize = (
    pynini.cdrewrite(quants_map, numbers, "", sigma_star) *
    pynini.cdrewrite(thousands_map, "", numbers+numbers+numbers, sigma_star) *
    pynini.cdrewrite(hundreds_map, "", numbers+numbers, sigma_star) *
    pynini.cdrewrite(tens_map, "", numbers, sigma_star) *
    pynini.cdrewrite(teens_map, "", "", sigma_star) *
    pynini.cdrewrite(ones_map, "", "", sigma_star) *
    pynini.cdrewrite(zero_del, "", "", sigma_star)
)


def normalize(string):
    return(pynini.compose(string.strip(), numbers_normalize).stringify())
