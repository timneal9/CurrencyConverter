//
//  Currencies.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/31/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import Foundation

class Currencies {
    
    let currencyArray = ["CAD":"Canadian Dollar",
                         "HKD":"Hong Kong Dollar",
                         "ISK":"Iceland Krona",
                         "PHP":"Philippine Peso",
                         "DKK":"Danish Krone",
                         "HUF":"Forint",
                         "CZK":"Czech Koruna",
                         "AUD":"Australian Dollar",
                         "RON":"Romanian Leu",
                         "SEK":"Swedish Krona",
                         "IDR":"Indian Rupee",
                         "INR":"Indian Rupee",
                         "BRL":"Brazilian Real",
                         "RUB":"Russian Ruble",
                         "HRK":"Kuna",
                         "JPY":"Yen",
                         "THB":"Baht",
                         "CHF":"Swiss Franc",
                         "SGD":"Singapore Dollar",
                         "PLN":"Zloty",
                         "BGN":"Bulgarian Lev",
                         "TRY":"Turkish Lira",
                         "CNY":"Yuan Renminbi",
                         "NOK":"Norwegian Krone",
                         "NZD":"New Zealand Dollar",
                         "ZAR":"Rand",
                         "USD":"United States Dollar",
                         "MXN":"Mexican Peso",
                         "ILS":"New Israeli Sheqel",
                         "GBP":"Pound Sterling",
                         "KRW":"Won",
                         "MYR":"Malaysian Ringgit",
                         "EUR":"European Union"
    ]
    
    var favorites = ["MXN", "NZD", "USD"]
    
    var currencyObjects = [
        CurrencyOld(currencyCode: "CAD", currencyName: "Canadian Dollar", countryName: "Canada", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "HKD", currencyName: "Hong Kong Dollar", countryName: "Hong Kong", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "ISK", currencyName: "Iceland Krona", countryName: "Iceland", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "PHP", currencyName: "Philippine Peso", countryName: "Philippines", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "DKK", currencyName: "Danish Krone", countryName: "Denmark, Greenland, Faroe Islands", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "HUF", currencyName: "Forint", countryName: "Hungary", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "CZK", currencyName: "Czech Koruna", countryName: "Czech Republic", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "AUD", currencyName: "Australian Dollar", countryName: "Australia", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "RON", currencyName: "Romanian Leu", countryName: "Romania", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "SEK", currencyName: "Swedish Krona", countryName: "Sweden", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "IDR", currencyName: "Indian Rupee", countryName: "India", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "INR", currencyName: "Indian Rupee", countryName: "Bhutan", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "BRL", currencyName: "Brazilian Real", countryName: "Brazil", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "RUB", currencyName: "Russian Ruble", countryName: "Russia", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "HRK", currencyName: "Kuna", countryName: "Croatia", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "JPY", currencyName: "Yen", countryName: "Japan", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "THB", currencyName: "Baht", countryName: "Thailand", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "CHF", currencyName: "Swiss Franc", countryName: "Switzerland", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "SGD", currencyName: "Singapore Dollar", countryName: "Singapore", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "PLN", currencyName: "Zloty", countryName: "Poland", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "BGN", currencyName: "Bulgarian Lev", countryName: "Bulgaria", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "TRY", currencyName: "Turkish Lira", countryName: "Turkey", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "CNY", currencyName: "Yuan Renminbi", countryName: "China", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "NOK", currencyName: "Norwegian Krone", countryName: "Svalbard And Jan Mayen", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "NZD", currencyName: "New Zealand Dollar", countryName: "New Zealand", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "ZAR", currencyName: "Rand", countryName: "Namibia", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "USD", currencyName: "United States Dollar", countryName: "United States", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "MXN", currencyName: "Mexican Peso", countryName: "Mexico", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "ILS", currencyName: "New Israeli Sheqel", countryName: "Isreal", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "GBP", currencyName: "Pound Sterling", countryName: "Great Britian", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "KRW", currencyName: "Won", countryName: "Korea", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "MYR", currencyName: "Malaysian Ringgit", countryName: "Malaysia", amountLabel: "0.00"),
        CurrencyOld(currencyCode: "EUR", currencyName: "Euro", countryName: "European Union", amountLabel: "0.00")
    ]
}
