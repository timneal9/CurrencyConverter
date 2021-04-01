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
    
    var currenciesObjects = [
        Currency(currencyCode: "CAD", currencyName: "Canadian Dollar", countryName: "Canada", amountLabel: "0.00"),
        Currency(currencyCode: "HKD", currencyName: "Hong Kong Dollar", countryName: "Hong Kong", amountLabel: "0.00"),
        Currency(currencyCode: "ISK", currencyName: "Iceland Krona", countryName: "Iceland", amountLabel: "0.00"),
        Currency(currencyCode: "PHP", currencyName: "Philippine Peso", countryName: "Philippines", amountLabel: "0.00"),
        Currency(currencyCode: "DKK", currencyName: "Danish Krone", countryName: "Denmark, Greenland, Faroe Islands", amountLabel: "0.00"),
        Currency(currencyCode: "HUF", currencyName: "Forint", countryName: "Hungary", amountLabel: "0.00"),
        Currency(currencyCode: "CZK", currencyName: "Czech Koruna", countryName: "Czech Republic", amountLabel: "0.00"),
        Currency(currencyCode: "AUD", currencyName: "Australian Dollar", countryName: "Australia", amountLabel: "0.00"),
        Currency(currencyCode: "RON", currencyName: "Romanian Leu", countryName: "Romania", amountLabel: "0.00"),
        Currency(currencyCode: "SEK", currencyName: "Swedish Krona", countryName: "Sweden", amountLabel: "0.00"),
        Currency(currencyCode: "IDR", currencyName: "Indian Rupee", countryName: "India", amountLabel: "0.00"),
        Currency(currencyCode: "INR", currencyName: "Indian Rupee", countryName: "Bhutan", amountLabel: "0.00"),
        Currency(currencyCode: "BRL", currencyName: "Brazilian Real", countryName: "Brazil", amountLabel: "0.00"),
        Currency(currencyCode: "RUB", currencyName: "Russian Ruble", countryName: "Russia", amountLabel: "0.00"),
        Currency(currencyCode: "HRK", currencyName: "Kuna", countryName: "Croatia", amountLabel: "0.00"),
        Currency(currencyCode: "JPY", currencyName: "Yen", countryName: "Japan", amountLabel: "0.00"),
        Currency(currencyCode: "THB", currencyName: "Baht", countryName: "Thailand", amountLabel: "0.00"),
        Currency(currencyCode: "CHF", currencyName: "Swiss Franc", countryName: "Switzerland", amountLabel: "0.00"),
        Currency(currencyCode: "SGD", currencyName: "Singapore Dollar", countryName: "Singapore", amountLabel: "0.00"),
        Currency(currencyCode: "PLN", currencyName: "Zloty", countryName: "Poland", amountLabel: "0.00"),
        Currency(currencyCode: "BGN", currencyName: "Bulgarian Lev", countryName: "Bulgaria", amountLabel: "0.00"),
        Currency(currencyCode: "TRY", currencyName: "Turkish Lira", countryName: "Turkey", amountLabel: "0.00"),
        Currency(currencyCode: "CNY", currencyName: "Yuan Renminbi", countryName: "China", amountLabel: "0.00"),
        Currency(currencyCode: "NOK", currencyName: "Norwegian Krone", countryName: "Svalbard And Jan Mayen", amountLabel: "0.00"),
        Currency(currencyCode: "NZD", currencyName: "New Zealand Dollar", countryName: "New Zealand", amountLabel: "0.00"),
        Currency(currencyCode: "ZAR", currencyName: "Rand", countryName: "Namibia", amountLabel: "0.00"),
        Currency(currencyCode: "USD", currencyName: "United States Dollar", countryName: "United States", amountLabel: "0.00"),
        Currency(currencyCode: "MXN", currencyName: "Mexican Peso", countryName: "Mexico", amountLabel: "0.00"),
        Currency(currencyCode: "ILS", currencyName: "New Israeli Sheqel", countryName: "Isreal", amountLabel: "0.00"),
        Currency(currencyCode: "GBP", currencyName: "Pound Sterling", countryName: "Great Britian", amountLabel: "0.00"),
        Currency(currencyCode: "KRW", currencyName: "Won", countryName: "Korea", amountLabel: "0.00"),
        Currency(currencyCode: "MYR", currencyName: "Malaysian Ringgit", countryName: "Malaysia", amountLabel: "0.00"),
        Currency(currencyCode: "EUR", currencyName: "Euro", countryName: "European Union", amountLabel: "0.00")
    ]
}
