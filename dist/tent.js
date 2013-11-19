
/**
 * @class Tent
 * Namespace for the Tent widget colleciton
 * @singleton
 *
*/


(function() {

  if (this.Tent == null) {
    this.Tent = {};
  }

  this.Tent.Controllers = Em.Namespace.create;

  this.Tent.Data = Em.Namespace.create;

}).call(this);



/**
* @class Tent.I18n
* A general purpose class for I18n support.
*/


(function() {

  Tent.I18n = Ember.Namespace.create({
    language: {},
    /**
    	* Loads a set of translations for localizing text
    	* @param {Object} translations A map of key:value pairs defining the translations to be used
    */

    loadTranslations: function(translations) {
      if (translations != null) {
        return this.set('language', $.extend(this.get('language'), translations));
      }
    },
    translate: function(code) {
      return "t_" + code;
    },
    /**
    	* Replace a key with its translation
    	* @param {String} key
    	* @param {String|[Array| Object]} [vars] arguments to be interpolated in the translated string
    */

    loc: function(key, vars) {
      var idx, string;
      if (key != null) {
        string = Ember.get(this.language, key) || key;
        idx = 0;
        if (typeof vars === 'string') {
          vars = [vars];
        }
        return string.replace(/%@([0-9]|[a-zA-Z]+)?/g, function(s, argIndex) {
          argIndex = (argIndex != null) && isNaN(argIndex) ? argIndex : (isNaN(parseInt(argIndex)) ? idx++ : parseInt(argIndex) - 1);
          s = vars != null ? vars[argIndex] : void 0;
          if ((s != null)) {
            return s;
          } else {
            return '';
          }
        });
      }
    }
  });

  Tent.translate = Tent.I18n.loc;

  Tent.I18n.loadTranslations({
    tent: {
      on: 'On',
      off: 'Off',
      pleaseSelect: 'Please Select...',
      confirm: 'Confirmation',
      button: {
        ok: 'Ok',
        yes: 'Yes',
        cancel: 'Cancel',
        save: 'Save',
        saveAs: 'Save As...',
        load: 'Load',
        no: 'No',
        proceed: 'Ignore warnings and proceed',
        dontProceed: 'No, return to page'
      },
      dateRange: {
        useFuzzy: 'Use relative date',
        presetRanges: {
          Today: 'Today',
          Tomorrow: 'Tomorrow',
          Last7days: 'Last 7 Days',
          Monthtodate: 'Month to date',
          Yeartodate: 'Year to date',
          ThepreviousMonth: 'The previous Month',
          Last30Days: 'Last 30 Days',
          Next30Days: 'Next 30 days'
        }
      },
      jqGrid: {
        hideShowAlt: 'Hide/Show Columns',
        hideShowCaption: 'Columns',
        hideShowTitle: 'Hide/Show Columns',
        horizontalScroll: 'Auto-Fit',
        multiviewList: 'List View',
        multiviewCard: 'Card View',
        emptyRecords: 'No results were returned',
        "export": {
          xml: 'XML',
          json: 'JSON',
          csv: 'CSV',
          xlsx: 'XLSX',
          xls: 'XLS',
          comma: 'COMMA',
          pipe: 'PIPE',
          semicolon: 'SEMI COLON',
          colon: 'COLON',
          _or: 'or',
          enterDelimiter: 'Enter Delimiter',
          headers: 'Column Headers',
          inclQuotes: 'Include Quotes',
          "export": 'Export'
        },
        pagerViewing: 'VIEWING',
        paging: {
          next: 'Next page',
          prev: 'Previous page',
          first: 'First page',
          last: 'Last page'
        },
        saveUi: {
          defaultName: 'No Customization',
          "default": 'No Customization',
          message: 'Save current settings as:'
        }
      },
      filter: {
        filter: 'Filters',
        filterAction: 'Filter',
        add: 'Add Field',
        bgHint: 'Add Filters',
        prompt: 'Select a field ...',
        operatorLabel: 'Operator',
        operatorPrompt: 'Select an operator',
        del: 'Delete Field',
        lock: 'Lock Field ',
        fieldname: 'Field Name',
        availableFilters: 'Available Filters',
        selectedFilter: 'Selected Filter',
        currentFilter: 'Current Filter',
        saveFilter: 'Save Filter',
        newFilter: 'New Filter',
        filterLabel: 'Filter Label',
        filterDescription: 'Filter Description',
        duplicate: 'A filter already exists for the selected field',
        save: 'Save',
        saveAs: 'Save As',
        cancel: 'Cancel',
        label: 'Label',
        more: 'more',
        description: 'Description',
        beginsWith: 'begins with',
        contains: 'contains',
        equal: 'equal',
        nEqual: 'not equal',
        before: 'before',
        after: 'after',
        beforeInc: 'before incl',
        afterInc: 'after incl',
        lThan: 'less than',
        gThan: 'greater than',
        lThanEq: 'less than or equal',
        gThanEq: 'greater than or equal',
        range: 'range',
        search: 'Search',
        clear: 'Clear',
        noFilter: 'No Filter',
        like: 'like'
      },
      warning: {
        header: 'Warnings Exist',
        warningsOnPage: 'The following warnings exist on this page. Do you wish to ignore them and proceed?'
      },
      grouping: {
        _groupBy: 'Group',
        range: {
          exact: 'Exact',
          tens: 'Tens',
          hundreds: 'Hundreds',
          thousands: 'Thousands',
          week: 'Week',
          weekStarting: 'Week starting',
          month: 'Month',
          quarter: 'Quarter',
          year: 'Year'
        },
        no_grouping: 'None',
        revert: 'Revert to Original',
        totals: 'Totals:'
      },
      rename: {
        main: 'Rename'
      },
      sorting: {
        main: 'Sort',
        ascending: 'Ascending',
        descending: 'Descending'
      },
      upload: {
        buttonLabel: 'Select file to Upload'
      }
    },
    error: {
      generic: 'Error',
      required: 'Field is required',
      numeric: 'Value must be numbers only',
      amount: 'Amount should be positive',
      positive: 'Value should be positive',
      email: 'Email format error',
      date: 'Date format error',
      dateBetween: 'Date should be between %@startDate and %@endDate',
      dateFuture: 'You provided a date in the future',
      maxLength: 'Length must be %@max characters or less',
      minLength: 'Length must be %@min characters or more',
      invalidCurrency: 'Invalid currency',
      regexp: 'Value must pass the regular expression %@regexp',
      minValue: 'Value must be greater than or equal to %@min',
      maxValue: 'Value must be less than or equal to %@max',
      valueBetween: 'Value must be between %@min and %@max',
      uniqueValue: '%@item with this %@property already exists'
    }
  });

}).call(this);


(function() {
}).call(this);


(function() {

  Tent.CURRENCIES_ISO_4217 = Ember.Object.create({
    AED: {
      cent: 2,
      name: "United Arab Emirates dirham"
    },
    AFN: {
      cent: 2,
      name: "Afghan afghani"
    },
    ALL: {
      cent: 2,
      name: "Albanian lek"
    },
    AMD: {
      cent: 2,
      name: "Armenian dram"
    },
    ANG: {
      cent: 2,
      name: "Netherlands Antillean guilder"
    },
    AOA: {
      cent: 2,
      name: "Angolan kwanza"
    },
    ARS: {
      cent: 2,
      name: "Argentine peso"
    },
    AUD: {
      cent: 2,
      name: "Australian dollar"
    },
    AWG: {
      cent: 2,
      name: "Aruban florin"
    },
    AZN: {
      cent: 2,
      name: "Azerbaijani manat"
    },
    BAM: {
      cent: 2,
      name: "Bosnia and Herzegovina convertible mark"
    },
    BBD: {
      cent: 2,
      name: "Barbados dollar"
    },
    BDT: {
      cent: 2,
      name: "Bangladeshi taka"
    },
    BGN: {
      cent: 2,
      name: "Bulgarian lev"
    },
    BHD: {
      cent: 3,
      name: "Bahraini dinar"
    },
    BIF: {
      cent: 0,
      name: "Burundian franc"
    },
    BMD: {
      cent: 2,
      name: "Bermudian dollar (customarily known as Bermuda dollar)"
    },
    BND: {
      cent: 2,
      name: "Brunei dollar"
    },
    BOB: {
      cent: 2,
      name: "Boliviano"
    },
    BOV: {
      cent: 2,
      name: "Bolivian Mvdol (funds code)"
    },
    BRL: {
      cent: 2,
      name: "Brazilian real"
    },
    BSD: {
      cent: 2,
      name: "Bahamian dollar"
    },
    BTN: {
      cent: 2,
      name: "Bhutanese ngultrum"
    },
    BWP: {
      cent: 2,
      name: "Botswana pula"
    },
    BYR: {
      cent: 0,
      name: "Belarusian ruble"
    },
    BZD: {
      cent: 2,
      name: "Belize dollar"
    },
    CAD: {
      cent: 2,
      name: "Canadian dollar"
    },
    CDF: {
      cent: 2,
      name: "Congolese franc"
    },
    CHE: {
      cent: 2,
      name: "WIR Euro (complementary currency)"
    },
    CHF: {
      cent: 2,
      name: "Swiss franc"
    },
    CHW: {
      cent: 2,
      name: "WIR Franc (complementary currency)"
    },
    CLF: {
      cent: 0,
      name: "Unidad de Fomento (funds code)"
    },
    CLP: {
      cent: 0,
      name: "Chilean peso"
    },
    CNY: {
      cent: 2,
      name: "Chinese yuan"
    },
    COP: {
      cent: 2,
      name: "Colombian peso"
    },
    COU: {
      cent: 2,
      name: "Unidad de Valor Real"
    },
    CRC: {
      cent: 2,
      name: "Costa Rican colon"
    },
    CUC: {
      cent: 2,
      name: "Cuban convertible peso"
    },
    CUP: {
      cent: 2,
      name: "Cuban peso"
    },
    CVE: {
      cent: 0,
      name: "Cape Verde escudo"
    },
    CZK: {
      cent: 2,
      name: "Czech koruna"
    },
    DJF: {
      cent: 0,
      name: "Djiboutian franc"
    },
    DKK: {
      cent: 2,
      name: "Danish krone"
    },
    DOP: {
      cent: 2,
      name: "Dominican peso"
    },
    DZD: {
      cent: 2,
      name: "Algerian dinar"
    },
    EGP: {
      cent: 2,
      name: "Egyptian pound"
    },
    ERN: {
      cent: 2,
      name: "Eritrean nakfa"
    },
    ETB: {
      cent: 2,
      name: "Ethiopian birr"
    },
    EUR: {
      cent: 2,
      name: "Euro"
    },
    FJD: {
      cent: 2,
      name: "Fiji dollar"
    },
    FKP: {
      cent: 2,
      name: "Falkland Islands pound"
    },
    GBP: {
      cent: 2,
      name: "Pound sterling"
    },
    GEL: {
      cent: 2,
      name: "Georgian lari"
    },
    GHS: {
      cent: 2,
      name: "Ghanaian cedi"
    },
    GIP: {
      cent: 2,
      name: "Gibraltar pound"
    },
    GMD: {
      cent: 2,
      name: "Gambian dalasi"
    },
    GNF: {
      cent: 0,
      name: "Guinean franc"
    },
    GTQ: {
      cent: 2,
      name: "Guatemalan quetzal"
    },
    GYD: {
      cent: 2,
      name: "Guyanese dollar"
    },
    HKD: {
      cent: 2,
      name: "Hong Kong dollar"
    },
    HNL: {
      cent: 2,
      name: "Honduran lempira"
    },
    HRK: {
      cent: 2,
      name: "Croatian kuna"
    },
    HTG: {
      cent: 2,
      name: "Haitian gourde"
    },
    HUF: {
      cent: 2,
      name: "Hungarian forint"
    },
    IDR: {
      cent: 2,
      name: "Indonesian rupiah"
    },
    ILS: {
      cent: 2,
      name: "Israeli new shekel"
    },
    INR: {
      cent: 2,
      name: "Indian rupee"
    },
    IQD: {
      cent: 3,
      name: "Iraqi dinar"
    },
    IRR: {
      cent: 0,
      name: "Iranian rial"
    },
    ISK: {
      cent: 0,
      name: "Icelandic króna"
    },
    JMD: {
      cent: 2,
      name: "Jamaican dollar"
    },
    JOD: {
      cent: 3,
      name: "Jordanian dinar"
    },
    JPY: {
      cent: 0,
      name: "Japanese yen"
    },
    KES: {
      cent: 2,
      name: "Kenyan shilling"
    },
    KGS: {
      cent: 2,
      name: "Kyrgyzstani som"
    },
    KHR: {
      cent: 2,
      name: "Cambodian riel"
    },
    KMF: {
      cent: 0,
      name: "Comoro franc"
    },
    KPW: {
      cent: 0,
      name: "North Korean won"
    },
    KRW: {
      cent: 0,
      name: "South Korean won"
    },
    KWD: {
      cent: 3,
      name: "Kuwaiti dinar"
    },
    KYD: {
      cent: 2,
      name: "Cayman Islands dollar"
    },
    KZT: {
      cent: 2,
      name: "Kazakhstani tenge"
    },
    LAK: {
      cent: 0,
      name: "Lao kip"
    },
    LBP: {
      cent: 0,
      name: "Lebanese pound"
    },
    LKR: {
      cent: 2,
      name: "Sri Lankan rupee"
    },
    LRD: {
      cent: 2,
      name: "Liberian dollar"
    },
    LSL: {
      cent: 2,
      name: "Lesotho loti"
    },
    LTL: {
      cent: 2,
      name: "Lithuanian litas"
    },
    LVL: {
      cent: 2,
      name: "Latvian lats"
    },
    LYD: {
      cent: 3,
      name: "Libyan dinar"
    },
    MAD: {
      cent: 2,
      name: "Moroccan dirham"
    },
    MDL: {
      cent: 2,
      name: "Moldovan leu"
    },
    MKD: {
      cent: 0,
      name: "Macedonian denar"
    },
    MMK: {
      cent: 0,
      name: "Myanma kyat"
    },
    MNT: {
      cent: 2,
      name: "Mongolian tugrik"
    },
    MOP: {
      cent: 2,
      name: "Macanese pataca"
    },
    MUR: {
      cent: 2,
      name: "Mauritian rupee"
    },
    MVR: {
      cent: 2,
      name: "Maldivian rufiyaa"
    },
    MWK: {
      cent: 2,
      name: "Malawian kwacha"
    },
    MXN: {
      cent: 2,
      name: "Mexican peso"
    },
    MXV: {
      cent: 2,
      name: "Mexican Unidad de Inversion (UDI) (funds code)"
    },
    MYR: {
      cent: 2,
      name: "Malaysian ringgit"
    },
    MZN: {
      cent: 2,
      name: "Mozambican metical"
    },
    NAD: {
      cent: 2,
      name: "Namibian dollar"
    },
    NGN: {
      cent: 2,
      name: "Nigerian naira"
    },
    NIO: {
      cent: 2,
      name: "Nicaraguan córdoba"
    },
    NOK: {
      cent: 2,
      name: "Norwegian krone"
    },
    NPR: {
      cent: 2,
      name: "Nepalese rupee"
    },
    NZD: {
      cent: 2,
      name: "New Zealand dollar"
    },
    OMR: {
      cent: 3,
      name: "Omani rial"
    },
    PAB: {
      cent: 2,
      name: "Panamanian balboa"
    },
    PEN: {
      cent: 2,
      name: "Peruvian nuevo sol"
    },
    PGK: {
      cent: 2,
      name: "Papua New Guinean kina"
    },
    PHP: {
      cent: 2,
      name: "Philippine peso"
    },
    PKR: {
      cent: 2,
      name: "Pakistani rupee"
    },
    PLN: {
      cent: 2,
      name: "Polish złoty"
    },
    PYG: {
      cent: 0,
      name: "Paraguayan guaraní"
    },
    QAR: {
      cent: 2,
      name: "Qatari riyal"
    },
    RON: {
      cent: 2,
      name: "Romanian new leu"
    },
    RSD: {
      cent: 2,
      name: "Serbian dinar"
    },
    RUB: {
      cent: 2,
      name: "Russian rouble"
    },
    RWF: {
      cent: 0,
      name: "Rwandan franc"
    },
    SAR: {
      cent: 2,
      name: "Saudi riyal"
    },
    SBD: {
      cent: 2,
      name: "Solomon Islands dollar"
    },
    SCR: {
      cent: 2,
      name: "Seychelles rupee"
    },
    SDG: {
      cent: 2,
      name: "Sudanese pound"
    },
    SEK: {
      cent: 2,
      name: "Swedish krona/kronor"
    },
    SGD: {
      cent: 2,
      name: "Singapore dollar"
    },
    SHP: {
      cent: 2,
      name: "Saint Helena pound"
    },
    SLL: {
      cent: 0,
      name: "Sierra Leonean leone"
    },
    SOS: {
      cent: 2,
      name: "Somali shilling"
    },
    SRD: {
      cent: 2,
      name: "Surinamese dollar"
    },
    SSP: {
      cent: 2,
      name: "South Sudanese pound"
    },
    STD: {
      cent: 0,
      name: "São Tomé and Príncipe dobra"
    },
    SYP: {
      cent: 2,
      name: "Syrian pound"
    },
    SZL: {
      cent: 2,
      name: "Swazi lilangeni"
    },
    THB: {
      cent: 2,
      name: "Thai baht"
    },
    TJS: {
      cent: 2,
      name: "Tajikistani somoni"
    },
    TMT: {
      cent: 2,
      name: "Turkmenistani manat"
    },
    TND: {
      cent: 3,
      name: "Tunisian dinar"
    },
    TOP: {
      cent: 2,
      name: "Tongan paʻanga"
    },
    TRY: {
      cent: 2,
      name: "Turkish lira"
    },
    TTD: {
      cent: 2,
      name: "Trinidad and Tobago dollar"
    },
    TWD: {
      cent: 2,
      name: "New Taiwan dollar"
    },
    TZS: {
      cent: 2,
      name: "Tanzanian shilling"
    },
    UAH: {
      cent: 2,
      name: "Ukrainian hryvnia"
    },
    UGX: {
      cent: 2,
      name: "Ugandan shilling"
    },
    USD: {
      cent: 2,
      name: "United States dollar"
    },
    USN: {
      cent: 2,
      name: "United States dollar (next day) (funds code)"
    },
    USS: {
      cent: 2,
      name: "United States dollar (same day) (funds code) (one source[who?] claims it is no longer used, but it is still on the ISO 4217-MA list)"
    },
    UYI: {
      cent: 0,
      name: "Uruguay Peso en Unidades Indexadas (URUIURUI) (funds code)"
    },
    UYU: {
      cent: 2,
      name: "Uruguayan peso"
    },
    UZS: {
      cent: 2,
      name: "Uzbekistan som"
    },
    VEF: {
      cent: 2,
      name: "Venezuelan bolívar fuerte"
    },
    VND: {
      cent: 0,
      name: "Vietnamese dong"
    },
    VUV: {
      cent: 0,
      name: "Vanuatu vatu"
    },
    WST: {
      cent: 2,
      name: "Samoan tala"
    },
    XAF: {
      cent: 0,
      name: "CFA franc BEAC"
    },
    XCD: {
      cent: 2,
      name: "East Caribbean dollar"
    },
    XOF: {
      cent: 0,
      name: "CFA franc BCEAO"
    },
    XPF: {
      cent: 0,
      name: "CFP franc"
    },
    YER: {
      cent: 2,
      name: "Yemeni rial"
    },
    ZAR: {
      cent: 2,
      name: "South African rand"
    }
  });

}).call(this);


(function() {

  Tent.TIMEZONES = [
    {
      name: "Australian Central Daylight Time",
      abbr: "ACDT",
      UTCOffset: "GMT+1030"
    }, {
      name: "Australian Central Standard Time",
      abbr: "ACST",
      UTCOffset: "GMT+0930"
    }, {
      name: "ASEAN Common Time",
      abbr: "ACT",
      UTCOffset: "GMT+0800"
    }, {
      name: "Atlantic Daylight Time",
      abbr: "ADT",
      UTCOffset: "GMT-0300"
    }, {
      name: "Australian Eastern Daylight Time",
      abbr: "AEDT",
      UTCOffset: "GMT+1100"
    }, {
      name: "Australian Eastern Standard Time",
      abbr: "AEST",
      UTCOffset: "GMT+1000"
    }, {
      name: "Afghanistan Time",
      abbr: "AFT",
      UTCOffset: "GMT+0430"
    }, {
      name: "Alaska Daylight Time",
      abbr: "AKDT",
      UTCOffset: "GMT-0800"
    }, {
      name: "Alaska Standard Time",
      abbr: "AKST",
      UTCOffset: "GMT-0900"
    }, {
      name: "Armenia Summer Time",
      abbr: "AMST",
      UTCOffset: "GMT+0500"
    }, {
      name: "Armenia Time",
      abbr: "AMT",
      UTCOffset: "GMT+0400"
    }, {
      name: "Argentina Time",
      abbr: "ART",
      UTCOffset: "GMT-0300"
    }, {
      name: "Arab Standard Time (Kuwait, Riyadh)",
      abbr: "AST",
      UTCOffset: "GMT+0300"
    }, {
      name: "Arabian Standard Time (Abu Dhabi, Muscat)",
      abbr: "AST",
      UTCOffset: "GMT+0400"
    }, {
      name: "Arabic Standard Time (Baghdad)",
      abbr: "AST",
      UTCOffset: "GMT+0300"
    }, {
      name: "Atlantic Standard Time",
      abbr: "AST",
      UTCOffset: "GMT-0400"
    }, {
      name: "Australian Western Daylight Time",
      abbr: "AWDT",
      UTCOffset: "GMT+0900"
    }, {
      name: "Australian Western Standard Time",
      abbr: "AWST",
      UTCOffset: "GMT+0800"
    }, {
      name: "Azores Standard Time",
      abbr: "AZOST",
      UTCOffset: "GMT-0100"
    }, {
      name: "Azerbaijan Time",
      abbr: "AZT",
      UTCOffset: "GMT+0400"
    }, {
      name: "Brunei Time",
      abbr: "BDT",
      UTCOffset: "GMT+0800"
    }, {
      name: "British Indian Ocean Time",
      abbr: "BIOT",
      UTCOffset: "GMT+0600"
    }, {
      name: "Baker Island Time",
      abbr: "BIT",
      UTCOffset: "GMT-1200"
    }, {
      name: "Bolivia Time",
      abbr: "BOT",
      UTCOffset: "GMT-0400"
    }, {
      name: "Brasilia Time",
      abbr: "BRT",
      UTCOffset: "GMT-0300"
    }, {
      name: "Bangladesh Standard Time",
      abbr: "BST",
      UTCOffset: "GMT+0600"
    }, {
      name: "British Summer Time (British Standard Time from Feb 1968 to Oct 1971)",
      abbr: "BST",
      UTCOffset: "GMT+0100"
    }, {
      name: "Bhutan Time",
      abbr: "BTT",
      UTCOffset: "GMT+0600"
    }, {
      name: "Central Africa Time",
      abbr: "CAT",
      UTCOffset: "GMT+0200"
    }, {
      name: "Cocos Islands Time",
      abbr: "CCT",
      UTCOffset: "GMT+0630"
    }, {
      name: "Central Daylight Time (North America)",
      abbr: "CDT",
      UTCOffset: "GMT-0500"
    }, {
      name: "Cuba Daylight Time[1]",
      abbr: "CDT",
      UTCOffset: "GMT-0400"
    }, {
      name: "Central European Daylight Time",
      abbr: "CEDT",
      UTCOffset: "GMT+0200"
    }, {
      name: "Central European Summer Time (Cf. HAEC)",
      abbr: "CEST",
      UTCOffset: "GMT+0200"
    }, {
      name: "Central European Time",
      abbr: "CET",
      UTCOffset: "GMT+0100"
    }, {
      name: "Chatham Daylight Time",
      abbr: "CHADT",
      UTCOffset: "GMT+1345"
    }, {
      name: "Chatham Standard Time",
      abbr: "CHAST",
      UTCOffset: "GMT+1245"
    }, {
      name: "Choibalsan",
      abbr: "CHOT",
      UTCOffset: "GMT-0800"
    }, {
      name: "Chamorro Standard Time",
      abbr: "ChST",
      UTCOffset: "GMT+1000"
    }, {
      name: "Chuuk Time",
      abbr: "CHUT",
      UTCOffset: "GMT+1000"
    }, {
      name: "Clipperton Island Standard Time",
      abbr: "CIST",
      UTCOffset: "GMT-0800"
    }, {
      name: "Central Indonesia Time",
      abbr: "CIT",
      UTCOffset: "GMT+0800"
    }, {
      name: "Cook Island Time",
      abbr: "CKT",
      UTCOffset: "GMT-1000"
    }, {
      name: "Chile Summer Time",
      abbr: "CLST",
      UTCOffset: "GMT-0300"
    }, {
      name: "Chile Standard Time",
      abbr: "CLT",
      UTCOffset: "GMT-0400"
    }, {
      name: "Colombia Summer Time",
      abbr: "COST",
      UTCOffset: "GMT-0400"
    }, {
      name: "Colombia Time",
      abbr: "COT",
      UTCOffset: "GMT-0500"
    }, {
      name: "Central Standard Time (North America)",
      abbr: "CST",
      UTCOffset: "GMT-0600"
    }, {
      name: "China Standard Time",
      abbr: "CST",
      UTCOffset: "GMT+0800"
    }, {
      name: "Central Standard Time (Australia)",
      abbr: "CST",
      UTCOffset: "GMT+0930"
    }, {
      name: "Central Summer Time (Australia)",
      abbr: "CST",
      UTCOffset: "GMT+1030"
    }, {
      name: "Cuba Standard Time",
      abbr: "CST",
      UTCOffset: "GMT-0500"
    }, {
      name: "China time",
      abbr: "CT",
      UTCOffset: "GMT+0800"
    }, {
      name: "Cape Verde Time",
      abbr: "CVT",
      UTCOffset: "GMT-0100"
    }, {
      name: "Central Western Standard Time (Australia)",
      abbr: "CWST",
      UTCOffset: "GMT+0845"
    }, {
      name: "Christmas Island Time",
      abbr: "CXT",
      UTCOffset: "GMT+0700"
    }, {
      name: "Davis Time",
      abbr: "DAVT",
      UTCOffset: "GMT+0700"
    }, {
      name: "Dumont d'Urville Time",
      abbr: "DDUT",
      UTCOffset: "GMT+1000"
    }, {
      name: "AIX specific equivalent of Central European Time[2]",
      abbr: "DFT",
      UTCOffset: "GMT+0100"
    }, {
      name: "Easter Island Standard Summer Time",
      abbr: "EASST",
      UTCOffset: "GMT-0500"
    }, {
      name: "Easter Island Standard Time",
      abbr: "EAST",
      UTCOffset: "GMT-0600"
    }, {
      name: "East Africa Time",
      abbr: "EAT",
      UTCOffset: "GMT+0300"
    }, {
      name: "Eastern Caribbean Time (does not recognise DST)",
      abbr: "ECT",
      UTCOffset: "GMT-0400"
    }, {
      name: "Ecuador Time",
      abbr: "ECT",
      UTCOffset: "GMT-0500"
    }, {
      name: "Eastern Daylight Time (North America)",
      abbr: "EDT",
      UTCOffset: "GMT-0400"
    }, {
      name: "Eastern European Daylight Time",
      abbr: "EEDT",
      UTCOffset: "GMT+0300"
    }, {
      name: "Eastern European Summer Time",
      abbr: "EEST",
      UTCOffset: "GMT+0300"
    }, {
      name: "Eastern European Time",
      abbr: "EET",
      UTCOffset: "GMT+0200"
    }, {
      name: "Eastern Greenland Summer Time",
      abbr: "EGST",
      UTCOffset: "GMT+0000"
    }, {
      name: "Eastern Greenland Time",
      abbr: "EGT",
      UTCOffset: "GMT-0100"
    }, {
      name: "Eastern Indonesian Time",
      abbr: "EIT",
      UTCOffset: "GMT+0900"
    }, {
      name: "Eastern Standard Time (North America)",
      abbr: "EST",
      UTCOffset: "GMT-0500"
    }, {
      name: "Eastern Standard Time (Australia)",
      abbr: "EST",
      UTCOffset: "GMT+1000"
    }, {
      name: "Further-eastern_European_Time",
      abbr: "FET",
      UTCOffset: "GMT+0300"
    }, {
      name: "Fiji Time",
      abbr: "FJT",
      UTCOffset: "GMT+1200"
    }, {
      name: "Falkland Islands Summer Time",
      abbr: "FKST",
      UTCOffset: "GMT-0300"
    }, {
      name: "Falkland Islands Time",
      abbr: "FKT",
      UTCOffset: "GMT-0400"
    }, {
      name: "Fernando de Noronha Time",
      abbr: "FNT",
      UTCOffset: "GMT-0200"
    }, {
      name: "Galapagos Time",
      abbr: "GALT",
      UTCOffset: "GMT-0600"
    }, {
      name: "Gambier Islands",
      abbr: "GAMT",
      UTCOffset: "GMT-0900"
    }, {
      name: "Georgia Standard Time",
      abbr: "GET",
      UTCOffset: "GMT+0400"
    }, {
      name: "French Guiana Time",
      abbr: "GFT",
      UTCOffset: "GMT-0300"
    }, {
      name: "Gilbert Island Time",
      abbr: "GILT",
      UTCOffset: "GMT+1200"
    }, {
      name: "Gambier Island Time",
      abbr: "GIT",
      UTCOffset: "GMT-0900"
    }, {
      name: "Greenwich Mean Time",
      abbr: "GMT",
      UTCOffset: "GMT+0000"
    }, {
      name: "South Georgia and the South Sandwich Islands",
      abbr: "GST",
      UTCOffset: "GMT-0200"
    }, {
      name: "Gulf Standard Time",
      abbr: "GST",
      UTCOffset: "GMT+0400"
    }, {
      name: "Guyana Time",
      abbr: "GYT",
      UTCOffset: "GMT-0400"
    }, {
      name: "Hawaii-Aleutian Daylight Time",
      abbr: "HADT",
      UTCOffset: "GMT-0900"
    }, {
      name: "Heure Avancée d'Europe Centrale francised name for CEST",
      abbr: "HAEC",
      UTCOffset: "GMT+0200"
    }, {
      name: "Hawaii-Aleutian Standard Time",
      abbr: "HAST",
      UTCOffset: "GMT-1000"
    }, {
      name: "Hong Kong Time",
      abbr: "HKT",
      UTCOffset: "GMT+0800"
    }, {
      name: "Heard and McDonald Islands Time",
      abbr: "HMT",
      UTCOffset: "GMT+0500"
    }, {
      name: "Khovd Time",
      abbr: "HOVT",
      UTCOffset: "GMT+0700"
    }, {
      name: "Hawaii Standard Time",
      abbr: "HST",
      UTCOffset: "GMT-1000"
    }, {
      name: "Indochina Time",
      abbr: "ICT",
      UTCOffset: "GMT+0700"
    }, {
      name: "Israel Daylight Time",
      abbr: "IDT",
      UTCOffset: "GMT+0300"
    }, {
      name: "Indian Ocean Time",
      abbr: "IOT",
      UTCOffset: "GMT+0300"
    }, {
      name: "Iran Daylight Time",
      abbr: "IRDT",
      UTCOffset: "GMT+0800"
    }, {
      name: "Irkutsk Time",
      abbr: "IRKT",
      UTCOffset: "GMT+0900"
    }, {
      name: "Iran Standard Time",
      abbr: "IRST",
      UTCOffset: "GMT+0330"
    }, {
      name: "Indian Standard Time",
      abbr: "IST",
      UTCOffset: "GMT+0530"
    }, {
      name: "Irish Standard Time[3]",
      abbr: "IST",
      UTCOffset: "GMT+0100"
    }, {
      name: "Israel Standard Time",
      abbr: "IST",
      UTCOffset: "GMT+0200"
    }, {
      name: "Japan Standard Time",
      abbr: "JST",
      UTCOffset: "GMT+0900"
    }, {
      name: "Kyrgyzstan time",
      abbr: "KGT",
      UTCOffset: "GMT+0600"
    }, {
      name: "Kosrae Time",
      abbr: "KOST",
      UTCOffset: "GMT+1100"
    }, {
      name: "Krasnoyarsk Time",
      abbr: "KRAT",
      UTCOffset: "GMT+0700"
    }, {
      name: "Korea Standard Time",
      abbr: "KST",
      UTCOffset: "GMT+0900"
    }, {
      name: "Lord Howe Standard Time",
      abbr: "LHST",
      UTCOffset: "GMT+1030"
    }, {
      name: "Lord Howe Summer Time",
      abbr: "LHST",
      UTCOffset: "GMT+1100"
    }, {
      name: "Line Islands Time",
      abbr: "LINT",
      UTCOffset: "GMT+1400"
    }, {
      name: "Magadan Time",
      abbr: "MAGT",
      UTCOffset: "GMT+1200"
    }, {
      name: "Marquesas Islands Time",
      abbr: "MART",
      UTCOffset: "GMT-0930"
    }, {
      name: "Mawson Station Time",
      abbr: "MAWT",
      UTCOffset: "GMT+0500"
    }, {
      name: "Mountain Daylight Time (North America)",
      abbr: "MDT",
      UTCOffset: "GMT-0600"
    }, {
      name: "Middle European Time Same zone as CET",
      abbr: "MET",
      UTCOffset: "GMT+0100"
    }, {
      name: "Middle European Saving Time Same zone as CEST",
      abbr: "MEST",
      UTCOffset: "GMT+0200"
    }, {
      name: "Marshall Islands",
      abbr: "MHT",
      UTCOffset: "GMT+1200"
    }, {
      name: "Macquarie Island Station Time",
      abbr: "MIST",
      UTCOffset: "GMT+1100"
    }, {
      name: "Marquesas Islands Time",
      abbr: "MIT",
      UTCOffset: "GMT-0930"
    }, {
      name: "Myanmar Time",
      abbr: "MMT",
      UTCOffset: "GMT+0630"
    }, {
      name: "Moscow Time",
      abbr: "MSK",
      UTCOffset: "GMT+0400"
    }, {
      name: "Malaysia Standard Time",
      abbr: "MST",
      UTCOffset: "GMT+0800"
    }, {
      name: "Mountain Standard Time (North America)",
      abbr: "MST",
      UTCOffset: "GMT-0700"
    }, {
      name: "Myanmar Standard Time",
      abbr: "MST",
      UTCOffset: "GMT+0630"
    }, {
      name: "Mauritius Time",
      abbr: "MUT",
      UTCOffset: "GMT+0400"
    }, {
      name: "Maldives Time",
      abbr: "MVT",
      UTCOffset: "GMT+0500"
    }, {
      name: "Malaysia Time",
      abbr: "MYT",
      UTCOffset: "GMT+0800"
    }, {
      name: "New Caledonia Time",
      abbr: "NCT",
      UTCOffset: "GMT+1100"
    }, {
      name: "Newfoundland Daylight Time",
      abbr: "NDT",
      UTCOffset: "GMT-0230"
    }, {
      name: "Norfolk Time",
      abbr: "NFT",
      UTCOffset: "GMT+1130"
    }, {
      name: "Nepal Time",
      abbr: "NPT",
      UTCOffset: "GMT+0545"
    }, {
      name: "Newfoundland Standard Time",
      abbr: "NST",
      UTCOffset: "GMT-0330"
    }, {
      name: "Newfoundland Time",
      abbr: "NT",
      UTCOffset: "GMT-0330"
    }, {
      name: "Niue Time",
      abbr: "NUT",
      UTCOffset: "GMT-1130"
    }, {
      name: "New Zealand Daylight Time",
      abbr: "NZDT",
      UTCOffset: "GMT+1300"
    }, {
      name: "New Zealand Standard Time",
      abbr: "NZST",
      UTCOffset: "GMT+1200"
    }, {
      name: "Omsk Time",
      abbr: "OMST",
      UTCOffset: "GMT+0600"
    }, {
      name: "Oral Time",
      abbr: "ORAT",
      UTCOffset: "GMT+0500"
    }, {
      name: "Pacific Daylight Time (North America)",
      abbr: "PDT",
      UTCOffset: "GMT-0700"
    }, {
      name: "Peru Time",
      abbr: "PET",
      UTCOffset: "GMT-0500"
    }, {
      name: "Kamchatka Time",
      abbr: "PETT",
      UTCOffset: "GMT+1200"
    }, {
      name: "Papua New Guinea Time",
      abbr: "PGT",
      UTCOffset: "GMT+1000"
    }, {
      name: "Phoenix Island Time",
      abbr: "PHOT",
      UTCOffset: "GMT+1300"
    }, {
      name: "Philippine Time",
      abbr: "PHT",
      UTCOffset: "GMT+0800"
    }, {
      name: "Pakistan Standard Time",
      abbr: "PKT",
      UTCOffset: "GMT+0500"
    }, {
      name: "Saint Pierre and Miquelon Daylight time",
      abbr: "PMDT",
      UTCOffset: "GMT-0200"
    }, {
      name: "Saint Pierre and Miquelon Standard Time",
      abbr: "PMST",
      UTCOffset: "GMT-0300"
    }, {
      name: "Pohnpei Standard Time",
      abbr: "PONT",
      UTCOffset: "GMT+1100"
    }, {
      name: "Pacific Standard Time (North America)",
      abbr: "PST",
      UTCOffset: "GMT-0800"
    }, {
      name: "Philippine Standard Time",
      abbr: "PST",
      UTCOffset: "GMT+0800"
    }, {
      name: "Réunion Time",
      abbr: "RET",
      UTCOffset: "GMT+0400"
    }, {
      name: "Rothera Research Station Time",
      abbr: "ROTT",
      UTCOffset: "GMT-0300"
    }, {
      name: "Sakhalin Island time",
      abbr: "SAKT",
      UTCOffset: "GMT+1100"
    }, {
      name: "Samara Time",
      abbr: "SAMT",
      UTCOffset: "GMT+0400"
    }, {
      name: "South African Standard Time",
      abbr: "SAST",
      UTCOffset: "GMT+0200"
    }, {
      name: "Solomon Islands Time",
      abbr: "SBT",
      UTCOffset: "GMT+1100"
    }, {
      name: "Seychelles Time",
      abbr: "SCT",
      UTCOffset: "GMT+0400"
    }, {
      name: "Singapore Time",
      abbr: "SGT",
      UTCOffset: "GMT+0800"
    }, {
      name: "Sri Lanka Time",
      abbr: "SLT",
      UTCOffset: "GMT+0530"
    }, {
      name: "Suriname Time",
      abbr: "SRT",
      UTCOffset: "GMT-0300"
    }, {
      name: "Samoa Standard Time",
      abbr: "SST",
      UTCOffset: "GMT-1100"
    }, {
      name: "Singapore Standard Time",
      abbr: "SST",
      UTCOffset: "GMT+0800"
    }, {
      name: "Showa Station Time",
      abbr: "SYOT",
      UTCOffset: "GMT+0300"
    }, {
      name: "Tahiti Time",
      abbr: "TAHT",
      UTCOffset: "GMT-1000"
    }, {
      name: "Thailand Standard Time",
      abbr: "THA",
      UTCOffset: "GMT+0700"
    }, {
      name: "Indian/Kerguelen",
      abbr: "TFT",
      UTCOffset: "GMT+0500"
    }, {
      name: "Tajikistan Time",
      abbr: "TJT",
      UTCOffset: "GMT+0500"
    }, {
      name: "Tokelau Time",
      abbr: "TKT",
      UTCOffset: "GMT+1400"
    }, {
      name: "Timor Leste Time",
      abbr: "TLT",
      UTCOffset: "GMT+0900"
    }, {
      name: "Turkmenistan Time",
      abbr: "TMT",
      UTCOffset: "GMT+0500"
    }, {
      name: "Tonga Time",
      abbr: "TOT",
      UTCOffset: "GMT+1300"
    }, {
      name: "Tuvalu Time",
      abbr: "TVT",
      UTCOffset: "GMT+1200"
    }, {
      name: "Coordinated Universal Time",
      abbr: "UCT",
      UTCOffset: "GMT+0000"
    }, {
      name: "Ulaanbaatar Time",
      abbr: "ULAT",
      UTCOffset: "GMT+0800"
    }, {
      name: "Coordinated Universal Time",
      abbr: "GMT",
      UTCOffset: "GMT+0000"
    }, {
      name: "Uruguay Summer Time",
      abbr: "UYST",
      UTCOffset: "GMT-0200"
    }, {
      name: "Uruguay Standard Time",
      abbr: "UYT",
      UTCOffset: "GMT-0300"
    }, {
      name: "Uzbekistan Time",
      abbr: "UZT",
      UTCOffset: "GMT+0500"
    }, {
      name: "Venezuelan Standard Time",
      abbr: "VET",
      UTCOffset: "GMT-0430"
    }, {
      name: "Vladivostok Time",
      abbr: "VLAT",
      UTCOffset: "GMT+1000"
    }, {
      name: "Volgograd Time",
      abbr: "VOLT",
      UTCOffset: "GMT+0400"
    }, {
      name: "Vostok Station Time",
      abbr: "VOST",
      UTCOffset: "GMT+0600"
    }, {
      name: "Vanuatu Time",
      abbr: "VUT",
      UTCOffset: "GMT+1100"
    }, {
      name: "Wake Island Time",
      abbr: "WAKT",
      UTCOffset: "GMT+1200"
    }, {
      name: "West Africa Summer Time",
      abbr: "WAST",
      UTCOffset: "GMT+0200"
    }, {
      name: "West Africa Time",
      abbr: "WAT",
      UTCOffset: "GMT+0100"
    }, {
      name: "Western European Daylight Time",
      abbr: "WEDT",
      UTCOffset: "GMT+0100"
    }, {
      name: "Western European Summer Time",
      abbr: "WEST",
      UTCOffset: "GMT+0100"
    }, {
      name: "Western European Time",
      abbr: "WET",
      UTCOffset: "GMT+0000"
    }, {
      name: "Western Standard Time",
      abbr: "WST",
      UTCOffset: "GMT+0800"
    }, {
      name: "Yakutsk Time",
      abbr: "YAKT",
      UTCOffset: "GMT+0900"
    }, {
      name: "Yekaterinburg Time",
      abbr: "YEKT",
      UTCOffset: "GMT+0500"
    }
  ];

}).call(this);


(function() {
}).call(this);


(function() {

  Tent.Browsers = {};

  Tent.Browsers.getIEVersion = function() {
    var re, rv, ua;
    if (navigator.appName === "Microsoft Internet Explorer") {
      ua = navigator.userAgent;
      re = new RegExp("MSIE ([0-9]{1,}[.0-9]{0,})");
      if (re.exec(ua) != null) {
        rv = parseFloat(RegExp.$1);
      }
    }
    return rv;
  };

  Tent.Browsers.isIE = function() {
    var res;
    res = this.getIEVersion() != null;
    this.isIE = function() {
      return res;
    };
    return res;
  };

  Tent.Browsers.executeForIE = function(context, callback, args) {
    if (Tent.Browsers.getIEVersion() !== 8) {
      if (args != null) {
        return callback.apply(context, args);
      } else {
        return callback.apply(context);
      }
    } else {
      if (args != null) {
        return setTimeout((function() {
          return callback.apply(context, args);
        }), 10);
      } else {
        return setTimeout((function() {
          return callback.apply(context);
        }), 10);
      }
    }
  };

}).call(this);


(function() {

  Tent.ResizeSupport = Ember.Mixin.create({
    resize: function() {
      var _ref;
      return (_ref = this.get('childViews')) != null ? _ref.forEach(function(child) {
        return typeof child.resize === "function" ? child.resize() : void 0;
      }) : void 0;
    }
  });

  Ember.$(document).ready(function() {
    var lastWindowHeightForResize, lastWindowWidthForResize;
    lastWindowHeightForResize = $(window).height();
    lastWindowWidthForResize = $(window).width();
    return $(window).resize(function(e) {
      if (($(window).height() !== lastWindowHeightForResize) || ($(window).width() !== lastWindowWidthForResize)) {
        lastWindowHeightForResize = $(window).height();
        lastWindowWidthForResize = $(window).width();
        return $.publish('/window/resize');
      }
    });
  });

}).call(this);


(function() {

  Tent.DEFAULT_STRING_TRUNCATION_LENGTH = 30;

  Ember.mixin(String.prototype, {
    truncate: function(maxLength) {
      var length;
      length = Ember.none(maxLength) ? Tent.DEFAULT_STRING_TRUNCATION_LENGTH : maxLength;
      if (this.length <= length) {
        return this.toString();
      } else {
        return this.substr(0, length) + '...';
      }
    },
    camelToWords: function() {
      var spaced;
      spaced = this.replace(/([A-Z])/g, " $1");
      return spaced[0].toUpperCase() + spaced.substring(1);
    },
    isBlank: function() {
      return this.trim().length === 0;
    },
    toBoolean: function() {
      return this.toLowerCase() === 'true';
    }
  });

  if (!(String.prototype.trim != null)) {
    String.prototype.trim = function() {
      return this.replace(/^\s+|\s+$/g, '');
    };
  }

  String.prototype.removeWhitespace = function() {
    return this.replace(/\s+/g, '');
  };

}).call(this);


(function() {

  if (Tent.computed == null) {
    Tent.computed = {};
  }

  Tent.computed.boolCoerceGently = function(dependentKey) {
    return Ember.computed(dependentKey, (function(key) {
      var value;
      value = this.get(dependentKey);
      if (typeof value === "boolean") {
        return value;
      }
      if (typeof value === 'string') {
        return value.toBoolean();
      }
      if (typeof value === 'number') {
        return value !== 0;
      }
    }));
  };

  Tent.computed.translate = function(dependentKey) {
    return Ember.computed(dependentKey, (function(key) {
      var value;
      value = this.get(dependentKey) || '';
      return Tent.translate(value);
    }));
  };

}).call(this);


(function() {

  if (Tent.messages == null) {
    Tent.messages = {};
  }

  Tent.messages.GENERIC_ERROR = 'error.generic';

  Tent.messages.REQUIRED_ERROR = 'error.required';

  Tent.messages.NUMERIC_ERROR = "error.numeric";

  Tent.messages.AMOUNT_ERROR = "error.amount";

  Tent.messages.EMAIL_FORMAT_ERROR = "error.email";

  Tent.messages.DATE_FORMAT_ERROR = "error.date";

  Tent.messages.DATE_BETWEEN_ERROR = "error.dateBetween";

  Tent.messages.DATE_FUTURE_ERROR = "error.dateFuture";

  Tent.messages.MIN_LENGTH = "error.minLength";

  Tent.messages.MAX_LENGTH = "error.maxLength";

  Tent.messages.CURRENCY_ERROR = "error.invalidCurrency";

  Tent.messages.REG_EXP = "error.regexp";

  Tent.messages.MIN_VALUE_ERROR = "error.minValue";

  Tent.messages.MAX_VALUE_ERROR = "error.maxValue";

  Tent.messages.GREATER_VALUE_ERROR = "error.greaterValue";

  Tent.messages.LESS_VALUE_ERROR = "error.lessValue";

  Tent.messages.VALUE_BETWEEN_ERROR = "error.valueBetween";

  Tent.messages.POSITIVE_ERROR = "error.positive";

  Tent.messages.UNIQUE_VALUE_ERROR = "error.uniqueValue";

}).call(this);


(function() {

  Tent.SelectableArrayProxy = Ember.ArrayProxy.extend({
    init: function() {
      this._super();
      this.set('_selectedElementsArray', []);
      this.set('_selectedIndexArray', []);
      this.set('_selectedElement', null);
      this.set('_selectedIndex', -1);
      return this.set('_selection', null);
    },
    clearSelection: function() {
      return this.set('selected', null);
    },
    selectAll: function() {
      var _this = this;
      if (this.get('isMultipleSelectionAllowed')) {
        this.beginPropertyChanges();
        this.clearSelection();
        this.get('content').forEach(function(element) {
          return _this.set('selected', element);
        });
        return this.endPropertyChanges();
      }
    },
    selected: (function(key, value) {
      if (value !== undefined) {
        if (this.get('isMultipleSelectionAllowed')) {
          this.set('_selection', this._multiSelection(value).slice());
        } else {
          this.set('_selection', new Array(this._singleSelection(value)).slice());
        }
      }
      return this.get('_selection');
    }).property().volatile(),
    _singleSelection: (function(value) {
      if (value !== undefined) {
        if (value !== null) {
          if (value !== this.get('_selectedElement')) {
            if (this.indexOf(value >= 0)) {
              this.set('_selectedElement', value);
              this.set('_selectedIndex', this.indexOf(value));
            }
          } else {
            this.set('_selectedElement', null);
            this.set('_selectedIndex', -1);
          }
        } else {
          this.set('_selectedElement', null);
          this.set('_selectedIndex', -1);
        }
      }
      return this.get('_selectedElement');
    }),
    _multiSelection: function(value) {
      var selectedElements, selectedIndices;
      if (value !== undefined) {
        if (value !== null) {
          selectedElements = this.get('_selectedElementsArray');
          selectedIndices = this.get('_selectedIndexArray');
          if (selectedElements.contains(value)) {
            selectedElements.removeObject(value);
            selectedIndices.splice(selectedIndices.indexOf(this.indexOf(value)), 1);
          } else {
            selectedElements.addObject(value);
            selectedIndices.push(this.indexOf(value));
          }
        } else {
          this.set('_selectedElementsArray', []);
          this.set('_selectedIndexArray', []);
        }
      }
      return this.get('_selectedElementsArray');
    },
    contentDidChange: (function() {
      var content, currentElement, currentElementsArray, currentIndex, currentIndexArray, element, newIndex, newIndexArray, _i, _j, _len, _len1, _results;
      content = this.get('content');
      if (this.get('isMultipleSelectionAllowed')) {
        currentIndexArray = this.get('_selectedIndexArray');
        currentElementsArray = this.get('_selectedElementsArray');
        newIndexArray = [];
        if (currentElementsArray.length !== 0) {
          for (_i = 0, _len = currentElementsArray.length; _i < _len; _i++) {
            element = currentElementsArray[_i];
            if (content.contains(element)) {
              newIndexArray.push(content.indexOf(element));
            }
          }
          if (currentIndexArray.toString() !== newIndexArray.toString()) {
            this.set('_selectedElementsArray', []);
            this.set('_selectedIndexArray', []);
            if (newIndexArray.length !== 0) {
              _results = [];
              for (_j = 0, _len1 = newIndexArray.length; _j < _len1; _j++) {
                element = newIndexArray[_j];
                _results.push(this.set('selected', content.objectAt(element)));
              }
              return _results;
            } else {
              return this.set('selected', null);
            }
          }
        }
      } else {
        currentIndex = this.get('_selectedIndex');
        currentElement = this.get('_selectedElement');
        if (currentElement !== null) {
          if (content.contains(currentElement)) {
            newIndex = this.indexOf(currentElement);
            if (newIndex !== currentIndex) {
              return this.set('_selectedIndex', content.indexOf(currentElement));
            }
          } else {
            return this.set('selected', null);
          }
        }
      }
    }).observes('content.@each')
  });

}).call(this);


(function() {

  accounting.settings = {
    currency: {
      symbol: "$",
      format: "%s%v",
      decimal: ".",
      thousand: ",",
      precision: 2
    },
    number: {
      precision: 2,
      thousand: ",",
      decimal: ".",
      pattern: 'xxx,xxx.xx'
    }
  };

  if (Tent.Formatting == null) {
    Tent.Formatting = {};
  }

  /**
  * @class Tent.Formatting
  * 
  * Formatting methods for converting base values to and from presentation strings.
  *
  */


  /**
  * @class Tent.Formatting.amount
  */


  Tent.Formatting.amount = Ember.Object.create({
    cleanup: function(value) {
      if ((value != null) && value !== '') {
        return Tent.Formatting.amount.format(accounting.unformat(value));
      } else {
        return "";
      }
    },
    /**
    	* @method format
    	* Formats an amount
    	* @param {Number} amount The amount to format
    	* @param {Array} [settings] Optional setting to use for formatting
    	* @return {String} The formatted value
    */

    format: function(amount, settings) {
      if (amount != null) {
        if (settings != null) {
          settings = Tent.Formatting.amount.settingsFilter(settings);
          return accounting.formatNumber(amount, settings);
        } else {
          return accounting.formatNumber(amount);
        }
      } else {
        return "";
      }
    },
    /**
    	* @method unformat
    	* Unformats an amount
    	* @param {String} amount The amount to format
    	* @param {Array} [settings] Optional setting to use for formatting
    	* @return {Number} The unformatted value
    */

    unformat: function(amount, settings) {
      if (amount != null) {
        if (settings != null) {
          settings = Tent.Formatting.amount.settingsFilter(settings);
          return accounting.unformat(amount, settings);
        } else {
          return accounting.unformat(amount);
        }
      } else {
        return null;
      }
    },
    settingsFilter: function(rawSettings) {
      return rawSettings;
    },
    cssClass: function() {
      return "amount";
    },
    /**
    	* @Object serializer A serialization object which implements serialize() and deserialize() methods.
    */

    serializer: null
  });

  Tent.Formatting.date = Ember.Object.create({
    options: {
      dateFormat: "mm/dd/yy"
    },
    getFormat: function() {
      return this.get('options').dateFormat;
    },
    format: function(value, dateFormat) {
      var hours, minutes;
      if (dateFormat === "dd-M-yy hh-mm tz") {
        hours = value.getHours();
        if (hours < 10) {
          hours = "0" + hours;
        }
        minutes = value.getMinutes();
        if (minutes < 10) {
          minutes = "0" + minutes;
        }
        return Tent.Formatting.date.format(value, "dd-M-yy") + ' ' + hours + ':' + minutes + " (" + Tent.Date.getAbbreviatedTZFromDate(value) + ")";
      } else {
        return $.datepicker.formatDate(dateFormat || Tent.Formatting.date.getFormat(), value);
      }
    },
    unformat: function(value, dateFormat) {
      if (dateFormat === "dd-M-yy hh-mm tz") {
        return $.datepicker.parseDate("dd-M-yy", value.substring(0, 11));
      } else {
        return $.datepicker.parseDate(dateFormat || Tent.Formatting.date.getFormat(), value);
      }
    },
    cssClass: function() {
      return "date";
    }
  });

  Tent.Formatting.number = Ember.Object.create({
    isValidNumber: function(value) {
      return (value !== '') && !(isNaN(value) || isNaN(parseFloat(value)));
    },
    errorText: function() {
      return Tent.I18n.loc('formatting.number');
    },
    format: function(value) {
      if ((typeof value === 'number') || value === '') {
        return value.toString(10);
      } else if (value != null) {
        return value;
      } else {
        return "";
      }
    },
    unformat: function(value) {
      var val;
      if (this.isValidNumber(value)) {
        return val = parseFloat(value);
      } else if (value === "") {
        return null;
      } else {
        return value;
      }
    },
    cssClass: function() {
      return "amount";
    },
    /**
    	* @Object serializer A serialization object which implements serialize() and deserialize() methods.
    */

    serializer: null
  });

  Tent.Formatting.percent = Ember.Object.create({
    isValidNumber: function(value) {
      return (value !== '') && !(isNaN(value) || isNaN(parseFloat(value)));
    },
    errorText: function() {
      return Tent.I18n.loc('formatting.percent');
    },
    format: function(value) {
      if (typeof value === 'number') {
        return Math.round(1000 * value) / 10..toString(10) + "%";
      } else if (value != null) {
        return value;
      } else {
        return "";
      }
    },
    unformat: function(value) {
      var val;
      if (value === "" || !(value != null)) {
        return null;
      }
      if (value.indexOf('%') !== -1) {
        value = value.split('%')[0];
      }
      if (this.isValidNumber(value)) {
        return val = parseFloat((value / 100).toFixed(3));
      } else {
        return value;
      }
    },
    cssClass: function() {
      return "amount";
    }
  });

}).call(this);



/**
* @class Tent.Validations
* Validations that can be applied to tent fields
*/


(function() {

  Tent.Validations = Ember.Object.create();

  Tent.Validation = Ember.Object.extend({
    ERROR_MESSAGE: Tent.messages.GENERIC_ERROR,
    isValueEmpty: function(value) {
      return !((value != null) && value !== '');
    },
    getErrorMessage: function(value, options) {
      return Tent.I18n.loc(this.get('ERROR_MESSAGE'), options || []);
    }
  });

  /**
  * @class Tent.Validations.email Validates that the value conforms to an email format
  */


  /**
  * @method validate
  * @param {String} value the value to test
  * @return {Boolean} the result of the validation
  */


  Tent.Validations.email = Tent.Validation.create({
    validate: function(value, options, message, view) {
      var isValid, pattern;
      pattern = /^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$/i;
      return isValid = this.isValueEmpty(value) || pattern.test(value);
    },
    ERROR_MESSAGE: Tent.messages.EMAIL_FORMAT_ERROR
  });

  /**
  * @class Tent.Validations.datebetween Validates that the date is between two specified dates
  */


  Tent.Validations.datebetween = Tent.Validation.create({
    /**
    * @method validate
    * @param {String} value the value to test
    * @param {Object} options the options to pass to the validation. options must contain a 
    * 'startDate' and an 'endDate' property
    * @return {Boolean} the result of the validation
    */

    validate: function(value, options, message, view) {
      var isValid;
      if (!(options != null) || !(options.startDate != null) || !(options.endDate != null)) {
        return false;
      }
      return isValid = this.isValueEmpty(value) || (this.convertToDate(value) > this.convertToDate(options.startDate) && this.convertToDate(value) < this.convertToDate(options.endDate));
    },
    convertToDate: function(value) {
      if (!(value instanceof Date)) {
        return new Date(value);
      }
      return value;
    },
    ERROR_MESSAGE: Tent.messages.DATE_BETWEEN_ERROR
  });

  /**
  * @class Tent.Validations.futuredate Validates that the date value is not later than today
  */


  Tent.Validations.futuredate = Tent.Validation.create({
    /**
    * @method validate
    * @param {String} value the value to test
    * @return {Boolean} the result of the validation
    */

    validate: function(value, options, message, view) {
      var today;
      today = new Date();
      if (!this.isValueEmpty(value) && this.convertToDate(value, view.get('dateFormat')) > today) {
        return false;
      }
      return true;
    },
    convertToDate: function(value, dateFormat) {
      if (!(value instanceof Date)) {
        return Tent.Formatting.date.unformat(value, dateFormat);
      }
      return value;
    },
    ERROR_MESSAGE: Tent.messages.DATE_FUTURE_ERROR
  });

  /**
  * @class Tent.Validations.minLength Validates that the value is greater than or equal to a defined length
  */


  Tent.Validations.minLength = Tent.Validation.create({
    /**
    * @method validate
    * @param {String} value the value to test
    * @param {Object} options the options to pass to the validation. options must contain a 
    * 'min' value
    * @param {String} message an optional message to display if the validation fails
    * @return {Boolean} the result of the validation
    */

    validate: function(value, options, message, view) {
      if (!(options != null) || !(options.min != null)) {
        return false;
      }
      if (value != null) {
        value = value.trim();
      }
      return this.isValueEmpty(value) || value.length >= options.min;
    },
    ERROR_MESSAGE: Tent.messages.MIN_LENGTH
  });

  /**
  * @class Tent.Validations.maxLength Validates that the value is less than or equal to a defined length
  */


  Tent.Validations.maxLength = Tent.Validation.create({
    /**
    * @method validate
    * @param {String} value the value to test
    * @param {Object} options the options to pass to the validation. options must contain a 
    * 'max' value
    * @param {String} message an optional message to display if the validation fails
    * @return {Boolean} the result of the validation
    */

    validate: function(value, options, message, view) {
      if (!(options != null) || !(options.max != null)) {
        return false;
      }
      if (value != null) {
        value = value.trim();
      }
      return this.isValueEmpty(value) || value.length <= options.max;
    },
    ERROR_MESSAGE: Tent.messages.MAX_LENGTH
  });

  /**
  * @class Tent.Validations.regExp Validates that the value matches a regular expression
  */


  Tent.Validations.regExp = Tent.Validation.create({
    /**
    * @method validate
    * @param {String} value the value to test
    * @param {Object} options the options to pass to the validation. options must contain a 'regexp' property
    * @param {String} message an optional message to display if the validation fails
    * @return {Boolean} the result of the validation
    */

    validate: function(value, options, message, view) {
      if (!(options != null) || !(options.regexp != null)) {
        return false;
      }
      message = !(message != null) && (options.message != null) ? options.message : Tent.messages.REG_EXP;
      if (message != null) {
        this.set('ERROR_MESSAGE', message);
      }
      return this.isValueEmpty(value) || options.regexp.test(value);
    },
    ERROR_MESSAGE: Tent.messages.REG_EXP
  });

  /**
  * @class Tent.Validations.valueBetween Validates that the value is between two numbers
  */


  Tent.Validations.valueBetween = Tent.Validation.create({
    /**
    * @method validate
    * @param {String} value the value to test
    * @param {Object} options the options to pass to the validation. options must contain either a 
    * 'min' or a 'max' value or both
    * @param {String} message an optional message to display if the validation fails
    * @return {Boolean} the result of the validation
    */

    validate: function(value, options, message, view) {
      if (!(options != null) || !((options.min != null) || (options.max != null))) {
        return false;
      }
      message = !(message != null) && (options.message != null) ? options.message : void 0;
      if (value) {
        if ((options.min != null) && options.min > value) {
          if (!message) {
            message = Tent.messages.MIN_VALUE_ERROR;
          }
          if (message != null) {
            this.set('ERROR_MESSAGE', message);
          }
          return false;
        } else if ((options.max != null) && options.max < value) {
          if (!message) {
            message = Tent.messages.MAX_VALUE_ERROR;
          }
          if (message != null) {
            this.set('ERROR_MESSAGE', message);
          }
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    },
    ERROR_MESSAGE: Tent.messages.VALUE_BETWEEN_ERROR
  });

  /**
  * @class Tent.Validations.positive Validates that the value is positive (>= 0)
  */


  Tent.Validations.positive = Tent.Validation.create({
    /**
    * @method validate
    * @param {String} value the value to test
    * @param {Object} options the options to pass to the validation. options must contain either a 
    * 'min' or a 'max' value or both
    * @param {String} message an optional message to display if the validation fails
    * @return {Boolean} the result of the validation
    */

    validate: function(value, options, message, view) {
      message = !(message != null) && (options != null) && (options.message != null) ? options.message : void 0;
      value = Tent.Formatting.amount.unformat(value);
      if (this.isValueEmpty(value) || value >= 0) {
        return true;
      } else {
        return false;
      }
    },
    ERROR_MESSAGE: Tent.messages.POSITIVE_ERROR
  });

  Tent.Validations.uniqueValue = Tent.Validation.create({
    /**
    * @method validate
    * @param {String} value the value to test
    * @param {Object} options the options to pass to the validation. 
    *  options must contain
    *  a 'testArr' string of comma separated values to test against
    *  a 'item' string - the name of field/item for which duplicacy is checked.
    *                     This is required for proper formation of error message in case of validation failure.
    *  a 'property' string - the property of above field/item which should be unique.
    *                     This is required for proper formation of error message in case of validation failure.
    * @param {String} message an optional message to display if the validation fails
    * Message string will be formed as: "'item' with this 'property' already exists"
    * @return {Boolean} the result of the validation
    */

    validate: function(value, options, message, view) {
      if (!(options != null) || !(options.testArr != null) || !(options.item != null) || !(options.property != null) || !(options.testArr instanceof Array)) {
        return false;
      }
      return !(options.testArr.contains(value));
    },
    ERROR_MESSAGE: Tent.messages.UNIQUE_VALUE_ERROR
  });

  /**
  * @class Tent.Validations.compareValue Validates that the value is greater than or less than numbers
  */


  Tent.Validations.compareValue = Tent.Validation.create({
    /**
    * @method validate
    * @param {String} value the value to test
    * @param {Object} options the options to pass to the validation. options must contain either a 
    * 'greaterThan' or 'lessThan' value 
    * @param {String} message an optional message to display if the validation fails
    * @return {Boolean} the result of the validation
    */

    validate: function(value, options, message, view) {
      if (!(options != null) || !((options.greaterThan != null) || (options.lessThan != null))) {
        return true;
      }
      message = !(message != null) && (options.message != null) ? options.message : void 0;
      if (value) {
        value = Number(value);
        if (options.greaterThan != null) {
          options.greaterThan = Number(options.greaterThan);
        }
        if (options.lessThan != null) {
          options.lessThan = Number(options.lessThan);
        }
        if ((options.greaterThan != null) && options.greaterThan >= value) {
          if (!message) {
            message = Tent.messages.GREATER_VALUE_ERROR;
          }
          if (message != null) {
            this.set('ERROR_MESSAGE', message);
          }
          return false;
        } else if ((options.lessThan != null) && options.lessThan <= value) {
          if (!message) {
            message = Tent.messages.LESS_VALUE_ERROR;
          }
          if (message != null) {
            this.set('ERROR_MESSAGE', message);
          }
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    }
  });

}).call(this);



/**
* @class Tent.Date
* This class has methods used to fetch data associated with dates and timezones.
  Private methods used for getting UTCOffset, timezone name or abbreviations using different combinations of data available.
  A "zone" object = A javascript object having timezone name, abbreviation and UTCOffset
*/


(function() {
  var filterZoneUsingTZAbbreviation, filterZoneUsingTZName, getZonesFromAbbreviation, getZonesFromUTCOffset;

  Tent.Date = Ember.Object.create({
    /**
    * @method getAbbreviatedTZFromUTCOffsetAndName Returns time zone abbreviation
    (closest match of the supplied name string is considered as full names of timezones 
    might be different from what is in the Tent list). 
    Returns null if UTCOffset is missing
    * @param {String} UTCOffset string of type : "GMT+0400"
    * @param {String} name Optional argument which is the full name of timezone
    * @return {String}
    */

    getAbbreviatedTZFromUTCOffsetAndName: function(UTCOffset, name) {
      var zone, zones;
      if (name == null) {
        name = null;
      }
      if (UTCOffset == null) {
        return null;
      }
      zones = getZonesFromUTCOffset(UTCOffset);
      zone = (zones.length === 1 ? zones[0] : filterZoneUsingTZName(zones, name));
      if (zone) {
        return zone['abbr'];
      } else {
        return null;
      }
    },
    /**
    * @method getFullTZFromUTCOffsetAndAbbreviation Returns timezone name, returns null if UTC Offset is missing
    * @param {String} UTCOffset string of type : "GMT+0400" (Required)
    * @param {String} abbr Timezone abbreviation of type: "IST" (Optional)
    * @return {string}
    */

    getFullTZFromUTCOffsetAndAbbreviation: function(UTCOffset, abbr) {
      var zone, zones;
      if (abbr == null) {
        abbr = null;
      }
      if (UTCOffset == null) {
        return null;
      }
      zones = getZonesFromUTCOffset(UTCOffset);
      if (zones.length) {
        zone = (zones.length === 1 ? zones[0] : filterZoneUsingTZAbbreviation(zones, abbr));
      }
      if (zone) {
        return zone['name'];
      } else {
        return null;
      }
    },
    /**
    * @method getAbbreviatedTZFromDate Returns timezone abbreviation, returns null if date is missing
    * @param {Date Object} date (Required)
    * @return {string}
    */

    getAbbreviatedTZFromDate: function(date) {
      /* 
        Possible Dates:
        Mon Apr 01 2013 14:55:15 GMT+0530 (IST) - with TZ abbreviations & GMT
        Mon Apr 01 2013 14:55:15 GMT+0530 (India Standard Time) - with TZ fullform & GMT(Windows)
        Mon Apr 1 15:19:25 UTC+0530 2013 - In IE, if data doesn't exist for client's tz, it shows date in this format 
        Fri Apr 5 06:31:52 EDT 2013 - In IE, if there exists data for client's tz, it shows date in this format
      */

      var dateString, hours, match, min, offset, tz, tzOffset;
      if (date == null) {
        return null;
      }
      tzOffset = date.getTimezoneOffset();
      hours = Math.floor(Math.abs(tzOffset / 60));
      min = Math.abs(tzOffset % 60);
      if (min < 10) {
        min = "0" + min;
      }
      if (hours < 10) {
        hours = "0" + hours;
      }
      if (tzOffset < 0) {
        offset = "GMT+" + hours + min;
      } else {
        offset = "GMT-" + hours + min;
      }
      dateString = date.toString("D");
      if (Tent.Browsers.isIE()) {
        match = /[A-Z]{3}/.exec(dateString);
      } else {
        match = /\((.+)\)/.exec(dateString);
      }
      if (match != null) {
        tz = match[0].replace(/[()]/g, "");
      } else {
        tz = null;
      }
      if ((tz != null) && tz.split(" ").length === 1) {
        return tz;
      }
      return Tent.Date.getAbbreviatedTZFromUTCOffsetAndName(offset, tz);
    },
    /** 
    * @method getFullTZFromDate Returns timezone name, returns null if date is missing
    * @param {Date Object} date (Required)
    * @return {String}
    */

    getFullTZFromDate: function(date) {
      var dateString, tz;
      if (date == null) {
        return null;
      }
      dateString = date.toString("D");
      tz = dateString.substring(35, dateString.length - 1);
      if (tz.split(" ").length !== 1) {
        return tz;
      } else {
        return Tent.Date.getFullTZFromUTCOffsetAndAbbreviation(dateString.substring(25, 33), tz);
      }
    },
    /**
    * @method getUTCOffsetFromTZ Returns UTCOffset given the timezone abbreviation and name. 
    * If name is not provided and there are more than one records with the given abbreviation,
    * null will be returned
    * @param {String} abbr (Required)
    * @param {String} name (Optional)
    * @return {String}
    */

    getUTCOffsetFromTZ: function(abbr, name) {
      var zone, zones;
      if (abbr == null) {
        return null;
      }
      zones = getZonesFromAbbreviation(abbr);
      zone = (zones.length === 1 ? zones[0] : (name != null ? filterZoneUsingTZName(zones, name) : null));
      if (zone) {
        return zone['UTCOffset'];
      } else {
        return null;
      }
    }
  });

  /**
  * @method filterZoneUsingTZAbbreviation (PRIVATE) Returns a zone object from an array of zone objects 
   if the given abbreviation matches any of the object abbreviations
   returns null if a list of 'zone' objects or abbreviation is not provided
  * @param {Array of Zone Objects} zones
  * @param {String} abbr
  * @return {Object} Zone object
  */


  filterZoneUsingTZAbbreviation = function(zones, abbr) {
    var zone;
    if (!((zones != null) || zones.length > 0)) {
      return null;
    }
    if (abbr == null) {
      return zones[0];
    }
    zone = zones.find(function(item) {
      return item.abbr === abbr;
    });
    return zone;
  };

  /**
  * @method filterZoneUsingTZName (PRIVATE) Returns an zone object from an array of zone objects
    if the given name exactly or almost matches any of the object names 
    (has the scope of "almost matching strings" as the name may not exactly match the ones in the Tent list)
    returns null if the list of 'zone' objects or name is not provided
  * @param {Array of Zone Objects} zones
  * @param {String} name
  * @return {Object} Zone object
  */


  filterZoneUsingTZName = function(zones, name) {
    var indices, min, zone;
    if (!((zones != null) || zones.length > 0)) {
      return null;
    }
    if (name == null) {
      return zones[0];
    }
    zone = zones.find(function(item) {
      return item.name === name;
    });
    if (!zone) {
      zones.forEach(function(item) {
        var i, str;
        str = item.name;
        i = 0;
        while (str[i] === name[i] && i < str.length && i < name.length) {
          i += 1;
        }
        return item.index = i;
      });
      indices = zones.mapProperty('index');
      min = Math.max.apply(Math, indices);
      zone = (min === 0 ? null : zones[indices.indexOf(min)]);
      return zone;
    }
  };

  /**
  * @method getZonesFromUTCOffset (PRIVATE) Returns an array list of zone objects which have the given UTCOffset
  * @param {String} UTCOffset 
  * @return {Object} Zone object
  */


  getZonesFromUTCOffset = function(UTCOffset) {
    return Tent.TIMEZONES.filter(function(item) {
      return item["UTCOffset"] === UTCOffset;
    });
  };

  /** 
  * @method getZonesFromAbbreviation (PRIVATE) Returns an array list of zone objects which have the given abbreviation
  * @param {String} abbr
  * @return {Object} Zone object
  */


  getZonesFromAbbreviation = function(abbr) {
    return Tent.TIMEZONES.filter(function(item) {
      return item["abbr"] === abbr;
    });
  };

}).call(this);


(function() {
}).call(this);



/**
 * @class Tent.SpanSupport  
 * Some docs here...
*/


(function() {

  Tent.SpanSupport = Ember.Mixin.create({
    /**
    * @property {Number} span The horizontal span which should be allocated to this widget
    */

    /**
    * @property {Number} vspan The vertical span which should be allocated to this widget
    */

    estimateSpan: function() {
      var currentView, span;
      currentView = this;
      while (currentView) {
        span = Number(currentView.get('span'));
        if (!((span === 0) || isNaN(span))) {
          return span;
        }
        currentView = currentView.get('parentView');
      }
      return 12;
    },
    spanClass: (function() {
      if (this.get('span')) {
        return 'span' + this.get('span');
      }
    }).property('span'),
    vspanClass: (function() {
      if (this.get('vspan')) {
        return 'vspan' + this.get('vspan');
      }
    }).property('vspan')
  });

}).call(this);



/**
 * @class Tent.VisibilitySupport
 * Some docs here...
*/


(function() {

  Tent.VisibilitySupport = Ember.Mixin.create({
    isVisible: true,
    _widgetShowing: true,
    isVisibleAsBoolean: Tent.computed.boolCoerceGently('isVisible'),
    isHidden: Ember.computed.not('isVisibleAsBoolean'),
    observesVisibility: (function() {
      if (this.get('isVisibleAsBoolean')) {
        if (!this.get('_widgetShowing')) {
          this.$().show();
        }
        return this.set('_widgetShowing', true);
      } else {
        if (this.get('_widgetShowing')) {
          this.$().hide();
        }
        return this.set('_widgetShowing', false);
      }
    }).observes('isVisible')
  });

}).call(this);



/**
 * @class Tent.ValidationSupport
 * Some docs here...
*/


(function() {

  Tent.ValidationSupport = Ember.Mixin.create({
    /**
    * @property {String }validations A list of comma-separated custom validations which should be applied to the widget
    */

    validations: null,
    isValid: true,
    validationErrors: [],
    validationWarnings: [],
    processWarnings: true,
    /**
    * @property {String} warnings A list of comma-separated custom validations which should be applied to the widget, but are interpreted
    * as warnings which may be ignored.
    */

    warnings: null,
    init: function() {
      return this._super();
    },
    willDestroyElement: function() {
      this._super();
      if (!this.isDestroyed) {
        return this.flushValidationErrors();
      }
    },
    validate: function() {
      var valid;
      this.flushValidationErrors();
      this.flushValidationWarnings();
      valid = this.executeCustomValidations();
      this.set('isValid', valid);
      return valid;
    },
    validateWarnings: function() {
      this.flushValidationWarnings();
      if (this.get('processWarnings')) {
        return this.executeCustomWarnings();
      }
    },
    executeCustomValidations: function() {
      var isValid, options, vName, valid, validator, _i, _len, _ref;
      valid = true;
      if ((this.get('validations') != null) && this.get('validations') !== "") {
        _ref = this.get('validations').split(',');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          vName = _ref[_i];
          isValid = true;
          validator = Tent.Validations.get(vName.trim());
          if (!(validator != null)) {
            throw new Error('Validator [' + vName + '] cannot be found');
          }
          options = this.parseCustomValidationOptions(vName);
          isValid = isValid && validator.validate(this.get('formattedValue'), options, null, this);
          if (!isValid) {
            this.addValidationError(validator.getErrorMessage(this.get('formattedValue'), options));
            valid = isValid;
          }
        }
      }
      return valid;
    },
    executeCustomWarnings: function() {
      var isValid, options, valid, validator, wName, _i, _len, _ref;
      valid = true;
      if ((this.get('warnings') != null) && this.get('warnings') !== "") {
        _ref = this.get('warnings').split(',');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          wName = _ref[_i];
          isValid = true;
          validator = Tent.Validations.get(wName.trim());
          if (!(validator != null)) {
            throw new Error('Validator [' + wName + '] cannot be found');
          }
          options = this.parseCustomValidationOptions(wName);
          isValid = isValid && validator.validate(this.get('formattedValue'), options, null, this);
          if (!isValid) {
            this.addValidationWarning(validator.getErrorMessage(this.get('formattedValue'), options));
            valid = isValid;
          }
        }
      }
      return valid;
    },
    parseCustomValidationOptions: function(vName) {
      if (this.get('validationOptions') != null) {
        if (typeof this.get('validationOptions') === 'string') {
          return eval("(" + this.get('validationOptions') + ")")[vName];
        } else {
          return this.get('validationOptions')[vName];
        }
      }
      return null;
    },
    errorsDidChange: (function() {
      return this.updateErrorPanel();
    }).observes('validationErrors.@each'),
    warningsDidChange: (function() {
      return this.updateWarningPanel();
    }).observes('validationWarnings.@each'),
    updateErrorPanel: function() {
      var message;
      message = Tent.Message.create({
        messages: $.merge([], this.get('validationErrors')),
        type: Tent.Message.ERROR_TYPE,
        sourceId: this.get('elementId'),
        label: this.get('label')
      });
      return $.publish("/message", [message]);
    },
    updateWarningPanel: function() {
      var message;
      message = Tent.Message.create({
        messages: $.merge([], this.get('validationWarnings')),
        type: Tent.Message.WARNING_TYPE,
        sourceId: this.get('elementId'),
        label: this.get('label'),
        severity: this.get('warningseverity')
      });
      return $.publish("/message", [message]);
    },
    hasErrors: (function() {
      return !this.get('isValid');
    }).property('isValid'),
    hasWarnings: (function() {
      return this.get('validationWarnings').length > 0;
    }).property('validationWarnings', 'validationWarnings.@each'),
    observesErrors: (function() {
      var classNames;
      classNames = this.get('classNames');
      if (classNames != null) {
        if (this.get('hasErrors')) {
          if (!classNames.contains('error')) {
            return classNames[classNames.length] = 'error';
          }
        } else {
          return classNames.removeObject('error');
        }
      }
    }).observes('hasErrors'),
    observesWarnings: (function() {
      var classNames;
      classNames = this.get('classNames');
      if (classNames != null) {
        if (this.get('hasWarnings')) {
          if (this.$('') != null) {
            this.$('').addClass('warning');
          }
          if (!classNames.contains('warning')) {
            return classNames[classNames.length] = 'warning';
          }
        } else {
          if (this.$('') != null) {
            this.$('').removeClass('warning');
          }
          return classNames.removeObject('warning');
        }
      }
    }).observes('validationWarnings', 'validationWarnings.@each'),
    flushValidationErrors: function() {
      this.set('validationErrors', []);
      return this.set('isValid', true);
    },
    flushValidationWarnings: function() {
      return this.set('validationWarnings', []);
    },
    addValidationError: function(error) {
      if (typeof error === "string") {
        error = Tent.I18n.loc(error);
      }
      this.get('validationErrors').pushObject(error);
      return this.set('isValid', false);
    },
    addValidationWarning: function(warning) {
      if (typeof warning === "string") {
        warning = Tent.I18n.loc(warning);
      }
      return this.get('validationWarnings').pushObject(warning);
    }
  });

}).call(this);



/**
 * @class Tent.MandatorySupport
 * Some docs here...
*/


(function() {
Tent.MandatorySupport = Ember.Mixin.create({
    /**
    	* @property {Boolean} required Boolean property to determine whether a value must be provided
    */

    required: false,
    requiredAsBoolean: Tent.computed.boolCoerceGently('required'),
    validate: function() {
      var isRequired, isValid, value;
      isValid = this._super();
      value = this.get('valueForMandatoryValidation');
      isRequired = (!this.get('required') && !this.get('isMandatory')) || (!this.isValueEmpty(value));
      if (!isRequired) {
        this.addValidationError(Tent.messages.REQUIRED_ERROR);
      }
      return isValid && isRequired;
    },
    isValueEmpty: function(value) {
      return !((value != null) && value !== '' && (value.length != null ? value.length > 0 : true));
    }
  });

}).call(this);



/**
* @class Tent.SerializerSupport.
*
* The host applications Model may apply serialization transforms on this field type. Where   
* this field is not bound to a model, SerializerSupport can apply those transforms explicitly.
* Set the {@link #serializer} property to and object that implements the {@link #from} and 
* {@link #to} methods.
*
*/


(function() {

  Tent.SerializerSupport = Ember.Mixin.create({
    serializer: null,
    deserialize: function(serialized) {
      if (this.get('serializer')) {
        return this.get('serializer').deserialize(serialized);
      } else {
        return serialized;
      }
    },
    serialize: function(deserialized) {
      if (this.get('serializer')) {
        return this.get('serializer').serialize(deserialized);
      } else {
        return deserialized;
      }
    },
    serializedValue: (function(key, value) {
      if (arguments.length === 1) {
        return this.serialize(this.get('value'));
      } else {
        return this.set('value', this.deserialize(value));
      }
    }).property('value')
  });

}).call(this);



/**
* @class Tent.FieldSupport
* @mixins Tent.SpanSupport
* @mixins Tent.ValidationSupport
* @mixins Tent.VisibilitySupport
* @mixins Tent.MandatorySupport
* 
* This mixin provides all of the basic properties and behaviors for a form field view
*/


(function() {
Tent.FieldSupport = Ember.Mixin.create(Tent.SpanSupport, Tent.ValidationSupport, Tent.VisibilitySupport, Tent.MandatorySupport, {
    /**
    * @property {Boolean} [textDisplay=false]
    * When set to true, the formatted value of the widget will be displayed, 
    * rather than the widget itself.
    */

    textDisplay: false,
    /**
    * @property {String} label The label for the field.
    */

    label: "",
    /**
    * @property {String} value The current value of the field.
    */

    value: null,
    /**
    * @property {String} formattedValue The current value of the field in its formatted form.
    */

    formattedValue: null,
    /**
    * @property serializedValue If a {@link serializer} has been defined, this will contain the serialized
    * value. If this value is set, a deserialized version of it will be set on the 'value' property
    */

    serializedValue: null,
    /**
      * @property {String} [readOnly=false] A boolean indicating that the field is read-only.
      * Although this allows the user to interact with the field (highlight, copy etc), they are not able to change
      * its value.
    */

    readOnly: false,
    /**
      * @property {String} [disabled=false] A boolean indicating that the field is disabled.
      * When disabled, the user is prevented from interacting with the field. In addition, if the field 
      * is tied to a form, its value will not be included in the form submission
    */

    disabled: false,
    /**
      * @property {String} placeholder A block of descriptive text to display in the field, usually hint as to the expected content.
      * The placeholder will not be recognised as a value, and will be hidden when text is entered into the field.
    */

    placeholder: null,
    /**
    * @property {String} helpBlock A block of text which provides additional help for completing the field
    */

    helpBlock: null,
    fieldClass: 'field',
    mixinClasses: 'control-group',
    classNames: ['tent-widget'],
    classNameBindings: ['mixinClasses', 'requiredAsBoolean:required', 'isHidden:hidden', 'isViewOnly:view-only', 'hasErrors:error', 'spanClass'],
    /**
    * @property {Boolean} [isEditable=true] A boolean value indicating whether the field is editable
    */

    isEditable: true,
    isEditableAsBoolean: Tent.computed.boolCoerceGently('isEditable'),
    isViewOnly: Ember.computed.not('isEditableAsBoolean'),
    /**
    * @property {Boolean} [hasPrefix=false] A boolean indicating whether a prefix should be displayed before the value
    */

    hasPrefix: false,
    /**
    * @property {String} prefix A string value to display as the prefix
    */

    prefix: null,
    translatedPlaceholder: (function() {
      return Tent.I18n.loc(this.get('placeholder'));
    }).property('placeholder'),
    isTextDisplay: (function() {
      return this.get('textDisplay') || (!this.get('isEditable'));
    }).property('textDisplay', 'isEditable'),
    forId: (function() {
      return this.get('inputIdentifier');
    }).property('inputIdentifier'),
    errorId: (function() {
      return this.get('elementId') + "_error";
    }).property('elementId'),
    helpId: (function() {
      return this.get('elementId') + "_help";
    }).property('elementId'),
    inputSizeClass: (function() {
      return 'input-medium';
    }).property(),
    widthExpectation: (function() {
      var fieldSize, formStyle;
      formStyle = this.get('form.formStyle');
      fieldSize = Tent.FieldSupport.SIZE_MAP[this.get('inputSizeClass')];
      if (formStyle === 'horizontal') {
        return fieldSize + 150;
      } else {
        return Math.max(fieldSize, 150);
      }
    }).property('form'),
    form: (function() {
      if (this.$() != null) {
        return Ember.View.views[this.$().closest('form').attr('id')];
      }
    }).property(),
    enableWarningProcessing: (function() {
      return this.set('processWarnings', true);
    }).observes('value'),
    focus: function() {
      return $('#' + this.get('inputIdentifier')).focus();
    },
    validateField: function() {
      var unformatted;
      this.set('isValid', this.validate());
      if (this.get('isValid')) {
        unformatted = this.unFormat(this.get('formattedValue'));
        this.set('value', unformatted);
        this.set('formattedValue', this.format(unformatted));
        return this.validateWarnings();
      }
    },
    resize: function() {
      this._super();
      return this.estimateFormStyle();
    },
    clear: function() {
      return this.set('value', null);
    },
    didInsertElement: function() {
      this._super();
      return this.estimateFormStyle();
    },
    estimateFormStyle: function() {},
    unEditableClass: (function() {
      if (!this.get('isEditable')) {
        return 'uneditable-input';
      }
    }).property('isEditable')
  });

  Tent.FieldSupport.SIZE_CLASSES = ['input-mini', 'input-small', 'input-mini', 'input-medium', 'input-large', 'input-xlarge', 'input-xlarge', 'input-xlarge', 'input-xxlarge', 'input-xxlarge', 'input-xxlarge', 'input-xxlarge'];

  Tent.FieldSupport.SIZE_MAP = {
    'input-mini': 60,
    'input-small': 90,
    'input-medium': 150,
    'input-large': 210,
    'input-xlarge': 270,
    'input-xxlarge': 530
  };

}).call(this);



/**
 * @class Tent.FormattingSupport 
 * Allows the 'value' property of the view to be bound to a controller while
 * displaying the 'formattedValue' in the DOM
 * The format() and unFormat() methods, which should be overridedn by your view class, 
 * define the data transformation between the value and formatted value
 * Note that all validation will be executed against the 'value' property
*/


(function() {

  Tent.FormattingSupport = Ember.Mixin.create({
    init: function() {
      this._super();
      return this.set("formattedValue", this.format(this.get("value")));
    },
    valueDidChange: (function() {
      return this.set("formattedValue", this.format(this.get("value")));
    }).observes("value"),
    format: function(value) {
      return this.trimValue(value);
    },
    unFormat: function(value) {
      return value;
    },
    trimValue: function(value) {
      if (value) {
        return value.trim();
      }
    }
  });

}).call(this);



/**
 * @class Tent.TooltipSupport
 * Some docs here...
*/


(function() {

  Tent.TooltipSupport = Ember.Mixin.create({
    /**
    	* @property {String} tooltip A detailed information message presented as a hover-icon beside the field
    */

    tooltip: null,
    didInsertElement: function() {
      this._super();
      return this.$("a[rel=tooltip]").tooltip();
    },
    tooltipT: (function() {
      return Tent.I18n.loc(this.get('tooltip'));
    }).property('tooltip')
  });

}).call(this);


(function() {

  Tent.Constants = Ember.Object.create({
    OPERATOR_BEGINS_WITH: "begin",
    OPERATOR_CONTAINS: "contain",
    OPERATOR_LIKE: "like",
    OPERATOR_EQUALS: "eql",
    OPERATOR_NOT_EQUALS: "not",
    OPERATOR_LESS_THAN: "lt",
    OPERATOR_GREATER_THAN: "gt",
    OPERATOR_LESS_THAN_EQUALS: "lte",
    OPERATOR_GREATER_THAN_EQUALS: "gte",
    OPERATOR_RANGE: "range"
  });

}).call(this);


(function() {
/**
  * @class Tent.FilteringSupport 
  * Allows widgets to participate in filter panels, and provides them with a range of 
  * comparison operators
  */


  Tent.FilteringSupport = Ember.Mixin.create({
    isFilter: false,
    filterOp: null,
    operators: [
      Ember.Object.create({
        label: "tent.filter.beginsWith",
        operator: Tent.Constants.get('OPERATOR_BEGINS_WITH')
      }), Ember.Object.create({
        label: "tent.filter.contains",
        operator: Tent.Constants.get('OPERATOR_CONTAINS')
      }), Ember.Object.create({
        label: "tent.filter.equal",
        operator: Tent.Constants.get('OPERATOR_EQUALS')
      }), Ember.Object.create({
        label: "tent.filter.nEqual",
        operator: Tent.Constants.get('OPERATOR_NOT_EQUALS')
      }), Ember.Object.create({
        label: "tent.filter.like",
        operator: Tent.Constants.get('OPERATOR_LIKE')
      })
    ],
    init: function() {
      return this._super(arguments);
    },
    didInsertElement: function() {
      return this._super();
    },
    filterSelection: (function() {
      var filterOp, selectedOperators;
      filterOp = this.get('filterOp');
      selectedOperators = this.get('operators').filter(function(item) {
        return item.get('operator') === filterOp;
      });
      if (selectedOperators.length === 1) {
        return selectedOperators[0];
      }
    }).property('filterOp'),
    isRangeOperator: (function() {
      var currentFilterOperator;
      currentFilterOperator = this.get('filterOp');
      return currentFilterOperator === 'range';
    }).property('filterOp'),
    observeFilterOp: (function() {
      var op;
      if (((op = this.get('filterOp')) != null) && !op.isBlank() && (this.get('operators') != null)) {
        return this.set('selectedOperator', this.get('operators').findProperty('operator', op));
      }
    }).observes('filterOp')
  });

}).call(this);



/**
 * @class Tent.AriaSupport
 * Some docs here...
*/


(function() {

  Tent.AriaSupport = Ember.Mixin.create({
    attributeBindings: ['ariaRequired:aria-required', 'ariaReadOnly:aria-readonly', 'ariaDisabled:aria-disabled', 'ariaDescribedBy:aria-describedby', 'ariaInvalid:aria-invalid'],
    ariaRequired: (function() {
      if (this.get('parentView.required')) {
        return 'true';
      } else {
        return 'false';
      }
    }).property('parentView.required'),
    ariaReadOnly: (function() {
      if (this.get('parentView.readOnly')) {
        return 'true';
      } else {
        return 'false';
      }
    }).property('parentView.readOnly'),
    ariaDisabled: (function() {
      if (this.get('parentView.disabled')) {
        return 'true';
      } else {
        return 'false';
      }
    }).property('parentView.disabled'),
    ariaDescribedBy: (function() {
      return this.get('parentView.errorId') + " " + this.get('parentView.helpId');
    }).property('parentView.errorId'),
    ariaInvalid: (function() {
      if (this.get('parentView.hasErrors')) {
        return 'true';
      } else {
        return 'false';
      }
    }).property('parentView.hasErrors')
  });

}).call(this);



/**
 * @class Tent.ReadonlySupport
 * Some docs here...
*/


(function() {

  Tent.ReadonlySupport = Ember.Mixin.create({
    attributeBindings: ['readOnly:readonly'],
    readOnly: (function() {
      if (this.get('parentView.readOnly') || this.get('parentView.isReadOnly')) {
        return true;
      } else {
        return false;
      }
    }).property('parentView.readOnly', 'parentView.isReadOnly')
  });

}).call(this);



/**
 * @class Tent.DisabledSupport
 * Some docs here...
*/


(function() {

  Tent.DisabledSupport = Ember.Mixin.create({
    attributeBindings: ['disabled'],
    disabledBinding: 'parentView.disabled'
  });

}).call(this);



/**
 * @class Tent.Html5Support
 * Some docs here...
*/


(function() {

  Tent.Html5Support = Ember.Mixin.create({
    attributeBindings: ['required'],
    required: (function() {
      return this.get('parentView.required');
    }).property('parentView.required')
  });

}).call(this);


Ember.TEMPLATES['text_field']=Ember.Handlebars.compile("<label class=\"control-label\" {{bindAttr for=\"view.forId\"}}>{{loc view.label}}\n  <span class='tent-required'></span>\n</label>\n<div class=\"controls\">\n  {{#if view.isFilter}}\n    {{#if view.operators}}\n      {{view Tent.Select \n        label=\"tent.filter.operatorLabel\"\n        listBinding=\"view.operators\" \n        class=\"embed no-label operators\" \n        optionLabelPath=\"content.label\"\n        optionValuePath=\"content.operator\"\n        selectionBinding=\"view.filterSelection\"\n        valueBinding=\"view.filterOp\"\n        selectionBinding=\"view.selectedOperator\"\n        advanced=false\n        prompt=\"tent.filter.operatorPrompt\"\n        disabledBinding=\"view.disabled\"\n        required=true\n        isValidBinding=\"view.operatorsIsValid\"\n      }}\n    {{/if}}\n  {{/if}}\n  <div class=\"input-prepend\">\n    {{#if view.isTextDisplay}}\n      <span class=\"text-display\">{{#if view.hasPrefix}}<span class=\"prefix\">{{loc view.prefix}}</span>{{/if}}{{view.formattedValue}}</span>\n    {{else}}\n      {{#if view.hasPrefix}}  \n        <span class=\"add-on\">{{view.prefix}}</span>\n      {{/if}} \n      {{view Tent.TextFieldInput \n        valueBinding=\"view.formattedValue\" \n        placeholderBinding=\"view.translatedPlaceholder\"\n        classBinding=\"view.fieldClass\"\n        typeBinding=\"view.type\"\n      }}\n\n      {{#if view.isRangeOperator}}\n        {{#unless view.hasOwnRangeDisplay}}\n          {{view Tent.TextFieldInput \n            valueBinding=\"view.value2\" \n            placeholderBinding=\"view.translatedPlaceholder\"\n            classBinding=\"view.controlClass\"\n            classNames=\"range-end\"\n            typeBinding=\"view.type\"\n          }}\n        {{/unless}}\n      {{/if}}\n      {{#if view.hasParsedValue}}\n        <span class=\"help-inline\">{{view.parsedValue}}</span>\n      {{/if}} \n      {{#if view.hasHelpBlock}}\n        <span class=\"help-block\" {{bindAttr id=\"view.helpId\"}}>{{loc view.helpBlock}}</span>\n      {{/if}}\n    {{/if}}\n    {{#if view.hasErrors}}\n      <ul class=\"help-inline\" {{bindAttr id=\"view.errorId\"}}>{{#each error in view.validationErrors}}<li>{{loc error}}</li>{{/each}}</ul>\n    {{/if}}  \n    {{#if view.hasWarnings}}\n      <ul class=\"help-inline warning\" {{bindAttr id=\"view.warningId\"}}>{{#each warning in view.validationWarnings}}<li>{{loc warning}}</li>{{/each}}</ul>\n    {{/if}}  \n\n  </div>\n  {{#if view.tooltip}}\n    <a href=\"#\" rel=\"tooltip\" data-placement=\"right\" {{bindAttr data-original-title=\"view.tooltipT\"}}></a>\n  {{/if}}\n\n</div>\n");


/**
 * @class Tent.TextField
 * @mixins Tent.FormattingSupport
 * @mixins Tent.FieldSupport
 * @mixins Tent.TooltipSupport
 * Usage 
 *       {{view Tent.TextField 
          valueBinding="Pad.appName" 
          label="Focused input" 
          placeholder="Type here.." 
          tooltip="Provide some information here" 
         }}
 *
*/


(function() {
Tent.TextField = Ember.View.extend(Tent.FormattingSupport, Tent.FieldSupport, Tent.TooltipSupport, Tent.FilteringSupport, {
    templateName: 'text_field',
    classNames: ['tent-text-field', 'control-group'],
    operatorsIsValid: true,
    /**
    * @property {String} controlClass Additional classes to be added to the input field (not added to the wrapping elements)
    */

    controlClass: '',
    /**
    * @property {String} type The type of the input element ('text', 'password' etc)
    */

    type: 'text',
    didInsertElement: function() {
      this._super(arguments);
      return this.set('inputIdentifier', this.$('input').attr('id'));
    },
    valueForMandatoryValidation: (function() {
      return this.get('formattedValue');
    }).property('formattedValue'),
    trimmedValue: (function() {
      return this.trimValue(this.get('value'));
    }).property('value'),
    focusOut: function() {
      var fieldValue;
      fieldValue = $('#' + this.get('inputIdentifier')).val();
      if (fieldValue === '' || fieldValue === this.get('translatedPlaceholder')) {
        return this.validateField();
      }
    },
    change: function() {
      this._super(arguments);
      return this.validateField();
    },
    fieldClass: (function() {
      return this.get('controlClass') + " primary-class";
    }).property('controlClass')
  });

  Tent.TextFieldInput = Ember.TextField.extend(Tent.AriaSupport, Tent.Html5Support, Tent.ReadonlySupport, Tent.DisabledSupport);

}).call(this);



/**
* @class Tent.Tag
* A single tag item
* Usage
*      {{view Tent.Tag text="Important"}}
*/


(function() {

  Tent.Tag = Ember.View.extend({
    tagName: 'span',
    /**
    * @property {String} [type=info] The type of tag to display
    */

    type: 'info',
    classNameBindings: ['labelClasses'],
    labelClasses: (function() {
      return 'label ' + 'label-' + this.get('type');
    }).property('type'),
    template: Ember.Handlebars.compile('{{view.text}}'),
    init: function() {
      var classNames, type;
      this._super();
      type = this.get('type');
      classNames = this.get('classNames');
      if (type) {
        return classNames.push('label-' + type);
      }
    }
  });

}).call(this);


(function() {
Tent.FilteringRangeSupport = Ember.Mixin.create(Tent.SerializerSupport, {
    operators: [
      Ember.Object.create({
        label: "tent.filter.equal",
        operator: Tent.Constants.get('OPERATOR_EQUALS')
      }), Ember.Object.create({
        label: "tent.filter.nEqual",
        operator: Tent.Constants.get('OPERATOR_NOT_EQUALS')
      }), Ember.Object.create({
        label: "tent.filter.lThan",
        operator: Tent.Constants.get('OPERATOR_LESS_THAN')
      }), Ember.Object.create({
        label: "tent.filter.lThanEq",
        operator: Tent.Constants.get('OPERATOR_LESS_THAN_EQUALS')
      }), Ember.Object.create({
        label: "tent.filter.gThan",
        operator: Tent.Constants.get('OPERATOR_GREATER_THAN')
      }), Ember.Object.create({
        label: "tent.filter.gThanEq",
        operator: Tent.Constants.get('OPERATOR_GREATER_THAN_EQUALS')
      }), Ember.Object.create({
        label: "tent.filter.like",
        operator: Tent.Constants.get('OPERATOR_LIKE')
      }), Ember.Object.create({
        label: "tent.filter.contains",
        operator: Tent.Constants.get('OPERATOR_CONTAINS')
      }), Ember.Object.create({
        label: "tent.filter.range",
        operator: Tent.Constants.get('OPERATOR_RANGE')
      })
    ],
    /**
    * @property {Array} rangeValue The value containing the range array if a range operator is selected while filtering
    * If no range operator is selected, this property will just return the normal value.
    *
    */

    rangeValue: (function(key, value) {
      var strVal, value2, _ref, _ref1;
      if (arguments.length === 1) {
        if (this.get('isRangeOperator') && (this.get('value2') != null)) {
          value = this.serialize((_ref = this.get('value')) != null ? _ref.toString().replace(/,/, '') : void 0);
          value2 = this.serialize((_ref1 = this.get('value2')) != null ? _ref1.toString().replace(/,/, '') : void 0);
          return "" + value + "," + value2;
        } else {
          return this.serialize(this.get('value'));
        }
      } else {
        if (value != null) {
          strVal = "" + value;
          if (strVal.search(/,/) > 0) {
            this.set('value', this.deserialize(parseInt(strVal.split(',')[0])));
            return this.set('value2', this.deserialize(parseInt(strVal.split(',')[1])));
          } else {
            return this.set('value', this.deserialize(value));
          }
        }
      }
    }).property('value', 'value2', 'isRangeOperator')
  });

}).call(this);



/**
* @class Tent.NumericTextField
* @extends Tent.TextField
* Usage
*       {{view Tent.NumericTextField label="" 
			valueBinding="" 
			dateFormat=""
         }}
*/


(function() {
Tent.NumericTextField = Tent.TextField.extend(Tent.FilteringRangeSupport, Tent.SerializerSupport, {
    /**
    	* @property serializer An object which implements serialize() and deserialize(). It will be applied
    	* to the value and available on the {@link serializedValue} property
    */

    serializer: null,
    validate: function() {
      var didOtherValidationPass, isValidNumber, value;
      didOtherValidationPass = this._super();
      value = this.get('formattedValue');
      isValidNumber = this.isValueEmpty(value) || Tent.Formatting.number.isValidNumber(value);
      if (!isValidNumber) {
        this.addValidationError(Tent.messages.NUMERIC_ERROR);
      }
      if (didOtherValidationPass && isValidNumber) {
        this.validateWarnings();
      }
      return didOtherValidationPass && isValidNumber;
    },
    validateWarnings: function() {
      return this._super();
    },
    isValueEmpty: function(value) {
      return !((value != null) && value !== '');
    },
    format: function(value) {
      return Tent.Formatting.number.format(value);
    },
    unFormat: function(value) {
      return Tent.Formatting.number.unformat(value);
    }
  });

}).call(this);



/**
 * @class Tent.CurrencySupport
 * To get the centesimal value of a currency use the property 'centesimalValue'
 * To get the ISO name of a currency use the property 'name'
*/


(function() {
Tent.CurrencySupport = Ember.Mixin.create({
    centesimalValue: (function() {
      if (this.get('currency')) {
        if (this.get('isValidCurrency')) {
          return Tent.CURRENCIES_ISO_4217[this.get('currency')].cent;
        }
      }
    }).property('currency'),
    name: (function() {
      if (this.get('currency')) {
        if (this.get('isValidCurrency')) {
          return Tent.CURRENCIES_ISO_4217[this.get('currency')].name;
        }
      }
    }).property('currency'),
    isValidCurrency: (function() {
      return Tent.CURRENCIES_ISO_4217[this.get('currency')] != null;
    }).property('currency')
  });

}).call(this);



/**
* @class Tent.AmountField
* @extends Tent.TextField
* 
* ##Usage
*
*       {{view Tent.AmountField valueBinding="" 
          label="" 
          currency="" 
          required=false
          readOnly=false
          disabled=false 
          textDisplayBinding=false
          tooltip=""
        }}
*/


(function() {
Tent.AmountField = Tent.TextField.extend(Tent.CurrencySupport, Tent.FilteringRangeSupport, Tent.SerializerSupport, {
    hasPrefix: true,
    hasHelpBlock: false,
    placeholder: accounting.settings.number.pattern,
    validAmountExp: /^(\-|\+)?(\d+\,?\d+)*\.?\d+$/,
    validations: 'positive',
    /**
    * @property serializer An object which implements serialize() and deserialize(). It will be applied
    * to the value and available on the {@link serializedValue} property
    */

    serializer: null,
    prefix: (function() {
      if (this.get('currency')) {
        return Tent.I18n.loc(this.get('currency'));
      } else {
        return '...';
      }
    }).property('currency'),
    validate: function() {
      var didOtherValidationPass, formattedValue, isValidCurrency;
      this.set('formattedValue', Tent.Formatting.amount.cleanup(this.get('formattedValue')));
      didOtherValidationPass = this._super();
      formattedValue = this.get('formattedValue');
      isValidCurrency = this.get('isValidCurrency');
      if (!isValidCurrency) {
        this.addValidationError(Tent.messages.CURRENCY_ERROR);
      }
      if (isValidCurrency && didOtherValidationPass) {
        this.validateWarnings();
      }
      return isValidCurrency && didOtherValidationPass;
    },
    validateWarnings: function() {
      return this._super();
    },
    format: function(value) {
      return Tent.Formatting.amount.format(value, this.get('centesimalValue'));
    },
    unFormat: function(value) {
      return Tent.Formatting.amount.unformat(value);
    },
    observeCurrencyForValidationAndFormatting: (function() {
      this.get('validationErrors').removeObject(Tent.I18n.loc(Tent.messages.CURRENCY_ERROR));
      if (this.get('isValidCurrency')) {
        if (!this.get('validationErrors').length) {
          this.set('isValid', true);
        }
        this.set('formattedValue', this.format(this.get('formattedValue')));
        return this.set('value', this.unFormat(this.get('formattedValue')));
      } else {
        return this.addValidationError(Tent.messages.CURRENCY_ERROR);
      }
    }).observes('currency'),
    inputSizeClass: (function() {
      return Tent.AmountField.SIZE_CLASSES[this.estimateSpan() - 1];
    }).property()
  });

  Tent.AmountField.SIZE_CLASSES = ['input-mini', 'input-mini', 'input-mini', 'input-small', 'input-medium', 'input-large', 'input-xlarge', 'input-xlarge', 'input-xlarge', 'input-xxlarge', 'input-xxlarge', 'input-xxlarge'];

}).call(this);


Ember.TEMPLATES['table']=Ember.Handlebars.compile("<thead>\n\t{{#if view.isEditable}}\n    {{#if view.multiselection}} \n      <th>\n        {{view Ember.Checkbox nameBinding=\"view.elementId\" checkedBinding=\"view.allSelected\"}}\n      </th>\n    {{else}}\n      <th></th>\n    {{/if}} \n  {{/if}}\n\t{{collection contentBinding=\"view.visibleHeaders\" itemViewClass=\"Tent.TableHeader\"}}\n</thead>\n{{collection contentBinding=\"view.list\" tagName=\"tbody\" itemViewClass=\"Tent.TableRow\"}}");

Ember.TEMPLATES['table_row']=Ember.Handlebars.compile("{{#if view.parentTable.isEditable}}\n  {{#if view.parentTable.multiselection}}\n    <td class=\"tent-width-small\">\n      {{view Ember.Checkbox nameBinding=\"view.parentTable.elementId\" valueBinding=\"{{view.elementId}}\"}}\n    </td>\n  {{else}}\n    <td class=\"tent-width-small\">\n\t  <input type='radio' {{bindAttr name=\"view.parentTable.elementId\" value=\"{{view.elementId}}\"}}>\n    </td>\n  {{/if}}\n{{/if}}\n{{collection contentBinding=\"view.parentTable.visibleColumns\" itemViewClass=\"Tent.TableCell\"}}\n\n");

(function() {
Tent.Table = Ember.View.extend({
    classNames: ['table', 'table-condensed'],
    classNameBindings: ['isBordered:table-bordered'],
    tagName: 'table',
    templateName: 'table',
    isBordered: true,
    _columnHeaders: (function() {
      if (this.get('headers') != null) {
        return this.get('headers').split(',');
      }
    }).property('headers'),
    visibleHeaders: (function() {
      return this.get('_columnHeaders');
    }).property('_columnHeaders'),
    _columns: (function() {
      if (this.get('columns') != null) {
        return this.get('columns').split(',');
      }
    }).property('columns'),
    visibleColumns: (function() {
      return this.get('_columns');
    }).property('_columns'),
    init: function() {
      this._super();
      if (this.get('multiselection') === void 0) {
        this.set('multiselection', false);
      }
      if (this.get('isEditable') === void 0) {
        this.set('isEditable', true);
      }
      if (!(this.get('_list') != null)) {
        return this.createListProxy();
      }
    },
    createListProxy: function() {
      this.set('_list', Tent.SelectableArrayProxy.create({
        content: this.get('list')
      }));
      return this.get('_list').set('isMultipleSelectionAllowed', this.get('multiselection') || this.get('context.multiselection'));
    },
    isRowSelected: function(row) {
      var rowContent, selElements;
      if ((selElements = this.get('_list').get('selected')) !== null) {
        rowContent = row.get('content');
        if (selElements.contains(rowContent)) {
          return true;
        }
        return selElements.some(function(element) {
          var elementId, rowId;
          if (element === rowContent) {
            return true;
          }
          elementId = Ember.get(element, 'id');
          rowId = Ember.get(rowContent, 'id');
          if ((elementId != null) && (rowId != null)) {
            return elementId === rowId;
          }
          return false;
        });
      } else {
        return false;
      }
    },
    select: function(selection) {
      var element, prevSelection, _i, _j, _len, _len1, _results;
      if (selection && selection instanceof Array) {
        prevSelection = this.get('_list.selected');
        if (prevSelection) {
          for (_i = 0, _len = prevSelection.length; _i < _len; _i++) {
            element = prevSelection[_i];
            this.select(element);
          }
        }
        if (selection) {
          _results = [];
          for (_j = 0, _len1 = selection.length; _j < _len1; _j++) {
            element = selection[_j];
            _results.push(this.select(element));
          }
          return _results;
        }
      } else {
        if (!(this.get('_list') != null)) {
          this.createListProxy();
        }
        return this.get('_list').set('selected', selection);
      }
    },
    selectAll: (function() {
      if (this.get('allSelected')) {
        return this.get('_list').selectAll();
      } else {
        return this.get('_list').clearSelection();
      }
    }).observes('allSelected'),
    updateContent: (function() {
      return this.get('_list').set('content', this.get('list'));
    }).observes('list'),
    selection: (function(key, value) {
      if (value !== void 0) {
        return this.select(value);
      } else {
        return this.get('_list.selected');
      }
    }).property('_list.selected')
  });

  Tent.TableRow = Ember.View.extend({
    tagName: 'tr',
    templateName: 'table_row',
    classNameBindings: ['isSelected:tent-selected'],
    parentTableBinding: 'parentView.parentView',
    didInsertElement: function() {
      if (this.get('parentTable').get('isEditable')) {
        return this.checkSelection();
      }
    },
    format: function(columnName, columnValue) {
      var formatter, formatterProvider, tableContent;
      if ((formatterProvider = this.get('parentTable.formatter')) != null) {
        tableContent = this.get('parentTable.list');
        formatter = formatterProvider(tableContent, columnName);
        if (formatter != null) {
          return formatter.format(columnValue);
        }
      }
      return columnValue;
    },
    cssClass: function(columnName) {
      var formatter, formatterProvider, tableContent;
      if ((formatterProvider = this.get('parentTable.formatter')) != null) {
        tableContent = this.get('parentTable.list');
        formatter = formatterProvider(tableContent, columnName);
        if ((formatter != null) && (formatter.cssClass != null)) {
          return formatter.cssClass();
        }
      }
      return "";
    },
    isSelected: (function() {
      return this.get('parentTable').isRowSelected(this);
    }).property('parentTable.selection'),
    checkSelection: (function() {
      if (this.get('isSelected')) {
        return this.$('input').prop('checked', true);
      } else {
        return this.$('input').prop('checked', false);
      }
    }).observes('isSelected'),
    mouseUp: function(event) {
      if (this.get('parentTable').get('isEditable')) {
        this.get('parentTable').select(this.get('content'));
      }
      return this.$("input").click(function(event) {
        if ($(this).prop('checked')) {
          $(this).prop('checked', false);
        }
        if (event.target === this) {
          return false;
        }
      });
    }
  });

  Tent.TableCell = Ember.View.extend({
    tagName: 'td',
    classNameBindings: ['isRadio:tent-width-small', 'cssClass'],
    defaultTemplate: Ember.Handlebars.compile('{{view.formattedColumnValue}}'),
    row: (function() {
      return this.get('parentView').get('parentView');
    }).property('parentView'),
    formattedColumnValue: (function() {
      var columnName, columnValue;
      columnName = this.get('content');
      columnValue = this.get('row.content.' + columnName);
      return this.get('row').format(columnName, columnValue);
    }).property('row', 'content'),
    cssClass: (function() {
      var columnName, row;
      columnName = this.get('content');
      row = this.get('row');
      return row.cssClass(columnName);
    }).property('row', 'content')
  });

  Tent.TableHeader = Ember.View.extend({
    tagName: 'th',
    defaultTemplate: Ember.Handlebars.compile('{{view.printableColumnName}}'),
    printableColumnName: (function() {
      var columnName;
      columnName = Tent.I18n.loc(this.get('content'));
      if (typeof columnName === 'string') {
        return columnName.camelToWords();
      }
    }).property('content')
  });

}).call(this);


Ember.TEMPLATES['jqgrid']=Ember.Handlebars.compile("{{#if view.content.isLoadable}}\n  {{#unless view.content.isLoaded}}\n    {{view Tent.WaitIcon}}\n  {{/unless}}\n{{/if}}\n\n<div class=\"jqgrid-backdrop\" class=\"\"></div>\n\n{{view Tent.JqGridHeaderView gridBinding=\"view\"}}\n\n<div class=\"grid-container\">\n  {{view Tent.FilterPanelView collectionBinding=\"view.collection\" isPinnedBinding=\"view.isPinned\" showFilterBinding=\"view.showFilter\" usageContextBinding=\"view.usageContext\"}}\n\n  <div class=\"table-container\">\n        {{#if view.showMultiview}}\n            {{view Tent.CollectionPanelView \n                collectionBinding=\"view.collection\"\n                contentViewTypeBinding=\"view.cardViewType\"\n                selectionBinding=\"view.selection\"\n                multiSelectBinding=\"view.multiSelect\"\n                isVisibleBinding=\"view.showCardView\"\n                scrollBinding=\"view.scroll\"\n            }} \n           \t{{#if view.showCardView}}\n\t            {{#if view.paged}}\n\t              {{#unless view.scroll}}\n\t                {{view Tent.Pager collectionBinding=\"view.collection\"}}\n\t              {{/unless}}\n\t            {{/if}}\n\t          {{/if}}\n        {{/if}}\n        <div {{bindAttr class=\":visibility-wrapper view.showCardView:hidden\"}}>\n          <table class=\"grid-table\"></table>\n          <div class=\"gridpager\"></div>\n        </div>\n    </div>\n</div>\n\n{{#if view.hasErrors}}\n  <span class=\"help-inline\" {{bindAttr id=\"view.errorId\"}}>{{#each error in view.validationErrors}}{{loc error}}{{/each}}</span>\n{{/if}}\n\n\n\n \n\n");

(function() {

  Tent.Grid = Ember.Namespace.create();

  /**
  * @class Tent.Grid.CollectionSupport
  * 
  * A mixin which allows the use of a collection to provide content and 
  * functionality for a grid
  *
  * The grid will bind to the following properties of the collection:
  *   
  * - columnsDescriptor: an array of descriptor objects defining the columns to be displayed
  *       e.g. [
          {id: "id", name: "id", title: "_hID", field: "id", sortable: true, hideable: false},
          {id: "title", name: "title", title: "_hTitle", field: "title", sortable: true},
          {id: "amount", name: "amount", title: "_hAmount", field: "amount", sortable: true, formatter: "amount",  align: 'right'},
        ]
  * - totalRows: the total number of rows in the entire result set (including pages not visible)
  * - totalPages: The total number of pages of data available
  *
  * The collection should also provide the following methods:
  *
  * - sort(sortdata): Sort the collection according to the sortdata provided
  *       e.g. 
          {fields: [
                sortAsc: true
                field: 'title'
            ]
          }
  *        
  * - goToPage(pageNumber): Navigate to the pagenumber provided (1 = first page)
  *
  */


  Tent.Grid.CollectionSupport = Ember.Mixin.create({
    /**
    * @property {Object} collection The collection object providing the API to the data source
    */

    collection: null,
    /**
    * @property {Boolean} paged Boolean to indicate the data should be presented as a paged list
    */

    paged: false,
    /**
    * @property {Number} pageSize The number of items in each page
    */

    pageSize: null,
    pagingInfoBinding: 'collection.pagingInfo',
    sortingInfoBinding: 'collection.sortingInfo',
    columnInfoBinding: 'collection.columnInfo',
    groupingInfoBinding: 'collection.groupingInfo',
    /**
    * @property {Boolean} scroll A boolean indicating that the grid should scroll vertically rather than paging
    */

    scroll: false,
    init: function() {
      this._super(arguments);
      if (this.get('collection') != null) {
        this.setupCustomizedProperties();
        return this.addScrollPropertyToCollection();
      }
    },
    addScrollPropertyToCollection: (function() {
      if (this.get('collection') != null) {
        return this.set('collection.scroll', this.get('scroll'));
      }
    }).observes('scroll', 'collection'),
    addNavigationBar: function() {
      this._super();
      if (this.get('collection.personalizable') && (this.get('usageContext') !== 'report')) {
        if (this.get('collection') != null) {
          this.renderSaveUIStateButton();
        }
        this.renderCollectionName();
        return this.populateCollectionDropdown();
      }
    },
    renderSaveUIStateButton: function() {
      var button, widget;
      widget = this;
      button = "<div class=\"button-wrapper save-ui-state\">\n  <a data-toggle=\"dropdown\" class=\"button-control\"><i class=\"icon-camera\"></i><span class=\"custom-name\"></span><span class=\"caret\"></span></a>\n  <ul class=\"dropdown-menu\">\n    <li><a class=\"save\">" + (Tent.I18n.loc("tent.button.save")) + "</a></li>\n    <li class=\"dropdown-submenu\">\n      <a>" + (Tent.I18n.loc("tent.button.saveAs")) + "</a>\n      <ul class=\"dropdown-menu save-as-panel\">\n          <p>" + (Tent.I18n.loc("tent.jqGrid.saveUi.message")) + "</p>\n          <p><input type=\"text\" class=\"input-medium keep-open\" value=\"" + (widget.get('collection.customizationName')) + "\"/></p>\n          <div><a class='btn pull-left cancel'>" + (Tent.I18n.loc("tent.button.cancel")) + "</a><a class='btn pull-right saveas'>" + (Tent.I18n.loc("tent.button.save")) + "</a></div>\n      </ul>\n    </li> \n    <li class=\"dropdown-submenu\">\n      <a>" + (Tent.I18n.loc("tent.button.load")) + "</a>\n      <ul class=\"dropdown-menu load-panel\">\n      </ul>\n    </li>  \n  </ul>\n</div>";
      this.$(".grid-header .left").append(button);
      if (Tent.Browsers.isIE()) {
        this.$('.save-ui-state .save-as-panel').mouseleave(function(e) {
          return $('body').focus();
        });
      }
      this.$('.save-ui-state').bind('keyup', (function(e) {
        if (e.keyCode === 27) {
          if (Tent.Browsers.isIE()) {
            $('body').focus();
          }
          return widget.toggleUIStatePanel();
        }
      }));
      this.$('.save-ui-state input').bind('keyup', (function(e) {
        widget.observeValueInput($(this));
        if (e.keyCode === 13) {
          if (Tent.Browsers.isIE()) {
            $('body').focus();
          }
          return widget.saveAs($(this));
        }
      }));
      this.$('.save-ui-state .cancel').click(function() {
        return widget.toggleUIStatePanel();
      });
      this.$('.save-ui-state .save').click(function() {
        if (!$(this).hasClass('disabled')) {
          return widget.save();
        }
      });
      this.$('.save-ui-state .saveas').click(function() {
        if (!$(this).hasClass('disabled') && widget.getInputField().val().trim() !== "") {
          return widget.saveAs($(this));
        }
      });
      return $('.keep-open').click(function(e) {
        return e.stopPropagation();
      });
    },
    renderCollectionName: (function() {
      if ((this.get('collection') != null) && this.get('collection.isCustomizable') && (this.get('collection.customizationName') != null)) {
        this.$(".grid-header .custom-name").text(this.get('collection.customizationName'));
      }
      if (this.get('collection.isShowingDefault')) {
        this.disableSaveButton();
      } else {
        this.enableSaveButton();
      }
      return this.observeValueInput(this.getInputField());
    }).observes('collection.customizationName'),
    populateCollectionDropdown: (function() {
      var index, personalization, _i, _len, _ref,
        _this = this;
      if (this.$() != null) {
        this.$(".load-panel").empty();
        this.$(".load-panel").append('<li><a class="load" data-index="-1">' + Tent.I18n.loc("tent.jqGrid.saveUi.default") + '</a></li>');
        if (this.get('collection.personalizations') != null) {
          _ref = this.get('collection.personalizations').toArray();
          for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
            personalization = _ref[index];
            this.$(".load-panel").append($('<li><a class="load" data-index="' + index + '" data-name="' + personalization.get('name') + '">' + personalization.get('name') + '</a></li>'));
          }
        }
        return this.$(".load-panel .load").click(function(e) {
          var name;
          index = $(e.target).attr('data-index');
          name = $(e.target).attr('data-name');
          _this.set('customizationIndex', index);
          _this.set('customizationName', name);
          return _this.initializeFromCustomizationIndex(index);
        });
      }
    }).observes('collection.personalizations', 'collection.personalizations.@each'),
    getInputField: function() {
      return this.$('.save-ui-state input');
    },
    save: function() {
      this.toggleUIStatePanel();
      this.set('customizationName', this.get('collection.customizationName'));
      return this.saveUiState(this.get('collection.customizationName'));
    },
    saveAs: function(el) {
      this.toggleUIStatePanel();
      this.set('customizationName', el.parents('.save-ui-state').find('input').val());
      return this.saveUiState(this.get('customizationName'));
    },
    toggleUIStatePanel: function() {
      var panel, widget;
      widget = this;
      panel = this.$('.save-ui-state');
      return this.$('.save-ui-state').toggleClass('open');
    },
    saveUiState: function(name) {
      if (this.get('collection') != null) {
        return this.get('collection').saveUIState(name);
      }
    },
    disableSaveButton: function() {
      return this.$('.save-ui-state .save').addClass('disabled');
    },
    enableSaveButton: function() {
      return this.$('.save-ui-state .save').removeClass('disabled');
    },
    observeValueInput: function($input) {
      var input;
      input = $input.val();
      if (!(input != null) || input.trim() === "") {
        return this.disableSaveAsButton();
      } else {
        return this.enableSaveAsButton();
      }
    },
    disableSaveAsButton: function() {
      return this.$('.save-ui-state .saveas').addClass('disabled');
    },
    enableSaveAsButton: function() {
      return this.$('.save-ui-state .saveas').removeClass('disabled');
    },
    setupCustomizedProperties: function() {
      this.setupPagingProperties();
      return this.setupSortingProperties();
    },
    setupPagingProperties: function() {
      return this.setPageSize();
    },
    setPageSize: function() {
      if (this.get('pageSize') != null) {
        this.set('collection.pageSize', this.get('pageSize'));
        if (this.get('pagingInfo') != null) {
          return this.set('pagingInfo.pageSize', this.get('pageSize'));
        }
      }
    },
    setupSortingProperties: function() {},
    setupColumnTitleProperties: function() {
      return this.set('colNames', []);
    },
    setupColumnVisibilityProperties: function() {
      var column, hidden, name, _ref, _results;
      if (this.get('collection.personalizable')) {
        _ref = this.get('columnInfo.hidden');
        _results = [];
        for (name in _ref) {
          hidden = _ref[name];
          _results.push((function() {
            var _i, _len, _ref1, _results1;
            _ref1 = this.get('columnModel');
            _results1 = [];
            for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
              column = _ref1[_i];
              if (column.name === name) {
                _results1.push(column.hidden = hidden);
              } else {
                _results1.push(void 0);
              }
            }
            return _results1;
          }).call(this));
        }
        return _results;
      }
    },
    setupColumnWidthProperties: function() {
      var column, name, width, _ref, _results;
      if (this.get('collection.personalizable')) {
        _ref = this.get('columnInfo.widths');
        _results = [];
        for (name in _ref) {
          width = _ref[name];
          _results.push((function() {
            var _i, _len, _ref1, _results1;
            _ref1 = this.get('columnModel');
            _results1 = [];
            for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
              column = _ref1[_i];
              if (column.name === name) {
                _results1.push(column.width = width);
              } else {
                _results1.push(void 0);
              }
            }
            return _results1;
          }).call(this));
        }
        return _results;
      }
    },
    setupColumnOrderingProperties: function() {
      var column, k, lastkey, order, permutation, position, v, _i, _j, _len, _len1, _ref, _ref1;
      if (this.get('collection.personalizable')) {
        if (this.get('columnInfo')) {
          if ((this.get('columnInfo.order') != null) && !$.isEmptyObject(this.get('columnInfo.order'))) {
            permutation = [0];
            if (this.getColModel() && this.getColModel().length > 0 && this.getColModel()[0].name !== 'cb') {
              delete this.get('columnInfo.order')[0];
              order = this.get('columnInfo.order');
              lastkey = null;
              for (k in order) {
                v = order[k];
                order[k - 1] = v - 1;
                lastkey = k;
              }
              delete this.get('columnInfo.order')[lastkey];
            }
            _ref = this.get('columnModel');
            for (position = _i = 0, _len = _ref.length; _i < _len; position = ++_i) {
              column = _ref[position];
              if (this.getColModel()[0].name === 'cb') {
                position = position + 1;
              }
              column = this.get('columnInfo.order')[position];
              if (column != null) {
                permutation[column] = position;
              }
            }
            if (permutation.length > 1) {
              return this.getTableDom().remapColumns(permutation, true, false);
            }
          } else {
            permutation = [0];
            _ref1 = this.get('columnModel');
            for (position = _j = 0, _len1 = _ref1.length; _j < _len1; position = ++_j) {
              column = _ref1[position];
              permutation[position + 1] = column.order || (position + 1);
            }
            return this.set('columnInfo.oldOrder', permutation);
          }
        }
      }
    },
    setupColumnGroupingProperties: function() {
      if ((this.get('groupingInfo.columnName') != null) && (this.get('groupingInfo.type') != null)) {
        return this.doRemoteGrouping(this.get('groupingInfo.type'), this.get('groupingInfo.columnName'));
      }
    },
    storeColumnDataToCollection: function() {
      var col, _i, _j, _len, _len1, _ref, _ref1, _results;
      if (this.getTableDom().length > 0) {
        if (this.get('columnInfo') != null) {
          _ref = this.getColModel();
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            col = _ref[_i];
            this.set('columnInfo.hidden.' + col.name, col.hidden);
          }
        }
        if (this.get('columnInfo') != null) {
          _ref1 = this.getTableDom().get(0).p.colModel;
          _results = [];
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            col = _ref1[_j];
            _results.push(this.set('columnInfo.widths.' + col.name, col.width));
          }
          return _results;
        }
      }
    },
    storeColumnOrderingToCollection: function(permutation) {
      var col, field, match, oldOrder, position, _i, _len;
      if (this.get('columnInfo') != null) {
        oldOrder = this.get('columnInfo.oldOrder');
        if (this.getColModel() && this.getColModel().length > 0 && this.getColModel()[0].name !== 'cb') {
          permutation.unshift(0);
          permutation = permutation.map(function(item) {
            return item + 1;
          });
          permutation[0] = 0;
        }
        if (oldOrder != null) {
          for (position = _i = 0, _len = permutation.length; _i < _len; position = ++_i) {
            col = permutation[position];
            match = null;
            for (field in oldOrder) {
              if (oldOrder[field] === col) {
                match = field;
              }
            }
            if (match != null) {
              this.set('columnInfo.order.' + match, position);
            }
          }
        }
        this.set('columnInfo.oldOrder', Ember.copy(this.get('columnInfo.order')));
        return console.log("Ordering = " + this.get('columnInfo.order'));
      }
    },
    didInsertElement: function() {
      if (this.get('collection') != null) {
        return this.setupCustomizedProperties();
      }
    },
    onPageOrSort: function(postdata, id, rcnt) {
      if (this.get('collection') != null) {
        if (this.get('scroll')) {
          this.set('rcnt', rcnt || 0);
        }
        if (this.shouldSort(postdata)) {
          this.getTableDom().jqGrid('groupingRemove', true);
          return this.get('collection').sort({
            fields: [
              {
                sortDir: postdata.sord,
                field: postdata.sidx
              }
            ]
          });
        } else {
          if (!(this.get('collection.personalizationsRecord') && !this.get('collection.personalizationsRecord.isLoaded'))) {
            return this.get('collection').goToPage(postdata.page);
          }
        }
      }
    },
    shouldSort: function(postdata) {
      var columnDef, newSort, sortBy, sortable, _i, _len, _ref;
      sortable = false;
      sortBy = postdata.sidx.split(',');
      newSort = sortBy[sortBy.length - 1].trim();
      if (this.get('columns') != null) {
        _ref = this.get('columns');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          columnDef = _ref[_i];
          if (newSort.indexOf(columnDef.name) > -1 && (columnDef.sortable != null) && columnDef.sortable) {
            postdata.sidx = columnDef.name;
            sortable = true;
          }
        }
      }
      return sortable && postdata.sidx !== "" && (postdata.sidx !== this.get('sortingInfo.fields.firstObject.field') || postdata.sord !== this.get('sortingInfo.fields.firstObject.sortDir'));
    },
    personalizationWasAdded: (function() {
      if (this.get('collection') != null) {
        return this.updateGridWitNewPersonalizationValues(this.get('collection').getSettings());
      }
    }).observes('collection.personalizations', 'collection.personalizations.@each'),
    getPersonalizationFromName: function(name) {
      var matches,
        _this = this;
      matches = this.get('collection.personalizations').filter(function(item) {
        return item.get('name') === name;
      });
      if (matches.length > 0) {
        return matches[0];
      }
    },
    initializeFromCustomizationIndex: function(index) {
      var customization, customizationName, settings;
      customization = this.get('customizationName');
      if (Number(index) === -1) {
        settings = this.get('collection.defaultPersonalization');
        settings.filtering = this.get('collection.defaultFiltering');
        customizationName = settings.customizationName;
      } else {
        if (this.get('customizationName') !== this.get('collection.customizationName') && (this.get('collection.personalizations').objectAt(index) != null)) {
          settings = this.get('collection.personalizations').objectAt(index).get('settings');
          customizationName = this.get('collection.personalizations').objectAt(index).get('name');
        }
      }
      this.get('collection').updateCollectionWithNewPersonalizationValues(customizationName, settings);
      return this.updateGridWitNewPersonalizationValues(settings);
    },
    updateGridWitNewPersonalizationValues: function(settings) {
      if (settings.columns != null) {
        this.set('columnInfo', jQuery.extend(true, {}, settings.columns));
      }
      if (settings.grouping != null) {
        this.set('groupingInfo', jQuery.extend(true, {}, settings.grouping));
      }
      this.applyStoredPropertiesToGrid();
      return this.populateCollectionDropdown();
    }
  });

}).call(this);


(function() {

  Tent.Grid = Tent.Grid || Ember.Namespace.create();

  /**
  * @class Tent.Grid.SelectionSupport
  * Provides support for selecting items in a grid
  */


  Tent.Grid.SelectionSupport = Ember.Mixin.create({
    didSelectRow: function(itemId, status, e) {
      if (!this.get('multiSelect')) {
        this.selectItemSingleSelect(itemId);
      } else {
        this.selectItemMultiSelect(itemId, status);
      }
      if (this.get('afterSelectRow') != null) {
        return this.get('afterSelectRow').call(this, itemId, status, e);
      }
    },
    selectItemSingleSelect: function(itemId) {
      this.clearSelection();
      return this.selectItem(itemId);
    },
    /**
    * @method  clearSelection Removes all items from the selection array and resets the grid
    */

    clearSelection: function() {
      return this.set('selection', []);
    },
    selectItem: function(itemId) {
      var selectedItem, selection;
      selectedItem = this.getItemFromModel(itemId);
      selection = this.get('selection');
      if ((selectedItem != null) && !selection.contains(selectedItem)) {
        return selection.pushObject(selectedItem);
      }
    },
    selectItemMultiSelect: function(itemId, status) {
      if (status !== false) {
        return this.selectItem(itemId);
      } else {
        return this.deselectItem(itemId);
      }
    },
    deselectItem: function(itemId) {
      return this.removeItemFromSelection(itemId);
    },
    removeItemFromSelection: function(id) {
      return this.get('selection').removeObject(this.getItemFromModel(id));
    },
    didSelectAll: function(rowIds, status) {
      var allPageItems, id, selectedIds, selectedItem, selection, _i, _j, _len, _len1;
      selectedIds = this.get('selectedIds');
      if (this.get('paged')) {
        if (status !== false) {
          allPageItems = [];
          selection = this.get('selection');
          for (_i = 0, _len = rowIds.length; _i < _len; _i++) {
            id = rowIds[_i];
            selectedItem = this.getItemFromModel(id);
            if ((selectedItem != null) && !selection.contains(selectedItem)) {
              allPageItems.push(selectedItem);
            }
          }
          selection.pushObjects(allPageItems);
        } else {
          allPageItems = [];
          for (_j = 0, _len1 = rowIds.length; _j < _len1; _j++) {
            id = rowIds[_j];
            allPageItems.push(this.getItemFromModel(id));
          }
          this.get('selection').removeObjects(allPageItems);
        }
      } else {
        if (status !== false) {
          this.selectAllItems();
        } else {
          this.clearSelection();
        }
      }
      if (this.get('afterSelectAll') != null) {
        return this.get('afterSelectAll').call(this, rowIds, status);
      }
    },
    selectAllItems: function() {
      return this.set('selection', this.get('content').filter(function() {
        return true;
      }));
    },
    selectionDidChange: (function() {
      return this.updateGrid();
    }).observes('selection.@each')
  });

}).call(this);


(function() {

  Tent.Grid.Adapters = Ember.Mixin.create({
    cachedGridData: [],
    columns: (function() {
      return this.get('collection.columnsDescriptor');
    }).property('collection.columnsDescriptor'),
    colNames: (function() {
      var column, name, names, t, title, _i, _len, _ref, _ref1;
      names = [];
      _ref = this.get('columnModel');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        column = _ref[_i];
        t = Tent.I18n.loc(column.title);
        if (this.get('columnInfo.titles') != null) {
          _ref1 = this.get('columnInfo.titles');
          for (name in _ref1) {
            title = _ref1[name];
            if (column.name === name) {
              t = title;
            }
          }
        }
        names.pushObject(t);
      }
      return names;
    }).property('columns'),
    hideFilteredColumns: (function() {
      var columnName, filteredColumns, _i, _len, _results;
      if (this.get('content.isLoaded')) {
        filteredColumns = this.get('content.filteredColumns.filtered') || [];
        _results = [];
        for (_i = 0, _len = filteredColumns.length; _i < _len; _i++) {
          columnName = filteredColumns[_i];
          _results.push(this.hideCol(columnName));
        }
        return _results;
      }
    }).observes('content.isLoaded', 'content.filteredColumns.filtered'),
    columnModel: (function() {
      var column, columns, item, _i, _len, _ref;
      columns = Ember.A();
      if (this.get('columns') != null) {
        _ref = this.get('columns');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          column = _ref[_i];
          item = Ember.Object.create({
            name: column.name,
            index: column.name,
            align: column.align,
            editable: column.editable,
            formatter: column.formatter,
            formatoptions: column.formatoptions,
            edittype: Tent.JqGrid.editTypes[column.formatter] || 'text',
            editoptions: column.editoptions || Tent.JqGrid.editOptions[column.formatter],
            editrules: column.editrules || Tent.JqGrid.editRules[column.formatter],
            width: column.width || 80,
            position: "right",
            hidden: column.hidden != null ? column.hidden : false,
            hideable: column.hideable,
            hidedlg: column.hideable === false ? true : void 0,
            sortable: column.sortable,
            groupable: column.groupable,
            resizable: true,
            title: Tent.I18n.loc(column.title),
            t: Tent.I18n.loc(column.title)
          });
          columns.pushObject(item);
        }
      }
      return columns;
    }).property('columns'),
    columnNames: (function() {
      var column, columnNames, _i, _len, _ref;
      columnNames = [];
      _ref = this.get('columnModel');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        column = _ref[_i];
        columnNames.pushObject(column.name);
      }
      return columnNames;
    }).property('columnModel', 'columnModel.@each'),
    fixedRows: (function() {
      return this.get('collection.totals');
    }).property('content', 'content.isLoaded'),
    fixedRowsCount: (function() {
      return this.get('fixedRows.length');
    }).property('fixedRows'),
    gridData: (function() {
      var cell, column, grid, item, model, models, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2;
      grid = [];
      if (this.get('content') != null) {
        models = this.get('content').toArray();
        if (this.isShowingValidGroups()) {
          for (_i = 0, _len = models.length; _i < _len; _i++) {
            model = models[_i];
            grid.push(model);
          }
        } else {
          for (_j = 0, _len1 = models.length; _j < _len1; _j++) {
            model = models[_j];
            item = {
              "id": model.get('id')
            };
            if (this.get('selectedIds').contains(model.get('id'))) {
              item.sel = true;
            }
            cell = [];
            _ref = this.get('columnModel');
            for (_k = 0, _len2 = _ref.length; _k < _len2; _k++) {
              column = _ref[_k];
              cell.push(model.get(column.name));
            }
            item.cell = cell;
            if (model.get("presentationType") === "summary") {
              grid;

            } else {
              grid.push(item);
            }
          }
        }
      }
      this.set('cachedGridData', grid);
      if ((_ref1 = this.getTableDom()) != null) {
        _ref1[0].p.rowNum = grid.length;
      }
      if ((_ref2 = this.getTableDom()) != null) {
        _ref2[0].p.pageSize = this.get('pagingInfo.pageSize');
      }
      return grid;
    }).property('content', 'content.isLoaded', 'content.@each'),
    gridDataDidChange: (function() {
      var data, grid, _ref;
      if (!(this.getTableDom() != null)) {
        return;
      }
      this.getTableDom()[0].p.viewrecords = false;
      if (this.get('content.isLoaded')) {
        this.getTableDom().jqGrid('clearGridData');
        /*
        			* As soon as the required data is loaded set viewrecords attribute of jqGrid to true, and let it 
        			* calculate whether there are any records or not using the reccount attribute
        */

        this.getTableDom()[0].p.viewrecords = true;
      }
      data = {
        rows: this.get('gridData'),
        total: this.get('collection.pagingInfo') != null ? this.get('collection.pagingInfo.totalPages') : void 0,
        records: this.get('collection.pagingInfo') != null ? this.get('collection.pagingInfo.totalRows') : void 0,
        page: this.get('collection.pagingInfo') != null ? this.get('collection.pagingInfo').page : void 0,
        userdata: this.get('fixedRows'),
        remoteGrouping: this.isShowingValidGroups(),
        columns: this.get('columnModel')
      };
      this.resetGrouping();
      if (this.isShowingValidGroups()) {
        data.columnName = this.get('groupingInfo.columnName');
        data.columnType = this.get('groupingInfo.columnType');
        data.groupType = this.get('groupingInfo.type');
        data.columnTitle = this.getColumnTitle(data.columnName);
        data.showGroupTitle = this.get('showGroupTitle');
        grid = this.getTableDom()[0];
        this.updatePagingForGroups(grid, data);
        if (grid != null) {
          grid.addGroupingData(data);
        }
      } else {
        if ((_ref = this.getTableDom()[0]) != null) {
          _ref.addJSONData(data, this.get('rcnt'));
        }
      }
      return this.updateGrid();
    }).observes('content', 'content.isLoaded', 'content.@each', 'pagingInfo'),
    gridIsEmpty: (function() {
      if (this.get('content.isLoaded') && !this.get('content.content.length')) {
        return this.$('.ui-jqgrid-bdiv').prepend('<div class="empty-message background-hint light">' + Tent.I18n.loc("tent.jqGrid.emptyRecords") + '</div>');
      } else {
        return this.$('.ui-jqgrid-bdiv .empty-message').remove();
      }
    }).observes('content.isLoaded', 'content.@each')
  });

}).call(this);



/**
* @class Tent.Grid.ExportSupport
* Adds export functionality to a grid
*/


(function() {

  Tent.Grid.ExportSupport = Ember.Mixin.create({
    /**
    * @property {Boolean} showExportButton Display a button in the header which allows the table data to
    * be exported to a selected format.
    */

    showExportButton: true,
    /**
    * @property {Array} enabledExports The list of export types which are allowed
    * Any types listed here will appear as options in the grids Exports dropdown.
    */

    enabledExports: ['xls', 'csv', 'json'],
    addNavigationBar: function() {
      return this._super();
    },
    getVisibleColumns: function(custom) {
      var visibleColumns,
        _this = this;
      if (custom == null) {
        custom = false;
      }
      visibleColumns = this.getColModel().filter(function(column) {
        return (column.name !== 'cb') && (!column.hidden);
      });
      return visibleColumns.map(function(column) {
        var userDefinedTitles;
        if (custom) {
          userDefinedTitles = _this.get('collection.columnInfo.titles');
          return userDefinedTitles[column.index] || column.t;
        } else {
          return column.name.underscore();
        }
      });
    },
    getExportUrl: function(contentType) {
      var collection, customHeaderString, params, visibleColumnString;
      visibleColumnString = this.getVisibleColumns().join(',');
      customHeaderString = this.getVisibleColumns(true).join(',');
      params = {
        del: ",",
        headers: true,
        quotes: true,
        date: this.generateExportDate(),
        columns: visibleColumnString,
        custom_headers: customHeaderString
      };
      if ((collection = this.get('collection')) != null) {
        return collection.getURL(contentType, params);
      }
    },
    clientDownload: function(file, type) {
      var data, link, popup;
      if (navigator.appName !== 'Microsoft Internet Explorer') {
        data = 'data:text/csv;charset=utf-8,' + escape(file);
        link = document.createElement('a');
        link.setAttribute('href', data);
        link.setAttribute('download', 'data.' + type);
        return link.click();
      } else {
        popup = window.open('', 'csv', '');
        return popup.document.body.innerHTML = '<pre>' + file + '</pre>';
      }
    },
    exportCSV: function(data, customParams) {
      var arr, del, key, n, obj, orderedData, str, value, _i, _len;
      orderedData = [];
      for (_i = 0, _len = data.length; _i < _len; _i++) {
        obj = data[_i];
        arr = [];
        str = customParams.headers && customParams.quotes ? "\'" : "";
        del = customParams.quotes ? "\'" + customParams.del + "\'" : customParams.del;
        for (key in obj) {
          value = obj[key];
          arr.push(value);
          if (customParams.headers) {
            str += key + del;
          }
        }
        orderedData.push(arr);
      }
      if (customParams.headers) {
        n = customParams.quotes ? -2 : -1;
        str = str.slice(0, n) + "\r\n";
      }
      orderedData.forEach(function(row) {
        if (customParams.quotes) {
          str += "\'";
        }
        str += row.join(del);
        return str += customParams.quotes ? "\' \r\n" : "\r\n";
      });
      return str;
    },
    generateExportDate: function() {
      return Tent.Formatting.date.format(new Date(), "dd-M-yy hh-mm tz");
    },
    getPersonalizedData: function(data, customParams) {
      var columns, customHeaders, index, obj, personalizedData, personalizedObject, precision, value, _i, _j, _len, _ref;
      precision = 2;
      if (data[0]['currency']) {
        precision = Tent.CURRENCIES_ISO_4217[data[0]['currency']].cent;
      }
      personalizedData = [];
      columns = customParams.columns.split(',');
      customHeaders = customParams.custom_headers.split(',');
      for (_i = 0, _len = data.length; _i < _len; _i++) {
        obj = data[_i];
        personalizedObject = {};
        for (index = _j = 0, _ref = columns.length - 1; 0 <= _ref ? _j <= _ref : _j >= _ref; index = 0 <= _ref ? ++_j : --_j) {
          if (typeof (value = obj[Ember.String.camelize(columns[index])]) === "number") {
            value = value.toFixed(precision);
          }
          personalizedObject[customHeaders[index]] = value;
        }
        personalizedData.pushObject(personalizedObject);
      }
      return personalizedData;
    }
  });

}).call(this);



/**
* @class Tent.Grid.EditableSupport
* Provides support for editable fields in a grid
*/


(function() {

  Tent.Grid.EditableSupport = Ember.Mixin.create({
    /**
    	* @property {Function} onEditRow A callback function which will be called when a row is made editable. 
    	* The context of the function is this JqGrid View, and it will accept the following parameters:
    	* 
    	* -rowId: the id of the selected row
    	* -grid: the jqGrid
    	*
    */

    onEditRow: null,
    /**
    	* @property {Function} onRestoreRow A callback function which will be called when editing of a row is cancelled,
    	* and the original values restored to the cells. 
    	* The context of the function is this JqGrid View, and it will accept the following parameters:
    	* 
    	* -rowId: the id of the selected row
    	* -grid: the jqGrid
    	*
    */

    onRestoreRow: null,
    /**
    	* @property {Function} onSaveCell A callback function which will be called when an editable cell is saved. (This 
    	* usually occurs on change or blur) 
    	* The context of the function is this JqGrid View, and it will accept the following parameters:
    	* 
    	* -rowId: the id of the selected row
    	* -grid: the jqGrid
    	* -cellName: the name of the edited cell
    	* -iCell: the position of the edited cell
    	*
    */

    onSaveCell: null,
    showEditableCells: function() {
      var id, table, _i, _len, _ref, _results;
      table = this.getTableDom();
      if (table != null) {
        _ref = table.jqGrid('getDataIDs');
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          id = _ref[_i];
          _results.push(this.showEditableCell(id, table));
        }
        return _results;
      }
    },
    showEditableCell: function(id, table) {
      if (this.get('selectedIds').contains(id)) {
        return this.editRow(id, table);
      } else {
        return this.restoreRow(id);
      }
    },
    editRow: function(rowId, table) {
      table = table || this.getTableDom();
      return table.jqGrid('editRow', rowId, false, this.onEditFunc());
    },
    restoreRow: function(rowId, table) {
      if (this.isRowCurrentlyEditing(rowId)) {
        table = table || this.getTableDom();
        table.jqGrid('restoreRow', rowId);
        this.saveEditedRow(rowId);
        if (this.get('onRestoreRow') != null) {
          return this.get('onRestoreRow').call(this, rowId, table);
        }
      }
    },
    restoreRows: function(ids) {
      var contentArray, onRestoreRow, row, rowId, savedRows, tableDom, _i, _len, _results;
      tableDom = this.getTableDom();
      savedRows = tableDom[0].p.savedRow.filter(function() {
        return true;
      });
      contentArray = this.get('content').toArray();
      onRestoreRow = this.get('onRestoreRow');
      _results = [];
      for (_i = 0, _len = savedRows.length; _i < _len; _i++) {
        row = savedRows[_i];
        rowId = row.id;
        tableDom.jqGrid('restoreRow', rowId);
        this.cancelEditedRow(rowId, contentArray);
        if (onRestoreRow != null) {
          _results.push(onRestoreRow.call(this, rowId, tableDom));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    },
    cancelEditedRow: function(rowId, contentArray) {
      var col, model, rowData, _i, _len, _ref, _results;
      rowData = this.getTableDom().getRowData(rowId);
      model = this.getItemFromModel(rowId, contentArray);
      _ref = this.getColModel();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        col = _ref[_i];
        if (col.editable) {
          _results.push(model.set(col.name, rowData[col.name]));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    },
    isRowCurrentlyEditing: function(rowId) {
      var isEditing, row, savedRow, _i, _len;
      isEditing = false;
      savedRow = this.getTableDom()[0].p.savedRow;
      for (_i = 0, _len = savedRow.length; _i < _len; _i++) {
        row = savedRow[_i];
        if (row.id === rowId) {
          isEditing = true;
        }
      }
      return isEditing;
    },
    onEditFunc: function(rowId) {
      var widget;
      widget = this;
      return function(rowId) {
        if (widget.get('onEditRow') != null) {
          return widget.get('onEditRow').call(widget, rowId, widget.getTableDom());
        }
      };
    },
    saveEditedRow: function(rowId, status, options) {
      var col, modelItem, rowData, _i, _len, _ref, _results;
      rowData = this.getTableDom().getRowData(rowId);
      modelItem = this.getItemFromModel(rowId);
      _ref = this.getColModel();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        col = _ref[_i];
        if (col.editable) {
          _results.push(this.saveEditedCell(rowId, col.name, rowData[col.name], null, null, null, modelItem));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    },
    saveEditedCell: function(rowId, cellName, value, iRow, iCell, cell, modelItem) {
      var formatter;
      modelItem = modelItem || this.getItemFromModel(rowId);
      formatter = this.getTableDom().getColProp(cellName).formatter;
      if ($.fn.fmatter[formatter] != null) {
        if (cell != null) {
          return modelItem.set(cellName, $.fn.fmatter[formatter].unformat(null, {}, cell));
        } else {
          return modelItem.set(cellName, $.fn.fmatter[formatter].unformat(value));
        }
      } else {
        return modelItem.set(cellName, value);
      }
    },
    saveEditableCell: function(element) {
      var cellName, cellpos, rowId;
      rowId = $(element).parents('tr:first').attr('id');
      cellpos = $(element).parents('tr').children().index($(element).parents('td'));
      cellName = this.getColModel()[cellpos].name;
      this.saveEditedCell(rowId, cellName, null, null, null, $(element).parent());
      if (this.onSaveCell != null) {
        return this.onSaveCell.call(this, rowId, this.getTableDom(), cellName, cellpos);
      }
    }
  });

}).call(this);


(function() {

  Tent.Grid.FilterSupport = Ember.Mixin.create({
    showFilter: false,
    isPinned: false,
    filterCoversGrid: false,
    /**
    	* @property {Boolean} maximizeGridOnFilter maximize the grid when the filter panel is displayed
    */

    maximizeGridOnFilter: false,
    toggleFilter: function() {
      this.toggleProperty('showFilter');
      this.resizeToContainer();
      if (this.get('maximizeGridOnFilter')) {
        if (this.get('showFilter')) {
          return this.maximize();
        } else {
          return this.restoreSize();
        }
      }
    }
  });

}).call(this);



/**
* @class Tent.Grid.GroupingSupport
* Adds grouping support to a grid
*/


(function() {

  Tent.Grid.GroupingSupport = Ember.Mixin.create({
    remoteGrouping: false,
    /**
     * @property {Boolean} showGroupTitle Show the title of the group in each grouping row along with the group data.
    */

    showGroupTitle: true,
    showingGroups: false,
    newGroupSelected: function(groupType, columnName) {
      if (this.remoteGrouping) {
        return this.doRemoteGrouping(groupType, columnName);
      } else {
        return this.doLocalGrouping(groupType, columnName);
      }
    },
    doLocalGrouping: function(groupType, columnName) {
      var columnDef, columnType, comparator, lastSort, _i, _len, _ref;
      if (groupType === 'none') {
        return this.getTableDom().jqGrid('groupingRemove', true);
      } else {
        columnType = this.getColumnType(columnName);
        lastSort = this.getTableDom()[0].p.sortname;
        _ref = this.get('columns');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          columnDef = _ref[_i];
          if (columnDef.name === columnName && (columnDef.sortable != null) && columnDef.sortable) {
            if ((!(lastSort != null)) || !(lastSort === columnName)) {
              this.getTableDom().sortGrid(columnName);
            }
          }
        }
        comparator = Tent.JqGrid.Grouping.getComparator(columnType, groupType);
        this.getTableDom().groupingGroupBy(columnName, {
          groupText: ['<b>' + this.getColumnTitle(columnName) + ':  {0}</b>'],
          range: comparator
        });
        return this.gridDataDidChange();
      }
    },
    getColumnType: function(columnName) {
      var col, columnType, _i, _len, _ref;
      columnType = 'string';
      _ref = this.get('columns');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        col = _ref[_i];
        if (col.name === columnName) {
          columnType = col.type;
        }
      }
      return columnType;
    },
    doRemoteGrouping: function(groupType, columnName) {
      var groupData;
      this.clearAllGrouping();
      if (groupType === 'none') {
        return this.get('collection').goToPage(1);
      } else {
        groupData = {
          columnName: columnName,
          type: groupType,
          columnType: this.getColumnType(columnName)
        };
        this.setShowingGroupsListState(true);
        return this.get('collection').goToGroupPage(1, groupData);
      }
    },
    didSelectGroup: function(itemId, status, e) {
      return this.selectRemoteGroup(itemId);
    },
    selectRemoteGroup: function(id) {
      this.setShowingGroupsListState(false);
      this.set('currentGroup', this.getSelectedGroup(id));
      this.showGroupHeader(id, this.get('currentGroup'));
      this.get('collection').setCurrentGroupId(id);
      return this.get('collection').goToPage(1);
    },
    getSelectedGroup: function(id) {
      var item, selectedGroup, _i, _len, _ref;
      _ref = this.get('content').toArray();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        if (item.get('id') === parseInt(id, 10)) {
          selectedGroup = item;
        }
      }
      return selectedGroup;
    },
    showGroupHeader: function(id, selectedGroup) {
      var aggregateColumns, columnName, columnTitle, columnType, comparator, content, groupType, headerRow, startValue, widget;
      widget = this;
      columnName = this.get('groupingInfo.columnName');
      columnType = this.get('groupingInfo.columnType');
      groupType = this.get('groupingInfo.type');
      columnTitle = this.getColumnTitle(columnName);
      if (selectedGroup != null) {
        content = "";
        if (this.get('showGroupTitle')) {
          content = "<span class='title'>" + this.getColumnTitle(columnName) + "</span>";
        }
        content = content + "<span class='range'>";
        comparator = Tent.JqGrid.Grouping.getComparator(columnType, groupType);
        startValue = selectedGroup[columnName.decamelize()];
        if (startValue != null) {
          content = content + comparator.rowTitle(startValue);
        }
        content = content + "</span>";
      }
      aggregateColumns = this.getTableDom()[0].getAggregateDataForGroupHeaderRow({
        columns: this.get('columnModel')
      }, selectedGroup, true);
      headerRow = $('<tbody><tr class="group-header"><td><i class="icon-caret-left"></i>' + content + '</td>' + aggregateColumns + '</tr></tbody>');
      this.$('.ui-jqgrid-hbox .ui-jqgrid-htable tbody').remove();
      this.$('.ui-jqgrid-hbox .ui-jqgrid-htable').append(headerRow);
      headerRow.click(function() {
        return widget.returnToGroupList();
      });
      return this.columnsDidChange();
    },
    refreshGroupHeader: function() {
      if (this.get('collection.groupingInfo.currentGroupId')) {
        return this.showGroupHeader(this.get('collection.groupingInfo.currentGroupId'), this.get('currentGroup'), true);
      }
    },
    columnOrderDidChange: (function() {
      return this.refreshGroupHeader();
    }).observes('columnInfo.order'),
    hideGroupHeader: function() {
      var headerRow;
      headerRow = this.$('.ui-jqgrid-hbox .group-header');
      headerRow.remove();
      return this.columnsDidChange();
    },
    getColSpan: function() {
      var visibleColumns;
      visibleColumns = this.getTableDom()[0].p.colModel.filter(function(col) {
        return !col.hidden;
      });
      return visibleColumns.length;
    },
    returnToGroupList: function() {
      this.setShowingGroupsListState(true);
      this.hideGroupHeader();
      return this.get('collection').goToGroupPage();
    },
    clearAllGrouping: function() {
      this.get('collection').clearGrouping();
      this.hideGroupHeader();
      return this.setShowingGroupsListState(false);
    },
    setShowingGroupsListState: function(isShowing) {
      this.set('showingGroups', isShowing);
      return this.set('collection.isShowingGroupsList', isShowing);
    },
    isShowingValidGroups: function() {
      return this.get('showingGroups') && (this.get('groupingInfo.columnName') != null);
    }
  });

}).call(this);



/**
* @class Tent.Grid.ColumnChooserSupport
* Adds a column choooser to a grid
*/


(function() {

  Tent.Grid.ColumnChooserSupport = Ember.Mixin.create({
    /**
    	* @property {Boolean} showColumnChooser Display a button at the top of the grid which presents
    	* a dialog to show/hide columns. Any columns which have a property **'hideable:false'** will not be shown
    	* in this dialog
    */

    showColumnChooser: true,
    addNavigationBar: function() {
      return this._super();
    },
    showCol: function(column) {
      this.getTableDom().jqGrid("showCol", column);
      return this.refreshGrid();
    },
    hideCol: function(column) {
      this.getTableDom().jqGrid("hideCol", column);
      return this.refreshGrid();
    },
    refreshGrid: function() {
      this.columnsDidChange();
      this.storeColumnDataToCollection();
      return this.resizeToContainer();
    }
  });

}).call(this);


(function() {

  Tent.Grid.ColumnMenu = Ember.Mixin.create({
    columnsDidChange: function() {
      return this.leftAlignLastDropdown();
    },
    addColumnDropdowns: function() {
      var column, columnDivId, context, groupType, template, _i, _len, _ref;
      if (this.get('columns') != null) {
        _ref = this.get('columns');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          column = _ref[_i];
          column.groupable = !((column.groupable != null) && column.groupable === false);
          column.renamable = !((column.renamable != null) && column.renamable === false);
          column.sortable = !((column.sortable != null) && column.sortable === false);
          if (column.groupable || column.renamable || column.sortable) {
            template = Handlebars.compile('\
						 	<ul class="dropdown-menu column-dropdown" data-column="{{column.name}}" data-last-title="{{title}}" data-orig-title="{{title}}">\
								{{#if column.sortable}}\
									<li class="sort dropdown-submenu">\
										<a tabindex="-1">{{sort}}</a>\
											<ul class="dropdown-menu">\
												<li><a tabindex="-1" class="ascending">{{ascending}}</a></li>\
												<li><a tabindex="-1" class="descending">{{descending}}</a></li>\
											</ul>\
									</li>\
								{{/if}}\
								{{#if column.groupable}}\
									<li class="group dropdown-submenu">\
										<a tabindex="-1">{{group}}</a>\
											<ul class="dropdown-menu">\
												<li data-grouptype="none"><a tabindex="-1">{{none}}</a></li>\
												{{#each groupType}}\
													<li data-grouptype="{{name}}"><a class="revert" tabindex="-1">{{title}}</a></li>\
												{{/each}}\
											</ul>\
									</li>\
								{{/if}}\
								{{#if column.renamable}}\
									<li class="rename dropdown-submenu">\
										<a tabindex="-1">{{rename}}</a>\
											<ul class="dropdown-menu wide">\
												<li><input type="text" value="{{title}}" class="input-medium"/></li>\
												<li><a tabindex="-1" class="revert">{{revert}}</a></li>\
											</ul>\
									</li>\
								{{/if}}\
							</ul>');
            if (column.type != null) {
              groupType = Tent.JqGrid.Grouping.ranges.get(column.type)();
            }
            if (!(groupType != null)) {
              groupType = Tent.JqGrid.Grouping.ranges['string'];
            }
            context = {
              column: column,
              title: Tent.I18n.loc(column.title),
              groupType: groupType,
              none: Tent.I18n.loc("tent.grouping.no_grouping"),
              revert: Tent.I18n.loc("tent.grouping.revert"),
              sort: Tent.I18n.loc("tent.sorting.main"),
              ascending: Tent.I18n.loc("tent.sorting.ascending"),
              descending: Tent.I18n.loc("tent.sorting.descending"),
              group: Tent.I18n.loc("tent.grouping._groupBy"),
              rename: Tent.I18n.loc("tent.rename.main")
            };
            columnDivId = '#jqgh_' + this.get('elementId') + '_jqgrid_' + column.name;
            this.$(columnDivId).addClass('dropdown');
            $(columnDivId + ' .title').after(template(context));
            $(columnDivId + ' .title').addClass('has-dropdown').attr('data-toggle', 'dropdown').append('<span class="dropdown-mask"><i class="icon-chevron-down"></i></span>');
          }
        }
        this.leftAlignLastDropdown();
        this.groupByColumnBindings();
        this.renameColumnHeaderBindings();
        return this.sortingBindings();
      }
    },
    toggleColumnDropdown: function(columnField) {
      var columnDivId;
      columnDivId = '#jqgh_' + this.get('elementId') + '_jqgrid_' + columnField;
      return $(columnDivId + ' .title').dropdown('toggle');
    },
    leftAlignLastDropdown: function() {
      var table, tableRight;
      if (this.$('.ui-jqgrid-htable').length > 0) {
        this.$('.column-dropdown .dropdown-submenu').removeClass('pull-left');
        this.$('.ui-th-column: .column-dropdown').removeClass('last');
        table = this.$('.ui-jqgrid-htable');
        tableRight = $(window).width() - (table.offset().left + table.outerWidth());
        return this.$('.ui-th-column:visible').each(function() {
          var columnLeft;
          columnLeft = $(window).width() - $(this).offset().left;
          if ((columnLeft - 250) < tableRight) {
            $('.dropdown-submenu', $(this)).addClass('pull-left');
          }
          if ((columnLeft - 120) < tableRight) {
            return $('.column-dropdown', $(this)).addClass('last');
          }
        });
      }
    },
    sortingBindings: function() {
      var widget;
      widget = this;
      this.$('.dropdown-menu .sort .ascending').click(function(e) {
        var target;
        target = $(e.target);
        return widget.findAscendingButton(target).click();
      });
      return this.$('.dropdown-menu .sort .descending').click(function(e) {
        var target;
        target = $(e.target);
        return widget.findDescendingButton(target).click();
      });
    },
    findAscendingButton: function(target) {
      return target.parents('.ui-th-column:first').find('.ui-icon-asc').eq(0);
    },
    findDescendingButton: function(target) {
      return target.parents('.ui-th-column:first').find('.ui-icon-desc').eq(0);
    },
    groupByColumnBindings: function() {
      var widget;
      widget = this;
      return this.$('.group.dropdown-submenu').click(function(e) {
        var column, groupType, target;
        target = $(e.target);
        groupType = target.attr('data-grouptype') || target.parents('li[data-grouptype]:first').attr('data-grouptype');
        column = target.attr('data-column') || target.parents('ul.column-dropdown:first').attr('data-column');
        return widget.newGroupSelected(groupType, column);
      });
    },
    renameColumnHeaderBindings: function() {
      var widget;
      widget = this;
      this.$('.rename.dropdown-submenu').mouseenter(function(e) {
        return $('input', this).focus();
      }).click(function(e) {
        var target;
        target = $(e.target);
        e.stopPropagation();
        return e.preventDefault();
      });
      this.$('.rename.dropdown-submenu').mouseleave(function(e) {
        return $('body').focus();
      });
      this.$('.rename.dropdown-submenu input').bind('keyup', (function(e) {
        var columnField, dropdownMenu, lastTitle, target;
        target = $(e.target);
        dropdownMenu = target.parents('ul.column-dropdown:first');
        columnField = dropdownMenu.attr('data-column');
        if (e.keyCode === 13) {
          if (Tent.Browsers.isIE()) {
            $(this).blur();
          }
          return widget.renameColumnHeader(columnField, $(this).val(), dropdownMenu);
        } else if (e.keyCode === 27) {
          lastTitle = dropdownMenu.attr('data-last-title');
          if (Tent.Browsers.isIE()) {
            $(this).blur();
          }
          widget.renameGridColumnHeader(columnField, lastTitle);
          $(this).val(lastTitle);
          widget.toggleColumnDropdown(columnField);
          e.preventDefault();
          return e.stopPropagation();
        }
      }));
      return this.$('.rename.dropdown-submenu .revert').click(function(e) {
        var columnField, dropdownMenu, originalTitle, target;
        target = $(e.target);
        dropdownMenu = target.parents('ul.column-dropdown:first');
        columnField = dropdownMenu.attr('data-column');
        originalTitle = dropdownMenu.attr('data-orig-title');
        if (Tent.Browsers.isIE()) {
          $('.rename.dropdown-submenu input').blur();
        }
        widget.renameColumnHeader(columnField, originalTitle, dropdownMenu);
        return $('.rename.dropdown-submenu input', dropdownMenu).val(originalTitle);
      });
    },
    renameColumnHeader: function(columnField, value, dropdownMenu) {
      this.toggleColumnDropdown(columnField);
      this.renameGridColumnHeader(columnField, value);
      if (this.get('columnInfo.titles')) {
        this.set('columnInfo.titles.' + columnField, value);
      }
      return dropdownMenu.attr('data-last-title', value);
    },
    renameGridColumnHeader: function(colname, value) {
      var column, _i, _len, _ref;
      if (value === "") {
        value = " ";
      }
      this.getTableDom().jqGrid('setLabel', colname, value);
      _ref = this.get('columnModel');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        column = _ref[_i];
        if (column.name === colname) {
          column.title = value;
        }
      }
      return this.columnsDidChange();
    }
  });

}).call(this);



/**
* @class Tent.Grid.Maximize
* Adds maximize/restore support to a grid
*/


(function() {

  Tent.Grid.Maximize = Ember.Mixin.create({
    /**
    	* @property {Boolean} showMaximizeButton Display a button at the top of the grid which presents
    	* a dialog to maximize the grid view.
    */

    showMaximizeButton: true,
    resizeGridSteps: true,
    resizeSpeed: 700,
    addNavigationBar: function() {
      return this.renderMaximizeButton();
    },
    renderMaximizeButton: function() {
      var widget;
      widget = this;
      if (this.get('showMaximizeButton')) {
        this.$(".grid-header .right").append('<div class="button-wrapper"><a class="maximize button-control"><i class="icon-resize-full"></i></a></div>');
        return this.$('a.maximize').click(function() {
          return widget.toggleFullScreen(this);
        });
      }
    },
    toggleFullScreen: function(a) {
      var widget;
      widget = this;
      if (this.get('fullScreen')) {
        return this.restoreSize();
      } else {
        return this.maximize();
      }
    },
    maximize: function() {
      var newHeight, newWidth, widget,
        _this = this;
      widget = this;
      this.set('currentTop', this.$().offset().top - $(window).scrollTop());
      this.set('currentLeft', this.$().offset().left);
      this.set('currentWidth', this.$().outerWidth());
      this.set('currentHeight', this.$().outerHeight());
      this.set('currentRight', $(window).width() - (this.$().offset().left + this.$().outerWidth()));
      this.set('currentBottom', $(window).height() - (this.$().offset().top + this.$().outerHeight()));
      newWidth = $(window).width() - 60;
      newHeight = $(window).height() - 120;
      this.$().css('top', this.get('currentTop') + 'px');
      this.$().css('left', this.get('currentLeft') + 'px');
      this.$().css('height', this.get('currentHeight') + 'px');
      this.$().css('width', this.get('currentWidth') + 'px');
      this.$().css('z-index', '2050');
      this.$().css('position', 'fixed');
      this.$().addClass('dialog');
      if (!this.get('resizeGridSteps')) {
        this.hideGrid();
      }
      this.$('.jqgrid-backdrop').show();
      $('.jqgrid-backdrop').animate({
        opacity: '0.6'
      }, 200, function() {
        return _this.$().animate({
          width: newWidth + 'px',
          height: $(window).height() - 60 - _this.get('currentHeight') > 60 ? 'auto' : newHeight + 'px',
          top: '60px',
          left: '30px',
          right: '30px',
          bottom: '60px'
        }, {
          duration: _this.get('resizeSpeed'),
          complete: function() {
            $('span', widget).removeClass('icon-resize-full');
            $('span', widget).addClass('icon-resize-small');
            _this.set('fullScreen', true);
            _this.resizeToContainer();
            if (!_this.get('resizeGridSteps')) {
              return _this.showGrid();
            }
          },
          step: function() {
            return _this.resizeToContainer();
          }
        });
      });
      this.set('resizeEscapeHandler', this.get('generateResizeEscapeHandler')(this));
      return $('body').bind('keyup click', this.get('resizeEscapeHandler'));
    },
    restoreSize: function() {
      var _this = this;
      $('body').unbind('keyup click', this.get('resizeEscapeHandler'));
      if (!this.get('resizeGridSteps')) {
        this.hideGrid();
      }
      return this.$().animate({
        width: this.get('currentWidth') + 'px',
        height: this.get('currentHeight') + 'px',
        top: this.get('currentTop') + 'px',
        left: this.get('currentLeft') + 'px',
        right: this.get('currentRight') + 'px',
        bottom: this.get('currentBottom') + 'px'
      }, {
        duration: this.get('resizeSpeed'),
        complete: function() {
          _this.$('.maximize > span').removeClass('icon-resize-small');
          _this.$('.maximize > span').addClass('icon-resize-full');
          _this.set('fullScreen', false);
          _this.$().css('height', '');
          _this.$().css('width', '');
          _this.resizeToContainer();
          _this.$().removeClass('dialog');
          if (!_this.get('resizeGridSteps')) {
            _this.showGrid();
          }
          return _this.removeBackdrop();
        },
        step: function() {
          return _this.resizeToContainer();
        }
      });
    },
    removeBackdrop: function() {
      var _this = this;
      return this.$('.jqgrid-backdrop').animate({
        opacity: '0.0'
      }, 900, function() {
        _this.$('.jqgrid-backdrop').hide();
        return _this.$().css('position', 'static');
      });
    },
    generateResizeEscapeHandler: function(widget) {
      return function(e) {
        if (e.keyCode === 27 || ($(e.target).attr('id') === 'jqgrid-backdrop')) {
          widget.toggleFullScreen();
        }
      };
    }
  });

}).call(this);


(function() {

  Tent.Grid.HorizontalScrollSupport = Ember.Mixin.create({
    /**
    	* @property {Boolean} horizontalScrolling Allow the grid content to scroll horizontally.
    	* This property defines whether the grid content will be forced to fit within the area assiged to the grid (false), 
    	* or whether the columns will disregard the grid width. The actual column widths will be the greater of the column 
    	* title width and the column content
    */

    horizontalScrolling: false,
    /**
    	 * @property {Boolean} ShowAutofitButton Show or hide the autofit button on the grid header panel.
    	 *
    	 * The autofit button will allow the grid to toggle between two modes
    	 * 
    	 * - **Autofit**: All columns are resized to fit within the grid viewing area
    	 * - **Non-Autofit**: All columns assume their natural width (using no wrapping) and a horizontal scrollbar is
    	 * displayed if necessary
    */

    showAutofitButton: true,
    /**
    	 * @property {Boolean} autofitIfSpaceAvailable If autofit is turned off, and there is free space in the grid, expand the
    	 * columns to fit the free space.
    */

    autofitIfSpaceAvailable: false,
    isHorizontalScrolling: false,
    gridDidRender: function() {
      this.set('isHorizontalScrolling', false);
      return this.modifyGridForAutofit();
    },
    showAutofitButtonProp: (function() {
      return this.get('showAutofitButton') && !this.get('showCardView');
    }).property('showAutofitButton', 'showCardView'),
    toggleActive: function(component) {
      component = component || this.$('.horizontal-scroll-button');
      if (this.get('horizontalScrolling')) {
        return component.removeClass('active');
      } else {
        return component.addClass('active');
      }
    },
    horizontalScrollingDidChange: (function() {
      return this.modifyGridForAutofit();
    }).observes('horizontalScrolling'),
    modifyGridForAutofit: function() {
      if (this.get('horizontalScrolling')) {
        if (!this.get('isHorizontalScrolling')) {
          return this.addHorizontalScroll();
        }
      } else {
        if (this.get('isHorizontalScrolling')) {
          return this.removeHorizontalScroll();
        }
      }
    },
    addHorizontalScroll: function() {
      this.set('isHorizontalScrolling', true);
      this.getTableDom().get(0).p.forceFit = false;
      this.getTableDom().get(0).p.shrinkToFit = false;
      this.moveHeaderAboveViewDiv();
      this.updateGrid();
      return this.adjustHeight();
    },
    removeHorizontalScroll: function() {
      this.set('isHorizontalScrolling', false);
      this.getTableDom().get(0).p.forceFit = true;
      this.getTableDom().get(0).p.shrinkToFit = true;
      this.revertHeaderIntoViewDiv();
      this.resetMinWidths();
      this.updateGrid();
      return this.adjustHeight();
    },
    moveHeaderAboveViewDiv: function() {
      var bdiv, hdiv, sdiv, view,
        _this = this;
      hdiv = $('.ui-jqgrid-hdiv', this.$());
      bdiv = $('.ui-jqgrid-bdiv', this.$());
      view = $('.ui-jqgrid-view', this.$());
      sdiv = $('.ui-jqgrid-sdiv', this.$());
      hdiv.detach();
      view.before(hdiv);
      if (sdiv.length > 0) {
        sdiv.detach();
        view.after(sdiv);
      }
      if (this.get('footerRow')) {
        sdiv.scroll(function(event) {
          return _this.trackFooterScrollPosition(hdiv, bdiv, sdiv);
        });
        return this.trackFooterScrollPosition(hdiv, bdiv, sdiv);
      } else {
        view.scroll(function(event) {
          return _this.trackContentScrollPosition(hdiv, view);
        });
        return this.trackContentScrollPosition(hdiv, view);
      }
    },
    trackFooterScrollPosition: function(hdiv, bdiv, sdiv) {
      hdiv.css("margin-left", "-" + sdiv.scrollLeft() + 'px');
      return bdiv.css("margin-left", "-" + sdiv.scrollLeft() + 'px');
    },
    trackContentScrollPosition: function(hdiv, view) {
      return hdiv.css("margin-left", "-" + view.scrollLeft() + 'px');
    },
    revertHeaderIntoViewDiv: function() {
      var bdiv, hdiv, sdiv, view;
      hdiv = $('.ui-jqgrid-hdiv', this.$());
      view = $('.ui-jqgrid-view', this.$());
      bdiv = $('.ui-jqgrid-bdiv', this.$());
      sdiv = $('.ui-jqgrid-sdiv', this.$());
      hdiv.detach();
      bdiv.before(hdiv);
      hdiv.css("margin-left", "0px");
      bdiv.css("margin-left", "0px");
      view.unbind('scroll');
      sdiv.unbind('scroll');
      if (sdiv.length > 0) {
        sdiv.detach();
        return bdiv.after(sdiv);
      }
    },
    resetMinWidths: function() {
      return this.$('.jqgfirstrow td').css("min-width", "0px");
    },
    setHeaderWidths: function() {
      var firstRowOfGrid, jqGridCols, totalWidth,
        _this = this;
      if (this.get('horizontalScrolling')) {
        firstRowOfGrid = this.$('.jqgfirstrow td');
        jqGridCols = this.getTableDom()[0].p.colModel;
        totalWidth = 0;
        this.$('.ui-jqgrid-htable th').each(function(index, col) {
          var finalWidth;
          finalWidth = _this.calculateColumnWidth(index, col, firstRowOfGrid);
          if (!jqGridCols[index].hidden) {
            totalWidth = totalWidth + parseInt(finalWidth);
            _this.changeColumnWidth(index, col, finalWidth, firstRowOfGrid, jqGridCols);
            return _this.changeFooterWidth(index, finalWidth);
          }
        });
        if (this.get('footerRow')) {
          this.getTableDom()[0].grid.sDiv.style.width = "auto";
        }
        if (this.get('autofitIfSpaceAvailable')) {
          return this.ensureColumnsExpandToAvailableSpace(firstRowOfGrid, jqGridCols);
        } else {
          return this.resizeTableToColumnsWidth(totalWidth);
        }
      }
    },
    calculateColumnWidth: function(index, col, firstRowOfGrid) {
      var widthBasedOnContent, widthBasedOnHeader;
      widthBasedOnHeader = this.calculateHeaderColumnWidth(index, col);
      widthBasedOnContent = this.calculateWidthBasedOnContent(index, firstRowOfGrid);
      if (widthBasedOnContent > widthBasedOnHeader) {
        return widthBasedOnContent;
      } else {
        return widthBasedOnHeader;
      }
    },
    changeColumnWidth: function(index, col, finalWidth, firstRowOfGrid, jqGridCols) {
      firstRowOfGrid.eq(index).css('width', finalWidth).css('min-width', finalWidth);
      $(col).css('width', finalWidth);
      return jqGridCols[index].width = finalWidth;
    },
    calculateHeaderColumnWidth: function(index, col) {
      var column;
      if (this.get('multiSelect') && index === 0) {
        return col.style.width.split('px')[0];
      } else {
        column = this.get('columnModel')[index - (this.get('multiSelect') ? 1 : 0)];
        if (column != null) {
          return column.title.length * 10;
        } else {
          return 80;
        }
      }
    },
    calculateWidthBasedOnContent: function(index, firstRowOfGrid) {
      var widthBasedOnContent;
      if (this.get('groupingInfo.columnName') != null) {
        return widthBasedOnContent = firstRowOfGrid.eq(index).width();
      } else {
        if (this.doesColumnHaveMinWidth(index, firstRowOfGrid)) {
          widthBasedOnContent = firstRowOfGrid.eq(index).css('min-width').split('px')[0];
        } else {
          widthBasedOnContent = firstRowOfGrid.eq(index).outerWidth();
        }
        return widthBasedOnContent;
      }
    },
    doesColumnHaveMinWidth: function(index, firstRowOfGrid) {
      var minWidth;
      minWidth = firstRowOfGrid.eq(index).css('min-width');
      return minWidth !== '0px' && !isNaN(minWidth);
    },
    changeFooterWidth: function(index, finalWidth) {
      var footers, _ref;
      if (this.get('footerRow')) {
        footers = this.getTableDom()[0].grid.footers;
        return (_ref = footers[index]) != null ? _ref.style.width = finalWidth + 'px' : void 0;
      }
    },
    resizeTableToColumnsWidth: function(totalWidth) {
      this.$('.ui-jqgrid-htable').width(totalWidth);
      this.$('.ui-jqgrid-btable').width(totalWidth);
      return this.$('.ui-jqgrid-ftable').width(totalWidth);
    },
    ensureColumnsExpandToAvailableSpace: function(firstRowOfGrid, jqGridCols) {
      var totalColumnsWidth, totalGridWidth,
        _this = this;
      totalGridWidth = this.$('.ui-jqgrid').width();
      totalColumnsWidth = this.$('.ui-jqgrid-btable').width();
      if ((totalColumnsWidth > 0) && (totalGridWidth > totalColumnsWidth)) {
        if (this.get('horizontalScrolling') && !this.get('temporaryAutoFit')) {
          Ember.run.next(this, function() {
            _this.set('temporaryAutoFit', true);
            return _this.set('horizontalScrolling', false);
          });
          return Ember.run.next(this, function() {
            _this.set('horizontalScrolling', true);
            return _this.set('temporaryAutoFit', false);
          });
        }
      }
    }
  });

}).call(this);


(function() {

  Tent.Grid.MultiViewSupport = Ember.Mixin.create({
    showMultiview: false,
    showCardView: false,
    showListView: true
  });

}).call(this);


(function() {
/**
  * @class Tent.JqGrid
  * @mixins Tent.ValidationSupport
  * @mixins Tent.MandatorySupport
  * @mixins Tent.Grid.CollectionSupport
  * @mixins Tent.Grid.SelectionSupport
  * @mixins Tent.Grid.Adapters
  * @mixins Tent.Grid.ExportSupport
  * @mixins Tent.Grid.EditableSupport
  * @mixins Tent.Grid.FilterSupport
  * @mixins Tent.Grid.GroupingSupport
  * @mixins Tent.Grid.ColumnChooserSupport
  * @mixins Tent.Grid.ColumnMenu
  * @mixins Tent.Grid.Maximize
  * @mixins Tent.Grid.HorizontalScrollSupport
  * 
  *
  * Create a jqGrid view which displays the data provided by its content property
  *
  * ##Usage
  *		{{view Tent.JqGrid
                    label="Tasks"
                    collectionBinding="Pad.collection"
                    selectionBinding="Pad.selectedTasks"
                    multiSelect=true             
                }}
  *
  * - collection: A collection representing an array of records, one for each row of the grid.
  * - selection: An array of selected objects. This will provide the initial selections, as well as 
  * contain the items selected from the grid.
  *
  * The content of the grid will be bound to the collection.
  * The columns for the grid will be bound to collection.columnsDescriptor
  */


  Tent.JqGrid = Ember.View.extend(Tent.ValidationSupport, Tent.MandatorySupport, Tent.Grid.Maximize, Tent.Grid.CollectionSupport, Tent.Grid.SelectionSupport, Tent.Grid.Adapters, Tent.Grid.HorizontalScrollSupport, Tent.Grid.ColumnChooserSupport, Tent.Grid.ExportSupport, Tent.Grid.FilterSupport, Tent.Grid.EditableSupport, Tent.Grid.ColumnMenu, Tent.Grid.GroupingSupport, Tent.Grid.MultiViewSupport, {
    templateName: 'jqgrid',
    classNames: ['tent-jqgrid'],
    classNameBindings: ['fixedHeader', 'hasErrors:error', 'paged', 'horizontalScrolling', 'footerRow', 'showFilter', 'isPinned', 'filterCoversGrid'],
    /**
    	* @property {String} title The title caption to appear above the table
    */

    title: null,
    /**
    	* @property {Boolean} multiSelect Boolean indicating that the list is a multi-select list
    */

    multiSelect: false,
    /**
    	* @property {Boolean} fixedHeader Boolean indicating that the header remains in view when the content is scrolled.
    */

    fixedHeader: false,
    /**
    	* @property	{Boolean} scroll A boolean indicating that the grid should scroll vertically rather than paging
    */

    scroll: false,
    /**
    	* @property {Boolean} filtering A boolean to indicate that the grid can be filtered.
    */

    filtering: false,
    /**
    	* @property {Boolean} grouping A boolean to indicate that the grid can be grouped.
    */

    grouping: true,
    /**
    	* @property {String} groupField The name of the field by which to group the grid
    */

    groupField: null,
    /** 
    	* @property {Boolean} clearAction Set this property to true to deselect all the selected items and restore all the editable fields.
    */

    clearAction: null,
    fullScreen: false,
    /**
    	 * @property {Boolean} footerRow Displays a row at the foot of the table for summary information
    */

    footerRow: false,
    /**
    	 * @property {Integer} fixedRowsCount Displays rows count at the foot of the table for summary information
    */

    fixedRowsCount: 1,
    /**
    	* @property {Array} content The array of items to display in the grid.
    	* By default this will be retrieved from the collection, if provided
    */

    contentBinding: 'collection',
    /**
    	* @property {Array} columns The array of column descriptors used to represent the data. 
    	* By default this will be retrieved from the collection, if provided
    */

    /**
    	* @property {Array} selection The array of items selected in the list. This can be used as a setter
    	* and a getter.
    */

    selection: [],
    /**
    	* @property {String} usageContext The environment into which this grid is to be placed.
    	* The behavior and presentation of the grid and its components may differ in different usage
    	* contexts. e.g. Filter panel may default to opened when in the 'report' context.
    	*
    	* Current allowed values are 'view' and 'report'
    */

    usageContext: null,
    init: function() {
      return this._super();
    },
    valueForMandatoryValidation: (function() {
      return this.get('selection');
    }).property('selection'),
    focus: function() {
      return this.getTableDom().focus();
    },
    didInsertElement: function() {
      var widget;
      this._super();
      widget = this;
      $.subscribe("/ui/refresh", function() {
        widget.resizeToContainer();
        if (widget.$() != null) {
          return widget.columnsDidChange();
        }
      });
      $.subscribe("/window/resize", function() {
        return widget.resizeToContainer();
      });
      this.setupDomIDs();
      this.bindHeaderView();
      return this.drawGrid();
    },
    bindHeaderView: function() {
      return this.getHeaderView().set('grid', this);
    },
    getHeaderView: function() {
      return Ember.View.views[this.$('.grid-header').attr('id')];
    },
    drawGrid: function() {
      this.setupColumnTitleProperties();
      this.setupColumnWidthProperties();
      this.setupColumnVisibilityProperties();
      this.buildGrid();
      this.gridDataDidChange();
      this.addNavigationBar();
      this.setupColumnGroupingProperties();
      this.setupColumnOrderingProperties();
      return this.gridDidRender();
    },
    applyStoredPropertiesToGrid: function() {
      if (this.get('collection.personalizable')) {
        this.set('columnModel', {});
        this.setupColumnTitleProperties();
        this.setupColumnWidthProperties();
        this.setupColumnVisibilityProperties();
        this.clearAllGrouping();
        this.getTableDom().GridUnload();
        this.buildGrid();
        this.setupColumnGroupingProperties();
        this.setupColumnOrderingProperties();
        return this.gridDidRender();
      }
    },
    willDestroyElement: function() {
      if (this.get('fullScreen')) {
        this.removeBackdrop();
      }
      return this.getTableDom().GridDestroy();
    },
    setupDomIDs: function() {
      this.set('tableId', this.get('elementId') + '_jqgrid');
      this.$('.grid-table').attr('id', this.get('tableId'));
      return this.$('.gridpager').attr('id', this.get('elementId') + '_pager');
    },
    getTableDom: function() {
      return this.$('#' + this.get('tableId'));
    },
    getTopPagerId: function() {
      return '#' + this.get('tableId') + '_toppager_left';
    },
    getPagerId: function() {
      return '#' + this.get('elementId') + '_pager';
    },
    getColModel: function() {
      return this.getTableDom().getGridParam('colModel');
    },
    buildGrid: function() {
      var widget,
        _this = this;
      widget = this;
      this.getTableDom().jqGrid({
        parentView: widget,
        datatype: function(postdata, id, rcnt) {
          return widget.onPageOrSort(postdata, id, rcnt);
        },
        height: this.get('height') || 'auto',
        colNames: this.get('colNames'),
        colModel: this.get('columnModel'),
        multiselect: this.get('multiSelect'),
        caption: this.get('title') != null ? Tent.I18n.loc(this.get('title')) : void 0,
        autowidth: this.get('horizontalScrolling') ? false : true,
        sortable: {
          update: function(permutation) {
            return _this.columnsDidChange();
          }
        },
        resizeStop: function(width, index) {
          _this.columnsDidChange(index);
          return _this.storeColumnDataToCollection();
        },
        loadComplete: widget.get('content.isLoaded'),
        loadtext: '<div class="wait"><i class="icon-spinner icon-spin icon-2x"></i></div>',
        forceFit: true,
        shrinkToFit: this.get('horizontalScrolling') ? false : true,
        viewsortcols: [true, 'vertical', false],
        scroll: this.get('scroll'),
        hidegrid: false,
        viewrecords: true,
        rowNum: this.get('paged') ? this.get('collection.pagingInfo.pageSize') : -1,
        gridview: true,
        toppager: false,
        cloneToTop: false,
        editurl: 'clientArray',
        pager: this.get('paged') ? this.getPagerId() : void 0,
        toolbar: [false, "top"],
        grouping: this.get('grouping'),
        footerrow: this.get('footerRow'),
        userDataOnFooter: true,
        onSelectRow: function(itemId, status, e) {
          return widget.didSelectRow(itemId, status, e);
        },
        onSelectGroup: function(itemId, status, e) {
          return widget.didSelectGroup(itemId, status, e);
        },
        onSelectAll: function(rowIds, status) {
          return widget.didSelectAll(rowIds, status);
        }
      });
      this.setInitialViewRecordsAttribute();
      this.addMarkupToHeaders();
      this.addColumnDropdowns();
      this.resizeToContainer();
      this.columnsDidChange();
      if (this.get('footerRow')) {
        $('tr.footrow').addClass('tent-jqgrid-footrow');
      }
      this.getTableDom().bind('jqGridRemapColumns', function(e, permutation, updateCells, keepHeader) {
        if (keepHeader) {
          _this.storeColumnOrderingToCollection(permutation);
        }
        return _this.refreshGroupHeader();
      });
      this.getTableDom().bind('jqGridDeactivateColumnDrag', function() {
        if (Tent.Browsers.getIEVersion() === 8 && !_this.get('horizontalScrolling')) {
          return _this.revertHeaderIntoViewDiv();
        }
      });
      return this.getTableDom()[0].p.useCollectionScrolling = this.get('scroll');
    },
    setInitialViewRecordsAttribute: function() {
      /*
      	    * Set initial value of viewrecords to be false so that the text "no records to view" does not
      	    * appear when page is refreshed or is first visited, this was not possible in initial definition
      	    * of jqGrid as jqGrid never shows viewrecords if it is set false in first call to jqGrid
      */
      return this.getTableDom()[0].p.viewrecords = false;
    },
    getItemFromModel: function(id, colName) {
      var model, row, value, _i, _len, _ref;
      if (colName != null) {
        row = this.get('content').toArray().find(function(item) {
          if (Number(id) === Number(item.get('id'))) {
            return item;
          }
        });
        id = row.get(colName);
      }
      _ref = this.get('content').toArray();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        model = _ref[_i];
        value = colName != null ? model.get(colName) : model.get('id');
        if (("" + value) === ("" + id)) {
          return model;
        }
      }
    },
    markErrorCell: function(rowId, iCell) {
      return this.getCell(rowId, iCell).addClass('error');
    },
    unmarkErrorCell: function(rowId, iCell) {
      return this.getCell(rowId, iCell).removeClass('error');
    },
    getCell: function(rowId, iCell) {
      return this.getTableDom().find('#' + rowId).children().eq(iCell);
    },
    /**
    	* @method sendAction send an action to the router. This is called from the 'action' formatter,
    	* which displays cell content as a link
    */

    sendAction: function(action, element, rowId, colName) {
      var view;
      view = this;
      while (!view.get('controller') && (view.get('parentView') != null)) {
        view = view.get('parentView');
      }
      if (view.get('controller') != null) {
        if (this.get('parentView.controller.namespace.router') != null) {
          return view.get('controller.namespace.router').send(action, this.getItemFromModel(rowId, colName));
        }
      }
    },
    addMarkupToHeaders: function() {
      return this.$('.ui-th-column div').each(function() {
        return $(this).contents().filter(function() {
          return this.nodeType === 3;
        }).replaceWith($('<span class="title">' + $(this).text() + '</span>'));
      });
    },
    addNavigationBar: function() {
      return this._super();
    },
    gridDidRender: function() {
      return this._super();
    },
    columnsDidChange: function(colChangedIndex) {
      this._super();
      return Tent.Browsers.executeForIE(this, function() {
        if (this.$() != null) {
          this.adjustHeight();
          this.removeLastDragBar();
          return this.setHeaderWidths();
        }
      });
    },
    adjustHeight: function() {
      var top;
      if (this.get('fixedHeader')) {
        top = this.$('.ui-jqgrid-htable').height();
        if (this.get('horizontalScrolling')) {
          this.$('.ui-jqgrid-bdiv').css('top', 0);
        } else {
          this.$('.ui-jqgrid-bdiv').css('top', top);
        }
        if (Tent.Browsers.isIE()) {
          this.$('.ui-jqgrid-bdiv').css('height', 'auto');
        }
        this.$('.ui-jqgrid-bdiv').css('bottom', this.heightForFooter() + this.heightForPager());
        if (this.get('footerRow')) {
          if (this.get('horizontalScrolling')) {
            this.$('.ui-jqgrid-sdiv').css('bottom', this.heightForPager());
            this.$('.ui-jqgrid-view').css('bottom', this.heightForFooter() + this.heightForPager());
          } else {
            this.$('.ui-jqgrid-view').css('bottom', this.heightForPager());
            this.$('.ui-jqgrid-sdiv').css('bottom', '0px');
          }
        } else {
          this.$('.ui-jqgrid-view').css('bottom', this.heightForPager());
        }
        if (!this.get('paged')) {
          if (this.get('horizontalScrolling')) {
            this.$('.ui-jqgrid-view').css('height', 'auto');
          } else {
            if (!Tent.Browsers.isIE()) {
              this.$('.ui-jqgrid-view').css('height', '100%');
            }
          }
        }
      } else {
        if (Tent.Browsers.isIE()) {
          this.$('.ui-jqgrid-bdiv').css('height', 'auto');
        }
      }
      $.publish('/grid/height-changed');
      return this.padLastCellsForScrollbar();
    },
    heightForPager: function() {
      var _ref;
      return ((_ref = this.$('.ui-jqgrid-pager')) != null ? _ref.height() : void 0) || 0;
    },
    heightForFooter: function() {
      var _ref;
      return ((_ref = this.$('.ui-jqgrid-sdiv')) != null ? _ref.height() : void 0) || 0;
    },
    removeLastDragBar: function() {
      this.$('.ui-th-column .ui-jqgrid-resize').show();
      return this.getLastColumn().find('.ui-jqgrid-resize').hide();
    },
    getLastColumn: function() {
      return this.$('.ui-th-column').filter(function() {
        return $(this).css('display') !== 'none';
      }).last();
    },
    resizeToContainer: function() {
      return Tent.Browsers.executeForIE(this, function() {
        var bdiv, widthWithoutScrollbar;
        if (this.$() != null) {
          bdiv = this.$('.ui-jqgrid-bdiv');
          if (this.get('horizontalScrolling')) {
            this.$('.ui-jqgrid-view, .ui-jqgrid, .ui-jqgrid-pager, .ui-jqgrid-hdiv').css('width', '100%');
            bdiv.css('width', 'auto');
            this.$('.ui-jqgrid-bdiv > div').css('position', 'static');
            this.$('.ui-jqgrid-btable').css('margin-right', bdiv.get(0).offsetWidth - bdiv.get(0).clientWidth);
          } else {
            this.getTableDom().setGridWidth(this.$('.table-container').innerWidth(), true);
            widthWithoutScrollbar = bdiv.get(0).clientWidth;
            this.$('.ui-jqgrid-btable').width(widthWithoutScrollbar + 'px');
          }
          if (Tent.Browsers.isIE()) {
            bdiv.css('width', '100%');
          }
          return this.adjustHeight();
        }
      });
    },
    padLastCellsForScrollbar: function() {
      return Tent.Browsers.executeForIE(this, function() {
        if (this.$() != null) {
          this.$('.ui-jqgrid-bdiv td').removeClass('last-cell');
          if (this.get('horizontalScrolling') || (Tent.Browsers.getIEVersion() === 8) || (Tent.Browsers.getIEVersion() === 9)) {
            return this.$('.ui-jqgrid-bdiv tr').each(function(index, row) {
              return $('td:not(:hidden)', row).last().addClass('last-cell');
            });
          }
        }
      });
    },
    hideGrid: function() {
      this.$(".gridpager").hide();
      return this.$(".grid-table").hide();
    },
    showGrid: function() {
      this.$(".gridpager").show();
      return this.$(".grid-table").show();
    },
    showSpinner: (function() {
      if (this.get('content.isLoaded') || !(this.get('content.isLoaded') != null)) {
        return this.getTableDom()[0].endReq();
      } else {
        return this.getTableDom()[0].beginReq();
      }
    }).observes('content.isLoaded'),
    updatePagingForGroups: function(grid, data) {
      grid.p.lastpage = data.total;
      grid.p.page = this.get('collection.currentGroupPage');
      grid.p.reccount = data.rows.length;
      grid.p.records = data.records;
      if (this.get('content.isLoaded')) {
        grid.p.viewrecords = true;
      }
      return grid.updatepager(null, false);
    },
    getColumnTitle: function(columnName) {
      var col, _i, _len, _ref;
      _ref = this.get('columns');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        col = _ref[_i];
        if (col.name === columnName) {
          return Tent.I18n.loc(col.title);
        }
      }
      return columnName;
    },
    resetGrouping: function() {
      if (this.get('grouping')) {
        return this.getTableDom().groupingSetup();
      }
    },
    selectedIds: (function() {
      var id, item, sel, _i, _len, _ref;
      sel = [];
      if (this.get('selection') != null) {
        _ref = this.get('selection');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          item = _ref[_i];
          id = "" + item.get('id');
          sel.pushObject(id);
        }
      }
      return sel;
    }).property('selection.@each'),
    updateGrid: function(doValidation) {
      return Tent.Browsers.executeForIE(this, function() {
        if ((this.$() != null) && (this.getTableDom() != null)) {
          this.unHighlightAllRows();
          this.highlightRows();
          this.showEditableCells();
          this.setHeaderWidths();
          this.resizeToContainer();
        }
        if (doValidation) {
          this.validate();
        }
        return $.publish("/grid/rendered");
      });
    },
    highlightRows: function() {
      var grid, item, table, _i, _len, _ref;
      table = this.getTableDom();
      if (table != null) {
        grid = table.get(0);
        _ref = this.get('selectedIds');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          item = _ref[_i];
          this.highlightRow(item, table);
        }
        return this.setSelectAllCheckbox(grid);
      }
    },
    isRowSelectedMultiSelect: function(id, grid) {
      return grid.p.selarrrow.contains(id);
    },
    isRowSelectedSingleSelect: function(id, grid) {
      return grid.p.selrow === id;
    },
    unHighlightAllRows: function() {
      var id, selectedIds, table, _i, _len, _ref, _results;
      table = this.getTableDom();
      selectedIds = this.get('selectedIds');
      _ref = table.getDataIDs();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        id = _ref[_i];
        if (!selectedIds.contains(id)) {
          if (this.get('multiSelect')) {
            if (this.isRowSelectedMultiSelect(id, table.get(0))) {
              table.jqGrid('setSelection', id, false);
              _results.push(this.restoreRow(id, table));
            } else {
              _results.push(void 0);
            }
          } else {
            if (this.isRowSelectedSingleSelect(id, table.get(0))) {
              table.jqGrid('setSelection', id, false);
              _results.push(this.restoreRow(id, table));
            } else {
              _results.push(void 0);
            }
          }
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    },
    highlightRow: function(id, table) {
      table = table || this.getTableDom();
      if (table != null) {
        if (this.get('multiSelect')) {
          if (!this.isRowSelectedMultiSelect(id, table.get(0))) {
            table.jqGrid('setSelection', id, false);
            return this.editRow(id, table);
          }
        } else {
          if (!this.isRowSelectedSingleSelect(id, table.get(0))) {
            table.jqGrid('setSelection', id, false);
            return this.editRow(id, table);
          }
        }
      }
    },
    clearAllSelections: (function() {
      if (this.get("clearAction") && (this.getTableDom() != null)) {
        this.set('selection', []);
        return this.set("clearAction", false);
      }
    }).observes("clearAction"),
    setSelectAllCheckbox: function(grid) {
      if (grid != null) {
        if (this.allRowsAreSelected(grid)) {
          return grid.setHeadCheckBox(true);
        } else {
          return grid.setHeadCheckBox(false);
        }
      }
    },
    allRowsAreSelected: function(grid) {
      var allSelected, id, selectedIds, _i, _len, _ref;
      selectedIds = this.get('selectedIds');
      allSelected = true;
      _ref = $(grid).jqGrid('getDataIDs');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        id = _ref[_i];
        if (!selectedIds.contains(id)) {
          allSelected = false;
        }
      }
      return allSelected;
    }
  });

}).call(this);


Ember.TEMPLATES['jqgrid_header']=Ember.Handlebars.compile("<div class=\"wrapper left\">\n    {{#if view.grid.showExportButton}}\n        {{#if view.someExportsAreAllowed}}\n            {{view view.exportView}}\n        {{/if}}\n    {{/if}}\n</div>\n<div class=\"wrapper middle\">\n    {{#if view.grid.scroll}}\n        <div class=\"header-pager\">\n            <p class=\"title\">{{loc tent.jqGrid.pagerViewing}}</p>\n            <p class=\"pager-details\">Page {{view.grid.pagingInfo.page}} of {{view.grid.pagingInfo.totalPages}}</p>\n        </div>\n    {{/if}}\n</div>\n<div class=\"wrapper right\">\n    {{#if view.grid.showAutofitButtonProp}}\n    \t<div class=\"button-wrapper\">\n        {{view Tent.Grid.AutofitButton gridBinding=\"view.grid\"}}\n      </div>\n    {{/if}}\n    {{#if view.grid.showMultiview}}\n    \t<div class=\"button-wrapper\">\n        {{view Tent.Grid.MultiviewButtons showCardViewBinding=\"view.grid.showCardView\" showListViewBinding=\"view.grid.showListView\"}}\n      </div>\n    {{/if}}\n    {{#if view.grid.showColumnChooser}}\n    \t<div class=\"button-wrapper\">\n        {{view Tent.Grid.ColumnChooserButton gridBinding=\"view.grid\"}}  \n      </div>\n    {{/if}}\n    {{#if view.grid.collection}}\n        {{#if view.grid.filtering}}\n            <div class=\"button-wrapper\">\n                <a {{action toggleFilter target=\"view.grid\"}} class=\"btn-filter button-control\">\n                    {{loc tent.filter.filter}}\n                </a>\n            </div>\n        {{/if}}\n    {{/if}}  \n</div>\n\n");

Ember.TEMPLATES['jqgrid_export']=Ember.Handlebars.compile("<a class=\"button-control\" data-toggle=\"dropdown\" href=\"#\">\n  Export<i class=\"icon-caret-down right-align\"></i>\n</a>\n<ul class=\"dropdown-menu\">\n  {{#if view.allowXlsExport}}\n    <li><a {{action exportData \"view.xls\" target=\"view\"}} href=\"#\" class=\"export-xls\">{{loc tent.jqGrid.export.xls}}</a></li>\n  {{/if}}\n  {{#if view.allowCsvExport}}\n    <li><a {{action exportData \"view.csv\" target=\"view\"}} href=\"#\" class=\"export-csv\">{{loc tent.jqGrid.export.csv}}</a></li>\n    <!-- <li><a class=\"export-xml\">#{Tent.I18n.loc(\"tent.jqGrid.export.xml\")}</a></li> -->\n    <li class=\"divider\"></li>\n    <li class=\"dropdown-submenu\">\n      <a href=\"#\">Delimiter</a>\n      <ul class=\"dropdown-menu custom-export\">\n        <li>\n          <form class=\"form-horizontal\" id=\"customExportForm\">\n            <div class=\"control-group\">\n              <label class=\"control-label\">Delimiter</label>\n              <div class=\"controls\">\n                  <select name=\"delimiter\" class=\"input-small\" id=\"delimiter\">\n                  <option value=\"\">{{loc tent.pleaseSelect}}</option>\n                  <option value=\",\" selected>{{loc tent.jqGrid.export.comma}}</option>\n                  <option value=\"|\">{{loc tent.jqGrid.export.pipe}}</option>\n                  <option value=\";\">{{loc tent.jqGrid.export.semicolon}}</option>\n                  <option value=\":\">{{loc tent.jqGrid.export.colon}}</option>\n                </select>\n              </div>\n            </div>\n            <div class=\"control-group\">\n              <label class=\"control-label\">{{loc tent.jqGrid.export._or}}</label>\n            </div>\n            <div class=\"control-group\">\n              <label class=\"control-label\">{{loc tent.jqGrid.export.enterDelimiter}}</label>\n              <div class=\"controls\">\n                <input type=\"text\" name=\"customDelimiter\" id=\"customDelimiter\"  maxlength=\"1\" class=\"input-small\">\n              </div>\n            </div>\n            <div class=\"control-group\">\n              <label class=\"control-label\">{{loc tent.jqGrid.export.headers}}</label>\n              <div class=\"controls\">\n                <label class=\"radio inline\">\n                  <input type=\"radio\" name=\"columnHeaders\" value=\"true\" checked>{{loc tent.on}}\n                </label>\n                <label class=\"radio inline\">\n                  <input type=\"radio\" name=\"columnHeaders\" value=\"false\">{{loc tent.off}}\n                </label>\n              </div>\n            </div>\n            <div class=\"control-group\">\n              <label class=\"control-label\">{{loc tent.jqGrid.export.inclQuotes}}</label>\n              <div class=\"controls\">\n                <label class=\"radio inline\">\n                  <input type=\"radio\" name=\"includeQuotes\" value=\"true\" checked>{{loc tent.on}}\n                </label>\n                <label class=\"radio inline\">\n                  <input type=\"radio\" name=\"includeQuotes\" value=\"false\">{{loc tent.off}}\n                </label>\n              </div>\n            </div>\n            <div class=\"control-group\">\n              <div class=\"controls\">\n                <button type=\"button\" class=\"btn\">{{loc tent.jqGrid.export.export}}</button>\n              </div>\n            </div>\n\n          </form>\n        </li>\n      </ul>\n    </li>\n    <li class=\"divider\"></li>\n  {{/if}}\n  {{#if view.allowJsonExport}}\n    <li><a {{action exportData \"view.json\" target=\"view\"}} href=\"#\" class=\"export-json\">{{loc tent.jqGrid.export.json}}</a></li>\n  {{/if}}\n</ul>\n");

(function() {
Tent.JqGridHeaderView = Ember.View.extend({
    classNames: ['grid-header', 'control-strip', 'ui-jqgrid-titlebar', 'ui-widget-header', 'ui-helper-clearfix'],
    templateName: 'jqgrid_header',
    grid: null,
    someExportsAreAllowed: (function() {
      var _ref;
      return (this.get('grid.enabledExports') != null) && (((_ref = this.get('grid.enabledExports')) != null ? _ref.length : void 0) > 0);
    }).property(),
    exportView: Ember.View.extend({
      classNames: ['export button-wrapper'],
      templateName: 'jqgrid_export',
      csv: 'csv',
      json: 'json',
      xls: 'xls',
      allowCsvExport: (function() {
        return this.get('parentView.grid.enabledExports').contains(this.get('csv'));
      }).property('parentView.grid.enabledExports'),
      allowJsonExport: (function() {
        return this.get('parentView.grid.enabledExports').contains(this.get('json'));
      }).property('parentView.grid.enabledExports'),
      allowXlsExport: (function() {
        return this.get('parentView.grid.enabledExports').contains(this.get('xls'));
      }).property('parentView.grid.enabledExports'),
      exportData: function(e) {
        var contentType, customHeaderString, customParams, grid, jsonUrlPart, personalizedData, ret, tableDom, url, visibleColumnString;
        contentType = e.context;
        grid = this.get('parentView.parentView');
        tableDom = grid.getTableDom();
        url = grid.getExportUrl(contentType);
        visibleColumnString = grid.getVisibleColumns().join(',');
        customHeaderString = grid.getVisibleColumns(true).join(',');
        customParams = {
          del: ',',
          columns: visibleColumnString,
          custom_headers: customHeaderString,
          headers: true
        };
        personalizedData = grid.getPersonalizedData(tableDom.getRowData(), customParams);
        if (contentType === 'json') {
          if (url != null) {
            jsonUrlPart = url.split('/').pop().split('?')[0];
            this.$('.export-json').attr('download', jsonUrlPart);
          }
          ret = '{ "exportDate": "' + grid.generateExportDate() + '",\n' + $.fn.xmlJsonClass.toJson(personalizedData, "data", "    ", true) + '}';
          return grid.clientDownload(ret, contentType);
        }
        if (url != null) {
          return document.location.href = url;
        } else {
          ret = 'exportDate \n' + grid.generateExportDate() + '\n' + grid.exportCSV(personalizedData, customParams);
          return grid.clientDownload(ret, contentType);
        }
      },
      didInsertElement: function() {
        var grid, tableDom,
          _this = this;
        grid = this.get('parentView.parentView');
        tableDom = grid.getTableDom();
        this.$('#customExportForm').click(function(e) {
          return e.stopPropagation();
        });
        this.$('#customExportForm').find('button').click(function() {
          var arry, columnHeaders, customHeaderString, customParams, delimiter, extension, includeQuotes, personalizedData, ret, url, visibleColumnString;
          arry = _this.$('#customExportForm').serializeArray();
          extension = 'csv';
          delimiter = ',';
          columnHeaders = true;
          includeQuotes = true;
          $.each(arry, function(i, fd) {
            if (fd.name === 'delimiter' && fd.value !== ',') {
              extension = 'txt';
              delimiter = fd.value;
            }
            if (fd.name === 'customDelimiter') {
              if (fd.value.length > 0) {
                delimiter = fd.value;
              }
            }
            if (fd.name === 'columnHeaders') {
              columnHeaders = fd.value === "true" ? true : false;
            }
            if (fd.name === 'includeQuotes') {
              return includeQuotes = fd.value === "true" ? true : false;
            }
          });
          visibleColumnString = grid.getVisibleColumns().join(',');
          customHeaderString = grid.getVisibleColumns(true).join(',');
          customParams = {
            del: delimiter,
            headers: columnHeaders,
            quotes: includeQuotes,
            date: grid.generateExportDate(),
            columns: visibleColumnString,
            custom_headers: customHeaderString
          };
          url = grid.get('collection').getURL(extension, customParams);
          if (!url) {
            personalizedData = grid.getPersonalizedData(tableDom.getRowData(), customParams);
            ret = 'exportDate \n' + grid.generateExportDate() + '\n' + grid.exportCSV(personalizedData, customParams);
            return grid.clientDownload(ret, extension);
          } else {
            return document.location.href = grid.get('collection').getURL(extension, customParams);
          }
        });
        this.$('#delimiter').change(function() {
          if ($('#delimiter').val().length > 0) {
            return $('#customDelimiter').val('');
          } else {
            if ($('#customDelimiter').val().length === 0) {
              return $('#delimiter').val(',');
            }
          }
        });
        if (Tent.Browsers.isIE()) {
          this.$('.custom-export').mouseleave(function(e) {
            return $('body').focus();
          });
          this.$('.custom-export').bind('keyup', (function(e) {
            if (e.keyCode === 27 || e.keyCode === 13) {
              return $('body').focus();
            }
          }));
        }
        return this.$('#customDelimiter').blur(function() {
          if ($('#customDelimiter').val().length > 0) {
            return $('#delimiter').val('');
          } else {
            return $('#delimiter').val(',');
          }
        });
      }
    })
  });

}).call(this);



/**
* @class jqgrid.formatter.amount Allows jsGrid cell content to be formatted as an amount
* This formatter should be added to a column descriptor as follows:
*       {id: "some_id", ..., formatter: "amount", formatoptions:{negative:true}}
*
* When 'negative' is set to true, then negative values will be displayed in different style to
* non-negative amounts (usually colored red).
*/


(function() {
  var partiallyLoadedCell;

  partiallyLoadedCell = function(options) {
    var partiallyLoadedColumns;
    partiallyLoadedColumns = Ember.View.views[options.gid.split("_")[0]].get("content.filteredColumns.partiallyFiltered");
    return partiallyLoadedColumns.contains(options.colModel.name);
  };

  jQuery.extend($.fn.fmatter, {
    amount: function(cellvalue, options, cell) {
      var formattedVal, _ref;
      if ((!cellvalue) && (cellvalue !== 0) && (cell != null)) {
        if ((options != null ? options.gid : void 0) && ((_ref = options.colModel) != null ? _ref.name : void 0) && partiallyLoadedCell(options)) {
          return "<span class=\"unentitled-cell\" title=\"" + (Tent.I18n.loc('unentitledCellMessage')) + "\"></span>";
        } else {
          cellvalue = $('input', cell).attr('value') || 0;
        }
      }
      formattedVal = Tent.Formatting.amount.format(cellvalue);
      if ((options != null) && (options.colModel.formatoptions != null) && options.colModel.formatoptions.negative && cellvalue < 0) {
        return '<span class="negative">' + formattedVal + '</span>';
      } else {
        return formattedVal;
      }
    }
  });

  jQuery.extend($.fn.fmatter.amount, {
    unformat: function(cellvalue, options, cell) {
      if ((!cellvalue) && (cellvalue !== 0) && (cell != null)) {
        cellvalue = $("input", cell).attr("value");
      }
      return Tent.Formatting.amount.unformat(cellvalue) || "";
    }
  });

  jQuery.extend($.fn.fmatter.amount, {
    formatCell: function(cellvalue, options, cell) {
      var input;
      if (cell != null) {
        input = $('input', cell);
        cellvalue = $("input", cell).attr("value");
      }
      return input.val(Tent.Formatting.amount.format(cellvalue) || "");
    }
  });

  /**
  * @class jqgrid.formatter.number Allows jsGrid cell content to be formatted as a number
  * This formatter should be added to a column descriptor as follows:
  *       {id: "some_id", ..., formatter: "number", formatoptions:{negative:true}}
  *
  * When 'negative' is set to true, then negative values will be displayed in different style to
  * non-negative numbers (usually colored red).
  */


  jQuery.extend($.fn.fmatter, {
    number: function(cellvalue, options, cell) {
      var formattedVal, _ref;
      if ((!cellvalue) && (cellvalue !== 0) && (cell != null)) {
        if ((options != null ? options.gid : void 0) && ((_ref = options.colModel) != null ? _ref.name : void 0) && partiallyLoadedCell(options)) {
          return "<span class=\"unentitled-cell\" title=\"" + (Tent.I18n.loc('unentitledCellMessage')) + "\"></span>";
        } else {
          cellvalue = $('input', cell).attr('value') || 0;
        }
      }
      formattedVal = Tent.Formatting.number.format(cellvalue);
      if ((options != null) && (options.colModel.formatoptions != null) && options.colModel.formatoptions.negative && cellvalue < 0) {
        return '<span class="negative">' + formattedVal + '</span>';
      } else {
        return formattedVal;
      }
    }
  });

  jQuery.extend($.fn.fmatter.number, {
    unformat: function(cellvalue, options, cell) {
      if ((!cellvalue) && (cellvalue !== 0) && (cell != null)) {
        cellvalue = $('input', cell).attr('value');
      }
      return Tent.Formatting.number.unformat(cellvalue) || "";
    }
  });

  /**
  * @class jqgrid.formatter.percent Allows jsGrid cell content to be formatted as a percentage value
  * This formatter should be added to a column descriptor as follows:
  *       {id: "some_id", ..., formatter: "percent"}
  */


  jQuery.extend($.fn.fmatter, {
    percent: function(cellvalue, opts, cell) {
      var _ref;
      if ((!cellvalue) && (cellvalue !== 0) && (cell != null)) {
        if ((opts != null ? opts.gid : void 0) && ((_ref = opts.colModel) != null ? _ref.name : void 0) && partiallyLoadedCell(opts)) {
          return "<span class=\"unentitled-cell\" title=\"" + (Tent.I18n.loc('unentitledCellMessage')) + "\"></span>";
        } else {
          cellvalue = $('input', cell).attr('value') || 0;
        }
      }
      return Tent.Formatting.percent.format(cellvalue);
    }
  });

  jQuery.extend($.fn.fmatter.percent, {
    unformat: function(cellvalue, options, cell) {
      if ((!cellvalue) && (cellvalue !== 0) && (cell != null)) {
        cellvalue = $('input', cell).attr('value');
      }
      return Tent.Formatting.percent.unformat(cellvalue) || "";
    }
  });

  jQuery.extend($.fn.fmatter.percent, {
    formatCell: function(cellvalue, options, cell) {
      var input;
      if (cell != null) {
        input = $('input', cell);
        cellvalue = input.attr('value');
        return input.val(Tent.Formatting.percent.format(cellvalue) || "");
      }
    }
  });

  /**
  * @class jqgrid.formatter.date Allows jsGrid cell content to be formatted as date values
  * This formatter should be added to a column descriptor as follows (dateFormat is optional):
  *       {id: "some_id", ..., formatter: "date", formatoptions:{dateFormat: "dd-M-yy"}}
  */


  jQuery.extend($.fn.fmatter, {
    date: function(cellvalue, options, rowdata) {
      if (options.colModel.formatoptions) {
        return Tent.Formatting.date.format(cellvalue, options.colModel.formatoptions.dateFormat);
      } else {
        return Tent.Formatting.date.format(cellvalue);
      }
    }
  });

  jQuery.extend($.fn.fmatter.date, {
    unformat: function(cellvalue, options) {
      return Tent.Formatting.date.unformat(cellvalue);
    }
  });

  /**
  * @class jqgrid.formatter.action Allows jsGrid cell content to be treated as a link.
  * This formatter should be added to a column descriptor as follows (redirectColumn is optional):
  *       {id: "some_id", ..., formatter: "action", .formatoptions({action: 'showNewRoute', redirectColumn: 'columnName'})
  * If no column name is supplied, it will redirect to 'newRoute' with context as data of the clicked row. The clicked row is 
  * searched on the basis of field 'id' in the data hash by comparing it against the clicked row Id.
  * If a column name is passed with in the format options, instead of rowId, value of the given column on the clicked row is compared
  * against the column value in the grid data.
  * This speacial redirectColumn option is required, for complicated data such that, data with single id needs to be shown
  * in different rows, with certain different column values, in that case, the 'id' for all the rows would be different
  * to meet ember data needs but the actual id for that data should be stored in some other column, so that 
  * appropriate processing and redirection can be done.
  */


  jQuery.extend($.fn.fmatter, {
    action: function(cellvalue, options, rowdata) {
      if (cellvalue) {
        if (options.colModel.formatoptions.redirectColumn != null) {
          return '<a onclick="Ember.View.views[$(this).parents(\'.tent-jqgrid\').attr(\'id\')].sendAction(\'' + options.colModel.formatoptions.action + '\', this, \'' + options.rowId + '\',\'' + options.colModel.formatoptions.redirectColumn + '\')">' + cellvalue + '</a>';
        } else {
          return '<a onclick="Ember.View.views[$(this).parents(\'.tent-jqgrid\').attr(\'id\')].sendAction(\'' + options.colModel.formatoptions.action + '\', this, \'' + options.rowId + '\')">' + cellvalue + '</a>';
        }
      }
    }
  });

  /**
  * @class jqgrid.formatter.checkboxEdit Allows jsGrid boolean cell content to be displayed as a checkbox
  * This formatter should be added to a column descriptor as follows:
  *       {id: "some_id", ..., formatter: "checkboxEdit"}
  */


  jQuery.extend($.fn.fmatter, {
    checkboxEdit: function(cval, opts) {
      var bchk, op;
      op = $.extend({}, opts.checkbox);
      if (opts.colModel !== void 0 && !$.fmatter.isUndefined(opts.colModel.formatoptions)) {
        op = $.extend({}, op, opts.colModel.formatoptions);
      }
      if ($.fmatter.isEmpty(cval) || $.fmatter.isUndefined(cval)) {
        cval = $.fn.fmatter.defaultFormat(cval, op);
      }
      cval = cval + "";
      cval = cval.toLowerCase();
      bchk = cval.search(/(false|0|no|off)/i) < 0 ? " checked='checked' " : "";
      return '<input type="checkbox" ' + bchk + ' value="' + cval + '" offval="no" data-formatter="checkboxEdit" onchange="Ember.View.views[$(this).parents(\'.tent-jqgrid\').attr(\'id\')].saveEditableCell(this)"/>';
    }
  });

  jQuery.extend($.fn.fmatter.checkboxEdit, {
    unformat: function(cellvalue, options, cell) {
      return $('input', cell).is(':checked');
    }
  });

  /**
  * @class jqgrid.formatter.selectEdit Allows jsGrid cell content to be selected from a select box dropdown
  * This formatter should be added to a column descriptor as follows:
  *       {id: "some_id", ..., formatter: "selectEdit", editoptions:{value: {1:'One',2:'Two',3:'Three'}}}
  */


  jQuery.extend($.fn.fmatter, {
    selectEdit: function(cval, opts) {
      var el, options, selected, text, val;
      options = opts.colModel.editoptions.value;
      if (options != null) {
        el = '<select data-formatter="selectEdit" onchange="Ember.View.views[$(this).parents(\'.tent-jqgrid\').attr(\'id\')].saveEditableCell(this)" >';
        for (val in options) {
          text = options[val];
          selected = val === cval ? 'selected="selected"' : "";
          el += ("<option value=\"" + val + "\" " + selected + ">") + text;
        }
        el += '</select>';
      }
      return el;
    }
  });

  jQuery.extend($.fn.fmatter.selectEdit, {
    unformat: function(cellvalue, options, cell) {
      return $('select', cell).val();
    }
  });

  Tent.JqGrid.Validators = Ember.Object.create({
    amount: function(value, colname) {
      var unformatted;
      unformatted = Tent.Formatting.amount.unformat(value);
      if (unformatted === 0 && value !== 0) {
        return [false, Tent.Formatting.number.errorText()];
      } else {
        return [true];
      }
    }
  });

  Tent.JqGrid.editTypes = {
    'amount': 'text',
    'select': 'select',
    'checkbox': 'checkbox'
  };

  Tent.JqGrid.editOptions = {
    'amount': {
      dataInit: function(elem) {
        $(elem).css('text-align', 'right');
        return $(elem).keypress(function(event) {
          var charCode;
          charCode = (event.which ? event.which : event.keyCode);
          if (charCode !== 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
          } else {
            return true;
          }
        });
      },
      dataEvents: [
        {
          type: 'keyup',
          fn: function(e) {
            return Ember.View.views[$(this).parents('.tent-jqgrid').attr('id')].saveEditableCell(this);
          }
        }, {
          type: 'blur',
          fn: function(e) {
            return $(this).val(Tent.Formatting.amount.format($(this).val()));
          }
        }
      ]
    },
    'checkbox': {
      value: "True:False",
      disabled: false
    }
  };

  Tent.JqGrid.editRules = {
    'amountEdit': {
      custom: true,
      custom_func: Tent.JqGrid.Validators.amount
    }
  };

}).call(this);



/**
* @class Tent.JqGrid.Grouping
* Provides configuration options for grouping by column values and comparators for defining
* grouping ranges.
*
*/


(function() {

  Tent.JqGrid.Grouping = Ember.Object.extend();

  /**
  * @method getComparator returns a comparator to use for a combination of datatype and grouping type
  * @param {String} dataType the type of the column which is defining the grouping e.g. 'date'
  * @param {String} groupType the type of grouping to perform e.g. 'month'
  */


  Tent.JqGrid.Grouping.getComparator = function(dataType, groupType) {
    var comparator, type, _i, _len, _ref;
    comparator = this.ranges.get('default')().comparator;
    if (!(this.ranges.get(dataType) != null)) {
      dataType = "string";
    }
    _ref = this.ranges.get(dataType)();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      type = _ref[_i];
      if (type.name === groupType) {
        if (type.comparator != null) {
          comparator = type.comparator;
        }
      }
    }
    return comparator;
  };

  /**
  * @class Tent.JqGrid.Grouping.comparator
  * A base class for providing custom comparison functions for determining if values lie in a particular range.
  */


  Tent.JqGrid.Grouping.comparator = Ember.Object.extend({
    /**
    	* @method compare Test whether a value lies in the same range as another.
    	* @param {Object} firstValue The value defining the range to use in the test
    	* @param {Object} testValue The value to test
    	* @param {Boolean} The result of the test
    */

    compare: function(firstValue, testValue) {
      return firstValue === testValue;
    },
    /**
    	* @method rowTitle Returns the text to display as the first interpolation of the group row text
    	* @param {Object} value the value which is used to determine the range
    */

    rowTitle: function(value, formatter) {
      if (value != null) {
        if (formatter != null) {
          return formatter(value);
        } else {
          return value;
        }
      } else {
        return '';
      }
    }
  });

  Tent.JqGrid.Grouping.helper = Ember.Object.create({
    numeric: {
      calculateName: function(value) {
        var _ref;
        return "" + (((_ref = Tent.Formatting.number.serializer) != null ? _ref.serialize(value) : void 0) || value);
      },
      rowTitle: function(value, formatter) {
        if (!(formatter != null)) {
          formatter = Tent.Formatting.number.format;
        }
        if (typeof value === "string") {
          value = Tent.Formatting.number.unformat(value);
        }
        this.calculateRange(value);
        return formatter(this.get('lower')) + ' - ' + formatter(this.get('upper'));
      },
      compare: function(last, value) {
        this.calculateRange(last);
        return (this.get('lower') <= value && value <= this.get('upper'));
      },
      calculateRange: function(range) {
        return function(value) {
          var lower, upper;
          if (value >= 0) {
            lower = value - (value % range);
            upper = lower + (range - 1);
          } else {
            if (value % range === 0) {
              lower = value;
              upper = value + (range - 1);
            } else {
              upper = -1 + value - (value % range);
              lower = upper - (range - 1);
            }
          }
          this.set('lower', lower);
          return this.set('upper', upper);
        };
      }
    },
    amount: {
      rowTitle: function(value, formatter) {
        if (value != null) {
          if (formatter != null) {
            return formatter(value);
          } else {
            return Tent.Formatting.amount.format(value);
          }
        } else {
          return '';
        }
      },
      rangeRowTitle: function(value, formatter) {
        if (!(formatter != null)) {
          formatter = Tent.Formatting.amount.format;
        }
        if (typeof value === "string") {
          value = Tent.Formatting.amount.unformat(value);
        }
        this.calculateRange(value);
        return formatter(this.get('lower')) + ' - ' + formatter(this.get('upper'));
      }
    }
  });

  /**
  * @property {Object} Tent.JqGrid.Grouping.ranges A collection of range definitions which provide titles, comparators etc for particular types
  */


  Tent.JqGrid.Grouping.ranges = Ember.Object.create({
    "default": function() {
      return {
        name: 'exact',
        title: Tent.I18n.loc('tent.grouping.range.exact'),
        comparator: Tent.JqGrid.Grouping.comparator.create()
      };
    },
    /**
    		* @class Tent.JqGrid.Grouping.ranges.date
    */

    date: function() {
      return [
        {
          /**
          					* @property {Object} exact group dates which are the same
          */

          name: 'exact',
          title: Tent.I18n.loc('tent.grouping.range.exact'),
          comparator: Tent.JqGrid.Grouping.comparator.create({
            compare: function(last, value) {
              return last.compareTo(value) === 0;
            }
          })
        }, {
          /**
          					* @property {Object} week group dates which occur in the same week
          */

          name: 'week',
          title: Tent.I18n.loc('tent.grouping.range.week'),
          comparator: Tent.JqGrid.Grouping.comparator.create({
            compare: function(last, value) {
              if ((last.getFullYear() === value.getFullYear()) && (last.getWeekOfYear() === value.getWeekOfYear())) {
                return true;
              }
              if (last.compareTo(value) === -1) {
                if ((last.getFullYear() + 1 === value.getFullYear()) && (last.getWeekOfYear() === value.getWeekOfYear()) && (last.getMonth() === 11) && (value.getMonth() === 0)) {
                  return true;
                }
              }
              if (last.compareTo(value) === 1) {
                if ((last.getFullYear() - 1 === value.getFullYear()) && (last.getWeekOfYear() === value.getWeekOfYear()) && (last.getMonth() === 0) && (value.getMonth() === 11)) {
                  return true;
                }
              }
            },
            rowTitle: function(value, formatter) {
              var week, yesterday;
              if (!(formatter != null)) {
                formatter = Tent.Formatting.date.format;
              }
              if (typeof value === "string") {
                value = Tent.Formatting.date.unformat(value);
              }
              week = value.getWeekOfYear();
              yesterday = value.clone();
              while (week === yesterday.getWeekOfYear()) {
                yesterday.add(-1).day();
              }
              return "" + (Tent.I18n.loc('tent.grouping.range.weekStarting')) + " " + (formatter(yesterday.add(1).day()));
            }
          })
        }, {
          /**
          					* @property {Object} month group dates which occur in the same month
          */

          name: 'month',
          title: Tent.I18n.loc('tent.grouping.range.month'),
          comparator: Tent.JqGrid.Grouping.comparator.create({
            compare: function(last, value) {
              return (last.getFullYear() === value.getFullYear()) && (last.getMonth() === value.getMonth());
            },
            rowTitle: function(value) {
              if (typeof value === "string") {
                value = Tent.Formatting.date.unformat(value);
              }
              return Tent.Formatting.date.format(value, 'MM') + ' ' + value.getFullYear();
            }
          })
        }, {
          /**
          					* @property {Object} quarter group dates which occur in the same quarter
          */

          name: 'quarter',
          title: Tent.I18n.loc('tent.grouping.range.quarter'),
          comparator: Tent.JqGrid.Grouping.comparator.create({
            compare: function(last, value) {
              var quarter, _ref;
              quarter = Math.floor(last.getMonth() / 3) + 1;
              return (last.getFullYear() === value.getFullYear()) && (((quarter - 1) * 3) <= (_ref = value.getMonth()) && _ref <= ((quarter - 1) * 3) + 2);
            },
            rowTitle: function(value) {
              var quarter;
              if (typeof value === "string") {
                value = Tent.Formatting.date.unformat(value);
              }
              quarter = Math.floor(value.getMonth() / 3) + 1;
              return 'Quarter ' + quarter + ', ' + value.getFullYear();
            }
          })
        }, {
          /**
          					* @property {Object} year group dates which occur in the same year
          */

          name: 'year',
          title: Tent.I18n.loc('tent.grouping.range.year'),
          comparator: Tent.JqGrid.Grouping.comparator.create({
            compare: function(last, value) {
              return last.getFullYear() === value.getFullYear();
            },
            rowTitle: function(value) {
              if (typeof value === "string") {
                value = Tent.Formatting.date.unformat(value);
              }
              return 'Year = ' + value.getFullYear();
            }
          })
        }
      ];
    },
    /**
    		* @class Tent.JqGrid.Grouping.ranges.string
    */

    string: function() {
      return [
        {
          /**
          					* @property {Object} exact group string which are the same
          */

          name: 'exact',
          title: Tent.I18n.loc('tent.grouping.range.exact'),
          comparator: Tent.JqGrid.Grouping.comparator.create()
        }
      ];
    },
    /**
    		* @class Tent.JqGrid.Grouping.ranges.number
    */

    number: function() {
      return [
        {
          /**
          					* @property {Object} exact group numbers which are the same
          */

          name: 'exact',
          title: Tent.I18n.loc('tent.grouping.range.exact'),
          comparator: Tent.JqGrid.Grouping.comparator.create()
        }, {
          /**
          					* @property {Object} 10s group numbers in ranges of ten
          */

          name: Tent.JqGrid.Grouping.helper.numeric.calculateName(10),
          title: Tent.I18n.loc('tent.grouping.range.tens'),
          comparator: Tent.JqGrid.Grouping.comparator.create({
            lower: null,
            upper: null,
            compare: Tent.JqGrid.Grouping.helper.numeric.compare,
            rowTitle: Tent.JqGrid.Grouping.helper.numeric.rowTitle,
            calculateRange: Tent.JqGrid.Grouping.helper.numeric.calculateRange(10)
          })
        }, {
          /**
          					* @property {Object} 100s group numbers in ranges of hundreds
          */

          name: Tent.JqGrid.Grouping.helper.numeric.calculateName(100),
          title: Tent.I18n.loc('tent.grouping.range.hundreds'),
          comparator: Tent.JqGrid.Grouping.comparator.create({
            lower: null,
            upper: null,
            compare: Tent.JqGrid.Grouping.helper.numeric.compare,
            rowTitle: Tent.JqGrid.Grouping.helper.numeric.rowTitle,
            calculateRange: Tent.JqGrid.Grouping.helper.numeric.calculateRange(100)
          })
        }, {
          /**
          					* @property {Object} 100s group numbers in ranges of thousands
          */

          name: Tent.JqGrid.Grouping.helper.numeric.calculateName(1000),
          title: Tent.I18n.loc('tent.grouping.range.thousands'),
          comparator: Tent.JqGrid.Grouping.comparator.create({
            lower: null,
            upper: null,
            compare: Tent.JqGrid.Grouping.helper.numeric.compare,
            rowTitle: Tent.JqGrid.Grouping.helper.numeric.rowTitle,
            calculateRange: Tent.JqGrid.Grouping.helper.numeric.calculateRange(1000)
          })
        }
      ];
    },
    /**
    		* @class Tent.JqGrid.Grouping.ranges.amount
    */

    amount: function() {
      return [
        {
          /**
          					* @property {Object} exact group amounts which are the same
          */

          name: 'exact',
          title: Tent.I18n.loc('tent.grouping.range.exact'),
          comparator: Tent.JqGrid.Grouping.comparator.create({
            rowTitle: Tent.JqGrid.Grouping.helper.amount.rowTitle
          })
        }, {
          /**
          					* @property {Object} 10s group amounts in ranges of ten
          */

          name: Tent.JqGrid.Grouping.helper.numeric.calculateName(10),
          title: Tent.I18n.loc('tent.grouping.range.tens'),
          comparator: Tent.JqGrid.Grouping.comparator.create({
            lower: null,
            upper: null,
            compare: Tent.JqGrid.Grouping.helper.numeric.compare,
            rowTitle: Tent.JqGrid.Grouping.helper.amount.rangeRowTitle,
            calculateRange: Tent.JqGrid.Grouping.helper.numeric.calculateRange(10)
          })
        }, {
          /**
          					* @property {Object} 100s group amounts in ranges of hundreds
          */

          name: Tent.JqGrid.Grouping.helper.numeric.calculateName(100),
          title: Tent.I18n.loc('tent.grouping.range.hundreds'),
          comparator: Tent.JqGrid.Grouping.comparator.create({
            lower: null,
            upper: null,
            compare: Tent.JqGrid.Grouping.helper.numeric.compare,
            rowTitle: Tent.JqGrid.Grouping.helper.amount.rangeRowTitle,
            calculateRange: Tent.JqGrid.Grouping.helper.numeric.calculateRange(100)
          })
        }, {
          /**
          					* @property {Object} 100s group amounts in ranges of thousands
          */

          name: Tent.JqGrid.Grouping.helper.numeric.calculateName(1000),
          title: Tent.I18n.loc('tent.grouping.range.thousands'),
          comparator: Tent.JqGrid.Grouping.comparator.create({
            lower: null,
            upper: null,
            compare: Tent.JqGrid.Grouping.helper.numeric.compare,
            rowTitle: Tent.JqGrid.Grouping.helper.amount.rangeRowTitle,
            calculateRange: Tent.JqGrid.Grouping.helper.numeric.calculateRange(1000)
          })
        }
      ];
    },
    /**
    		* @class Tent.JqGrid.Grouping.ranges.boolean
    */

    boolean: function() {
      return [
        {
          /**
          					* @property {Object} exact group boleans which have the same value
          */

          name: 'exact',
          title: Tent.I18n.loc('tent.grouping.range.exact'),
          comparator: Tent.JqGrid.Grouping.comparator.create()
        }
      ];
    }
  });

  /**
  * @class Tent.JqGrid.Grouping.ranges.utcdate
  */


  Tent.JqGrid.Grouping.ranges.utcdate = Tent.JqGrid.Grouping.ranges.date;

}).call(this);


(function() {

  Tent.Grid.AutofitButton = Ember.View.extend({
    classNames: ['tent-autofit'],
    template: Ember.Handlebars.compile('<a {{bindAttr title="view.title"}} {{bindAttr class=":horizontal-scroll-button :button-control view.active:active"}}><i class="icon-resize-horizontal"></i></a>'),
    title: Tent.I18n.loc("tent.jqGrid.horizontalScroll"),
    grid: null,
    active: (function() {
      return !this.get('grid.horizontalScrolling');
    }).property('grid.horizontalScrolling'),
    click: function() {
      return this.get('grid').set('horizontalScrolling', !this.get('grid').get('horizontalScrolling'));
    }
  });

}).call(this);


Ember.TEMPLATES['grid/column_chooser_button']=Ember.Handlebars.compile("<a class=\"open-dropdown button-control\">\n\t{{loc tent.jqGrid.hideShowCaption}}<i class=\"icon-caret-down\"></i>\n</a>\n<div class=\"dropdown-menu columns pull-right\">\n\t<div class=\"window\"></div>\n\t<ul>\n\t\t{{#each view.model}}\n\t\t\t<li><label><input type=\"checkbox\" {{bindAttr data-column=\"name\"}} {{bindAttr checked=\"checked\"}}/><span class=\"title\">{{loc title}}</span></label></li>\n\t\t{{/each}}\n\t</ul>\n</div>");


/**
* @mixin Tent.ToggleVisibility 
* Mixes in the ability to show/hide a subcomponent by calling {@link #toggleVisibility}.
* The subcomponent will also be hidden by clicking outside of its area, or pressing the 'escape'
*/


(function() {

  Tent.ToggleVisibility = Ember.Mixin.create({
    isShowing: false,
    /**
    	* @method bindToggleVisibility Attach an event handle to an element to allow it to toggle the visibility of another element.
    	* @param {Object} source The source jQuery object which triggers the toggle
    	* @param {Object} dest The jQuery object to show and hide
    */

    bindToggleVisibility: function(source, dest) {
      var widget;
      widget = this;
      return source.click(function(e) {
        return widget.toggleVisibility(dest, source);
      });
    },
    toggleVisibility: function(component, source) {
      if (component.css('display') === 'none') {
        return this.showComponent(component, source);
      } else {
        return this.hideComponent(component);
      }
    },
    /**
    	* @method hideComponent Hides a toggleable component
    	* @param {Object} component The jQuery object to hide
    */

    hideComponent: function(component) {
      this.set('isShowing', false);
      component.css('display', 'none');
      $('body').get(0).removeEventListener('click', this.get('hideHandler'), true);
      return $('body').get(0).removeEventListener('keyup', this.get('hideHandler'), true);
    },
    /**
    	* @method showComponent Shows a toggleable component
    	* @param {Object} component The jQuery object to show
    */

    showComponent: function(component, source) {
      this.set('isShowing', true);
      component.css('display', 'block');
      this.set('hideHandler', this.get('generateHideHandler')(this, component, source));
      $('body').get(0).addEventListener('click', this.get('hideHandler'), true);
      return $('body').get(0).addEventListener('keyup', this.get('hideHandler'), true);
    },
    generateHideHandler: function(widget, component, source) {
      return function(e) {
        if (e.keyCode === 27 || (($(e.target).closest(component).length === 0) && (e.target !== source.get(0)))) {
          widget.hideComponent(component);
          e.stopPropagation();
        }
      };
    }
  });

}).call(this);


(function() {
Tent.Grid.ColumnChooserButton = Ember.View.extend(Tent.ToggleVisibility, {
    classNames: ['column-chooser'],
    templateName: 'grid/column_chooser_button',
    grid: null,
    model: (function() {
      var annotatedModel, filteredColumns;
      filteredColumns = this.get('grid.content.filteredColumns.filtered') || [];
      annotatedModel = this.get('grid.columnModel').map(function(item) {
        item.set('checked', !item.hidden);
        return item;
      });
      return annotatedModel.filter(function(item) {
        var unfiltered;
        unfiltered = filteredColumns.length ? !filteredColumns.contains(item.name) : true;
        return unfiltered && item.hideable !== false;
      });
    }).property('grid.columnModel', 'grid.columnModel.@each', 'grid.content.isLoaded'),
    didInsertElement: function() {
      var grid;
      grid = this.get('grid');
      this.bindToggleVisibility(this.$(".open-dropdown"), this.$(".dropdown-menu"));
      return this.$().on('click', 'input', function(e) {
        var column;
        column = $(this).attr('data-column');
        if ($(this).is(':checked')) {
          return grid.showCol(column);
        } else {
          return grid.hideCol(column);
        }
      });
    }
  });

}).call(this);


Ember.TEMPLATES['filterpanel/filter_panel_view']=Ember.Handlebars.compile("\n<div class=\"filter-container slide-from-left\">\n\t\t<div>\n\t\t\t<h3>Filter</h3>\n\t\t\t<a {{action togglePin target=\"view\"}} {{bindAttr class=\":pin-button :pull-right view.isPinned:selected\"}}><i class=\"icon-pushpin\"></i></a>\n\t\t</div>\n\t\t{{#view Tent.Form formStyle=\"vertical\"}}\n\t\t\t<div class=\"filterpanel\">\n\t\t\t\t<header>\n\t\t\t\t\t<a {{action addFilterField target=\"controller\"}} class=\"add-filter-button\"><i class=\"icon-plus\"></i>{{loc tent.filter.add}}</a>\n\n\t\t\t\t\t{{view Tent.Button label=\"tent.filter.filterAction\" type=\"link\" action=\"applyFilter\" targetBinding=\"view.parentView\" class=\"filter-button\" iconClass=\"icon-caret-right\" isDisabledBinding=\"view.parentView.areAnyFieldsInvalid\" validate=true }}\n\t\t\t\t</header>\n\t\t\t\t<div class=\"content\">\n\t\t\t\t\t<div class=\"background-hint\">{{loc tent.filter.bgHint}}</div>\n\t\t\t\t\t{{#each view.controller.content}}\n\t\t\t\t\t\t{{view Tent.FilterFieldView contentBinding=\"this\" usageContextBinding=\"view.parentView.usageContext\" }}\n\t\t\t\t\t{{/each}}\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t{{/view}}\n</div>\n");

Ember.TEMPLATES['filterpanel/filter_field_view']=Ember.Handlebars.compile("<section class=\"animate-in\">\n\t<div class=\"filter-controls pull-right\">\n\t\t{{#if view.showTrashIcon}}\n\t\t\t<a {{action deleteFilterField this target=\"view.parentController\"}} title=\"{{loc tent.filter.del}}\"><i class=\"icon-trash\"></i></a>\n\t\t{{/if}}\n\t\t{{#if view.showLockIcon}}\n\t\t\t<a {{action toggleLock target=\"view\"}} title=\"{{loc tent.filter.lock}}\" {{bindAttr class=\"view.lockIsSelected:selected view.lockIsEnabled:enabled:disabled :field-lock\"}}><i class=\"icon-lock\"></i></a>\n\t\t{{/if}}\n\t</div>\n\t<div class=\"filter-field\">\n\t\t{{view Tent.Select listBinding=\"view.filterableColumns\" selectionBinding=\"controller.selectedColumn\" valueBinding=\"controller.content.field\" label=\"tent.filter.fieldname\" optionLabelPath=\"content.title\" optionValuePath=\"content.name\" multiple=false required=false preselectSingleElement=true class=\"no-label\" prompt=\"tent.filter.prompt\" disabledBinding=\"view.isDisabled\"}}\n \t\t{{#if view.typeIsSelected}}\n \t\t\t{{#if view.duplicateField}}\n \t\t\t\t<div class=\"error\">{{loc tent.filter.duplicate}}</div>\n \t\t\t{{else}}\n \t\t\t\t{{view Tent.FilterFieldControlView columnBinding=\"controller.selectedColumn\" contentBinding=\"controller.content\" isDisabledBinding=\"view.isDisabled\" isValidBinding=\"view.isValid\"}}\n \t\t\t{{/if}}\n \t\t{{/if}}\n \t</div>\n</section>\n\n\n \n");

(function() {
Tent.FilterPanelController = Ember.ArrayController.extend({
    contentBinding: 'collection.selectedFilter.values',
    collection: null,
    addFilterField: function() {
      return this.get('collection').createBlankFilterFieldValue();
    },
    removeFilterField: function(fieldContent) {
      return this.get('collection').removeFilterFieldValue(fieldContent);
    },
    applyFilter: function() {
      return this.get('collection').doFilter();
    },
    deleteFilterField: function(event) {
      return this.removeFilterField(event.context);
    },
    filterableColumns: (function() {
      var filterableCols,
        _this = this;
      filterableCols = this.get('collection.columnsDescriptor').filter(function(column) {
        return column.filterable !== false;
      });
      return filterableCols.map(function(item) {
        return Ember.copy(item, true);
      });
    }).property('collection.columnsDescriptor')
  });

  Tent.FilterPanelView = Ember.View.extend({
    templateName: 'filterpanel/filter_panel_view',
    collection: null,
    isPinned: false,
    showFilter: false,
    usageContext: null,
    validations: Ember.A(),
    init: function() {
      this._super();
      return this.set('controller', Tent.FilterPanelController.create({
        collection: this.get('collection')
      }));
    },
    collectionDidChange: (function() {
      return this.get('controller').set('collection', this.get('collection'));
    }).observes('collection', 'collection.isLoaded'),
    willDestroyElement: function() {
      if (this.get('controller') != null) {
        this.get('controller').destroy();
      }
      return this.get('validations').clear();
    },
    togglePin: function() {
      var _this = this;
      this.toggleProperty('isPinned');
      return Ember.run.next(function() {
        return $.publish("/window/resize");
      });
    },
    showFilterDidChange: (function() {
      this.set('isPinned', false);
      return $.publish("/window/resize");
    }).observes('showFilter'),
    applyFilter: function() {
      if (!this.get('isPinned')) {
        this.set('showFilter', false);
      }
      return this.get('controller').applyFilter();
    },
    fieldValidationStateChanged: function(fieldId, isValid, operatorsIsValid) {
      var allValid, field;
      allValid = isValid && operatorsIsValid;
      field = this.get('validations').findProperty('id', fieldId);
      if (field != null) {
        return field.set('value', allValid);
      } else {
        return this.get('validations').pushObject(Ember.Object.create({
          id: fieldId,
          value: allValid
        }));
      }
    },
    areAnyFieldsInvalid: (function() {
      var invalids;
      invalids = this.get('validations').findProperty('value', false);
      return invalids != null;
    }).property('validations.@each', 'validations.@each.value')
  });

  Tent.FilterFieldController = Ember.ObjectController.extend({
    selectedColumn: null,
    content: null,
    usageContext: null,
    deleteField: function() {
      return this.get('parentController').deleteFilterField(this.get('content'));
    }
  });

  Tent.FilterFieldView = Ember.View.extend({
    templateName: 'filterpanel/filter_field_view',
    classNames: ['filter-field'],
    classNameBindings: ['locked', 'duplicateField'],
    parentControllerBinding: 'parentView.parentView.controller',
    collectionBinding: 'parentView.parentView.collection',
    content: null,
    usageContext: null,
    isValid: true,
    operatorsIsValid: true,
    lockedBinding: 'content.locked',
    init: function() {
      this._super();
      if (Tent.Browsers.isIE()) {
        this.set('locked', this.get('content.locked'));
      }
      this.set('controller', this.createController());
      return this.initializeSelection();
    },
    createController: function() {
      return Tent.FilterFieldController.create({
        content: this.get('content'),
        parentController: this.get('parentController'),
        collection: this.get('collection'),
        usageContext: this.get('usageContext')
      });
    },
    initializeSelection: function() {
      var columns, selectedColumn, selectedField;
      selectedField = this.get('controller.content.field');
      if (selectedField != null) {
        columns = this.get('filterableColumns');
        selectedColumn = columns.filter(function(item) {
          return item.name === selectedField;
        });
        if (selectedColumn.length === 1) {
          return this.set('controller.selectedColumn', selectedColumn[0]);
        }
      }
    },
    filterableColumns: (function() {
      var filterableCols;
      filterableCols = this.get('parentController.filterableColumns');
      return filterableCols;
    }).property('parentController.filterableColumns'),
    willDestroyElement: function() {
      this.set('isValid', true);
      this.set('operatorsIsValid', true);
      if (this.get('controller') != null) {
        return this.get('controller').destroy();
      }
    },
    typeIsSelected: (function() {
      return this.get('content.field') != null;
    }).property('content.field'),
    duplicateField: (function() {
      var matches,
        _this = this;
      if (this.get('content.field') != null) {
        matches = this.get('collection.selectedFilter.values').filter(function(item) {
          return item.field === _this.get('content.field');
        });
        if (matches.length > 1) {
          setTimeout(function() {
            return _this.set('content.field', null);
          }, 4000);
          return true;
        }
      }
      return false;
    }).property('content.field'),
    isDisabled: (function() {
      return this.get('locked') && (!(this.get('usageContext') != null) || this.get('usageContext') === 'view');
    }).property('locked', 'usageContext'),
    toggleLock: function() {
      if (this.get('lockIsEnabled')) {
        return this.toggleProperty('locked');
      }
    },
    showLockIcon: (function() {
      return this.get('locked') || (this.get('usageContext') !== 'view' && (this.get('usageContext') != null));
    }).property('usageContext', 'locked'),
    lockIsSelected: (function() {
      return this.get('locked') && this.get('lockIsEnabled');
    }).property('locked', 'lockIsEnabled'),
    lockIsEnabled: (function() {
      return (this.get('usageContext') != null) && this.get('usageContext') !== 'view';
    }).property('usageContext'),
    showTrashIcon: (function() {
      return !(this.get('usageContext') === 'view' && this.get('locked'));
    }).property('usageContext'),
    isValidDidChange: (function() {
      return this.get('parentView.parentView').fieldValidationStateChanged(this.get('elementId'), this.get('isValid'), this.get('operatorsIsValid'));
    }).observes('isValid', 'operatorsIsValid')
  });

  Tent.FilterFieldControlView = Ember.ContainerView.extend({
    content: null,
    column: null,
    isDisabled: false,
    isValid: true,
    operatorsIsValid: true,
    init: function() {
      this._super();
      return this.populateContainer();
    },
    columnDidChange: (function() {
      return this.populateContainer();
    }).observes('column'),
    willDestroyElement: function() {
      if (!this.isDestroyed) {
        return this.resetFieldView();
      }
    },
    resetFieldView: function() {
      var _this = this;
      if (this.get('fieldView') != null) {
        return Ember.run(function() {
          if (!_this.get('fieldView').isDestroyed) {
            _this.get('fieldView').flushValidationErrors();
            _this.get('fieldView').destroy();
          }
          _this.set('parentView.content.op', "");
          _this.set('parentView.content.data', "");
          return _this.set('isValid', true);
        });
      }
    },
    populateContainer: function() {
      var coll, fieldView;
      this.resetFieldView();
      switch (this.get('column.type')) {
        case "string":
          if (this.get('column.edittype') === 'select') {
            if (this.get('column.editoptions.value') != null) {
              fieldView = Tent.Select.create({
                label: Tent.I18n.loc(this.get('column.title')),
                isFilter: true,
                list: this.get('column.editoptions.value'),
                optionLabelPath: 'content.key',
                optionValuePath: 'content.value',
                valueBinding: "parentView.content.data",
                filterOpBinding: "parentView.content.op",
                field: this.get('column.name'),
                classNames: ["no-label"],
                disabledBinding: "parentView.isDisabled",
                isValidBinding: "parentView.isValid",
                operatorsIsValidBinding: 'parentView.operatorsIsValid',
                required: true
              });
            }
            if (this.get('column.editoptions.collection')) {
              coll = eval(this.get('column.editoptions.collection.name')).fetchCollection();
              fieldView = Tent.Select.create({
                label: Tent.I18n.loc(this.get('column.title')),
                isFilter: true,
                list: coll,
                optionLabelPath: this.get('column.editoptions.collection.label'),
                optionValuePath: this.get('column.editoptions.collection.value'),
                valueBinding: "parentView.content.data",
                filterOpBinding: "parentView.content.op",
                field: this.get('column.name'),
                classNames: ["no-label"],
                disabledBinding: "parentView.isDisabled",
                isValidBinding: "parentView.isValid",
                operatorsIsValidBinding: 'parentView.operatorsIsValid',
                required: true
              });
            }
          } else {
            fieldView = Tent.TextField.create({
              label: Tent.I18n.loc(this.get('column.title')),
              isFilter: true,
              valueBinding: "parentView.content.data",
              filterOpBinding: "parentView.content.op",
              field: this.get('column.name'),
              classNames: ["no-label"],
              disabledBinding: "parentView.isDisabled",
              isValidBinding: "parentView.isValid",
              operatorsIsValidBinding: 'parentView.operatorsIsValid',
              required: true
            });
          }
          break;
        case "date":
        case "utcdate":
          fieldView = Tent.DateRangeField.create({
            label: Tent.I18n.loc(this.get('column.title')),
            isFilter: true,
            valueBinding: "parentView.content.data",
            filterOpBinding: "parentView.content.op",
            fuzzyValueBinding: "parentView.content.fuzzyData",
            allowFuzzyDates: true,
            closeOnSelect: true,
            arrows: true,
            dateFormat: "yy-mm-dd",
            classNames: ["no-label"],
            disabledBinding: "parentView.isDisabled",
            isValidBinding: "parentView.isValid",
            operatorsIsValidBinding: 'parentView.operatorsIsValid',
            required: true
          });
          break;
        case "number":
        case "amount":
          fieldView = Tent.NumericTextField.create({
            label: Tent.I18n.loc(this.get('column.title')),
            isFilter: true,
            serializer: Tent.Formatting.number.serializer,
            rangeValueBinding: "parentView.content.data",
            filterOpBinding: "parentView.content.op",
            field: this.get('column.name'),
            classNames: ["no-label"],
            disabledBinding: "parentView.isDisabled",
            isValidBinding: "parentView.isValid",
            operatorsIsValidBinding: 'parentView.operatorsIsValid',
            required: true
          });
          break;
        case "boolean":
          fieldView = Tent.Checkbox.create({
            label: Tent.I18n.loc(this.get('column.title')),
            isFilter: true,
            checkedBinding: "parentView.content.data",
            filterOpBinding: "parentView.content.op",
            field: this.get('column.name'),
            classNames: ["no-label"],
            disabledBinding: "parentView.isDisabled",
            isValidBinding: "parentView.isValid",
            operatorsIsValidBinding: 'parentView.operatorsIsValid',
            required: true
          });
      }
      if (fieldView != null) {
        this.set('fieldView', fieldView);
        return this.get('childViews').pushObject(fieldView);
      }
    }
  });

}).call(this);


Ember.TEMPLATES['grid/multiview_buttons']=Ember.Handlebars.compile("<div class=\"btn-group\" data-toggle=\"buttons-radio\">\n  <button type=\"button\" class=\"btn button active\" {{bindAttr title=\"tent.jqGrid.multiviewList\"}} data-view=\"list\" ><i class=\"icon-list\"></i></button>\n  <button type=\"button\" class=\"btn button\" {{bindAttr title=\"tent.jqGrid.multiviewCard\"}} data-view=\"card\"><i class=\"icon-th\"></i></button>\n</div>");

(function() {
Tent.Grid.MultiviewButtons = Ember.View.extend({
    templateName: 'grid/multiview_buttons',
    showCardView: false,
    showListView: true,
    didInsertElement: function() {
      return this.$('.btn-group').button();
    },
    click: function(e) {
      var selected;
      selected = this.$('.active').attr('data-view');
      switch (selected) {
        case "card":
          this.set('showCardView', true);
          return this.set('showListView', false);
        case "list":
          this.set('showCardView', false);
          return this.set('showListView', true);
        default:
          this.set('showCardView', false);
          return this.set('showListView', true);
      }
    }
  });

}).call(this);


Ember.TEMPLATES['panel']=Ember.Handlebars.compile("{{#if view.hasChildViews}}\n\t<div class=\"section accordion-group\">\n\t\t{{yield}}\n\t</div>\n{{else}}\n\t{{#if view.collapsible}}\n\t\t<div class=\"section accordion-group\">\n\t\t   \t<div class=\"panel-header clearfix\">\n\t\t    \t<h3>{{loc view.name}}</h3>\n\t\t    \t<a class=\"pull-right\" data-toggle=\"collapse\" {{bindAttr href=\"view.href\"}}>\n\t\t\t      <span class=\"caret\" ></span>\n\t\t\t    </a>\n\t\t    </div>\n\t\t    <div {{bindAttr class=\"view.collapsedClass\"}}>\n\t\t      <div class=\"panel-content\">\n\t\t        {{yield}}\n\t\t      </div>\n\t\t    </div>\n\t\t</div>\n\t \n\t{{else}}\n\t\t{{#if view.name}}<h3>{{loc view.name}}</h3>{{/if}}{{yield}}\n\t{{/if}}\n{{/if}}");


/**
* @class Tent.Panel
* A container for content which can specify a span and a title. 
* A panel can also be collapsible, in {@link #collapsible} is set to true, 
* and in that case, the initial collapsed state can be specified by {@link #collapsed}.
*
* Usage 
* 		{{#view Tent.Panel span="10" title=""}}
*			...
*		  {{/view}}
*/


(function() {
Tent.Panel = Ember.View.extend(Tent.SpanSupport, {
    layoutName: 'panel',
    classNames: ['tent-panel'],
    classNameBindings: ['spanClass', 'collapsible', 'collapsed'],
    nameBinding: 'title',
    /**
    * @property {Number} span The horizontal span which should be allocated to this widget
    */

    /**
    * @property {String} title The title to display at the top of the panel.
    */

    title: "",
    /**
    * @property collapsible Boolean to indicate that the panel is collapsible
    */

    collapsible: false,
    /**
    * @property collapsed Boolean to indicate that the panel is collapsed initially
    */

    collapsed: false,
    hideHeaderWhenExpanded: false,
    collapsedClass: (function() {
      return "collapse " + (!this.get('collapsed') ? "in" : "");
    }).property('collapsed'),
    href: (function() {
      return "#" + this.get('elementId') + " .collapse";
    }).property("elementId"),
    didInsertElement: function() {
      var _this = this;
      if (this.get('collapsible')) {
        this.$('.collapse').on('hide', function() {
          return _this.set('collapsed', true);
        });
        return this.$('.collapse').on('show', function() {
          return _this.set('collapsed', false);
        });
      }
    },
    show: function() {
      this.$('.collapse').collapse('show');
      return this.set('collapsed', false);
    },
    hide: function() {
      this.$('.collapse').collapse('hide');
      return this.set('collapsed', true);
    }
  });

  /**
  * @class Tent.PanelHead
  * Used in the case where a custom header is required for a panel
  */


  Tent.PanelHead = Ember.View.extend({
    classNames: ['accordion-heading'],
    didInsertElement: function() {
      if (this.$('.panel-link').length > 0) {
        return this.set('hasLink', true);
      }
    },
    hideHeaderContent: (function() {
      return this.get('parentView.hideHeaderWhenExpanded') && !this.get('parentView.collapsed');
    }).property('parentView.collapsed'),
    layout: Ember.Handlebars.compile('<div class="panel-header clearfix">\
        <span class="content">{{#unless view.hideHeaderContent}}{{yield}}{{/unless}}</span>\
        {{#unless view.hasLink}}\
        <a class="pull-right" data-toggle="collapse" {{bindAttr href="view.parentView.href"}}>\
          <span class="caret" ></span>\
        </a>\
        {{/unless}}\
      </div>')
  });

  Tent.PanelBody = Ember.View.extend({
    layout: Ember.Handlebars.compile('<div {{bindAttr class="view.parentView.collapsedClass"}}>\
        <div class="panel-content">\
          {{yield}}\
        </div>\
      </div>')
  });

  /**
  * @class Tent.PanelSlider
  *
  * Used where the content is expected to slide down (rather than be revealed down)
  * Effectively, the bottom row of the content becomes the header content when the 
  * panel is collapsed
  *
  * Usage: 
  *           {{#view Tent.Panel span="10" collapsible=true collapsed=false hasChildViews=true }}
                {{#view Tent.PanelSlider minHeight=40}}
                 
                  ... content here ...
                {{/view}}
              {{/view}}
  *
  */


  Tent.PanelSlider = Ember.View.extend({
    layout: Ember.Handlebars.compile('<div class="panel-slider panel-header clearfix">\
        <span class="content"><span>{{yield}}</span></span>\
        <a class="pull-right">\
          <span class="caret" ></span>\
        </a>\
      </div>'),
    minHeight: 30,
    didInsertElement: function() {
      var content,
        _this = this;
      content = this.$('.content');
      this.set('height', this.$('.content').outerHeight());
      this.$('.content').css('min-height', '30px').css('position', 'absolute').css('bottom', '0px');
      this.$('a').click(function() {
        if (_this.get('parentView.collapsed')) {
          _this.$('.panel-slider').animate({
            height: _this.get('height') + 'px'
          });
          return _this.set('parentView.collapsed', false);
        } else {
          _this.$('.panel-slider').animate({
            height: _this.get('minHeight') + 'px'
          });
          return _this.set('parentView.collapsed', true);
        }
      });
      if (!this.get('parentView.collapsed')) {
        return this.$('.panel-slider').css('height', this.get('height') + 'px');
      }
    }
  });

  /**
  * @class Tent.PanelLink
  * Generates a link for use within the body of a header. This link will expand and 
  * contract the group
  */


  Tent.PanelLink = Ember.View.extend({
    tagName: 'span',
    classNames: ['panel-link'],
    classNameBindings: ['hidden'],
    collapsedDidChange: (function() {
      return this.calculateVisibility();
    }).observes('parentView.parentView.collapsed'),
    didInsertElement: function() {
      this.set('hidden', this.get('parentView.parentView.collapsed'));
      return this.calculateVisibility();
    },
    calculateVisibility: function() {
      var hidden;
      hidden = false;
      if (this.get('whenCollapsed') != null) {
        if (this.get('whenCollapsed') !== this.get('parentView.parentView.collapsed')) {
          hidden = true;
        }
      }
      return this.set('hidden', hidden);
    },
    layout: Ember.Handlebars.compile('<a class="accordion-toggle" data-toggle="collapse" \
    {{bindAttr href="view.parentView.parentView.href"}}>\
    {{#if view.title}}{{loc view.title}}{{/if}}{{yield}}\
  </a>'),
    /**
    * @property {String} title A title to display which acts as the link text to expand the group
    */

    title: ""
  });

  Tent.Form = Tent.Panel.extend({
    tagName: 'form',
    staticClasses: '',
    classNameBindings: ['spanClass', 'staticClasses', 'formClass'],
    classNames: ['tent-form'],
    formStyle: 'horizontal',
    formClass: (function() {
      return 'form-' + this.get('formStyle');
    }).property('formStyle')
  });

  Tent.Fieldset = Tent.Panel.extend({
    layout: Ember.Handlebars.compile('{{#if view.legendName}}<legend>{{loc view.legendName}}</legend>{{/if}}{{yield}}'),
    tagName: 'fieldset'
  });

}).call(this);


(function() {

  Tent.CollapsibleSupport = Ember.Mixin.create({
    classNameBindings: ['collapsible'],
    /**
    	* @property {Boolean} collapsible A boolean which determines whether the header is collapsible.
    	* If set to true, then a {@link #title} should be provided so that there is a meaningful header 
    	* area when collapsed.
    */

    collapsible: false,
    /**
    	 * @property {Boolean} collapsed Defines whether the collapsible is collapsed initially.
    */

    collapsed: false,
    /**
    	 * @property {Boolean} useTransition This property determines whether a CSS transition is used for sliding.
    */

    useTransition: true,
    /**
    	 * @property {Boolean} horizontalSlide This property determines whether a javascript transition is used for horizontal sliding.
    */

    horizontalSlide: false,
    slideDirection: "left",
    onTransitionStep: function() {
      return $.publish("/ui/horizontalSlide", {
        source: this.$()
      });
    },
    onExpandEnd: function() {
      this.set('collapsed', false);
      this.$('').removeClass('collapsed');
      return $.publish("/ui/refresh", ['resize']);
    },
    onCollapseEnd: function() {
      this.set('collapsed', true);
      this.$('').addClass('collapsed');
      return $.publish("/ui/refresh", ['resize']);
    },
    didInsertElement: function() {
      var widget;
      this._super();
      if (this.get('collapsible')) {
        if (this.isUsingCSSTransition()) {
          widget = this;
          return this.$('').bind('webkitTransitionEnd oTransitionEnd transitionend msTransitionEnd', function() {
            widget.set('collapsed', widget.$('').hasClass('collapsed'));
            return $.publish("/ui/refresh", ['resize']);
          });
        }
      }
    },
    click: function(e) {
      var target;
      target = this.getClickArea(e);
      if (target.length && this.get('collapsible')) {
        return this.toggle();
      }
    },
    toggle: function() {
      var collapsible;
      if (this.get('horizontalSlide')) {
        collapsible = this;
        if (this.get('collapsed')) {
          return this.expand();
        } else {
          return this.collapse();
        }
      } else {
        this.$('').toggleClass('collapsed');
        if (!this.isUsingCSSTransition()) {
          return this.triggerListenersImmediately();
        }
      }
    },
    expand: function() {
      var collapsible, dir;
      if (this.get('horizontalSlide')) {
        collapsible = this;
        dir = {};
        this.$('.drag-bar').css({
          'visibility': 'hidden'
        });
        dir["" + collapsible.get("slideDirection")] = "0px";
        return this.$().animate(dir, {
          duration: 400,
          step: function() {
            return collapsible.onTransitionStep();
          },
          complete: function() {
            return collapsible.onExpandEnd();
          }
        });
      } else {
        this.$('').removeClass('collapsed');
        if (!this.isUsingCSSTransition()) {
          return this.triggerListenersImmediately();
        }
      }
    },
    collapse: function() {
      var collapsible, dir;
      if (this.get('horizontalSlide')) {
        collapsible = this;
        collapsible.set('width', collapsible.$().width());
        this.$('.drag-bar').css({
          'visibility': 'hidden'
        });
        dir = {};
        dir["" + collapsible.get("slideDirection")] = "-" + (collapsible.get('width')) + "px";
        return this.$().animate(dir, {
          duration: 400,
          step: function() {
            return collapsible.onTransitionStep();
          },
          complete: function() {
            return collapsible.onCollapseEnd();
          }
        });
      } else {
        this.$('').addClass('collapsed');
        if (!this.isUsingCSSTransition()) {
          return this.triggerListenersImmediately();
        }
      }
    },
    triggerListenersImmediately: function() {
      this.set('collapsed', this.$('').hasClass('collapsed'));
      return $.publish("/ui/refresh", ['resize']);
    },
    isUsingCSSTransition: function() {
      return this.get('useTransition') && Modernizr.csstransitions;
    },
    getClickArea: function(e) {
      if ($(e.target).hasClass('clickarea')) {
        return $(e.target);
      } else {
        return $(e.target).parentsUntil(this.$(), '.clickarea').eq(0);
      }
    }
  });

}).call(this);


(function() {

  Tent.HideableSupport = Ember.Mixin.create({
    classNameBindings: ['hideable'],
    /**
    	* @property {Boolean} hideable A boolean which determines whether the header is hideable.
    */

    hideable: false,
    /**
    	* @property {Boolean} hidden A boolean which determines whether the header is initially hidden
    */

    hidden: false,
    didInsertElement: function() {
      this._super();
      if (this.get('hideable')) {
        if (this.get('hidden')) {
          return this.hide(true);
        }
      }
    },
    /**
    	* @method hide
    	* @param {Boolean} force execute the function even if the component is already hidden
    */

    hide: function(force) {
      if (force == null) {
        force = false;
      }
      if (this.get('hideable') && (force || !this.get('hidden'))) {
        this.$('').addClass('hidden');
        this.set('hidden', true);
        return $.publish("/ui/refresh", ['resize']);
      }
    },
    /**
    	* @method show
    	* @param {Boolean} force execute the function even if the component is already shown
    */

    show: function(force) {
      if (force == null) {
        force = false;
      }
      if (this.get('hideable') && (force || this.get('hidden'))) {
        this.$('').removeClass('hidden');
        this.set('hidden', true);
        this.set('hidden', false);
        return $.publish("/ui/refresh", ['resize']);
      }
    }
  });

}).call(this);


(function() {
/**
  * @class Tent.Section
  *
  * ## Usage
  *
  *		{{#view Tent.Section span="5" vspan="12" title="_menu"}}
  *		{{/view}}
  *
  * A Section typically will contain three subsections {@link Tent.Header}, {@link Tent.Content} and
  * {@link Tent.Footer}.
  * 
  * If you provide a {@link #title}, then a {@link Tent.Header} will be generated automatically, so you
  * should **not** provide your own {@link Tent.Header} in addition to this.
  *
  */


  Tent.Section = Ember.View.extend(Tent.SpanSupport, {
    tagName: 'section',
    classNameBindings: ['spanClass', 'vspanClass', 'hClass'],
    classNames: ['tent-section'],
    /**
    	* @property {String} title The title to display in the header. If title is provided, a header section will
    	* be generated automatically.
    */

    title: null,
    /**
    	* @property {String} hLevel The header size to use if a title property is provided. e.g. '1', '2' etc
    */

    hLevel: '2',
    hClass: (function() {
      return "hlevel" + this.get('hLevel');
    }).property('hLevel'),
    formattedTitle: (function() {
      switch (this.get('hLevel')) {
        case "1":
          return '{{#if view.title}}{{#view Tent.Header}}<h1>{{loc view.parentView.title}}</h1>{{/view}}{{/if}}{{yield}}';
        case "2":
          return '{{#if view.title}}{{#view Tent.Header}}<h2>{{loc view.parentView.title}}</h2>{{/view}}{{/if}}{{yield}}';
        case "3":
          return '{{#if view.title}}{{#view Tent.Header}}<h3>{{loc view.parentView.title}}</h3>{{/view}}{{/if}}{{yield}}';
        case "4":
          return '{{#if view.title}}{{#view Tent.Header}}<h4>{{loc view.parentView.title}}</h4>{{/view}}{{/if}}{{yield}}';
        case "5":
          return '{{#if view.title}}{{#view Tent.Header}}<h5>{{loc view.parentView.title}}</h5>{{/view}}{{/if}}{{yield}}';
        default:
          return '{{#if view.title}}{{#view Tent.Header}}<h2>{{loc view.parentView.title}}</h2>{{/view}}{{/if}}{{yield}}';
      }
    }).property('title'),
    layout: (function() {
      return Ember.Handlebars.compile(this.get('formattedTitle'));
    }).property('formattedTitle')
  });

  /**
  * @class Tent.Header
  *
  * ## Usage
  *
  *		{{#view Tent.Header span="5" class="program-header"}}
  *		{{/view}}
  *
  * A Header panel will typically be used within a {@link Tent.Section}. 
  *
  * The Header may consist of a single header area, populated with a title or other nested content, or it 
  * can contain a header area (displaying a title) with a further section beneath. This arrangement is usually
  * used to provide an expanding/contracting header. If expand/contract is not required, it is standard to use a simple
  * header and put the main body in the {@link Tent.Content} widget
  */


  Tent.Header = Ember.View.extend(Tent.SpanSupport, Tent.CollapsibleSupport, Tent.HideableSupport, {
    tagName: 'header',
    classNameBindings: ['spanClass', 'useTransition:use-transition'],
    /**
    	* @property {String} title The title to be displayed in the header.
    	* You may provide a title explicitly using the title property. You may also nest content
    	* in the Header view and that will appear below the title header.
    	* If nested content is provided, but no title provided, the nested content will appear in the header section
    */

    title: null,
    formattedTitle: (function() {
      switch (this.get('hLevel')) {
        case "1":
          return '<h1>{{loc view.title}}</h1>';
        case "2":
          return '<h2>{{loc view.title}}</h2>';
        case "3":
          return '<h3>{{loc view.title}}</h3>';
        case "4":
          return '<h4>{{loc view.title}}</h4>';
        case "5":
          return '<h5>{{loc view.title}}</h5>';
        default:
          return '<h2>{{loc view.title}}</h2>';
      }
    }).property('title'),
    layout: (function() {
      if (this.get('collapsible')) {
        if (this.get('title')) {
          return Ember.Handlebars.compile('<div class="header">' + this.get('formattedTitle') + '<b class="caret clickarea"/></div>{{yield}}');
        } else {
          return Ember.Handlebars.compile('<div class="header">You must provide a title for a collapsed header</div>');
        }
      } else {
        if (this.get('title')) {
          return Ember.Handlebars.compile('<div class="header">' + this.get('formattedTitle') + '</div>{{yield}}');
        } else {
          return Ember.Handlebars.compile('<div class="header">{{yield}}</div>');
        }
      }
    }).property('formattedTitle')
  });

  /**
  * @class Tent.Content
  *
  * ## Usage
  *
  *		{{#view Tent.Content span="5"}}
  *		{{/view}}
  * A Content panel will typically be used within a {@link Tent.Section}. The panel height will change to
  * fill the available space within the Section
  */


  Tent.Content = Ember.View.extend(Tent.SpanSupport, {
    classNameBindings: ['spanClass'],
    classNames: ['content'],
    layout: Ember.Handlebars.compile('{{yield}}'),
    /**
    	 * @property {Boolean} sizeToHeaderContent Rather than using the headers css height property, the content
    	 * should shift down to accomodate the height of the headers content.
    */

    sizeToHeaderContent: false,
    didInsertElement: function() {
      this.set('section', this.$().parent('section'));
      this.set('header', this.get('section').children('header'));
      this.set('headerView', Ember.View.views[this.get('header').attr('id')]);
      return this.resize();
    },
    resize: function() {
      var footerOffset, h, headerOffset;
      this.set('footer', this.get('section').children('footer'));
      if (this.get('sizeToHeaderContent')) {
        h = $('.header', this.get('header'));
        headerOffset = h.length > 0 ? h.outerHeight(true) : 0;
      } else {
        headerOffset = this.get('header').length > 0 ? this.get('header').outerHeight(true) : 0;
      }
      this.$().css('top', headerOffset + "px");
      footerOffset = this.get('footer').length > 0 ? this.get('footer').outerHeight(true) : 0;
      return this.$().css('bottom', footerOffset + "px");
    },
    headerDidCollapse: (function() {
      return this.resize();
    }).observes('headerView.collapsed', 'headerView.hidden')
  });

  /**
  * @class Tent.Footer
  *
  * ## Usage
  *
  *		{{#view Tent.Footer span="5"}}
  *		{{/view}}
  *
  * A Footer panel will typically be used within a {@link Tent.Section}. 
  *
  */


  Tent.Footer = Ember.View.extend(Tent.SpanSupport, {
    tagName: 'footer',
    classNameBindings: ['spanClass'],
    layout: Ember.Handlebars.compile('{{yield}}'),
    didInsertElement: function() {
      var content, section;
      section = this.$().parent('section');
      content = section.children('.content');
      if (content.length > 0) {
        return Ember.View.views[content.attr('id')].resize();
      }
    }
  });

}).call(this);


(function() {
/**
  * @class Tent.HSection
  *
  * ## Usage
  *
  *		{{#view Tent.HSection vspan="12"}}
  *		{{/view}}
  *
  * A HSection typically will contain three subsections {@link Tent.Left}, {@link Tent.Center} and
  * {@link Tent.Right}.
  * 
  * The main benefit to a HSection is that the Left and Right panels can be expanded and contracted, with
  * the center panel adapting to fill the available space.
  *
  */


  Tent.HSection = Ember.View.extend(Tent.SpanSupport, {
    tagName: 'section',
    classNameBindings: ['spanClass', 'vspanClass', 'hClass'],
    classNames: ['tent-hsection'],
    layout: Ember.Handlebars.compile("{{yield}}"),
    didInsertElement: function() {
      var $left, $right;
      $left = this.$().children('.left-panel:first');
      if ($left != null) {
        this.set('left-panel', Ember.View.views[$left.attr('id')]);
      }
      $right = this.$().children('.right-panel:first');
      if ($right != null) {
        this.set('right-panel', Ember.View.views[$right.attr('id')]);
      }
      return this.listenForEvents();
    },
    willDestroyElement: function() {
      $.unsubscribe('ui/h-collapse-left');
      return $.unsubscribe('ui/h-expand-left');
    },
    expandAll: function() {
      this.get('left-panel').expand();
      return this.get('right-panel').expand();
    },
    collapseAll: function() {
      this.get('left-panel').collapse();
      return this.get('right-panel').collapse();
    },
    listenForEvents: function() {
      var _this = this;
      $.subscribe('ui/h-collapse-left', function(e, params) {
        var _ref, _ref1, _ref2;
        if (((_ref = params.source) != null ? (_ref1 = _ref.closest('.tent-hsection')) != null ? _ref1.get(0) : void 0 : void 0) === ((_ref2 = _this.$('')) != null ? _ref2.get(0) : void 0)) {
          return _this.get('left-panel').collapse();
        }
      });
      return $.subscribe('ui/h-expand-left', function(e, params) {
        var _ref, _ref1, _ref2;
        if (((_ref = params.source) != null ? (_ref1 = _ref.closest('.tent-hsection')) != null ? _ref1.get(0) : void 0 : void 0) === ((_ref2 = _this.$('')) != null ? _ref2.get(0) : void 0)) {
          return _this.get('left-panel').expand();
        }
      });
    }
  });

  /**
  * @class Tent.Left
  *
  * ## Usage
  *
  *		{{#view Tent.Left span="5" class=""}}
  *		{{/view}}
  *
  * This container should be used as part of a {@link Tent.HSection}
  * Left will appear on the left-hand side of a Tent.HSection and is collapsible.
  *
  */


  Tent.Left = Ember.View.extend(Tent.SpanSupport, Tent.CollapsibleSupport, {
    tagName: 'section',
    classNameBindings: ['spanClass', 'useTransition'],
    classNames: ['left-panel'],
    collapsible: true,
    horizontalSlide: true,
    slideDirection: "left",
    useTransition: false,
    layout: Ember.Handlebars.compile('<div class="drag-bar clickarea"><i class="icon-caret-left"></i></div><div class="panel-content">{{yield}}</div>'),
    didInsertElement: function() {
      var _this = this;
      return $.subscribe('/window/resize', function() {
        _this.repositionDragBar();
        return _this.keepAlignedWithLeft();
      });
    },
    willDestroyElement: function() {
      return $.unsubscribe('/window/resize');
    },
    onExpandEnd: function() {
      this._super();
      return this.repositionDragBar();
    },
    onCollapseEnd: function() {
      this._super();
      return this.repositionDragBar();
    },
    repositionDragBar: function() {
      var shift;
      shift = this.get('collapsed') ? 0 : 20;
      this.$('.drag-bar').css({
        'left': this.$().width() - shift,
        'visibility': 'visible'
      });
      return this.$('.drag-bar i').css({
        'visibility': 'visible'
      });
    },
    sourceIsInMySection: function(data) {
      var _ref, _ref1;
      return (data != null) && (((_ref = data.source) != null ? _ref.parent('section').get(0) : void 0) === ((_ref1 = this.$()) != null ? _ref1.parent('section').get(0) : void 0));
    },
    keepAlignedWithLeft: function(data) {
      if (this.$() != null) {
        if (this.get('collapsed') && !this.sourceIsInMySection(data)) {
          return this.$().css('left', "-" + this.$().width() + 'px');
        }
      }
    }
  });

  /**	
  * @class Tent.Center
  *
  * ## Usage
  *
  *		{{#view Tent.Center}}
  *		{{/view}}
  *
  * This container should be used as part of a {@link Tent.HSection}
  * Center will appear in the center of a Tent.HSection and will expand to fill the space available.
  */


  Tent.Center = Ember.View.extend(Tent.SpanSupport, {
    classNameBindings: ['spanClass', 'leftCollapsed', 'rightCollapsed'],
    classNames: ['center-panel'],
    layout: Ember.Handlebars.compile('{{yield}}'),
    leftView: null,
    didInsertElement: function() {
      var left, right, section,
        _this = this;
      this.resize();
      section = this.$().parent('section');
      left = section.children('.left-panel');
      right = section.children('.right-panel');
      this.set('leftView', Ember.View.views[left.attr('id')]);
      this.set('rightView', Ember.View.views[right.attr('id')]);
      $.subscribe("/ui/horizontalSlide", function(a, data) {
        return _this.resize(data);
      });
      $.subscribe("/ui/refresh", function(a, data) {
        return _this.resize();
      });
      return $.subscribe("/window/resize", function() {
        return _this.resize();
      });
    },
    resize: function(data) {
      var left, leftOffset, right, rightOffset, section;
      if (this.$() != null) {
        section = this.$().parent('section');
        left = section.children('.left-panel');
        leftOffset = left.length > 0 ? left.outerWidth(true) + left.offset().left - section.offset().left : 0;
        if (this.$().css('left') !== leftOffset + "px") {
          this.$().css('left', leftOffset + "px");
        }
        right = section.children('.right-panel');
        rightOffset = right.length > 0 ? right.outerWidth(true) - ((right.offset().left + right.outerWidth()) - (section.offset().left + section.width())) : 0;
        if (this.$().css('right') !== rightOffset + "px") {
          return this.$().css('right', rightOffset + "px");
        }
      }
    },
    siblingDidChange: (function() {
      this.set('leftCollapsed', this.get('leftView.collapsed'));
      this.set('rightCollapsed', this.get('rightView.collapsed'));
      return this.resize();
    }).observes('leftView.collapsed', 'rightView.collapsed'),
    willDestroyElement: function() {
      $.unsubscribe("/ui/refresh");
      return $.unsubscribe("/window/resize");
    }
  });

  /**
  * @class Tent.Right
  *
  * ## Usage
  *
  *		{{#view Tent.Right span="5"}}
  *		{{/view}}
  *
  * This container should be used as part of a {@link Tent.HSection}
  * Right will appear on the right-hand side of a Tent.HSection and is collapsible.
  */


  Tent.Right = Ember.View.extend(Tent.SpanSupport, Tent.CollapsibleSupport, {
    tagName: 'section',
    classNameBindings: ['spanClass', 'useTransition'],
    classNames: ['right-panel'],
    collapsible: true,
    collapsed: false,
    horizontalSlide: true,
    slideDirection: "right",
    useTransition: false,
    layout: Ember.Handlebars.compile('<div class="drag-bar clickarea"><i class="icon-caret-right"></i></div><div class="panel-content">{{yield}}</div>'),
    didInsertElement: function() {
      var _this = this;
      $.publish('/window/resize');
      $.subscribe("/ui/horizontalSlide", function(a, data) {
        return _this.keepAlignedWithRight(data);
      });
      $.subscribe("/window/resize", function(a, data) {
        return _this.keepAlignedWithRight(data);
      });
      return $.publish('/window/resize');
    },
    willDestroyElement: function() {
      $.unsubscribe('/window/resize');
      return $.unsubscribe('/ui/horizontalSlide');
    },
    keepAlignedWithRight: function(data) {
      if (this.$() != null) {
        if (this.get('collapsed') && !this.sourceIsInMySection(data)) {
          return this.$().css('right', "-" + this.$().width() + 'px');
        }
      }
    },
    sourceIsInMySection: function(data) {
      var _ref, _ref1;
      return (data != null) && (((_ref = data.source) != null ? _ref.parent('section').get(0) : void 0) === ((_ref1 = this.$()) != null ? _ref1.parent('section').get(0) : void 0));
    },
    onExpandEnd: function() {
      this._super();
      this.$('.drag-bar').css({
        'left': 0,
        'visibility': 'visible'
      });
      return this.$('.drag-bar i').css({
        'visibility': 'visible'
      });
    },
    onCollapseEnd: function() {
      this._super();
      this.$('.drag-bar').css({
        'left': 0 - 20,
        'visibility': 'visible'
      });
      return this.$('.drag-bar i').css({
        'visibility': 'visible'
      });
    }
  });

}).call(this);


Ember.TEMPLATES['checkbox']=Ember.Handlebars.compile("<div class=\"controls\">\n    <label class=\"checkbox\">\n    \t{{loc view.label}}\n    \t{{view Ember.Checkbox checkedBinding=\"view.checked\" disabledBinding = \"view.disabled\" valueBinding= \"view.value\"}}\n    </label>\n\n    {{#if view.hasWarnings}}\n      <ul class=\"help-inline warning\" {{bindAttr id=\"view.warningId\"}}>{{#each warning in view.validationWarnings}}<li>{{loc warning}}</li>{{/each}}</ul>\n    {{/if}} \n</div> ");

(function() {
Tent.Checkbox = Ember.View.extend(Tent.FieldSupport, {
    templateName: 'checkbox',
    classNames: ['tent-checkbox', 'control-group'],
    change: function() {
      this._super(arguments);
      return this.set('isValid', this.validate());
    },
    formattedValue: (function() {
      return this.get('checked');
    }).property('checked')
  });

}).call(this);


Ember.TEMPLATES['select']=Ember.Handlebars.compile("<label class=\"control-label\" {{bindAttr for=\"view.forId\"}}>{{loc view.label}}\n    <span class='tent-required'></span>\n</label>\n\n<div class=\"controls\">\n  {{#if view.isFilter}}\n    {{#if view.operators}}\n      {{view Tent.Select \n        label=\"tent.filter.operatorLabel\"\n        listBinding=\"view.operators\" \n        class=\"embed no-label operators\" \n        optionLabelPath=\"content.label\"\n        optionValuePath=\"content.operator\"\n        selectionBinding=\"view.filterSelection\"\n        valueBinding=\"view.filterOp\"\n        prompt=\"tent.filter.operatorPrompt\"\n        disabledBinding=\"view.disabled\"\n        isValidBinding=\"view.operatorsIsValid\"\n        required=true\n      }}\n    {{/if}}\n  {{/if}}\n  <div class=\"input-prepend\">\n    {{#if view.showSpinner}}\n      <div class=\"wait\"><i class=\"icon-spinner icon-spin\"></i></div>\n    {{/if}}\n    {{#if view.isTextDisplay}}\n      <span class=\"text-display\">{{loc view.currentSelectedLabel}}</span>\n    {{else}}\n      {{#if view.isRadioGroup}}\n        <div class=\"radio-group\">\n          {{view Tent.SelectElement \n                 contentBinding=\"view.list\" \n                 class=\"tent-radio-group\"\n                 optionLabelPathBinding=\"view.optionLabelPath\" \n                 optionValuePathBinding =\"view.optionValuePath\" \n                 selectionBinding=\"view.selection\"\n                 valueBinding = \"view.value\"\n                 tagName = \"div\"\n                 templateName = \"radio_group\"\n          }} \n        </div>\n      {{else}}\n        {{#if view.listIsLoaded}}\n          {{view Tent.SelectElement \n                 contentBinding=\"view.list\" \n                 classNameBindings=\"view.inputSizeClass\" \n                 class=\"primary-class\"\n                 optionLabelPathBinding=\"view.optionLabelPath\" \n                 optionValuePathBinding =\"view.optionValuePath\" \n                 selectionBinding=\"view.selection\"\n                 multipleBinding=\"view.multiple\"\n                 promptBinding = \"view._prompt\"\n                 advancedBinding=\"view.advanced\" \n                 valueBinding = \"view.value\"}} \n        {{/if}} \n      {{/if}}\n      {{#if view.hasHelpBlock}}\n        <span class=\"help-block\" {{bindAttr id=\"view.helpId\"}}>{{loc view.helpBlock}}</span>\n      {{/if}}\n    {{/if}}\n  \t{{#if view.tooltip}}\n      <a href=\"#\" rel=\"tooltip\" data-placement=\"right\" {{bindAttr data-original-title=\"view.tooltipT\"}}></a>\n    {{/if}}\n  \t{{#if view.hasErrors}}\n      \t<span class=\"help-inline\" {{bindAttr id=\"view.errorId\"}}>{{#each error in view.validationErrors}}{{error}}{{/each}}</span>\n    {{/if}}\n    {{#if view.hasWarnings}}\n      <ul class=\"help-inline\" {{bindAttr id=\"view.warningId\"}}>{{#each warning in view.validationWarnings}}<li>{{loc warning}}</li>{{/each}}</ul>\n    {{/if}}  \n  </div>\n</div>");

Ember.TEMPLATES['radio_group']=Ember.Handlebars.compile("{{#if view.prompt}}{{loc view.prompt}}{{/if}}\n{{#each view.content}}\n\t<label>{{view Tent.RadioOption contentBinding=\"this\"}}</label>\n{{/each}}");


/**
* @class Tent.Select
* @mixins Tent.FieldSupport
* @mixins Tent.TooltipSupport
*
* Usage
*        {{view Tent.Select 
            listBinding="" 
            selectionBinding="" 
            label="" 
            optionLabelPath="" 
            optionValuePath="" 
            multiple=true 
          }}
*/


(function() {
Tent.Select = Ember.View.extend(Tent.FieldSupport, Tent.TooltipSupport, Tent.FilteringSupport, {
    templateName: 'select',
    classNames: ['tent-select', 'control-group'],
    contentBinding: 'selection',
    operatorsIsValid: true,
    value: null,
    /**
    * @property {Array} list An array of objects to be presented as the dropdown options. Each item of
    * the array should be a hash of two values, representing the text to display, and the value of that option
    */

    list: null,
    /**
    * @property {Object} selection A property to which the selected item(s) from the field is bound
    */

    selection: null,
    /**
    * @property {String} optionLabelPath The name of the property of the list which is to 
    * be used as the label for the option
    */

    optionLabelPath: null,
    /**
    * @property {String} optionValuePath The name of the property of the list which is to 
    * be used as the value for the option
    */

    optionValuePath: null,
    /**
    * @property {Boolean} [multiple=false] A boolean property indicating whether multiple values may be selected.
    */

    multiple: false,
    /**
    * @property {Boolean} isRadioGroup A boolean property to indicate that the presentation should be a group of radio buttons
    */

    isRadioGroup: false,
    /**
    * @property {Boolean} [showPrompt=true] A boolean property to indicate whether a prompt should be displayed in
    * the select dropdown. 
    * If no 'prompt' property is set, the prompt will default to a message similar to 'Please Select ...'
    */

    showPrompt: true,
    /**
    * @property {Boolean} [preselectSingleElement=false] A boolean property to indicate whether a prompt 
    * should be displayed in the select dropdown if the list has only one option available. If set to true, the only option 
    * in the list will be preselected. If false, the prompt will be displayed.
    *
    */

    preselectSingleElement: false,
    /**
     * @property {Boolean} isLoading A boolean to indicate that the content for the control has not yet loaded.
     * This will usually be represented in the UI by a spinning icon.
    */

    isLoading: null,
    isLoaded: null,
    /**
    * @property {Boolean} advanced This attached Select2 behavior to the widget, allowing such features as autocomplete,
    * option formatting and tag management.
    */

    advanced: false,
    init: function() {
      this._super();
      if (this.get('list.length') === 1 && this.get('preselectSingleElement')) {
        return this.set('showPrompt', false);
      }
    },
    didInsertElement: function() {
      this._super(arguments);
      this.set('inputIdentifier', this.$('> .controls > .input-prepend > select').attr('id'));
      this.setupAdvancedMode();
      if (Tent.Browsers.isIE()) {
        this.$('.ember-select').bind('focus mouseover', function() {
          return $(this).removeClass('clicked mouseout').addClass('expand');
        }).bind('click', function() {
          $(this).toggleClass('clicked');
          if ($(this).hasClass('mouseout')) {
            return $(this).removeClass('expand');
          }
        }).bind('mouseout', function() {
          if ($(this).hasClass('clicked')) {
            return $(this).addClass('mouseout');
          } else {
            return $(this).removeClass('expand');
          }
        }).bind('blur', function() {
          return $(this).removeClass('expand clicked mouseout');
        });
      }
      return this.valueDidChange();
    },
    valueForMandatoryValidation: (function() {
      if (this.get('multiple')) {
        return this.get('selection');
      } else {
        return this.get('value');
      }
    }).property('value', 'selection'),
    formattedValue: (function() {
      return this.get('currentSelectedLabel');
    }).property('currentSelectedLabel'),
    selectionDidChange: (function() {
      return this.set('content', this.get('selection'));
    }).observes('selected'),
    valueDidChange: (function() {
      var selectedValueObject, value, valuePath,
        _this = this;
      value = this.get('value');
      if (value != null) {
        valuePath = this.get('optionValuePath').replace(/^content\.?/, '');
        selectedValueObject = this.get('list').filter(function(item) {
          return value === (valuePath != null ? Ember.get(item, valuePath) : item);
        });
        if (selectedValueObject.length === 1) {
          return this.set('selection', selectedValueObject[0]);
        }
      }
    }).observes('value'),
    listObserver: (function() {
      var _this = this;
      if (this.get('preselectSingleElement')) {
        if (this.get("list.length") === 1) {
          this.set("showPrompt", false);
          return this.set("selection", this.get("list").toArray()[0]);
        } else {
          this.set("selection", null);
          return Ember.run(function() {
            return _this.set("showPrompt", true);
          });
        }
      }
    }).observes("list", "list.length", "list@each"),
    listIsLoaded: (function() {
      if ((this.get('list.isLoadable') != null) && this.get('list.isLoadable') && this.get('list.isLoaded')) {
        this.valueDidChange();
        return this.get('list.isLoaded');
      } else {
        return true;
      }
    }).property("list", "list.length", "list@each", "list.isLoaded"),
    currentSelectedLabel: (function() {
      var content, item, labels, _i, _len;
      content = this.get('selection');
      if (content != null) {
        if (content instanceof Array) {
          labels = [];
          for (_i = 0, _len = content.length; _i < _len; _i++) {
            item = content[_i];
            labels.push(Tent.I18n.loc(this.getLabelForContent({
              content: item
            })));
          }
          return labels.join();
        } else {
          return Tent.I18n.loc(this.getLabelForContent(this));
        }
      }
    }).property('selection'),
    getLabelForContent: function(item) {
      return Ember.get(item, this.get('optionLabelPath'));
    },
    _prompt: (function() {
      var prompt;
      if (!this.get('multiple') && this.get('showPrompt')) {
        if (prompt = Tent.I18n.loc(this.get('prompt'))) {
          return prompt;
        } else {
          return Tent.I18n.loc('tent.pleaseSelect');
        }
      }
    }).property('prompt', 'showPrompt'),
    change: function(e) {
      this._super(arguments);
      this.set('isValid', this.validate());
      return e.stopPropagation();
    },
    focusOut: function(e) {
      return e.stopPropagation();
    },
    showSpinner: (function() {
      if (this.get('isLoaded') != null) {
        return !this.get('isLoaded');
      }
      if (this.get('isLoading') != null) {
        return this.get('isLoading');
      }
    }).property('isLoaded', 'isLoading'),
    setupAdvancedMode: function() {
      if (this.get('advanced') && !this.get('isRadioGroup')) {
        return this.$('.primary-class').select2({
          placeholder: this.get('_prompt'),
          allowClear: !this.get('multiple') ? true : void 0,
          dropdownAutoWidth: true
        });
      }
    },
    operators: [
      Ember.Object.create({
        label: "tent.filter.equal",
        operator: Tent.Constants.get('OPERATOR_EQUALS')
      }), Ember.Object.create({
        label: "tent.filter.nEqual",
        operator: Tent.Constants.get('OPERATOR_NOT_EQUALS')
      })
    ]
  });

  Tent.SelectElement = Ember.Select.extend(Tent.AriaSupport, Tent.Html5Support, Tent.DisabledSupport, {
    defaultTemplate: Ember.Handlebars.compile('\
    {{#if view.prompt}}\
      {{#if view.advanced}}\
        <option></option>\
      {{else}}\
        <option value>{{view.prompt}}</option>\
      {{/if}}\
    {{/if}}\
\
    {{#each option in view.content}}\
      {{#with option}}\
        {{#if isDisabled}}\
          {{view Tent.DisabledSelectOption contentBinding="this"}}\
        {{else}}\
          {{view Tent.SelectOption contentBinding="this"}}\
        {{/if}}\
      {{/with}}\
    {{/each}}')
  });

  Tent.SelectOption = Ember.SelectOption.extend({
    labelPathDidChange: Ember.observer(function() {
      var labelPath;
      labelPath = Ember.get(this, 'parentView.optionLabelPath');
      if (!labelPath) {
        return;
      }
      return Ember.defineProperty(this, 'label', Ember.computed(function() {
        if (Ember.get(this, labelPath) !== "") {
          return Tent.I18n.loc(Ember.get(this, labelPath));
        }
      }).property(labelPath).cacheable());
    }, 'parentView.optionLabelPath')
  });

  Tent.DisabledSelectOption = Ember.View.extend({
    tagName: 'optgroup',
    attributeBindings: ['label'],
    label: (function() {
      return Tent.I18n.loc(this.get(this.get('parentView.optionLabelPath')));
    }).property('')
  });

}).call(this);


(function() {

  Tent.RadioOption = Ember.SelectOption.extend({
    tagName: "div",
    classNames: ['tent-radio-option'],
    attributeBindings: ['type', 'value', 'checked', 'name'],
    type: "radio",
    layout: Ember.Handlebars.compile('<input type="radio" class="tent-radio-option"\
  	{{bindAttr value="view.value"}}\
  	{{bindAttr name="view.name"}}\
  	{{bindAttr checked="view.checked"}}/>\
  	{{loc view.label}}'),
    name: (function() {
      return this.get('parentView.elementId');
    }).property(),
    label: (function() {
      return Tent.I18n.loc(this.get('content').get(this.get('parentView.optionLabelPath')));
    }).property(),
    radioId: (function() {
      return this.get('elementId');
    }).property(),
    change: function() {
      return this.get('parentView').set('selection', this.get('content'));
    },
    didInsertElement: function() {
      this._super();
      this.set('inputIdentifier', this.$('input[type="radio"]').attr('id'));
      if (this.get('parentView.selection') === this.get('content')) {
        return this.set('checked', true);
      }
    },
    selectionDidChange: (function() {
      if (this.get('parentView.selection') === this.get('content')) {
        return this.set('checked', true);
      } else {
        return this.set('checked', false);
      }
    }).observes('parentView.selection'),
    labelPathDidChange: Ember.observer(function() {
      var labelPath;
      labelPath = Ember.get(this, 'parentView.optionLabelPath');
      if (!labelPath) {
        return;
      }
      return Ember.defineProperty(this, 'label', Ember.computed(function() {
        return Tent.I18n.loc(Ember.get(this, labelPath));
      }).property(labelPath).cacheable());
    }, 'parentView.optionLabelPath')
  });

}).call(this);


Ember.TEMPLATES['checkbox_group']=Ember.Handlebars.compile("<label class=\"control-label\">{{loc view.label}}</label>\n\n<div class=\"controls\">\n  {{#each check in view._list}}\n    {{view Ember.Checkbox checkedBinding=\"view.list.selected\" disabledBinding = \"view.disabled\" }} {{check}}\n  {{/each}}\n</div>\n\n");

(function() {
Tent.CheckboxGroup = Ember.View.extend({
    templateName: 'checkbox_group',
    classNames: ['tent-checkbox-group', 'control-group'],
    init: function() {
      this._super();
      return this.set('_list', Tent.SelectableArrayProxy.create({
        content: this.get('list')
      }) || []);
    },
    checkedDidChange: (function() {
      return this.set('selection', this.get('list.selected'));
    }).observes('list.selected')
  });

}).call(this);



/**
* @class Tent.EmailField
* @extends Tent.TextField
* A text field which allows an email address to be entered. An error message will be displayed if the user enters
* a badly-formed email.
*  
* Usage
*       {{view Tent.EmailField 
			label="" 
			valueBinding="" 
         }}
*/


(function() {
Tent.EmailTextField = Tent.TextField.extend({
    validate: function() {
      var didOtherValidationPass, isValidEmail, pattern, value;
      didOtherValidationPass = this._super();
      value = this.get('formattedValue');
      pattern = /^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$/i;
      isValidEmail = this.isValueEmpty(value) || pattern.test(value);
      if (!isValidEmail) {
        this.addValidationError(Tent.messages.EMAIL_FORMAT_ERROR);
      }
      if (didOtherValidationPass && isValidEmail) {
        this.validateWarnings();
      }
      return didOtherValidationPass && isValidEmail;
    },
    validateWarnings: function() {
      return this._super();
    },
    isValueEmpty: function(value) {
      return !((value != null) && value !== '');
    }
  });

}).call(this);


(function() {

  Tent.AlertMessage = Ember.View.extend({
    tagName: 'div',
    classNames: ['alert'],
    title: null,
    template: Ember.Handlebars.compile('<a href="#" class="close" close="close">x</a>{{#if view.title}}<span class="title">{{loc view.title}}</span>{{/if}}{{loc view.text}}'),
    init: function() {
      var classNames, type;
      this._super();
      type = this.get('type');
      classNames = this.get('classNames');
      if (type) {
        return classNames.push('alert-' + type);
      }
    },
    click: function(event) {
      var target, targetClose;
      target = event.target;
      targetClose = target.getAttribute('close');
      if (targetClose === 'close') {
        this.destroy();
        return false;
      }
    }
  });

}).call(this);


Ember.TEMPLATES['modal_pane']=Ember.Handlebars.compile("\n\t{{#if view.label}}\n\t\t{{#unless view.customButton}}\n\t\t{{view Tent.Button class=\"launch\" labelBinding=\"view.label\" aria-haspopup=\"true\" action=\"launch\" targetBinding=\"view\" typeBinding=\"view.type\"}}\n\t\t{{/unless}}\n\t{{/if}}\n\t<div class=\"modal-backdrop fade in\"></div>\n\t<div class=\"modal hide fade\" tabindex=\"-1\" role=\"dialog\" aria-hidden=\"true\" {{bindAttr data-backdrop=\"view.backdrop\"}}>\n\t\t<div class=\"modal-header\">\n\t\t\t{{view Tent.Button buttonClass=\"close-dialog close\" label=\"&times;\" actionBinding=\"view.closeAction\" targetBinding=\"view.closeTarget\" type=\"link\"}}\n\n\t\t  \t{{view Tent.ModalHeader}}\n\t\t</div>\n\t\t{{#if view.customContent}}\n\t\t\t{{yield}}\n\t\t{{else}}\n\t\t\t<div class=\"modal-body\">\n\t\t\t\t{{view Tent.MessagePanel type=\"secondary\" isActive=false collapsible=true collapsed=true}}\n\t\t\t\t{{#if view.text}}\n\t\t\t  \t\t<p>{{loc view.text}}</p>\n\t\t\t  \t{{/if}}\n\t\t\t  \t{{yield}}\n\t\t\t</div>\n\t\t\n\t\t\t<div class=\"modal-footer\">\n\t\t\t\t<div class=\"btn-toolbar\">\n\t\t\t\t  {{#if view.secondaryLabel}}\n\t\t\t\t  \t{{view Tent.Button buttonClass=\"close-dialog pull-left cancel\" labelBinding=\"view.secondaryLabel\" actionBinding=\"view.secondaryAction\" targetBinding=\"view.secondaryTarget\" typeBinding=\"view.secondaryType\" iconClassBinding=\"view.secondaryIcon\"}}\n\t\t\t\t  {{/if}}\n\t\t\t\t  {{#if view.primaryLabel}}\n\t\t\t\t  \t{{view Tent.Button buttonClassBinding=\"view.primaryButtonClass\" labelBinding=\"view.primaryLabel\" actionBinding=\"view.primaryAction\" targetBinding=\"view.primaryTarget\" typeBinding=\"view.primaryType\" iconClassBinding=\"view.primaryIcon\" validate=\"true\" warnBinding=\"view.warn\"}}\n\t\t\t\t  {{/if}}\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t{{/if}}\n\t</div>\n");

Ember.TEMPLATES['modal_body']=Ember.Handlebars.compile("<div class=\"modal-body\">\n\t{{view Tent.MessagePanel type=\"secondary\" isActive=false collapsible=true collapsed=true}}\n\t{{#if view.text}}\n  \t\t<p>{{loc view.text}}</p>\n  \t{{/if}}\n  \t{{yield}}\n</div>");

Ember.TEMPLATES['modal_footer']=Ember.Handlebars.compile("<div class=\"modal-footer\">\n\t<div class=\"btn-toolbar\">\n\t\t{{yield}}\n\t</div>\n</div>");


/**
* @class Tent.ModalPane
* Display a model popup panel.
* 
* A button will be displayed to allow the popup to be launched. You provide a {@link #label}
* and optionally a {@link #type} for the button. If no label is provided, the button will not be displayed 
* and the popup will be displayed automatically.
* You may alternatively associate a separate element to launch the popup when clicked, by specifying a {@link #customButton}
* value, which should be the id of the element.
*
* Text to go into the header of the popup is provided using the {@link #header} property.
*
* The body of the popup may be provided either by the {@link #text} property, or by nesting 
* content within the view (using {{#view}} rather than {{view}}).
*
* Labels for the button in the popup are provided by the {@link #primaryLabel} and {@link #secondaryLabel} properties.
*
* The primary button action is configured using the {@link #primaryAction} and {@link #primaryTarget} property pair.
* Similarly use {@link #secondaryAction} and {@link #secondaryTarget} for the secondary button.
* The close button (located at the top right), is bound to the secondary action, unless a {@link #closeAction} is provided.
*
* The dialog can be closed when clicking the primary button by adding 'primaryButtonClass="close-dialog"'
*
* When the dialog is closed by clicking outside the dialog, the secondary action will be called.
*
* ## Usage
*
*       {{#view Tent.ModalPane   
                text="_modalText" 
                buttonClass=""
                type="primary"
                header="_modalHeader" 
                primaryLabel="_ok" 
                secondaryLabel="_cancel"
                primaryAction="modalSubmit"
                primaryTargetBinding="Pad"
                secondaryAction="modalCancel"
                secondaryTargetBinding="Pad"
                closeAction="clearUp"
                closeTargetBinding="controller"
                primaryIcon=""
                secondaryIcon="icon-remove icon-white"
            }}
              <h5>Some more content</h5>
        {{/view}}
*
* <h4> Validation </h4>
* The primary button will by default have validation set to true. This means that widgets within the modal dialog
* will be validated on submission, and any errors that occur will be displayed in an error panel within the modal.
* The primary button will be disabled until all of the validation errors have been corrected. 
*
* ## Alternate Usage
*
* If you need more complex footer content, you can provide it with a dedicated {@link Tent.ModalFooter} view.
* In this instance, you also need to provide a {@link Tent.ModalBody} for the body content.
*
*
* Usage is like:

    {{#view Tent.ModalPane 
          label="Using Custom Footer" 
          header="_modalHeader" 
          customContent=true
    }}
      {{#view Tent.ModalBody}}
        body content goes here ...
      {{/view}}
      {{#view Tent.ModalFooter}}
        {{view Tent.Button buttonClass="close-dialog pull-left cancel" label="cancel" type="secondary"}}
        {{view Tent.Button buttonClass="" label="go" type="primary" validate=true}}
        ... other buttons ...
      {{/view}}
    {{/view}}

 - In order to use the ModalBody and ModalFooter views, you must set {@link #customContent} to true.
 - Any button that will close the dialog should have a css class of 'close-dialog'
 - The cancel button should be identified with a css class of 'cancel'. In the event that the Modal is 
 closed by this button, or the 'x' close button, or by clicking outside of the modal, then the action 
 associated with the cancel button will be executed.
*
*/


(function() {
Tent.ModalPane = Ember.View.extend({
    layoutName: 'modal_pane',
    classNames: ['tent-widget', 'control-group', 'tent-modal', 'tent-form'],
    /**
    * @property {String} label The label for the launch button
    */

    label: null,
    /**
    * @property {String} header The text to display in the header section of the modal dialog
    */

    header: null,
    /**
    * @property {String} text The text to display in the body section.
    * The dialog will also display any nested content in the body section, so in that case the 
    * text property would be optional
    */

    text: null,
    /**
    * @property {String} type The type of button used to launch the dialog. May be
    * one of {@link Tent.Button#type}
    */

    type: "primary",
    /**
    * @property {String} primaryLabel The label for the primary button
    */

    primaryLabel: null,
    /**
    * @property {String} secondaryLabel The label for the secondary button
    */

    secondaryLabel: null,
    /**
    * @property {String} primaryAction The method to execute when the primary button is clicked
    */

    primaryAction: null,
    /**
    * @property {String} primaryTarget The target providing the action to call when the primary button is clicked
    */

    primaryTarget: null,
    /**
    * @property {String} secondaryAction The method to execute when the secondary button is clicked
    */

    secondaryAction: "hide",
    /**
    * @property {String} secondaryTarget The target providing the action to call when the primary button is clicked
    */

    secondaryTarget: "parentView",
    /**
    * @property {String} primaryIcon An icon to display in the primary button
    */

    primaryIcon: null,
    /**
    * @property {String} secondaryIcon An icon to display in the secondary button
    */

    secondaryIcon: null,
    /**
    * @property {String} secondaryType The type of button to display for the secondary button. May be
    * one of {@link Tent.Button#type}
    *
    */

    secondaryType: 'secondary',
    /**
    * @property {String} primaryType The type of button to display for the primary button. May be
    * one of {@link Tent.Button#type}
    *
    */

    primaryType: 'primary',
    /**
    * @property {String} closeAction The method to execute when the close button is clicked.
    * This will default to the {@link #secondaryAction}
    */

    closeAction: null,
    /**
    * @property {String} closeTarget The target providing the action to call when the close button is clicked
    * This will default to the {@link #secondaryTarget}
    */

    closeTarget: null,
    /**
    * @property {String} customButton will allow us to link the launch of modal pane with the html element whose id we provide.
    * This will default to null
    */

    customButton: null,
    /**
    * @property {Boolean} customContent A boolean indicating that the ModalPane should not provide
    * its own body or footer. A Tent.ModalBody and Tent.ModalFooter may be provided in the nested content.
    */

    customContent: false,
    /**
    * @property {Boolean} autoLaunch A boolean to indicate whether the modal panel will be displayed on entering the 
    * screen, regardless of any other property settings.
    */

    autoLaunch: null,
    /**
    * @property {Boolean} validate Determines whether the primary button executes validations on 
    * the form widgets.
    */

    validate: true,
    /**
    * @property {Boolean} warn A boolean to indicate that warning messages will be handled by the 
    * primary button. If warning messages of a certain severity exist, a popup will be displayed to 
    * allow the user to chose to ignore the warnings.
    */

    warn: false,
    hidden: true,
    /**
    * @property {Boolean} clickOutsideToClose A boolean indicating that the ModalPane should hide when
    * click outside of modal pane..
    */

    clickOutsideToClose: true,
    init: function() {
      this._super(arguments);
      if (!(this.get('closeAction') != null)) {
        this.set('closeAction', this.get('secondaryAction'));
      }
      if (!(this.get('closeTarget') != null)) {
        return this.set('closeTarget', this.get('secondaryTarget'));
      }
    },
    didInsertElement: function() {
      var modalId, widget,
        _this = this;
      if (this.get('autoLaunch')) {
        this.launch();
      } else {
        if ((!this.cancelAutoLaunch()) && !((this.get('label') != null) || (this.get('customButton') != null))) {
          this.launch();
        }
      }
      if (this.get('customButton') != null) {
        widget = this;
        $("#" + this.get("customButton")).click(function() {
          return widget.launch();
        });
      }
      this.$(".modal:first").on("shown", function(e) {
        return $.publish("/ui/refresh", ['resize']);
      });
      this.$(".modal:first").on("hidden", function(e) {
        if (!_this.get('hidden') && _this.targetIsMessagePanel(e.target)) {
          _this.triggerCancelAction(e);
          return _this.hide();
        }
      });
      modalId = this.get('elementId');
      return this.$('.close-dialog').filter(function() {
        return $(this).parents('.tent-modal:first').attr('id') === modalId;
      }).click(function(event) {
        if (!$(event.target).attr('disabled')) {
          return _this.hide();
        }
      });
    },
    cancelAutoLaunch: function() {
      return (this.get('autoLaunch') != null) && this.get('autoLaunch') === false;
    },
    primaryButtonClass: (function() {
      if (this.get('closeOnSubmit')) {
        return '.close-dialog';
      }
    }).property('closeOnSubmit'),
    targetIsMessagePanel: function(source) {
      return this.$('.modal').get(0) === source;
    },
    enableMessagePanel: function() {
      var panel, primaryPanel;
      primaryPanel = this.getPrimaryMessagePanelView();
      panel = this.getMessagePanelView();
      if (primaryPanel != null) {
        primaryPanel.setActive(false);
      }
      if (panel != null) {
        return panel.setActive(true);
      }
    },
    disableMessagePanel: function() {
      var panel, primaryPanel;
      primaryPanel = this.getPrimaryMessagePanelView();
      panel = this.getMessagePanelView();
      if (panel != null) {
        panel.clearAll();
      }
      if (primaryPanel != null) {
        primaryPanel.setActive(true);
      }
      if (panel != null) {
        panel.setActive(false);
      }
      return this.clearValidationsOnHide();
    },
    getPrimaryMessagePanelView: function() {
      return Ember.View.views[$('.tent-message-panel.primary').attr('id')];
    },
    getMessagePanelView: function() {
      return Ember.View.views[this.$('.tent-message-panel:first').attr('id')];
    },
    clearValidationsOnHide: function(element) {
      var _this = this;
      if (element == null) {
        element = this;
      }
      element.forEachChildView(function(childView) {
        if (childView.get('childViews.length') !== 0) {
          return _this.clearValidationsOnHide(childView);
        }
      });
      if (element.get('hasErrors') && (element.flushValidationErrors != null)) {
        return element.flushValidationErrors();
      }
    },
    triggerCancelAction: function(e) {
      var buttonView, id, modal, selectedCancel;
      modal = this;
      selectedCancel = null;
      this.$('.cancel').each(function() {
        if ($(this).parents('.tent-modal:first').attr('id') === modal.get('elementId')) {
          return selectedCancel = $(this);
        }
      });
      if ((selectedCancel != null) && selectedCancel.length > 0) {
        id = selectedCancel.parent('.tent-button').attr('id');
        buttonView = Ember.View.views[id];
        return buttonView.triggerAction();
      }
    },
    willDestroyElement: function() {
      return this.hide();
    },
    launch: function() {
      this.set('hidden', false);
      this.$('.modal:first').modal(this.get('options'));
      this.fadeParentModal();
      return this.enableMessagePanel();
    },
    hide: function() {
      this.set('hidden', true);
      this.restoreParentModal();
      this.$('.modal:first').modal('hide');
      return this.disableMessagePanel();
    },
    fadeParentModal: function() {
      var parentBackdrop;
      parentBackdrop = this.$().parents('.tent-modal:first').find('.modal-backdrop:first');
      parentBackdrop.hide().attr('data-hidden', true);
      if (parentBackdrop.length > 0) {
        return this.$('.modal-backdrop:first').fadeIn(0).attr('data-hidden', false);
      } else {
        return this.$('.modal-backdrop:first').fadeIn(200).attr('data-hidden', false);
      }
    },
    restoreParentModal: function() {
      var parentBackdrop;
      parentBackdrop = this.$().parents('.tent-modal:first').find('.modal-backdrop:first');
      parentBackdrop.show().attr('data-hidden', false);
      if (parentBackdrop.length > 0) {
        return this.$('.modal-backdrop:first').fadeOut(0).attr('data-hidden', true);
      } else {
        return this.$('.modal-backdrop:first').fadeOut(200).attr('data-hidden', true);
      }
    },
    backdrop: (function() {
      if (!this.get('clickOutsideToClose')) {
        return 'static';
      } else {
        return 'true';
      }
    }).property('clickOutsideToClose')
  });

  Tent.ModalHeader = Ember.View.extend({
    tagName: 'h3',
    defaultTemplate: Ember.Handlebars.compile('{{loc view.parentView.header}}')
  });

  /**
  * @class Tent.ModalBody
  * Add a body panel to a modal dialog.
  *
  * This view should be used only within a Tent.ModalPane which has its {@link Tent.ModalPane#customContent} property set to true
  */


  Tent.ModalBody = Ember.View.extend({
    layoutName: 'modal_body'
  });

  /**
  * @class Tent.ModalFooter
  * Add a footer panel to a modal dialog.
  *
  * This view should be used only within a Tent.ModalPane which has its {@link Tent.ModalPane#customContent} property set to true
  */


  Tent.ModalFooter = Ember.View.extend({
    layoutName: 'modal_footer'
  });

}).call(this);



/**
* @class Tent.ProgressBar
* 
* Usage
* 		{{view Tent.ProgressBar isStriped=true progress="50" isAnimated=true}}
*/


(function() {

  Tent.ProgressBar = Ember.View.extend({
    classNames: ['tent-progress-bar', 'progress'],
    classNameBindings: ['isStriped:progress-striped', 'isAnimated:active'],
    template: Ember.Handlebars.compile('<div class="bar" {{bindAttr style="view.style"}}></div>'),
    /**
    * @property {Boolean} isAnimated Boolean to indicate if the bar should be rendered with a progress animation.
    */

    isAnimated: false,
    /**
    * @property {Boolean} isStriped Boolean to indicate if the bar should be rendered with stripes
    */

    isStriped: false,
    /**
    * @property {Number} progress The progress to be displayed, as a percentage between 0 and 100
    */

    progress: 0,
    style: Ember.computed(function() {
      return "width:" + this.get('progress') + "%;";
    }).property('progress')
  });

}).call(this);


Ember.TEMPLATES['button']=Ember.Handlebars.compile("<div \t{{bindAttr class=\"view.classes view.buttonClass\"}}\n\t\t{{action triggerAction target=\"view\"}}\n\t\t{{bindAttr data-toggle=\"view.dataToggle\"}}\n    {{bindAttr disabled=\"view.isDisabled\"}}\n    {{bindAttr title=\"view.localizedTitle\"}}\n\t\trole=\"button\"\n\t\t>\n  <i {{bindAttr class=\"view.iconClass\"}}></i> {{view.localizedLabel}}\n  {{#if view.hasOptions}}\n  \t <span class=\"caret\"></span>\n  {{/if}}\n</div>\n{{#if view.hasOptions}}\n\t{{collection contentBinding=\"view._options\" tagName=\"ul\" classNames=\"dropdown-menu\" itemViewClass=\"Tent.ButtonOptions\"}}\n{{/if}}\n\n{{#if view.warn}}\n\n\t{{#view Tent.ModalPane \n          viewName=\"warningPanel\"\n          autoLaunch=false\n          header=\"tent.warning.header\" \n          primaryLabel=\"tent.button.proceed\" \n          secondaryLabel=\"tent.button.dontProceed\"\n          primaryType=\"warning\"\n          primaryIcon=\"icon-ok icon-white\"\n          secondaryIcon=\"icon-remove\"\n          primaryAction=\"ignoreWarnings\"\n          primaryTargetBinding=\"view\"\n    }}\n    \t{{loc tent.warning.warningsOnPage}}\n    \t \n  \t\t{{#each view.parentView.messagePanel.warning}}\n  \t\t\t\t<div class=\"alert\">\n  \t\t\t\t\t<strong>{{loc label}}:</strong>  {{messages}}\n  \t\t\t\t</div>\n  \t\t{{/each}}\n\t\t\t \n    {{/view}}\n{{/if}}\n\n{{#if view.shouldConfirm}}\n\n  {{#view Tent.ModalPane \n          viewName=\"confirmationPanel\"\n          autoLaunch=false\n          headerBinding=\"view.confirmationTitle\" \n          primaryLabelBinding=\"view.confirmationYes\" \n          secondaryLabelBinding=\"view.confirmationNo\"\n          primaryType=\"warning\"\n          primaryIcon=\"icon-ok icon-white\"\n          secondaryIcon=\"icon-remove\"\n          primaryAction=\"confirmAction\"\n          primaryTargetBinding=\"view\"\n          closeAction=\"view.confirmationNo\"\n    }}\n\n      {{loc view.parentView.confirmationMessage}}\n      \n       \n  {{/view}}\n{{/if}}");


/**
* @class Tent.Button
*
* ##Usage
* 
*       {{view Tent.Button label="_buttonClickMe" type="primary" action="clickEvent" target="Pad"}}
*/


(function() {
Tent.Button = Ember.View.extend(Ember.TargetActionSupport, {
    classNames: ['tent-button'],
    classNameBindings: ['hasOptions:tent-button-group button-group'],
    templateName: 'button',
    /**
    * @property {String} label The label for the button
    */

    label: 'Button',
    /**
    * @property {String} title The title for the button (HTML title which shows on element hover)
    */

    title: null,
    messagePanel: null,
    localizedLabel: (function() {
      return Tent.I18n.loc(this.get('label'));
    }).property('label'),
    localizedTitle: (function() {
      return Tent.I18n.loc(this.get('title'));
    }).property('title'),
    /**
    * @property {String} type The type of button.
    * Valid types are:
    *
    * - **primary**: Provides extra visual weight and identifies the primary action in a set of buttons
    * - **info**: Used as an alternative to the default styles
    * - **success**: Indicates a successful or positive action
    * - **warning**: Indicates caution should be taken with this action
    * - **danger**: Indicates a dangerous or potentially negative action
    * - **inverse**: Alternate dark gray button, not tied to a semantic action or use
    * - **link**: Deemphasize a button by making it look like a link while maintaining button behavior
    *
    */

    type: 'primary',
    isDisabled: false,
    /**
    * @property disabled {Boolean} A boolean to indicate that the button is disabled
    */

    disabled: null,
    /**
    * @property enabled {Boolean} A boolean to indicate that the button is enabled
    * This is used as a convenience property for avoiding having to use negative handlebars bindings
    */

    enabled: null,
    /**
    * @property {String} action The action to be invoked on the target when the button is clicked
    */

    action: null,
    /**  
    * @property {Object} target The target which hosts the action function.
    */

    target: null,
    /**
    * @property {Boolean} validate If validate is set to true, all fields on the current form
    * need to be valid before the action will be executed. The Button will execute a form validation
    * if it has not happened already.
    */

    validate: false,
    /**
    * @property {Boolean} warn If warn is set to true, a dialog will be presented if there are any 
    * warnings pending on the page. The user will be asked to either proceed, ignoring the warnings, or to 
    * cancel the button action and fix the warnings. {@link #validate} must also be set to true to 
    * enable this property.
    */

    warn: false,
    /**
    * @property {String} iconClass The css class to assign an icon to the button e.g. 'icon-remove icon-white'
    */

    iconClass: null,
    optionLabelPath: 'label',
    optionTargetPath: 'target',
    optionActionPath: 'action',
    /**
    * @property {String} confirmationTitle If a confirmation is required, this will be the title for the confirmation 
    * dialog box
    */

    confirmationTitle: "tent.confirm",
    /**
    * @property {String} confirmationMessage If a confirmation is required, this will be the message to be displayed
    * in the confirmation dialog box. A confirmation dialog will only be presented if a value is provided for 
    * this property.
    */

    confirmationMessage: null,
    /**
    * @property {String} confirmationYes If a confirmation is required, this will be the label for the Yes button
    * in the confirmation dialog box
    */

    confirmationYes: "tent.button.yes",
    /**
    * @property {String} confirmationNo If a confirmation is required, this will be the label for the No button 
    * in the confirmation dialog box
    */

    confirmationNo: "tent.button.no",
    confirmed: true,
    init: function() {
      this._super();
      this.set('_options', Ember.ArrayProxy.create({
        content: this.get('optionList')
      }) || []);
      if (this.get('disabled') != null) {
        this.set('isDisabled', this.get('disabled'));
      }
      if (this.get('enabled') != null) {
        this.set('isDisabled', !this.get('enabled'));
      }
      if (this.get('confirmationMessage') != null) {
        return this.set('confirmed', false);
      }
    },
    targetObject: (function() {
      var target, value;
      target = this.get('target');
      if (Ember.typeOf(target) === "string") {
        value = Em.get(this, target);
        if (value === undefined) {
          value = Em.get(window, target);
        }
        target = value;
      }
      return target || this.get('context.target') || this.get('content') || this.get('context');
    }).property('target', 'content', 'context'),
    triggerAction: function(dontValidate) {
      if (!this.get('isDisabled') && this.get('validate') && !dontValidate === false) {
        this.doValidation();
      }
      if (!this.get('isDisabled')) {
        if (!this.get('hasOptions')) {
          if (this.get('warn') === true && this.get('doWarningsExist')) {
            return this.showWarningPanel();
          } else if ((this.get('confirmationMessage') != null) && !this.get('confirmed')) {
            return this.showConfirmationPanel();
          } else {
            return this._super();
          }
        } else {
          return this.$().toggleClass('open');
        }
      } else {
        return false;
      }
    },
    shouldConfirm: (function() {
      return (this.get('confirmationMessage') != null) && !this.get('confirmed');
    }).property('confirmationMessage'),
    confirmAction: function() {
      this.hideConfirmationPanel();
      this.set('confirmed', true);
      return this.triggerAction(true);
    },
    classes: (function() {
      var classes, type;
      classes = ((type = this.get("type")) !== null && this.BUTTON_CLASSES.indexOf(type.toLowerCase()) !== -1 ? "btn btn-" + type.toLowerCase() : "btn");
      if (this.get("hasOptions")) {
        classes = classes.concat(" dropdown-toggle");
      }
      if (this.get("isDisabled")) {
        classes = classes.concat(" disabled");
      }
      return classes;
    }).property('type', 'hasOptions', 'isDisabled'),
    hasOptions: (function() {
      var options;
      options = this.get("optionList");
      return options !== undefined && options.get('length') !== 0;
    }).property('_options'),
    BUTTON_CLASSES: ['primary', 'secondary', 'info', 'success', 'warning', 'danger', 'inverse', 'link'],
    optionList: (function() {
      var content, options;
      options = (options = this.get('options'));
      if (options === undefined && (content = this.get('content')) !== undefined) {
        options = content.get('options');
      }
      return options;
    }).property('options', 'content').volatile(),
    doValidation: function() {
      var form;
      this.setupMessageBind();
      form = this.findParentForm();
      if (form != null) {
        return this.validateChildViews(form);
      }
    },
    validateChildViews: function(parentView) {
      var view, _i, _len, _ref, _results;
      _ref = parentView.get('_childViews');
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        view = _ref[_i];
        if (typeof view.validate === 'function') {
          view.validate();
        }
        if (view.get('_childViews') != null) {
          _results.push(this.validateChildViews(view));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    },
    findParentForm: function() {
      var $form;
      $form = this.$().parents('.tent-form:first');
      if ($form.length > 0) {
        return Ember.View.views[$form.attr('id')];
      }
    },
    setupMessageBind: function() {
      var mp;
      mp = this.getMessagePanel();
      if (mp != null) {
        return this.set('messagePanel', mp);
      }
    },
    getMessagePanel: function() {
      var mp, view;
      mp = $('.tent-message-panel.active');
      if (mp.length > 0) {
        return view = Ember.View.views[mp.attr('id')];
      }
    },
    disableButtonIfErrorsExist: (function() {
      var mp;
      mp = this.get('messagePanel');
      if (mp != null) {
        return this.set('isDisabled', mp.get('hasErrors'));
      }
    }).observes('messagePanel', 'messagePanel.hasErrors'),
    disabledDidChange: (function() {
      return this.set('isDisabled', this.get('disabled'));
    }).observes('disabled'),
    enabledDidChange: (function() {
      return this.set('isDisabled', !this.get('enabled'));
    }).observes('enabled'),
    isDisabledDidChange: (function() {
      var d;
      return d = this.get('isDisabled');
    }).observes('isDisabled'),
    doWarningsExist: (function() {
      return this.get('messagePanel.hasSevereWarnings');
    }).property('messagePanel', 'messagePanel.hasSevereWarnings'),
    ignoreWarnings: function() {
      this.get('messagePanel').clearWarnings();
      this.hideWarningPanel();
      return this.triggerAction(false);
    },
    showWarningPanel: function() {
      return this.get('warningPanel').launch();
    },
    hideWarningPanel: function() {
      return this.get('warningPanel').hide();
    },
    showConfirmationPanel: function() {
      return this.get('confirmationPanel').launch();
    },
    hideConfirmationPanel: function() {
      return this.get('confirmationPanel').hide();
    }
  });

  Tent.ButtonOptions = Ember.View.extend(Ember.TargetActionSupport, {
    template: Ember.Handlebars.compile('<a href="#">{{#if view.content.iconClass}}<i {{bindAttr class="view.content.iconClass"}}></i>{{/if}} {{loc view.label}}</a>'),
    optionLabelBinding: 'parentView.parentView.optionLabelPath',
    optionTargetBinding: 'parentView.parentView.optionTargetPath',
    optionActionBinding: 'parentView.parentView.optionActionPath',
    click: function() {
      var button;
      button = this.get('parentView.parentView');
      button.$().toggleClass('open');
      return this.triggerAction();
    },
    label: (function() {
      var content;
      content = this.get('content');
      return content.get(this.get('optionLabel')) || content.get(this.get('optionAction')).camelToWords();
    }).property('content'),
    target: (function() {
      var content;
      content = this.get('content');
      return content.get(this.get('optionTarget')) || this.get("parentView.parentView.context.target") || this.get("parentView.parentView.content") || this.get("parentView.parentView.context");
    }).property('content'),
    action: (function() {
      var content;
      content = this.get('content');
      return content.get(this.get('optionAction'));
    }).property('content')
  });

}).call(this);


Ember.TEMPLATES['accordion_group']=Ember.Handlebars.compile("{{#if view.title}}\n\t<div class=\"accordion-heading\">\n\t\t<a class=\"accordion-toggle\" data-toggle=\"collapse\" \n\t\t\t{{bindAttr data-parent=\"view.dataParent\"}}\n\t\t\t{{bindAttr href=\"view.href\"}}>\n\t\t\t{{loc view.title}}\n\t\t</a>\n\t</div>\n\t<div class=\"accordion-body collapse\" {{bindAttr id=\"view.id\"}}>\n\t\t<div class=\"accordion-inner\">{{yield}}</div>\n\t</div>\n{{else}}\n\t{{yield}}\n{{/if}}\n ");

Ember.TEMPLATES['accordion_heading']=Ember.Handlebars.compile("{{#if view.title}}\n\t<span>\n\t\t<a class=\"accordion-toggle\" data-toggle=\"collapse\" \n\t\t\t{{bindAttr data-parent=\"view.dataParent\"}}\n\t\t\t{{bindAttr href=\"view.href\"}}>\n\t\t\t{{loc view.title}}\n\t\t</a>\n\t</span>\n\t<span>\n\t\t{{yield}}\n\t</span>\n{{else}}\n\t<span class=\"accordion-toggle accordion-head-content\">{{yield}}</span>\n{{/if}}\n\t ");


/**
* @class Tent.Accordion
* 
* ##Usage 1
* 
* This format can be used when simple text links can be used in the headers
*   	{{#view Tent.Accordion}}
*	      {{#view Tent.AccordionGroup title="Title1"}}
*	        {{view Tent.Button label="Button with options only" type="info" optionsBinding="Pad.btnOptions"}}
*	      {{/view}}
*	      {{#view Tent.AccordionGroup title="Title2"}}
*	          {{view Tent.TextField valueBinding="Pad.appName" label="Killer Input"}}
*	          {{view Tent.Checkbox label="Self Destruct now" checkedBinding="Pad.privacyPolicy"}}
*	      {{/view}}
*	      {{#view Tent.AccordionGroup title="Title3"}}
*	          Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid.
*	      {{/view}}
*	      {{#view Tent.AccordionGroup title="Title4"}}
*	          Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid.
*	      {{/view}}
*	    {{/view}}
*
* Where more complex content needs to go in the headers, this format may be used:
        {{#view Tent.Accordion}}
          {{#view Tent.AccordionGroup }}
            {{#view Tent.AccordionHeading title="Title1"}}
              <b>Some header content</b>  
            {{/view}}
            {{#view Tent.AccordionBody}}
              body content
            {{/view}}
          {{/view}}
           ...
        {{/view}}

* Or where the title needs to be located other than in the default position:
        {{#view Tent.Accordion}}
          {{#view Tent.AccordionGroup }}
            {{#view Tent.AccordionHeading}}
              <b>more content</b>  <span class="pull-right">{{view Tent.AccordionTitle title="x"}}</span>
            {{/view}}
            {{#view Tent.AccordionBody}}
              body content
            {{/view}}
          {{/view}}
           ...
        {{/view}}
*/


(function() {
Tent.Accordion = Ember.View.extend({
    classNames: ['accordion']
  });

  /**
  * @class Tent.AccordionGroup
  * 
  * ##Usage
  * 		{{#view Tent.AccordionGroup title="_Title1"}}
  *	        ...
  *	  	  {{/view}}
  *
  */


  Tent.AccordionGroup = Ember.View.extend({
    classNames: ['accordion-group'],
    layoutName: 'accordion_group',
    dataParent: (function() {
      return "#" + this.get("parentView.elementId");
    }).property("elementId"),
    href: (function() {
      return "#" + this.get('elementId') + " .accordion-body";
    }).property("elementId")
  });

  /**
  * @class Tent.AccordionHeading
  * Used in the case where a custom header is required for an accordion group
  */


  Tent.AccordionHeading = Ember.View.extend({
    /**
    	* @property {String} title A title to display which acts as the link text to expand the group
    	* A title may alternatively be provided by a {@link Tent.AccordionTitle} within the body of the heading
    */

    title: null,
    classNames: ['accordion-heading'],
    layoutName: 'accordion_heading',
    dataParent: (function() {
      return "#" + this.get("parentView.parentView.elementId");
    }).property("elementId"),
    href: (function() {
      return "#" + this.get('parentView.elementId') + " .accordion-body";
    }).property("elementId")
  });

  /**
  * @class Tent.AccordionTitle
  * Generates a title link for use within the body of a header. This link will expand and 
  * contract the group
  */


  Tent.AccordionTitle = Ember.View.extend({
    tagName: 'span',
    layout: Ember.Handlebars.compile('<a class="accordion-toggle" data-toggle="collapse" \
		{{bindAttr data-parent="view.dataParent"}}\
		{{bindAttr href="view.href"}}>\
		{{loc view.title}}\
	</a>'),
    /**
    	* @property {String} title A title to display which acts as the link text to expand the group
    */

    title: null,
    dataParent: (function() {
      return "#" + this.get("parentView.parentView.parentView.elementId");
    }).property("elementId"),
    href: (function() {
      return "#" + this.get('parentView.parentView.elementId') + " .accordion-body";
    }).property("elementId")
  });

  /**
  * @class Tent.AccordionBody
  * Contains the body part of an accordion group. This is used only when a {@link Tent.AccordionHeading} is required.
  */


  Tent.AccordionBody = Ember.View.extend({
    classNames: ['accordion-body', 'collapse'],
    layout: Ember.Handlebars.compile('<div class="accordion-inner">{{yield}}</div>')
  });

}).call(this);


Ember.TEMPLATES['tabs']=Ember.Handlebars.compile("<ul {{bindAttr id=\"id\"}} class=\"nav nav-tabs\"></ul>\n<div class=\"tab-content\">\n\t{{yield}}\n</div>");

(function() {
/**
  * @class Tent.Tabs
  * Display a group of {@link Tent.TabPane}s
  *
  * Usage 
  *        {{#view Tent.Tabs active="settings"}}
                {{#view Tent.TabPane id="profile" title="_profile"}}
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit.
                {{/view}}
                {{#view Tent.TabPane id="messages" title="_messages"}}
                    Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium,
                {{/view}}
                {{#view Tent.TabPane id="settings" title="_settings"}}
                    At vero eos et accusamus et iusto odio dignissimos ducimus
                {{/view}}
            {{/view}}
  */


  Tent.Tabs = Ember.View.extend({
    layoutName: 'tabs',
    fixedHeader: false,
    classNames: ['tent-tabs'],
    classNameBindings: ['fixedHeader'],
    /**
    * @property {String} active The id of the tabpane which should be initially displayed
    */

    active: null,
    didInsertElement: function() {
      var _this;
      _this = this;
      return _this.$().on("shown", 'a[data-toggle="tab"]', function(e) {
        _this.set('active', $(this).attr('href').replace('#', ''));
        return $.publish("/ui/refresh", ['tab-shown']);
      });
    }
  });

  /**
  * @class Tent.TabPane
  * An individual tab pane to be displayed as part of a {@link Tent.Tabs}
  *
  * Usage 
  *       {{#view Tent.TabPane id="profile" title="_profile"}}
              Lorem ipsum dolor sit amet, consectetur adipisicing elit.
          {{/view}}
  */


  Tent.TabPane = Ember.View.extend({
    classNames: ["tab-pane"],
    layout: Ember.Handlebars.compile('{{yield}}'),
    /**
    * @property {String} id The id of the pane. This should be unique for the page
    */

    id: null,
    /**
    * @property {String} title The title for the pane. This title will be translated and displayed in a tab by the containing {@link Tent.Tabs}.
    */

    title: null,
    init: function() {
      this._super();
      return this.set('resizeHandler', $.proxy(this.resize, this));
    },
    /**
    * The title will be updated from the bindings, but there is a race condition between the
    * Instantiation of the view and change of title, now there are two cases
    * 1) if the value is changed before this view is instantiated the observer
    * will not fire because the value is set and will not change, in that case
    * we would need to call the observer explicitely in the didInsertElement for
    * this view to render that tab element.
    * 2) if the value is set after this view is instantiated the observer will
    * automatically fire and will render the required tab element, and once
    * the value of the title is set, the observer won't do anything
    */

    didInsertElement: function() {
      this.updateTitle();
      this.resize();
      return $.subscribe("/ui/refresh", this.get('resizeHandler'));
    },
    willDestroyElement: function() {
      return $.unsubscribe("/ui/refresh", this.get('resizeHandler'));
    },
    updateTitle: (function() {
      var href, title;
      if (!Ember.empty(this.get("title"))) {
        title = Tent.I18n.loc(this.get("title"));
        href = "#" + this.get("elementId");
        if (!this.exists(href)) {
          this.get("parentView").$("ul:first").append("<li><a href=\"" + href + "\" data-toggle=\"tab\">" + title + "</a></li>");
          if (this.get("parentView.active") === this.get("elementId")) {
            return this.getTabWithHref(this.get("parentView.active")).tab("show");
          }
        }
      }
    }).observes("title"),
    /**
    * This method checks whether there already exists an element with same href as the href of this 
    * view instance, if there is it will update the element's title and return true, so that it is not 
    * appended on the tabs
    */

    exists: function(href) {
      var list, list_item, _i, _len;
      list = this.get("parentView").$("ul:first")[0].children;
      for (_i = 0, _len = list.length; _i < _len; _i++) {
        list_item = list[_i];
        if (list_item.children[0].getAttribute("href") === href) {
          $(list_item.children[0]).html(this.get('title'));
          return true;
        }
      }
      return false;
    },
    getTabWithHref: function(href) {
      return this.get("parentView").$("a[href=#" + href + "]");
    },
    resize: function() {
      var parentView, topOffset;
      parentView = this.get('parentView');
      if (parentView.get('fixedHeader')) {
        topOffset = parentView.$('.nav-tabs').height();
        return parentView.$('.tab-content').css('top', topOffset + 'px');
      }
    }
  });

}).call(this);


(function() {

  Tent.JQWidget = Em.Mixin.create({
    init: function() {
      this.set('options', this._gatherOptions());
      return this._super();
    },
    didInsertElement: function() {
      this._super();
      return this._gatherEvents(this.get('options'));
    },
    willDestroyElement: function() {
      var observers, prop, ui, _i, _len;
      this._super();
      ui = this.get('ui');
      if (ui) {
        observers = this._observers;
        for (_i = 0, _len = observers.length; _i < _len; _i++) {
          prop = observers[_i];
          this.removeObserver(prop, observers[prop]);
        }
        return ui._destroy();
      }
    },
    _gatherOptions: function() {
      var options, optionsCallback, uiOptions;
      uiOptions = this.get('uiOptions');
      options = {};
      optionsCallback = function(key) {
        var observer;
        options[key] = this.get(key) || this.get('defaultOptions')[key];
        observer = function() {
          var value;
          return value = this.get(key);
        };
        this.addObserver(key, observer);
        this._observers = this._observers || {};
        return this._observers[key] = observer;
      };
      uiOptions.forEach(optionsCallback, this);
      return options;
    },
    _gatherEvents: function(options) {
      var self, uiEvents;
      uiEvents = this.get('uiEvents') || [];
      self = this;
      return uiEvents.forEach(function(event) {
        var callback;
        callback = self[event];
        if (callback) {
          return options[event] = function(event, ui) {
            return callback.call(self, event, ui);
          };
        }
      });
    }
  });

}).call(this);



/**
* @class Tent.DateField
* @extends Tent.TextField
* Usage
*       {{view Tent.DateField label="" 
			valueBinding="" 
			showOtherMonths=true  
			dateFormat=""
				 }}
*/


(function() {
Tent.DateField = Tent.TextField.extend(Tent.JQWidget, {
    /**
    	* @property {Boolean} allowFuzzyDates The date input will accept free-form text and will attempt to parse that into
    	* a valid date
    */

    allowFuzzyDates: false,
    /**
    	* @property {String} fuzzyDate This will store the fuzzy date if one is entered by the user.
    */

    fuzzyDate: null,
    useFontIcon: true,
    fontIconClass: 'icon-calendar',
    hasParsedValue: false,
    uiType: 'datepicker',
    uiOptions: ['dateFormat', 'changeMonth', 'changeYear', 'minDate', 'maxDate', 'showButtonPanel', 'showOtherMonths', 'selectOtherMonths', 'showWeek', 'firstDay', 'numberOfMonths', 'showOn', 'buttonImage', 'buttonImageOnly', 'showAnim', 'disabled', 'constrainInput'],
    classNames: ['tent-date-field'],
    placeholder: (function() {
      return this.get('options').dateFormat;
    }).property('options.dateFormat'),
    valueForMandatoryValidation: (function() {
      return this.get('formattedValue');
    }).property('formattedValue'),
    defaultOptions: {
      dateFormat: Tent.Formatting.date.getFormat(),
      changeMonth: true,
      changeYear: true,
      showOn: "button",
      buttonImage: "stylesheet/images/calendar.gif",
      buttonImageOnly: false
    },
    optionDidChange: (function() {
      if (this.get('disabled') || this.get('isReadOnly') || this.get('readOnly')) {
        return this.$().datepicker('disable');
      } else {
        return this.$().datepicker('enable');
      }
    }).observes('disabled', 'readOnly', 'isReadOnly'),
    init: function() {
      this._super();
      if (this.get('allowFuzzyDates') && this.isFuzzyDate(this.get('fuzzyValue'))) {
        this.set('formattedValue', this.get('fuzzyValue'));
        return this.change();
      }
    },
    change: function() {
      this.set('hasParsedValue', false);
      this.set('fuzzyValue', null);
      return this.validateField();
    },
    didInsertElement: function() {
      this._super(arguments);
      if (this.get('allowFuzzyDates')) {
        this.set('options.constrainInput', false);
      }
      this.$('input').datepicker(this.get('options'));
      if (this.get('useFontIcon')) {
        return this.$('.ui-datepicker-trigger').html('<i class="' + this.get('fontIconClass') + '"></i>');
      }
    },
    validate: function() {
      var isValid, isValidDate;
      isValid = this._super();
      isValidDate = this.isDateValid(this.get("formattedValue")) || this.convertFuzzyDate(this.get("formattedValue"));
      if (!isValidDate) {
        this.addValidationError(Tent.messages.DATE_FORMAT_ERROR);
      }
      if (isValid) {
        this.validateWarnings();
      }
      return isValid && isValidDate;
    },
    isDateValid: function(dateString) {
      var valid;
      valid = true;
      try {
        $.datepicker.parseDate(this.get('dateFormat'), dateString);
      } catch (e) {
        valid = false;
      }
      return valid || (dateString === "");
    },
    convertFuzzyDate: function(date) {
      if (this.isFuzzyDate(date)) {
        this.set('formattedValue', this.format(this.parseFuzzyDate(date)));
        this.set('fuzzyValue', date);
        this.set('hasParsedValue', true);
        this.set('parsedValue', date);
        return true;
      } else {
        this.set('hasParsedValue', false);
        return false;
      }
    },
    isFuzzyDate: function(date) {
      return !!this.parseFuzzyDate(date);
    },
    parseFuzzyDate: function(date) {
      return Date.parse(date);
    },
    validateWarnings: function() {
      return this._super();
    },
    format: function(value) {
      return Tent.Formatting.date.format(value, this.get('dateFormat'));
    },
    unFormat: function(value) {
      try {
        if (this.isDateValid(value)) {
          return Tent.Formatting.date.unformat(value, this.get('dateFormat'));
        } else {
          return Tent.Formatting.date.unformat(this.parseFuzzyDate(value), this.get('dateFormat'));
        }
      } catch (error) {
        return null;
      }
    },
    focusOut: function() {
      var field, today;
      field = this.$('input.primary-class').val();
      if (!field || field === '' || field === this.get('translatedPlaceholder')) {
        today = this.format(new Date());
        this.$('input.primary-class').val(today);
        this.set('formattedValue', today);
      }
      return this.validateField();
    }
  });

}).call(this);


(function() {

  Tent.FuzzyDateSupport = Ember.Mixin.create({
    /**
    	* @property {Boolean} allowFuzzyDates The date input will accept free-form text and will attempt to parse that into
    	* a valid date
    */

    allowFuzzyDates: false,
    /**
    	* @property {String} fuzzyValue This will store the fuzzy date if one is entered by the user.
    */

    fuzzyValue: null,
    useFuzzyDates: false,
    initializeFromFuzzyValue: function() {
      var dateRange;
      dateRange = this.getDateStringFromFuzzyValue(this.get('fuzzyValue'));
      this.set('value', dateRange);
      this.set('dateValue', dateRange);
      this.setFuzzyCheckBox(true);
      this.set('useFuzzyDates', true);
      return this.set('fuzzyValueTemp', this.get('fuzzyValue'));
    },
    resetFuzzyValue: function() {
      this.setFuzzyCheckBox(false);
      this.set('dateValue', this.get('value'));
      return this.set('fuzzyValueTemp', this.get('value'));
    },
    setFuzzyCheckBox: function(isChecked) {
      return this.$('.useFuzzy').prop('checked', isChecked);
    },
    getDateStringFromFuzzyValue: function(fuzzy) {
      var end, formattedEnd, formattedStart, preset, start;
      preset = this.getPresetRangeWhichMatchesString(fuzzy);
      if (preset != null) {
        start = typeof preset.dateStart === 'string' ? Date.parse(preset.dateStart) : preset.dateStart();
        formattedStart = Tent.Formatting.date.format(start, this.get('dateFormat'));
        end = typeof preset.dateEnd === 'string' ? Date.parse(preset.dateEnd) : preset.dateEnd();
        formattedEnd = Tent.Formatting.date.format(end, this.get('dateFormat'));
        return formattedStart + this.get('rangeSplitter') + " " + formattedEnd;
      } else {
        return fuzzy;
      }
    },
    getPresetRangeWhichMatchesString: function(fDate) {
      var rangesFromPlugin;
      rangesFromPlugin = this.get('plugin.options.presetRanges');
      return rangesFromPlugin.find(function(item) {
        return item.text.removeWhitespace() === fDate;
      });
    },
    fuzzyValueDidChange: (function() {
      if (this.get('allowFuzzyDates') && this.get('useFuzzyDates')) {
        if (this.isFuzzyDateInPresetsList(this.get('fuzzyValueTemp'))) {
          this.set('fuzzyValue', this.get('fuzzyValueTemp'));
          return this.set('formattedValue', Tent.I18n.loc("tent.dateRange.presetRanges." + this.get('fuzzyValueTemp')));
        }
      } else {
        this.set('fuzzyValue', null);
        return this.set('formattedValue', this.getDateStringFromFuzzyValue(this.get('dateValue')));
      }
    }).observes('fuzzyValueTemp', 'useFuzzyDates'),
    isConventionalDate: function(date) {
      return Tent.Formatting.date.unformat(date.trim(), this.get('dateFormat')) != null;
    },
    isFuzzyDate: function(date) {
      var conventional;
      conventional = false;
      try {
        conventional = this.isConventionalDate(date);
      } catch (e) {
        conventional = false;
      }
      return this.isFuzzyDateValid(date) && !conventional;
    },
    isFuzzyDateValid: function(date) {
      return !!this.parseFuzzyDate(date);
    },
    parseFuzzyDate: function(date) {
      return Date.parse(date);
    },
    listenForFuzzyDropdownChanges: function() {
      var _this = this;
      return $("#" + this.get('dropdownId') + " li").click(function(e) {
        return _this.setFuzzyValueFromSelectedPreset(e);
      });
    },
    setFuzzyValueFromSelectedPreset: function(e) {
      var classes, fValue, li, presetArr;
      if (this.get('allowFuzzyDates')) {
        li = $(e.currentTarget);
        if (this.presetIsFuzzy(li)) {
          this.enableCheckbox();
          classes = li.attr('class').split(' ');
          presetArr = classes.find(function(item) {
            if (item.split('ui-daterangepicker-').length > 1) {
              return true;
            } else {
              return false;
            }
          });
          fValue = presetArr.split('ui-daterangepicker-')[1];
          return this.set('fuzzyValueTemp', fValue);
        } else {
          this.disableCheckbox();
          this.setCheckValue(false);
          return this.set('useFuzzyDates', false);
        }
      } else {
        return this.set('fuzzyValue', null);
      }
    },
    isFuzzyDateInPresetsList: function(date) {
      var ranges;
      if (!(date != null)) {
        return false;
      }
      ranges = this.get('plugin.options.presetRanges');
      return ranges.find(function(item) {
        return item.text.removeWhitespace() === date;
      }) != null;
    },
    presetIsFuzzy: function(li) {
      return li.attr('class').indexOf('preset_') === -1;
    },
    listenForFuzzyCheckboxChanges: function() {
      var _this = this;
      _this = this;
      return this.$('.useFuzzy').click(function(e) {
        return _this.checkWasClicked();
      });
    },
    setCheckValue: function(value) {
      return this.$('.useFuzzy').prop('checked', value);
    },
    isChecked: function() {
      return !!this.$('.useFuzzy').prop('checked');
    },
    enableCheckbox: function() {
      return this.$('.useFuzzy').prop('disabled', false);
    },
    disableCheckbox: function() {
      return this.$('.useFuzzy').prop('disabled', true);
    },
    checkWasClicked: function() {
      if (this.get('useFuzzyDates')) {
        return this.set('useFuzzyDates', false);
      } else {
        return this.set('useFuzzyDates', true);
      }
    }
  });

}).call(this);



/**
* @class Tent.DateRangeField
* @extends Tent.TextField
* 
* This widget wraps the Filament Date Range Picker control. The selected value will consist of
* two dates which are bound to the {@link #startDate} and {@link #endDate} properties. 
* The {@link #value} property is also bound with the string value of the range, as seen in the 
* input control ('date1 - date2').
*
* The initial value can be sourced from the value property if provided. If no value is provided,
* then the startDate and endDate properties will be used to initialize the control.
* 
* Usage
*       {{view Tent.DateRangeField label="" 
			valueBinding="" 
			startDateBinding=""
			endDateBinding=""
			showOtherMonths=true  
			dateFormat=""
				 }}
*/


(function() {
Tent.DateRangeField = Tent.TextField.extend(Tent.FuzzyDateSupport, {
    classNames: ['tent-date-range-field'],
    classNameBindings: ['allowFuzzyDates'],
    /**
    	* @property {Array} presetRanges Array of objects to be made into menu range presets. 
    	* 
    	* Each object requires 3 properties:
    	* - text: string, text for menu item
    	* - dateStart: date.js string, or function which returns a date object, start of date range
    	* - dateEnd: date.js string, or function which returns a date object, end of date range
    */

    presetRanges: null,
    /**
    	* @property {Array} 
    	* Available options are: 
    	* - 'specificDate'
    	* - 'allDatesBefore'
    	* - 'allDatesAfter'
    	* - 'dateRange'. 
    	*
    	* Each can be passed a string for link and label text. (example: presets: {specificDate: 'Pick a date'} )
    */

    presets: null,
    /**
    	* @property {String} rangeSplitter The character to use between two dates in the range
    */

    rangeSplitter: ',',
    /**
    	* @property {Date} earliestDate The earliest date allowed in the system. e.g. the 'All Dates Before'
    	* range will use this as the first date in the range
    */

    earliestDate: null,
    /**
    	* @property {Date} latestDate The latest date allowed in the system. e.g. the 'All Dates After'
    	* range will use this as the last date in the range
    */

    latestDate: null,
    /**
    	* @property {Boolean} closeOnSelect will close the rangepicker when a full range is selected
    */

    closeOnSelect: false,
    /**
    	* @property {Boolean} arrows will add date range advancing arrows to input.
    */

    arrows: true,
    /**
    	* @property {Date} startDate The selected start date in the range
    */

    startDate: null,
    /**
    	* @property {Date} endDate The selected end date in the range
    */

    endDate: null,
    /**
    	* @property {String} dateFormat The expected format for each date in the range
    */

    dateFormat: Tent.Formatting.date.getFormat(),
    hasOwnRangeDisplay: true,
    operators: null,
    init: function() {
      return this._super();
    },
    didInsertElement: function() {
      var widget;
      this._super(arguments);
      widget = this;
      this.set('dropdownId', this.get('elementId') + "dropdown");
      this.set('plugin', this.$('input').daterangepicker({
        id: this.get('dropdownId'),
        presetRanges: this.get('presetRanges') != null ? this.get('presetRanges') : void 0,
        presets: this.get('presets') != null ? this.get('presets') : void 0,
        rangeSplitter: this.get('rangeSplitter') != null ? this.get('rangeSplitter') : void 0,
        dateFormat: this.get('dateFormat'),
        earliestDate: this.get('earliestDate') != null ? this.get('earliestDate') : void 0,
        latestDate: this.get('latestDate') != null ? this.get('latestDate') : void 0,
        closeOnSelect: this.get('closeOnSelect'),
        arrows: this.get('arrows'),
        allowFuzzyDates: this.get('allowFuzzyDates'),
        datepickerOptions: {
          dateFormat: this.get('dateFormat')
        },
        onChange: function() {
          return widget.change();
        }
      }));
      this.initializeValue();
      this.listenForFuzzyCheckboxChanges();
      this.listenForFuzzyDropdownChanges();
      this.handleReadonly();
      this.handleDisabled();
      return this.set('filterOp', Tent.Constants.get('OPERATOR_RANGE'));
    },
    willDestroyElement: function() {
      if (!this.isDestroyed) {
        return this.$('input').remove();
      }
    },
    /**
    	* @method getValue Return the current value of the input field
    	* @return {String}
    */

    getValue: function() {
      if (this.$('.ember-text-field') != null) {
        return this.$('.ember-text-field').val();
      }
    },
    /**
    	* @method setValue Set the value of the input field
    	* @param {String} value
    */

    setValue: function(value) {
      return this.$('.ember-text-field').val(value);
    },
    initializeValue: function() {
      if (!(this.get('value') != null) && !(this.get('fuzzyValue') != null)) {
        this.setValue(this.getDateStringFromStartAndEndDates());
      }
      if (this.get('fuzzyValue') != null) {
        return this.initializeFromFuzzyValue();
      } else {
        return this.resetFuzzyValue();
      }
    },
    getDateStringFromStartAndEndDates: function() {
      var end, start;
      if (this.get('startDate') != null) {
        start = Tent.Formatting.date.format(this.get('startDate'), this.get('dateFormat'));
      }
      if (this.get('endDate') != null) {
        end = Tent.Formatting.date.format(this.get('endDate'), this.get('dateFormat'));
      }
      return start + this.get('rangeSplitter') + " " + end;
    },
    placeholder: (function() {
      return this.get('dateFormat') + this.get('rangeSplitter') + " " + this.get('dateFormat');
    }).property('dateFormat'),
    change: function(e) {
      var unformatted;
      if ((e != null) && !$(e.originalTarget).is('.useFuzzy')) {
        return;
      }
      if (!this.isFuzzyDate(this.get("formattedValue"))) {
        this.set('dateValue', this.get("formattedValue"));
      } else {
        this.set('dateValue', this.getDateStringFromFuzzyValue(this.get("formattedValue")));
      }
      this.set("fuzzyValueTemp", this.get("formattedValue"));
      this.set('isValid', this.validate());
      if (this.get('isValid')) {
        unformatted = this.unFormat(this.get('dateValue'));
        return this.set('value', this.convertSingleDateToDateRange(unformatted));
      }
    },
    focusOut: function() {},
    convertSingleDateToDateRange: function(date) {
      if (this.isFuzzyDate(date)) {
        return date;
      }
      if (date.indexOf(",") === -1) {
        date += "," + date;
      }
      return date;
    },
    validate: function() {
      var endDate, endString, isValid, isValidEndDate, isValidStartDate, startDate, startString;
      isValid = this._super();
      isValidStartDate = isValidEndDate = true;
      if ((this.get('dateValue') != null) && this.get('dateValue') !== "") {
        startString = this.getStartFromDate(this.get('dateValue'));
        if (startString != null) {
          try {
            startDate = Tent.Formatting.date.unformat(startString.trim(), this.get('dateFormat'));
            this.set('startDate', startDate);
          } catch (e) {
            isValidStartDate = false;
            this.set('startDate', null);
          }
        }
        endString = this.getEndFromDate(this.get('dateValue'));
        if (endString != null) {
          try {
            endDate = Tent.Formatting.date.unformat(endString.trim(), this.get('dateFormat'));
            this.set('endDate', endDate);
          } catch (e) {
            isValidEndDate = false;
            this.set('endDate', null);
          }
        } else {
          this.set('endDate', this.get('startDate'));
        }
      }
      if (!((isValidStartDate && isValidEndDate) || this.isFuzzyDateValid(this.get('formattedValueTemp')))) {
        this.addValidationError(Tent.messages.DATE_FORMAT_ERROR);
      }
      if (this.isFuzzyDateValid(this.get('formattedValueTemp')) || (isValid && isValidStartDate && isValidEndDate)) {
        this.validateWarnings();
      }
      return this.isFuzzyDateValid(this.get('formattedValueTemp')) || (isValid && isValidStartDate && isValidEndDate);
    },
    getStartFromDate: function(date) {
      return date.split(this.get('rangeSplitter'))[0];
    },
    getEndFromDate: function(date) {
      return date.split(this.get('rangeSplitter'))[1];
    },
    validateWarnings: function() {
      return this._super();
    },
    format: function(value) {
      return value;
    },
    unFormat: function(value) {
      return value;
    },
    readOnlyHandler: function(e) {
      e.preventDefault();
      e.stopPropagation();
      $('.ui-daterangepicker').hide();
      return false;
    },
    handleReadonly: (function() {
      if ((this.get('readOnly') != null) && this.get('readOnly')) {
        this.$('.ui-rangepicker-input').bind('click', this.get('readOnlyHandler'));
        return this.$('.ui-daterangepicker-prev, .ui-daterangepicker-next').css("visibility", "hidden");
      } else {
        this.$('.ui-rangepicker-input, .ui-daterangepicker-prev, .ui-daterangepicker-next').unbind('click', this.get('readOnlyHandler'));
        return this.$('.ui-daterangepicker-prev, .ui-daterangepicker-next').css("visibility", "visible");
      }
    }).observes('readOnly'),
    handleDisabled: (function() {
      if (this.$() != null) {
        if ((this.get('disabled') != null) && this.get('disabled')) {
          return this.$('.ui-daterangepicker-prev, .ui-daterangepicker-next').css("visibility", "hidden");
        } else {
          return this.$('.ui-daterangepicker-prev, .ui-daterangepicker-next').css("visibility", "visible");
        }
      }
    }).observes('disabled')
  });

}).call(this);


Ember.TEMPLATES['textarea']=Ember.Handlebars.compile("<label class=\"control-label\">{{loc view.label}}<span class='tent-required'></span></label>\n<div class=\"controls\">\n  <div class=\"input-prepend\">\n    {{#if view.hasPrefix}}  \n      <span class=\"add-on\">{{loc view.prefix}}</span>\n    {{/if}}     \n    {{#if view.textDisplay}}\n      <span class=\"text-display\">{{view.formattedValue}}</span>\n    {{else}}\n      {{view Tent.TextareaInput \n          classBinding=\"view.inputSizeClass\" \n          valueBinding=\"view.formattedValue\" \n          placeholderBinding=\"view.translatedPlaceholder\"\n          rowsBinding=\"view.rows\"\n          colsBinding=\"view.cols\"\n      }}\n      {{#if view.hasHelpBlock}}\n        <span class=\"help-block\" {{bindAttr id=\"view.helpId\"}}>{{loc view.helpBlock}}</span>\n      {{/if}}\n    {{/if}}\n    {{#if view.tooltip}}\n      <a href=\"#\" rel=\"tooltip\" data-placement=\"right\" {{bindAttr data-original-title=\"view.tooltipT\"}}></a>\n    {{/if}}\n    {{#if view.hasHelpBlock}}\n      <span class=\"help-block\">{{loc view.helpBlock}}</span>\n    {{/if}}\n    {{#if view.hasErrors}}\n      <span class=\"help-inline\" {{bindAttr id=\"view.errorId\"}}>{{#each error in view.validationErrors}}{{error}}{{/each}}</span>\n    {{/if}}  \n  </div>\n\n</div>\n");


/**
* @class Tent.Textarea
* @mixins Tent.FormattingSupport
* @mixins Tent.FieldSupport
* @mixins Tent.TooltipSupport
* @mixins Tent.AriaSupport
* @mixins Tent.Html5Support
* @mixins Tent.ReadonlySupport
* @mixins Tent.DisabledSupport
* Usage
*      {{view Tent.Textarea label="" valueBinding="" }}
* @property {String} label
* @property {Boolean} readonly
*/


(function() {
Tent.Textarea = Ember.View.extend(Tent.FormattingSupport, Tent.FieldSupport, Tent.TooltipSupport, {
    templateName: 'textarea',
    classNames: ['tent-textarea', 'control-group'],
    valueForMandatoryValidation: (function() {
      return this.get('formattedValue');
    }).property('formattedValue'),
    didInsertElement: function() {
      this._super();
      return this.set('inputIdentifier', this.$('textarea').attr('id'));
    },
    focusOut: function() {},
    change: function() {
      return this.validateField();
    }
  });

  Tent.TextareaInput = Ember.TextArea.extend(Tent.AriaSupport, Tent.Html5Support, Tent.ReadonlySupport, Tent.DisabledSupport);

}).call(this);


(function() {

  Tent.Breadcrumb = Ember.View.extend({
    router: null,
    homeState: 'home',
    classNames: ['tent-breadcrumb'],
    template: Ember.Handlebars.compile('{{#collection tagName="ul" contentBinding="view.content"}}\
				<button class="btn btn-link" {{bindAttr data-state="view.content.name"}}>{{loc view.content.title}} <i class="icon-chevron-right"></i></button>\
			{{/collection}}'),
    init: function() {
      this._super();
      return this.generateBreadcrumb();
    },
    generateBreadcrumb: (function() {
      var currentState, path;
      if (this.get('router') != null) {
        currentState = this.get('router').get('currentState');
        path = [];
        this.addPathItem(currentState, path);
        while (currentState.get('parentState') != null) {
          currentState = currentState.get('parentState');
          if (currentState != null) {
            this.addPathItem(currentState, path);
          }
        }
        return this.set('content', path.reverse());
      }
    }).observes('router.currentState'),
    addPathItem: function(state, arr) {
      if ((state.get('name') != null) && state.get('title')) {
        arr.push(Ember.Object.create({
          name: state.get('name'),
          title: state.get('title')
        }));
      }
      return arr;
    },
    click: function(e) {
      var state;
      state = $(e.target).attr("data-state");
      if (state != null) {
        return this.get('router').transitionTo(state);
      }
    }
  });

}).call(this);


Ember.TEMPLATES['file_upload']=Ember.Handlebars.compile("<span class='btn btn-primary fileinput-button'>\n  {{#if view.helpText}}\n  \t<span><i class=\"icon-upload-alt\"></i>&nbsp; &nbsp;{{loc view.helpText}}</span>\n  {{/if}}\n  <input type=\"file\" name=\"files[]\" {{bindAttr data-url=\"view.dataUrl\" disabled=\"view.disabled\"}} multiple >\n  {{#if view.applyWait}}\n     {{view Tent.WaitIcon}}\n  {{/if}}\n</span>\n\n\n\n ");

(function() {
Tent.FileUpload = Ember.View.extend({
    templateName: 'file_upload',
    classNameBindings: ['tent-file-upload'],
    /**
    * @property {helpText} helpText The text to appear on the file upload button
    */

    helpText: 'tent.upload.buttonLabel',
    /**
    * @property {disabled} disabled A boolean to enable or disable the widget
    */

    disabled: false,
    /**
    * @property {Boolean} dropZone The classname associated with an element which is to act as the 
    * target for drag and drop
    */

    dropZone: null,
    /**
    * @property {Hash} formData Additional params that needs to be send to server along with the 
    * uploaded files
    */

    formData: null,
    didInsertElement: function() {
      var _this = this;
      return this.$('input').fileupload({
        dropZone: this.getDropZone(),
        add: function(e, data) {
          _this.set('applyWait', true);
          data.formData = _this.get('formData');
          return data.submit().success(_this.uploadResultFunctionWrapper(_this.get('parentView.controller'), 'Success')).error(_this.uploadResultFunctionWrapper(_this.get('parentView.controller'), 'Error'));
        }
      });
      /*
          @getDropZone()?.bind('mouseenter', ->
            $(@).addClass('hover')
          ).bind('mouseleave',->
            $(@).removeClass('hover')
          )
      */

    },
    getDropZone: function() {
      if (this.get('dropZone') != null) {
        return $('.' + this.get('dropZone'));
      }
    },
    uploadResultFunctionWrapper: function(context, name) {
      var resultFunction, self;
      resultFunction = this.get('upload' + name + 'Function');
      self = this;
      if (context && resultFunction) {
        return function(result, textStatus, jqXHR) {
          self.set('applyWait', false);
          return resultFunction.apply(context, arguments);
        };
      } else {
        return function(result, textStatus, jqXHR) {
          self.set('applyWait', false);
          return void 0;
        };
      }
    }
  });

}).call(this);


Ember.TEMPLATES['message_panel']=Ember.Handlebars.compile("{{#if view.hasErrors}}\n<section class=\"alert-error clearfix\">\n\t<h5>Errors</h5>\n\t{{#if view.collapsible}}\n\t\t<div {{bindAttr class=\"view.expandoClass\"}}>\n\t\t\t{{#each view.error}}\n\t\t\t\t<div class=\"error-message\" {{bindAttr data-target=\"this.sourceId\"}}>\n\t  \t\t\t\t{{#if this.label}}<label>{{loc this.label}}: </label>{{/if}}<ul>{{#each this.messages}}<li>{{this}}</li>{{/each}}</ul>\n\t  \t\t\t</div> \n\t\t  \t{{/each}}\n\t\t  \t{{#if view.hasMoreThanOneError}}\n\t\t\t\t<a class=\"dropdown-toggle pull-right close collapsed\" data-toggle=\"collapse\" data-target=\".error-expando\">\n\t\t\t\t\t<b class=\"caret\"></b>\n\t\t\t\t</a>\n\t\t\t{{/if}}\n\t\t</div>\n\t\t\n\t{{else}}\n\t\t<div>\n\t\t\t{{#each view.error}}\n\t\t\t\t<div class=\"error-message\" {{bindAttr data-target=\"this.sourceId\"}}>\n\t  \t\t\t\t{{#if this.label}}<label>{{loc this.label}}: </label>{{/if}}<ul>{{#each this.messages}}<li>{{this}}</li>{{/each}}</ul>\n\t  \t\t\t</div> \n\t\t  \t{{/each}}\n\t\t</div>\n\t{{/if}}\n</section>\n{{/if}}\n\n{{#if view.hasInfos}}\n<section class=\"alert-info clearfix\">\n\t{{view Tent.Button label=\"x\" type=\"link\" action=\"clearInfos\" targetBinding=\"view\" class=\"close\"}}\n\t<h5>Info</h5>\n\t<div class=\"info-expando\">\n\t\t{{#each view.info}}\n\t\t\t<div class=\"info-message\" {{bindAttr data-target=\"this.sourceId\"}}>{{this.messages}}</div> \n\t  \t{{/each}}\n\t</div>\n</section>\n{{/if}}\n\n{{#if view.hasSuccesses}}\n<section class=\"alert-success clearfix\">\n\t{{view Tent.Button label=\"x\" type=\"link\" action=\"clearSuccesses\" targetBinding=\"view\" class=\"close\"}}\n\t<h5>Success</h5>\n\t<div class=\"info-expando\">\n\t\t{{#each view.success}}\n\t\t\t<div class=\"success-message\" {{bindAttr data-target=\"this.sourceId\"}}>{{this.messages}}</div> \n\t  \t{{/each}}\n\t</div>\n</section>\n{{/if}}\n\n{{#if view.hasWarnings}}\n\t{{#each view.warning}}\n\t\t<section class=\"alert clearfix\" {{bindAttr data-target=\"this.sourceId\"}} data-type=\"warning\">\n\t\t\t{{view Tent.Button label=\"x\" type=\"link\" action=\"removeMessageCommand\" targetBinding=\"view\" class=\"close\"}}\n\t\t\t<h5>Warning</h5>\n\t\t\t\t<div>\n\t\t\t\t\t<div class=\"error-message\" {{bindAttr data-target=\"this.sourceId\"}}>\n\t\t  \t\t\t\t<label>{{loc this.label}}:</label> {{this.messages}}\n\t\t  \t\t\t</div> \n\t\t\t \t</div>\n\t\t</section>\n\t{{/each}}\n{{/if}}\n\n");

(function() {
/**
   * @class Tent.MessagePanel
   * @extends Ember.View
   *
   * A panel for displaying error and information messages for the application.
   *
   * All Tent widgets will publish messages when they are in an error state and these will
   * be displayed dynamically by the MessagePanel. If there are no errors, the panel will be hidden.
   * Each error message will identify the source of the error, if provided, and can also send focus
   * to the source widget when clicked.
   *
   * Error messages can also be displayed by explicitly publishing them, setting type='error'
   *
   * 			$.publish('/message', {
   					type:'error', 
   					messages:['Date format incorrect'], 
   					sourceId: 'ember13'
   					label: 'Date'
   			})
   *
   * - **type**: The type of message, can be 'error', 'info', 'success' or 'warning'
   * - **messages**: An array of messages to display
   * - **sourceId**: If the message refers to a Tent widget, provide the elementId of the widget
   * so that focus can be transferred to it when the error is clicked
   * - **label**: The label to display beside the messages for this source
   *
   * Each source will be allocated one line in the MessagePanel. If there are no messages for
   * a source, it will be removed from the MessagePanel. So in effect, to clear the messages for a source, send an
   * empty messages array
   * 			
   * 			$.publish('/message', {
   					type:'error', 
   					messages:[], 
   					sourceId: 'ember13'
   			})
   * 
   * Information messages are displayed as-is, with no linking to source widgets.
   *
   * 			$.publish('/message', {
   					type:'info', 
   					messages:['Please call this number for assistance..']
   			})
   *
   * If you wish to display more than one message, use different sourceId's in the published message.
   *
   * The default state of the MessagePanel is collapsed and showing the first message. The panel can 
   * be expanded if there is more than one message. The panel can be permanently expanded by setting the 
   * {@link #collapsible} property to false. The default collapse state can be set with the {@link #collapsed}
   * property.
   *
   * 
   *
   * ##Usage
   *         {{view Tent.MessagePanel}}
   *
  */


  Tent.MessagePanel = Ember.View.extend({
    templateName: 'message_panel',
    classNames: ['tent-message-panel'],
    classNameBindings: ['type', 'isActive:active'],
    title: null,
    /**
    	* @property {String} type Defines the type of message panel. Typically there will be one 'primary'
    	* panel per application. Modal dialogues may also have 'secondary' panels which become active when the
    	* panels are displayed
    */

    type: 'primary',
    /**
     	* @property {Boolean} collapsible A boolean indicating that the panel is collapsible
    */

    collapsible: true,
    /**
     	* @property {Boolean} collapsed A boolean indicating that the panel is collapsed by default
    */

    collapsed: true,
    /**
    	* @property {Boolean} isActive One message panel should be active at a time, usually the primary one.
    	* When a popup is displayed, it's message panel will usually become active, with the primary panel becoming
    	* inactive.
    */

    isActive: true,
    init: function() {
      this._super();
      this.clearAll();
      this.set('handler', $.proxy(this.handleNewMessage(), this));
      this.showContainerWhenVisible();
      return $.subscribe('/message', this.get('handler'));
    },
    didInsertElement: function() {
      return this.getParentContainer();
    },
    willDestroy: function() {
      $.unsubscribe('/message', this.get('handler'));
      return this._super();
    },
    setActive: function(isActive) {
      return this.set('isActive', isActive);
    },
    handleNewMessage: function() {
      return function(e, msg) {
        var arrayWithMessageRemoved;
        if (this.get('isActive')) {
          if (!(msg.type != null)) {
            throw new Error('Message must have a type');
          }
          if (msg.type === 'clearAll') {
            return this.clearAll();
          } else {
            arrayWithMessageRemoved = [];
            if (msg.messages != null) {
              arrayWithMessageRemoved = this.get(msg.type).filter(function(item, index, enumerable) {
                return item.sourceId !== msg.sourceId;
              });
              if (msg.messages.length > 0) {
                arrayWithMessageRemoved.pushObject($.extend({}, msg));
              }
              return this.set(msg.type, arrayWithMessageRemoved);
            }
          }
        }
      };
    },
    getParentContainer: function() {
      var header;
      header = this.$('').parents('header.hideable:first');
      if (header.length > 0) {
        return this.set('parentContainer', Ember.View.views[header.attr('id')]);
      }
    },
    showContainerWhenVisible: (function(forceShow) {
      if (forceShow == null) {
        forceShow = false;
      }
      if (this.get('parentContainer') != null) {
        if (this.get('hasErrors') || this.get('hasInfos') || this.get('hasSuccesses') || this.get('hasWarnings')) {
          return this.get('parentContainer').show(forceShow);
        } else {
          return this.get('parentContainer').hide();
        }
      }
    }).observes('hasErrors', 'hasInfos', 'hasWarnings', 'hasSuccesses'),
    expandoClass: (function() {
      if (this.get('collapsed')) {
        return "error-expando collapse";
      } else {
        return "error-expando collapse in";
      }
    }).property('collapsed'),
    /**
    	 * return the error messages
    */

    getErrorsForView: function(viewId) {
      var error, errors, _i, _len, _ref;
      errors = [];
      _ref = this.get('error');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        error = _ref[_i];
        if (error.sourceId === viewId) {
          $.merge(errors, error.messages);
        }
      }
      return errors.uniq();
    },
    getInfosForView: function(viewId) {
      var info, infos, _i, _len, _ref;
      infos = [];
      _ref = this.get('info');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        info = _ref[_i];
        if (info.sourceId === viewId) {
          $.merge(infos, info.messages);
        }
      }
      return infos.uniq();
    },
    getSuccessesForView: function(viewId) {
      var success, successes, _i, _len, _ref;
      successes = [];
      _ref = this.get('success');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        success = _ref[_i];
        if (success.sourceId === viewId) {
          $.merge(successes, success.messages);
        }
      }
      return successes.uniq();
    },
    removeMessage: function(type, id) {
      var msgArr;
      msgArr = this.get(type);
      return this.set(type, msgArr.filter(function(item, index, enumerable) {
        return item.sourceId !== id;
      }));
    },
    removeMessageCommand: function(button) {
      var id, section, type;
      section = button.$().parent('section');
      type = section.attr('data-type');
      id = section.attr('data-target');
      this.removeMessage(type, id);
      return this.stopProcessingWarnings(id);
    },
    stopProcessingWarnings: function(id) {
      var view;
      view = Ember.View.views[id];
      if (view != null) {
        view.set('processWarnings', false);
        return view.flushValidationWarnings();
      }
    },
    hasErrors: (function() {
      return this.get('error').length > 0;
    }).property('error', 'error.@each'),
    hasInfos: (function() {
      return this.get('info').length > 0;
    }).property('info', 'info.@each'),
    hasSuccesses: (function() {
      return this.get('success').length > 0;
    }).property('success', 'success.@each'),
    hasWarnings: (function(severity) {
      return this.get('warning').length > 0;
    }).property('warning', 'warning.@each'),
    hasSevereWarnings: (function() {
      var hasW, w, _i, _len, _ref;
      hasW = false;
      _ref = this.get('warning');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        w = _ref[_i];
        if (w.severity === 'high') {
          return true;
        }
      }
      return hasW;
    }).property('warning', 'warning.@each'),
    hasFirstLongTextError: (function() {
      var _this = this;
      return Ember.run.next(this, function() {
        var firstError;
        firstError = _this.$('.error-message:first');
        if (firstError != null) {
          return _this.$('.error-expando').css('min-height', firstError.height() + "px");
        }
      });
    }).observes('error', 'error.@each'),
    ensureContainerResizesAfterDomRenders: (function() {
      var _this = this;
      return Ember.run.next(this, function() {
        return _this.showContainerWhenVisible(true);
      });
    }).observes('error', 'warning', 'success', 'info', 'error.@each', 'warning.@each', 'success.@each', 'info.@each'),
    hasMoreThanOneError: (function() {
      return this.get('error').length > 1;
    }).property('error', 'error.@each'),
    clearAll: function() {
      this.clearErrors();
      this.clearInfos();
      this.clearSuccesses();
      return this.clearWarnings();
    },
    clearErrors: function() {
      return this.set('error', []);
    },
    clearInfos: function() {
      return this.set('info', []);
    },
    clearSuccesses: function() {
      return this.set('success', []);
    },
    clearWarnings: function() {
      return this.set('warning', []);
    },
    click: function(e) {
      var target, targetId, wrappingMessage;
      target = $(e.target);
      wrappingMessage = target.closest('.error-message', this.$());
      if ((wrappingMessage != null) && wrappingMessage.length > 0) {
        targetId = wrappingMessage.attr('data-target');
        if (Ember.View.views[targetId] != null) {
          return Ember.View.views[targetId].focus();
        }
      }
    }
  });

  Tent.Message = Ember.Object.extend({
    messages: null,
    params: null,
    type: null,
    sourceId: null
  });

  Tent.Message.ERROR_TYPE = 'error';

  Tent.Message.INFO_TYPE = 'info';

  Tent.Message.SUCCESS_TYPE = 'success';

  Tent.Message.WARNING_TYPE = 'warning';

}).call(this);



/**
* @class Tent.Spinner
* @extends Tent.TextField
* Usage
*       {{view Tent.Spinner label="" 
					valueBinding="" 
					minBinding="" 
					maxBinding=""
         }}
  value can be entered maually in the spinner. 
  To put restrictions on that use custom validation: valueBetween
			  {{view Tent.Spinner label="" 
						valueBinding="" 
						minBinding="" 
						maxBinding="" 
						validations="valueBetween"
			      validationOptions="{valueBetween:{min:2, max:20}}"}}
  To restrict only one min/max value, give the other as null   
  			eg: validationOptions = "{valueBetween:{min:null, max:20}}"
*/


(function() {
Tent.Spinner = Tent.NumericTextField.extend(Tent.JQWidget, {
    uiType: 'spinner',
    uiEvents: ['change'],
    uiOptions: ['max', 'min', 'icons', 'culture', 'disabled', 'incremental', 'numberFormat', 'step', 'page'],
    classNames: ['tent-spinner'],
    defaultOptions: {
      min: 0,
      change: this.change
    },
    init: function() {
      return this._super();
    },
    didInsertElement: function() {
      this._super(arguments);
      return this.$('input').spinner(this.get('options'));
    },
    optionsDidChange: (function() {
      if (this.get('min')) {
        this.$('input').spinner({
          'min': this.get('min')
        });
      }
      if (this.get('max')) {
        this.$('input').spinner({
          'max': this.get('max')
        });
      }
      if (this.get('disabled') || this.get('isReadOnly') || this.get('readOnly')) {
        return this.$('input').spinner('disable');
      } else {
        return this.$('input').spinner('enable');
      }
    }).observes('min', 'max', 'disabled', 'readOnly', 'isReadOnly'),
    change: function(event, ui) {
      if (isNaN(Number(this.$('input').attr('value')))) {
        this.$('input').attr('value', null);
      }
      return this.set('value', this.$('input').spinner('value'));
    }
  });

}).call(this);


(function() {

  Tent.WaitIcon = Ember.View.extend({
    template: Ember.Handlebars.compile('<div class="wait"><i class="icon-spinner icon-spin icon-2x"></i></div>')
  });

}).call(this);



/**
* @class Tent.Tree
*
* Usage
*        {{view Tent.Tree
            contentBinding="" 
            selectionBinding="" 
            aria=""
            activeVisible=""
            autoActivate=""
            autoScroll=""
            checkbox=""
            folderOnClickShould=""
            disabled=""
            icons=""
            keyboard=""
            nodeSelection=""
            tabbable=""
            radio=""
          }}
*/


(function() {

  Tent.Tree = Ember.View.extend({
    template: (function() {
      var guid;
      guid = Ember.guidFor(this);
      return Ember.Handlebars.compile("<div id=\"" + guid + "-tree\" {{bindAttr class=\"view.radio:fancytree-radio\"}}></div>");
    }).property(),
    classNames: ['tent-tree'],
    /**
    * @property {Boolean} [aria=false] A boolean property which enables/disables WAI-ARIA support.
    */

    aria: false,
    /**
    * @property {Boolean} [activeVisible=true] A boolean property which makes sure active nodes
    * are visible (expanded).
    */

    activeVisible: true,
    /**
    * @property {Boolean} [autoActivate=true] A boolean property indicating whether to
    * automatically activate a node when it is focused (using keys).
    */

    autoActivate: true,
    /**
    * @property {Boolean} [autoCollapse=false] A boolean property indicating whether to
    * automatically collapse all siblings, when a node is expanded.
    */

    autoCollapse: false,
    /**
    * @property {Boolean} [autoScroll=false] A boolean property indicating whether to
    * automatically scroll nodes into visible area
    */

    autoScroll: false,
    /**
    * @property {Boolean} [checkbox=false] A boolean property responsible for displaying
    * checkboxes on the nodes.
    */

    checkbox: false,
    /**
    * @property {String} folderOnClickShould The property responsible for the folder click behaviour
    * If the value is 'expandOnDblClick' the folder expands only on double click
    * If the value is 'activate' the folder gets activated (not selected) on click
    * If the value is 'expand' the folder expands on click (not selected & activated)
    * If the value is 'activateAndExpand' the folder is expanded & activated on click
    */

    folderOnClickShould: 'expandOnDblClick',
    /**
    * @property {Boolean} [disabled=false] A boolean property responsible for enabling/disabling
    * the entire tree
    */

    disabled: false,
    /**
    * @property {Array} extensions built for the fancytree widget which we wish to load
    * must be specified here.
    */

    extensions: [],
    /**
    * @property {Boolean} [generateIds=true] A boolean property indicating whether to generate
    * unique ids for li elements.
    */

    generateIds: false,
    /**
    * @property {Boolean} [icons=true] when true icons for the nodes are displayed on the UI
    */

    icons: false,
    /**
    * @property {Boolean} [keyboard=true] A boolean property indicating keyboard navigation support
    */

    keyboard: true,
    /**
    * @property {String} nodeSelecion The property resposible for node selection behaviour
    * If the value is 'singleSelect' user can select only one node
    * If the value is 'multiSelect' user can select multiple nodes
    * If the value is 'heirMultiSelect' user can select all the children on selecting parent node
    */

    nodeSelection: 'multiSelect',
    /**
    * @property {Boolean} [tabbable=true] a boolean indicating whether the whole tree behaves as one single control
    */

    tabbable: true,
    /**
    * @property {Integer} minExpandLevel Locks expand/collapse for all the nodes on the given minExpandLevel value
    */

    minExpandLevel: 1,
    /**
    * @property {Boolean} [radio=false] Displays radio buttons instead of checkboxes when set to true
    * property checkbox must be set to true in order to see the radio button.
    * To simulate radio group behavior the property nodeSelection must be set to 'singleSelect'
    * else we will have multi-select radio buttons.
    */

    radio: false,
    /**
    * @property {Array} content an array of parent child relationship which is responsible for 
    * rendering the tree.
    * Example:
    * [
    *  {
    *    title: 'Node Title', 
    *    folder: true, // the value must be set to true else folderOnClickShould value wont have any effect
    *    tooltip: 'tooltip that needs to be displayed for the node on hover',
    *    extraClasses: 'class1 class2', //Adding classes to nodes,
    *    expanded: true, //Will be expanded on load
    *    lazy: true, //TODO, children will be loaded via AJAX call
    *    children: [
    *      {
    *        title: "<span>can enter HTML too using a span tag </span>",
    *        value: 100 // if it is a leaf node then we must specify the value, which will be 
    *                  // collected in selection array on selection.
    *      },
    *      {title: 'child 2', value: 'can be any data type'}
    *    ]
    *  }
    * ]
    *
    */

    content: Em.A(),
    /**
    * @property {Array} selection an array which holds selected leafnode values from the tree.
    */

    selection: Em.A(),
    selectMode: (function() {
      switch (this.get('nodeSelection')) {
        case 'singleSelect':
          return 1;
        case 'multiSelect':
          return 2;
        case 'heirMultiSelect':
          return 3;
        default:
          return 2;
      }
    }).property('nodeSelection'),
    clickFolderMode: (function() {
      switch (this.get('folderOnClickShould')) {
        case 'activate':
          return 1;
        case 'expand':
          return 2;
        case 'activateAndExpand':
          return 3;
        case 'expandOnDblClick':
          return 4;
        default:
          return 4;
      }
    }).property('folderOnClickShould'),
    addArrayObservers: function(array) {
      var _this = this;
      return array.addArrayObserver(Em.Object.create({
        arrayWillChange: function(array, start, removeCount, addCount) {
          if (removeCount && removeCount === array.get('length')) {
            _this.get('selection').clear();
            _this.reloadTree([]);
            return _this.rerender();
          } else if (removeCount) {
            return _this.removeNodes(array.slice(start, start + removeCount));
          }
        },
        arrayDidChange: function(array, start, removeCount, addCount) {
          if (addCount && addCount === array.get('length')) {
            return _this.reloadTree(array);
          } else if (addCount) {
            return _this.addNodes(array.slice(start, start + addCount));
          }
        }
      }));
    },
    contentDidChange: (function() {
      if (!this.contentIsValid()) {
        return;
      }
      this.reloadTree(this.get('content'));
      this.addArrayObservers(this.get('content'));
      return this.get('selection').clear();
    }).observes('content'),
    contentIsValid: function() {
      if (!(this.get('content') != null)) {
        return false;
      }
      if (this.get('content.isLoadable') && this.get('content.isLoaded')) {
        return true;
      }
      if (this.get('content.isLoadable') && !this.get('content.isLoaded')) {
        return false;
      }
      return true;
    },
    optionsDidChange: (function() {
      var element, name, optionDidChange, options, value, _i, _len, _results;
      options = ['activeVisible', 'autoActivate', 'aria', 'autoCollapse', 'autoScroll', 'minExpandLevel', 'clickFolderMode', 'checkbox', 'disabled', 'icons', 'keyboard', 'selectMode', 'tabbable'];
      element = this.getTreeDom();
      _results = [];
      for (_i = 0, _len = options.length; _i < _len; _i++) {
        name = options[_i];
        value = this.get(name);
        optionDidChange = value !== element.fancytree('option', name);
        if (optionDidChange) {
          _results.push(element.fancytree('option', name, value));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    }).observes('activeVisible', 'autoActivate', 'aria', 'autoCollapse', 'autoScroll', 'clickFolderMode', 'checkbox', 'disabled', 'icons', 'keyboard', 'selectMode', 'tabbable', 'minExpandLevel'),
    didInsertElement: function() {
      var options;
      options = $.extend({
        source: this.get('content')
      }, this.getTreeEvents(), this.getNodeEvents(), this.getDefaultSettings());
      this.getTreeDom().fancytree(options);
      if (!this.get('hasArrayObservers')) {
        this.addArrayObservers(this.get('content'));
        this.set('hasArrayObservers', true);
      }
      return this.highlightSelectedNodes();
    },
    highlightSelectedNodes: function() {
      var item, _i, _len, _ref, _results;
      _ref = this.get('selection');
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        _results.push(this.selectNode(item));
      }
      return _results;
    },
    getTreeEvents: function() {
      var event, options, treeEvents, _i, _len,
        _this = this;
      options = {};
      treeEvents = ['treeInit', 'create'];
      for (_i = 0, _len = treeEvents.length; _i < _len; _i++) {
        event = treeEvents[_i];
        if (this[event] != null) {
          options[event] = (function(e, data, flag) {
            return _this[event].call(_this, e, data, flag);
          });
        }
      }
      return options;
    },
    getNodeEvents: function() {
      var event, nodeEvents, options, widget, _i, _len;
      options = {};
      nodeEvents = ['beforeActivate', 'activate', 'deactivate', 'beforeSelect', 'select', 'beforeExpand', 'collapse', 'expand', 'loadChildren', 'focustree', 'blurtree', 'focus', 'blur', 'click', 'dblclick', 'keydown', 'keypress', 'createnode', 'rendernode', 'lazyload', 'lazyread'];
      widget = this;
      for (_i = 0, _len = nodeEvents.length; _i < _len; _i++) {
        event = nodeEvents[_i];
        if (widget[event.toLowerCase()] != null) {
          options[event] = (function(e, data) {
            return widget[e.type.slice(9)](e, data);
          });
        }
      }
      return options;
    },
    getDefaultSettings: function() {
      var defaultSettings, options, setting, _i, _len;
      options = {};
      defaultSettings = ['aria', 'activeVisible', 'autoActivate', 'autoCollapse', 'autoScroll', 'checkbox', 'clickFolderMode', 'disabled', 'extensions', 'generateIds', 'icons', 'keyboard', 'nolink', 'selectMode', 'tabbable', 'minExpandLevel'];
      for (_i = 0, _len = defaultSettings.length; _i < _len; _i++) {
        setting = defaultSettings[_i];
        options[setting] = this.get(setting);
      }
      return options;
    },
    removeNodes: function(options) {
      var option, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = options.length; _i < _len; _i++) {
        option = options[_i];
        _results.push(this.removeChildFromRootNode(option));
      }
      return _results;
    },
    addNodes: function(nodes) {
      var node, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = nodes.length; _i < _len; _i++) {
        node = nodes[_i];
        _results.push(this.addChildrenToRootNode(node));
      }
      return _results;
    },
    getTreeDom: (function() {
      return this.$("#" + (Ember.guidFor(this)) + "-tree");
    }),
    getTree: (function() {
      return this.getTreeDom().fancytree('getTree');
    }),
    enable: function() {
      if (this.getTreeDom().fancytree('option', 'disabled')) {
        return this.getTreeDom().fancytree('enable');
      }
    },
    disable: function() {
      if (!this.getTreeDom().fancytree('option', 'disabled')) {
        return this.getTreeDom().fancytree('disable');
      }
    },
    reloadTree: (function(content) {
      return this.getTree().reload(content);
    }),
    getRootNode: (function() {
      return this.getTreeDom().fancytree('getRootNode');
    }),
    expandAll: (function() {
      return this.getRootNode().visit(function(node) {
        return node.setExpanded(true);
      });
    }),
    collapseAll: (function() {
      return this.getRootNode().visit(function(node) {
        return node.setExpanded(false);
      });
    }),
    toggleExpand: (function() {
      return this.getRootNode().visit(function(node) {
        return node.toggleExpanded();
      });
    }),
    selectAll: (function() {
      return this.getTree().visit(function(node) {
        return node.setSelected(true);
      });
    }),
    selectNode: (function(val) {
      return this.getTree().visit(function(node) {
        if (node.data.value === val) {
          return node.setSelected(true);
        }
      });
    }),
    deselectAll: (function() {
      return this.getTree().visit(function(node) {
        return node.setSelected(false);
      });
    }),
    toggleSelect: (function() {
      return this.getTree().visit(function(node) {
        return node.toggleSelected();
      });
    }),
    getActiveNode: (function() {
      return this.getTreeDom().fancytree('getActiveNode');
    }),
    toJSON: (function() {
      return JSON.stringify(this.getTree().toDict(true));
    }),
    getNode: (function(id) {
      return this.getTree().getNodeByKey(id);
    }),
    focusNode: (function(id) {
      return this.getTree().activateKey(id);
    }),
    setNodeTitle: function(title, id) {
      if (id != null) {
        return this.getNode(id).setTitle(title);
      } else {
        return this.getActiveNode().setTitle(title);
      }
    },
    sortTree: function(compareFunction, deepSort) {
      if (deepSort == null) {
        deepSort = true;
      }
      return this.getRootNode().sortChildren(compareFunction, deepSort);
    },
    sortActiveBranch: function(compareFunction, deepSort) {
      if (deepSort == null) {
        deepSort = true;
      }
      return this.getActiveNode().sortChildren(compareFunction, deepSort);
    },
    addChildren: (function(node, options) {
      return node.addChildren(options);
    }),
    addChildrenToActiveNode: (function(options) {
      return this.addChildren(this.getActiveNode(), options);
    }),
    addChildrenToRootNode: function(options) {
      return this.addChildren(this.getRootNode(), options);
    },
    addChildrenToNode: (function(nodeId, options) {
      return this.addChildren(this.getNode(nodeId), options);
    }),
    removeChild: function(node, options) {
      var childNode, index, title;
      title = options.title;
      childNode = node.findFirst(function(n) {
        return n.title === title;
      });
      if (childNode.isFolder()) {
        if (childNode.isSelected()) {
          this.recursivelyRemoveNodeChildren(childNode);
        }
      } else {
        index = this.get('selection').indexOf(childNode.data.value);
        if (index !== -1) {
          this.get('selection').removeAt(index);
        }
      }
      return node.removeChild(childNode);
    },
    removeChildFromActiveNode: (function(options) {
      return this.removeChild(this.getActiveNode(), options);
    }),
    removeChildFromRootNode: (function(options) {
      return this.removeChild(this.getRootNode(), options);
    }),
    removeChildFromNode: (function(nodeId, options) {
      return this.removeChild(this.getNode(nodeId), options);
    }),
    replaceChildren: (function(node, options) {
      return node.fromDict(options);
    }),
    replaceRootChildren: (function(options) {
      return this.replaceChildren(this.getRootNode(), options);
    }),
    replaceActiveNodeChildren: (function(options) {
      return this.replaceChildren(this.getActiveNode(), options);
    }),
    reinitialize: (function() {
      return this.getTreeDom().fancytree();
    }),
    recursivelyAdd: function(node) {
      if (node.isFolder()) {
        return this.recursivelyAddNodeChildren(node);
      } else {
        if (!node.isSelected()) {
          return this.get('selection').pushObject(node.data.value);
        }
      }
    },
    recursivelyAddNodeChildren: function(node) {
      var child, _i, _len, _ref, _results;
      _ref = node.children;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        _results.push(this.recursivelyAdd(child));
      }
      return _results;
    },
    recursivelyRemove: function(node) {
      var index;
      if (node.isFolder()) {
        return this.recursivelyRemoveNodeChildren(node);
      } else {
        index = this.get('selection').indexOf(node.data.value);
        if (index !== -1) {
          return this.get('selection').removeAt(index);
        }
      }
    },
    recursivelyRemoveNodeChildren: function(node) {
      var child, _i, _len, _ref, _results;
      _ref = node.children;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        _results.push(this.recursivelyRemove(child));
      }
      return _results;
    },
    beforeselect: function(e, data) {
      var index;
      if (data.node.isFolder()) {
        if (this.get('nodeSelection') !== 'heirMultiSelect') {
          return;
        }
        if (data.node.isSelected()) {
          return this.recursivelyRemoveNodeChildren(data.node);
        } else {
          return this.recursivelyAddNodeChildren(data.node);
        }
      } else {
        if (data.node.isSelected()) {
          index = this.get('selection').indexOf(data.node.data.value);
          if (index !== -1) {
            return this.get('selection').removeAt(index);
          }
        } else {
          if ((this.get('nodeSelection') !== 'multiSelect') && (this.get('nodeSelection') !== 'heirMultiSelect')) {
            this.get('selection').clear();
          }
          return this.get('selection').pushObject(data.node.data.value);
        }
      }
    }
  });

}).call(this);


Ember.TEMPLATES['collection_panel']=Ember.Handlebars.compile("{{#unless view.collection.modelData.isLoaded}}\n\t{{view Tent.WaitIcon}}\n{{/unless}}\n\n{{#if view.scroll}}\n  <div class=\"scroller\">\n    <div class=\"offset\"></div>\n    <div class=\"panel-content\">\n      {{#each item in view.collection.modelData}}\n        <article class=\"collection-panel\">\n          {{view Tent.CollectionPanelContentContainerView \n            itemBinding=\"item\" \n            contentViewTypeBinding=\"view.contentViewType\" \n            collectionBinding=\"view.collection\"\n            multiSelectBinding=\"view.multiSelect\"\n            selectionBinding=\"view.selection\"\n          }}\n        </article>\n      {{/each}}\n    </div>\n  </div>\n{{else}}\n  {{#each item in view.collection.modelData}}\n    <article class=\"collection-panel\">\n      {{view Tent.CollectionPanelContentContainerView \n        itemBinding=\"item\" \n        contentViewTypeBinding=\"view.contentViewType\" \n        collectionBinding=\"view.collection\"\n        multiSelectBinding=\"view.multiSelect\"\n        selectionBinding=\"view.selection\"\n      }}\n    </article>\n  {{/each}}\n{{/if}}");

Ember.TEMPLATES['collection_panel_content']=Ember.Handlebars.compile("<header>\n\t<div class=\"header-border vertical-align-with-header\">\n\t\t<h1>\n\t\t\t{{#if view.multiSelect}}\n\t\t\t\t{{view Ember.Checkbox checkedBinding=\"view.selected\" class=\"item-selector\"}}\n\t\t\t{{/if}}\n\t\t\t{{view.content.title}}</h1>\n\t\t<a {{action delete this}} title=\"Delete\"><i class=\"icon-trash\"></i></a>\n\t</div>\n</header>\n<div class=\"content\">\n\t<div class=\"section\">\n\t\t<label>Program</label>\n\t\t<p class=\"text-med\">Rugged Bicycles LLC Pgm</p>\n\t\t<p class=\"text-large\">$2,395,204</p>\n\t\t<label>Projected Settlement</label>\n\t</div>\n\t<div class=\"section\">\n\t\t<label>Date :</label>\n\t\t<p>Jun 24, 2013</p>\n\t\t<label>{{view.durationLabel}}</label>\n\t\t<p>{{view.durationValue}}</p>\n\t\t<label>Seller :</label>\n\t\t<p>Rugged Bicycles LLC</p>\n\t\t<label>{{view.finishLabel}}</label>\n\t\t<p>{{view.finishValue}}</p>\n\t\t \n\t</div>\n</div>\n<footer>\n\t<div class=\"footer-border vertical-align-with-table\">\n\t\t<a {{action reconcile this}}>Reconcile <i class=\"icon-caret-right\"></i></a>\n\t</div>\n</footer>\t\n");

(function() {
/**
  * @class Tent.CollectionPanelView
  * 
  * Displays a collection of objects in separate panels laid out in a 2d grid.
  * The {@link #contentViewType} property must be populated with a view which will render each panel. This view 
  * should be a subclass of Tent.TaskCollectionPanelContentView
  * 
  * Usage within a template:
  *     {{view Tent.CollectionPanelView 
              collectionBinding="Pad.jqRemoteCollection"
              contentViewType="Tent.TaskCollectionPanelContentView"
         }} 
  *
  */


  Tent.CollectionPanelView = Ember.View.extend({
    templateName: 'collection_panel',
    classNames: ['collection-panel-container'],
    multiSelect: false,
    selection: null,
    scrollTimeout: 200,
    currentPage: 1,
    /**
    * @property {Object} collection The colleciton which contains the items for display.
    */

    collection: null,
    /**
    * @property {String} contentViewType The name of a view class which will render the contents of each panel.
    * This view will have its 'content' populated with the model for that panel
    */

    contentViewType: null,
    didInsertElement: function() {
      this.get('collection').update();
      if (this.get('selection') == null) {
        this.set('selection', Ember.A());
      }
      if (this.get('scroll')) {
        return this.setupScrolledPaging();
      }
    },
    contentDidChange: (function() {
      var _this = this;
      if ((this.$() != null) && this.get('collection.modelData.isLoaded')) {
        return Ember.run.next(function() {
          return _this.positionScrollbar();
        });
      }
    }).observes('collection.modelData', 'collection.modelData.isLoaded', 'isVisible'),
    setupScrolledPaging: function() {
      var _this = this;
      return this.$().unbind('scroll').bind('scroll', function() {
        return _this.scrollGrid();
      });
    },
    scrollGrid: function() {
      var _this = this;
      if (this.get('scrollTimer') != null) {
        clearTimeout(this.get('scrollTimer'));
      }
      return this.set('scrollTimer', setTimeout(function() {
        return _this.scrollCollection();
      }, this.get('scrollTimeout')));
    },
    scrollCollection: function() {
      var cardsPerRow, newPageNum, rowHeight, scrollTop, scroller;
      scroller = this.$();
      scrollTop = scroller.get(0).scrollTop;
      rowHeight = this.getCardHeight();
      cardsPerRow = this.cardsPerRow();
      newPageNum = this.findPageNumberAtScrollPosition(scrollTop, rowHeight, cardsPerRow);
      if (this.get('currentPage') !== newPageNum) {
        this.set('currentPage', newPageNum);
        return this.get('collection').goToPage(newPageNum);
      }
    },
    findPageNumberAtScrollPosition: function(scrollTop, rowHeight, cardsPerRow) {
      var cardsAbove, pageSize;
      pageSize = this.get('collection.pagingInfo.pageSize');
      cardsAbove = parseInt(scrollTop / this.getCardHeight(), 10) * cardsPerRow;
      return parseInt(cardsAbove / pageSize, 10) + 1;
    },
    positionScrollbar: function() {
      var paddingHeight, page, pageSize, rowHeight, totalCards, totalHeightForAllRows, totalRowsToShow;
      page = this.get('collection.pagingInfo.page');
      pageSize = this.get('collection.pagingInfo.pageSize');
      totalCards = this.get('collection.pagingInfo.totalRows');
      rowHeight = this.getCardHeight();
      totalRowsToShow = this.rowsInGrid(totalCards);
      paddingHeight = this.rowsOfPadding() * rowHeight;
      totalHeightForAllRows = totalRowsToShow * rowHeight;
      return this.$(".scroller").css({
        height: totalHeightForAllRows
      }).children("div:first").css('height', paddingHeight);
    },
    getCardHeight: function() {
      var panel;
      panel = this.$('.collection-panel:first');
      if (panel != null) {
        return panel.outerHeight();
      }
    },
    cardsPerRow: function() {
      var panel, panelWidth, panelsPerRow;
      panel = this.$('.collection-panel:first');
      panelWidth = panel.outerWidth();
      return panelsPerRow = parseInt(this.$().innerWidth() / panelWidth, 10);
    },
    rowsInGrid: function(cardCount) {
      var addition, mod, rows;
      mod = cardCount % this.cardsPerRow();
      addition = mod > 0 ? 1 : 0;
      return rows = parseInt(cardCount / this.cardsPerRow(), 10) + addition;
    },
    rowsOfPadding: function() {
      var addition, mod, pageSize, rowsPerPage;
      pageSize = this.get('collection.pagingInfo.pageSize');
      mod = pageSize % this.cardsPerRow();
      addition = mod > 0 ? 1 : 0;
      rowsPerPage = parseInt(pageSize / this.cardsPerRow(), 10) + addition;
      return rowsPerPage * (this.get('currentPage') - 1);
    }
  });

  Tent.CollectionPanelContentContainerView = Ember.ContainerView.extend({
    item: null,
    contentViewType: null,
    collection: null,
    multiSelect: false,
    childViews: ['contentView'],
    contentView: (function() {
      if (this.get('contentViewType') != null) {
        return eval(this.get('contentViewType')).create({
          content: this.get('item'),
          collection: this.get('collection'),
          multiSelect: this.get('multiSelect'),
          selection: this.get('selection')
        });
      }
    }).property('item'),
    selectionDidChange: (function() {
      return this.set('contentView.selection', this.get('selection'));
    }).observes('selection', 'selection.@each'),
    selectedDidChange: function(isSelected) {
      if (isSelected) {
        return this.addToSelection();
      } else {
        return this.removeFromSelection();
      }
    },
    addToSelection: function() {
      if (!this.get('selection').contains(this.get('item'))) {
        return this.get('selection').pushObject(this.get('item'));
      }
    },
    removeFromSelection: function() {
      return this.get('selection').removeObject(this.get('item'));
    }
  });

  /**
  * @class Tent.CollectionPanelContentView
  * This class should be extended to provide the content for a {@link #Tent.CollectionPanelView}
  */


  Tent.CollectionPanelContentView = Ember.View.extend({
    templateName: null,
    classNames: ['collection-panel-content'],
    classNameBindings: ['selected'],
    content: null,
    multiSelect: false,
    selection: [],
    didInsertElement: function() {
      return this.$().parents('.collection-panel:first').css('opacity', '1');
    },
    selected: (function() {
      var _ref;
      return (_ref = this.get('selection')) != null ? _ref.contains(this.get('content')) : void 0;
    }).property('selection', 'selection.@each'),
    /**
    * @method getLabelForField Returns a translated label for the given field name of a collections columns
    * @param {String} fieldName the field name of the column to be returned
    * @return {String} the translated label for the field
    */

    getLabelForField: function(fieldName) {
      var column, _ref;
      column = (_ref = this.get('collection')) != null ? _ref.getColumnByField(fieldName) : void 0;
      return Tent.I18n.loc(column != null ? column['title'] : void 0);
    },
    /**
    * @method formattedValue Formats a given value using the formatter associated with a collection column definition.
    * @param {String} fieldName the field name of the column which is used to locate the formatter
    * @param {Object} value the value to be formatted
    * @return {String} the formatted value
    */

    formattedValue: function(fieldName, value) {
      var column, _ref;
      column = (_ref = this.get('collection')) != null ? _ref.getColumnByField(fieldName) : void 0;
      if (column['formatter'] != null) {
        return $.fn.fmatter[column['formatter']](value, {
          colModel: {
            formatOptions: column['formatoptions']
          }
        });
      } else {
        return value;
      }
    },
    click: function(e) {
      var checked;
      if ($(e.target).is('.item-selector')) {
        checked = $(e.target).is(':checked');
        return this.get('parentView').selectedDidChange(checked);
      }
    }
  });

}).call(this);


Ember.TEMPLATES['pager']=Ember.Handlebars.compile("<div class=\"tent-pager control-strip\">\n\t<div class=\"wrapper middle\">\n\t\t<div class=\"button-wrapper\">\n\t\t\t\t<span>\n\t\t      <a {{action first target=\"view\"}} class=\"button-control\" href=\"#\" {{bindAttr title=\"view.firstTitle\"}}><i class=\"icon-double-angle-left\"></i></a>\n\t\t    </span>\n\t\t\t\t<span>\n\t\t      <a {{action prev target=\"view\"}} class=\"button-control\" href=\"#\" {{bindAttr title=\"view.prevTitle\"}}><i class=\"icon-angle-left\"></i></a>\n\t\t    </span>\n\t\t    <span class=\"summary\">\n\t\t      Page: {{view.collection.pagingInfo.page}} of {{view.collection.pagingInfo.totalPages}}\n\t\t    </span>\n\t\t    <span>\n\t\t      <a {{action next target=\"view\"}} class=\"button-control\" href=\"#\" {{bindAttr title=\"view.nextTitle\"}}><i class=\"icon-angle-right\"></i></a>     \n\t\t    </span>\n\t\t    <span>\n\t\t      <a {{action last target=\"view\"}} class=\"button-control\" href=\"#\" {{bindAttr title=\"view.lastTitle\"}}><i class=\"icon-double-angle-right\"></i></a>\n\t\t    </span>\n\t\t</div>\n\t</div>\n\t{{#if view.collection.totalRows}}\n\t\t<div class=\"wrapper right\">\n\t\t\t<div class=\"button-wrapper\">\n\t\t\t\tView {{view.collection.startRow}} - {{view.collection.endRow}} of {{view.collection.totalRows}}\n\t\t\t</div>\n\t\t</div>\n\t{{/if}}\n</div>\n\n ");

(function() {
Tent.Pager = Ember.View.extend({
    templateName: 'pager',
    prevTitle: Tent.I18n.loc('tent.jqGrid.paging.prev'),
    nextTitle: Tent.I18n.loc('tent.jqGrid.paging.next'),
    firstTitle: Tent.I18n.loc('tent.jqGrid.paging.first'),
    lastTitle: Tent.I18n.loc('tent.jqGrid.paging.last'),
    first: function() {
      this.get('collection').goToPage(1);
      return console.log('first');
    },
    prev: function() {
      if (this.get('collection.pagingInfo.page') > 1) {
        return this.get('collection').prevPage();
      }
    },
    next: function() {
      if (this.get('collection.pagingInfo.page') < this.get('collection.pagingInfo.totalPages')) {
        return this.get('collection').nextPage();
      }
    },
    last: function() {
      return this.get('collection').goToPage(this.get('collection.pagingInfo.totalPages'));
    },
    getPage: function() {
      return this.get('collection.pagingInfo.page');
    }
  });

}).call(this);


(function() {

  Tent.Application = Tent.Application || Em.Namespace.create();

  Tent.Application.MainMenuView = Ember.View.extend({
    /**
    * @property {Boolean} collapseAutomatically If set to true, the menu will collapse when an actionable
    * item is selected.
    */

    collapseAutomatically: true,
    classNames: ['main-menu', 'mp-level', 'selected'],
    didInsertElement: function() {
      this._super();
      this.hideMenusWithNoValidChildren();
      this.openMenuInitially();
      return this.selectItemFromUrl();
    },
    openMenuInitially: function() {
      return $('.dashboard-toggle a').click();
    },
    selectedActionDidChange: (function() {
      return this.selectItemFromAction(this.get('controller.selectedAction'));
    }).observes('controller.selectedAction'),
    selectItemFromUrl: function(path) {
      var that;
      path = path || window.location.pathname;
      that = this;
      if ((this.$() != null)) {
        return this.forAllChildViews(function(view) {
          if (view.get('hasAction')) {
            if (path.indexOf(view.get('route')) !== -1) {
              that.set('controller.selectedItem', view);
              return this.navigateToCorrectMenuLevel(view);
            }
          }
        });
      }
    },
    selectItemFromAction: function(action) {
      var that;
      that = this;
      if ((this.$() != null)) {
        return this.forAllChildViews(function(view) {
          if (view.get('hasAction')) {
            if (action === view.get('action')) {
              return that.set('controller.selectedItem', view);
            }
          }
        });
      }
    },
    forAllChildViews: function(callback, bottomUp, view) {
      var childView, _i, _len, _ref;
      if (bottomUp == null) {
        bottomUp = false;
      }
      view = view || this;
      if (!bottomUp) {
        callback.call(this, view);
      }
      _ref = view.get('childViews');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        childView = _ref[_i];
        this.forAllChildViews(callback, bottomUp, childView);
      }
      if (bottomUp) {
        return callback.call(this, view);
      }
    },
    navigateToCorrectMenuLevel: function(selectedItem) {
      var item, levels, reversed, _i, _len, _results;
      this.openMenuInitially();
      levels = selectedItem.$().parentsUntil('#mp-menu', 'li');
      reversed = levels.toArray().reverse();
      _results = [];
      for (_i = 0, _len = reversed.length; _i < _len; _i++) {
        item = reversed[_i];
        _results.push($(item).find('a:first').click());
      }
      return _results;
    },
    hideMenusWithNoValidChildren: function() {
      return this.forAllChildViews(function(view) {
        if (view.checkParentEntitlements != null) {
          return view.checkParentEntitlements();
        }
      }, true);
    }
  });

}).call(this);


Ember.TEMPLATES['application/menu_item']=Ember.Handlebars.compile("{{#if view.isEntitled}}\n\t\t<a {{bindAttr class=\"view.applyHighlight:active-menu view.hasAction:menu-link view.isDisabled:ui-state-disabled\"}} {{action menuClicked target=\"view\"}}>\n\t\t\t{{#if view.hasChildren}}<i class=\"icon-chevron-left\"></i>{{/if}}\n\t\t\t<i {{bindAttr class=\":menu-icon view.icon\"}} {{bindAttr data-title=\"view.title\"}} data-placement=\"right\" data-animation=\"false\"></i>\n\t\t\t<span class=\"content\">{{loc view.title}}</span>\n\t\t</a>\n\t\t{{#if view.hasChildren}}\n\t\t\t<div class=\"mp-level\">\n\t\t\t\t<h2><i {{bindAttr class=\":menu-icon view.icon\"}}></i> {{loc view.title}}</h2>\n\t\t\t\t<a class=\"mp-back\">Back <i class=\"icon-chevron-right\"></i></a>\n\t\t\t\t<ul>\n\t\t\t\t\t{{yield}}\n\t\t\t\t</ul>\n\t\t\t</div>\n\t\t{{/if}}\n{{/if}}");

(function() {

  Tent.Application = Tent.Application || Em.Namespace.create();
Tent.Application.MenuItemView = Ember.View.extend({
    tagName: 'li',
    classNames: ['menu-item'],
    layoutName: 'application/menu_item',
    collapsed: false,
    isEnabled: true,
    anyChildEntitled: true,
    init: function() {
      return this._super();
    },
    hasAction: Ember.computed.bool('action'),
    menuClicked: function(e) {
      if (this.get('hasAction') && this.get('isEnabled')) {
        return this.get('controller').menuClicked(this);
      }
    },
    isSelected: (function() {
      return this.get('controller.selectedItem') === this;
    }).property('controller.selectedItem'),
    applyHighlight: (function() {
      return this.get('isSelected') && this.get('hasAction');
    }).property('isSelected'),
    isEntitled: (function() {
      return this.get('anyChildEntitled') && this.evaluateEntitlements();
    }).property('operations', 'anyChildEntitled'),
    evaluateEntitlements: function() {
      var ops,
        _this = this;
      if (!this.get('operations')) {
        return true;
      }
      ops = this.get('operations').removeWhitespace().split(',');
      return ops.filter(function(operation) {
        return _this.evaluatePolicy(operation);
      }).length > 0;
    },
    checkParentEntitlements: function() {
      if (this.get('parentView').checkChildEntitlements != null) {
        return this.get('parentView').checkChildEntitlements();
      }
    },
    checkChildEntitlements: function() {
      if (this.get('childViews').filterProperty('isEntitled', true).length === 0) {
        return this.set('anyChildEntitled', false);
      }
    },
    evaluatePolicy: function(operation) {
      return Endeavour.policy(operation);
    },
    isDisabled: Ember.computed.not("isEnabled")
  });

}).call(this);


(function() {

  Tent.Application = Tent.Application || Em.Namespace.create();

  Tent.Application.PanelToggleView = Ember.View.extend({
    elementId: "dashboard-toggle",
    classNames: ['dashboard-toggle'],
    template: Ember.Handlebars.compile('<a><i class="icon-reorder"></i></a>'),
    attributeBindings: ['rel'],
    rel: 'popover',
    targets: ['main-menu'],
    didInsertElement: function() {
      return this._super();
    },
    click: function() {
      var target, _i, _len, _ref, _results;
      _ref = this.get('targets');
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        target = _ref[_i];
        if (this.getViewForTarget(target) != null) {
          _results.push(this.getViewForTarget(target).toggleCollapse());
        } else {
          _results.push($('.' + target).toggleClass('expanded'));
        }
      }
      return _results;
    },
    getViewForTarget: function(target) {
      return Ember.View.views[$('.' + target).attr('id')];
    }
  });

}).call(this);


(function() {

  Tent.MLPushMenuView = Tent.Application.MainMenuView.extend({
    classNames: ['tent-push-menu'],
    currentLevel: 1,
    maxDepth: 0,
    levelOffset: 40,
    didInsertElement: function() {
      this.set('treatIEDifferently', Tent.Browsers.getIEVersion() === 8 || Tent.Browsers.getIEVersion() === 9);
      this.set('expandWidth', $('#mp-menu').width());
      this.annotateLevels();
      this._super();
      return this.redraw();
    },
    showMenu: function() {
      var width;
      width = this.get('expandWidth') + ((this.get('currentLevel') - 1) * this.get('levelOffset'));
      this.translate(width, $('.mp-pusher'));
      return this.set('collapsed', false);
    },
    hideMenu: function() {
      var width;
      width = 0;
      this.translate(width, $('.mp-pusher'));
      return this.set('collapsed', true);
    },
    showMenuLevel: function(menu, level) {
      var width;
      if (this.get('treatIEDifferently')) {
        if (level === 1) {
          width = this.get('expandWidth') + ((level - 1) * this.get('levelOffset'));
        } else {
          width = (level - 1) * this.get('levelOffset');
        }
      } else {
        width = this.get('expandWidth') + ((level - 1) * this.get('levelOffset'));
      }
      return menu.css('margin-left', "-" + width + "px");
    },
    hideMenuLevel: function(menu, level) {
      var width;
      width = this.get('expandWidth') * level;
      return menu.css('margin-left', "-" + width + "px");
    },
    toggleCollapse: function() {
      if (this.get('collapsed')) {
        return this.showMenu();
      } else {
        return this.hideMenu();
      }
    },
    translate: function(val, el) {
      var left, right;
      if (this.get('treatIEDifferently')) {
        left = val;
        right = val;
        el.css('margin-left', "" + left + "px");
        return el.css('margin-right', "-" + right + "px");
      } else {
        el.css('WebkitTransform', 'translate3d(' + val + 'px,0,0)');
        el.css('MozTransform', 'translate3d(' + val + 'px,0,0)');
        return el.css('transform', 'translate3d(' + val + 'px,0,0)');
      }
    },
    annotateLevels: function() {
      var _this = this;
      this.$().attr('data-level', 1).addClass('selected current root');
      return this.$('.mp-level').each(function(i, el) {
        return $(el).attr('data-level', _this.getLevelDepth($(el)));
      });
    },
    getLevelDepth: function(el) {
      var depth;
      depth = el.parents('.mp-level').length + 1;
      if (depth > this.get('maxDepth')) {
        this.set('maxDepth', depth);
      }
      return depth;
    },
    click: function(e) {
      var target;
      target = $(e.target);
      if (this.isBackButton(target) || this.isOverlapArea(target)) {
        this.goBack();
        if (this.isOverlapArea(target)) {
          return this.showLevelIcons();
        }
      } else {
        if (this.isLevelHeader(target)) {
          return;
        }
        if (this.hasChildLevel(target) && !this.isDisabled(target) && !target.is('ul')) {
          return this.navigateToNewLevel(e);
        } else {
          if (this.get('collapseAutomatically')) {
            return this.hideMenu();
          }
        }
      }
    },
    isBackButton: function(target) {
      return target.hasClass('mp-back') || target.hasClass('mp-level') || target.parents('a:first').hasClass('mp-back');
    },
    isOverlapArea: function(target) {
      return parseInt(target.parents('.mp-level').attr('data-level')) !== this.get('currentLevel');
    },
    isLevelHeader: function(target) {
      return target.is('h2') || target.parent().is('h2');
    },
    goBack: function() {
      var mpLevel;
      mpLevel = this.getMpLevelElement(this.get('currentLevel'));
      this.removeSelectedClass(mpLevel);
      this.set('currentLevel', this.get('currentLevel') - 1);
      return this.redraw();
    },
    navigateToNewLevel: function(e) {
      this.set('currentLevel', this.findLevel($(e.target)) + 1);
      $(e.target).parents('.mp-level:first').find('ul:first .mp-level').removeClass('selected');
      $(e.target).parents('li:first').find('.mp-level').addClass('selected');
      return this.redraw();
    },
    getMpLevelElement: function(level) {
      return $('.selected[data-level="' + level + '"]', '.mp-menu');
    },
    removeSelectedClass: function(target) {
      if (target.hasClass('mp-level')) {
        return target.removeClass('selected');
      } else {
        return target.parents('.mp-level:first').removeClass('selected');
      }
    },
    findLevel: function(target) {
      return parseInt(target.parents('.mp-level:first').attr('data-level'));
    },
    hasChildLevel: function(target) {
      return target.parents('.menu-item:first').children('.mp-level').length === 1;
    },
    isDisabled: function(target) {
      return target.hasClass('ui-state-disabled') || target.parents('a:first').hasClass('ui-state-disabled');
    },
    redraw: function() {
      this.hideLowerLevels();
      this.showSelectedLevels();
      this.addRemoveCurrentClass();
      this.showLevelIcons();
      return this.showMenu();
    },
    hideLowerLevels: function() {
      var level, _i, _ref, _ref1, _results,
        _this = this;
      _results = [];
      for (level = _i = _ref = this.get('currentLevel') + 1, _ref1 = this.get('maxDepth'); _ref <= _ref1 ? _i <= _ref1 : _i >= _ref1; level = _ref <= _ref1 ? ++_i : --_i) {
        _results.push($('[data-level="' + level + '"]', '.mp-menu').each(function(index, menu) {
          return _this.hideMenuLevel($(menu), level);
        }));
      }
      return _results;
    },
    showSelectedLevels: function() {
      var level, _i, _ref, _results,
        _this = this;
      _results = [];
      for (level = _i = 1, _ref = this.get('currentLevel'); 1 <= _ref ? _i <= _ref : _i >= _ref; level = 1 <= _ref ? ++_i : --_i) {
        _results.push(this.getMpLevelElement(level).each(function(index, menu) {
          return _this.showMenuLevel($(menu), level);
        }));
      }
      return _results;
    },
    addRemoveCurrentClass: function(menu, level) {
      var current, _i, _results;
      current = this.get('currentLevel');
      _results = [];
      for (level = _i = 1; 1 <= current ? _i <= current : _i >= current; level = 1 <= current ? ++_i : --_i) {
        menu = this.getMpLevelElement(level);
        if (level === this.get('currentLevel')) {
          _results.push(menu.addClass('current'));
        } else {
          _results.push(menu.removeClass('current'));
        }
      }
      return _results;
    },
    showLevelIcons: function() {
      var currentLevel, level, _i, _ref, _results;
      currentLevel = this.get('currentLevel');
      this.removeLevelIcon(currentLevel);
      if (currentLevel !== 1) {
        _results = [];
        for (level = _i = 1, _ref = this.get('currentLevel') - 1; 1 <= _ref ? _i <= _ref : _i >= _ref; level = 1 <= _ref ? ++_i : --_i) {
          _results.push(this.showLevelIcon(level));
        }
        return _results;
      }
    },
    showLevelIcon: function(level) {
      var icon, mpLevel;
      mpLevel = this.getMpLevelElement(level);
      icon = mpLevel.find(' > h2 > .menu-icon');
      return mpLevel.append(icon.clone());
    },
    removeLevelIcon: function(level) {
      return this.getMpLevelElement(level).find('> .menu-icon').hide(500, function() {
        return $(this).remove();
      });
    }
  });

}).call(this);


(function() {
}).call(this);



/*
GridController
- content: bind to Model
- modelType: 
- store
- rowSelection holds the object represented by the selected row
*/


(function() {

  Tent.Controllers.GridController = Ember.ArrayController.extend({
    content: null,
    modelType: null,
    store: null,
    rowSelection: null,
    list: (function() {
      if (this.get('content')) {
        return this.getArrayFromRecordArray(this.get('content'));
      }
    }).property('content'),
    rowSelectionDidChange: (function() {
      var obj, _i, _len, _ref, _results;
      console.log('#####################');
      _ref = this.get('rowSelection');
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        obj = _ref[_i];
        _results.push(console.log(obj.id + "  :  " + obj.title));
      }
      return _results;
    }).observes('rowSelection'),
    getArrayFromRecordArray: function(recordArray) {
      var item, _i, _len, _list, _ref;
      _list = [];
      _ref = recordArray.toArray();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        if (item != null) {
          _list.push(item.toJSON());
        }
      }
      return _list;
    },
    page: function(pageInfo) {
      var query;
      query = $.extend(pageInfo, {
        type: 'paging'
      });
      return this.set('content', this.store.findQuery(this.modelType, query));
    },
    sort: function(args, pagingInfo) {
      var query, result;
      if (args.multiColumnSort) {
        query = this.getMultiColumnQuery(args, pagingInfo);
      } else {
        query = this.getSingleColumnQuery(args, pagingInfo);
      }
      query = $.extend(query, pagingInfo, {
        multiColumn: args.multiColumnSort
      });
      result = this.store.findQuery(this.modelType, query);
      return this.set('content', result);
    },
    getMultiColumnQuery: function(args, pagingInfo) {
      var cols, query;
      cols = args.sortCols;
      return query = this.generateQueryFromCols(cols);
    },
    getSingleColumnQuery: function(args, pagingInfo) {
      var ascending, col, query;
      col = args.sortCol;
      ascending = args.sortAsc;
      return query = this.generateQueryFromCol(col, ascending);
    },
    generateQueryFromCols: function(cols) {
      var col, fields, query, _i, _len;
      fields = [];
      for (_i = 0, _len = cols.length; _i < _len; _i++) {
        col = cols[_i];
        fields.push({
          sortAsc: col.sortAsc,
          field: col.sortCol.field
        });
      }
      query = {
        type: 'sorting',
        fields: fields
      };
      return query;
    },
    generateQueryFromCol: function(col, ascending) {
      var query;
      return query = {
        type: 'sorting',
        field: col.field,
        sortAsc: ascending
      };
    }
  });

}).call(this);


(function() {

  Tent.Application = Tent.Application || Em.Namespace.create;

  Tent.Application.MainMenuController = Ember.Controller.extend({
    selectedItem: null,
    selectedAction: null,
    menuClicked: function(menuItem) {
      return this.set('selectedItem', menuItem);
    },
    selectedItemDidChange: (function() {
      return this.executeAction(this.get('selectedItem').get('action'));
    }).observes('selectedItem'),
    executeAction: function(action) {
      return this.get('target').send(action);
    },
    menuTransition: function(action) {
      return this.set('selectedAction', action);
    }
  });

}).call(this);


(function() {
}).call(this);


(function() {
  var getPath, normalizePath;

  getPath = Ember.Handlebars.getPath;

  normalizePath = Ember.Handlebars.normalizePath;

  Tent.Handlebars = Ember.Namespace.create({
    getPath: function(property, options) {
      var context, normalized, path, pathRoot;
      context = (options.contexts && options.contexts[0]) || this;
      normalized = normalizePath(context, property, options.data);
      pathRoot = normalized.root;
      path = normalized.path;
      return getPath(pathRoot, path, options) || Ember.get(path) || path;
    }
  });

}).call(this);



/**
* `formatAmount` allows you to present a numeric value formatted as a money amount 
* according to the current locale
*		
*		{{formatAmount amount}}
*
* @class Handlebars.helpers.formatAmount
* @param {Number} amount
* @returns {String} HTML string
*/


(function() {

  Ember.Handlebars.registerHelper('formatAmount', function(property, options) {
    var amount;
    amount = Tent.Handlebars.getPath(property, options);
    return Tent.Formatting.amount.format(amount, options.hash);
  });

}).call(this);



/**
* `formatDate` allows you to present a Date value formatted to the current locale
*		
*		{{formatDate date}}
*
* @class Handlebars.helpers.formatDate
* @param {Date} date
* @returns {String} HTML string
*/


(function() {

  Ember.Handlebars.registerHelper('formatDate', function(context, options) {
    var date;
    date = Tent.Handlebars.getPath(context, options);
    return Tent.Formatting.date.format(date, options.hash.format);
  });

}).call(this);



/**
* `formatNumber` allows you to present a numeric value formatted  
* according to the current locale
*		
*		{{formatNumber number}}
*
* @class Handlebars.helpers.formatNumber
* @param {Number} number
* @returns {String} HTML string
*/


(function() {

  Ember.Handlebars.registerHelper('formatNumber', function(context, options) {
    var number;
    number = Tent.Handlebars.getPath(context, options);
    return Tent.Formatting.number.format(number, options.hash.format);
  });

}).call(this);



/**
* `loc` will translate a string key using the bundle for the current locale
*		
*		{{loc string}}
*
* You may optionally pass in an **args** property, which is a space-delimited list of
* values which will be interpolated into the translated key string 
*
*    	{{loc string args='view.firstName view.lastName'}}
*
* @class Handlebars.helpers.loc
* @param {String} key
* @param {}
* @returns {String} translated string
*/


(function() {

  Ember.Handlebars.registerHelper('loc', function(property, options) {
    var arg, args, key;
    key = Tent.Handlebars.getPath(property, options);
    if (key != null) {
      args = [];
      if (options.hash.args != null) {
        args.push((function() {
          var _i, _len, _ref, _results;
          _ref = Ember.String.w(options.hash.args);
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            arg = _ref[_i];
            _results.push(Ember.get(arg));
          }
          return _results;
        })());
      }
      return Ember.String.htmlSafe(Tent.I18n.loc(key, args[0]));
    }
    return path;
  });

}).call(this);


(function() {
}).call(this);



/**
* @class Tent.Data.Pager
* Adds paging support
*/


(function() {

  Tent.Data.Pager = Ember.Mixin.create({
    paged: false,
    pageSize: null,
    _page: 1,
    _totalRows: 27,
    _scrollDir: 'down',
    init: function() {
      this._super();
      return this.REQUEST_TYPE.PAGE = 'paging';
    },
    currentPage: (function(key, value) {
      if (arguments.length === 1) {
        if (this.isValidPage(this.get('_page'))) {
          return this.get('_page');
        } else {
          return 1;
        }
      } else {
        if (!!this.isValidPage(value)) {
          this.set('_page', value);
        }
        return this.get('_page');
      }
    }).property('data'),
    isValidPage: function(page) {
      return true;
    },
    totalPages: (function() {
      return this.get('_totalPages') || (Math.max(1, Math.ceil(this.get('totalRows') / this.get('pageSize')))) || 1;
    }).property('_totalPages', 'totalRows', 'pageSize'),
    totalRows: (function() {
      return this.get('_totalRows') || this.get('_totalPages') * this.get('pagesize') || 1;
    }).property('_totalRows', '_totalPages', 'pageSize'),
    startRow: (function() {
      return ((this.get('currentPage') - 1) * this.get('pageSize')) + 1;
    }).property('currentPage', 'pageSize'),
    endRow: (function() {
      if ((this.get('totalRows') - this.get('startRow')) < this.get('pageSize')) {
        return this.get('totalRows');
      } else {
        return this.get('currentPage') * this.get('pageSize');
      }
    }).property('startRow', 'currentPage', 'totalRows', 'pageSize'),
    goToPage: function(page) {
      this.set('currentPage', page);
      if (this.get('isShowingGroupsList')) {
        this.set('currentGroupPage', page);
      }
      return this.update(this.REQUEST_TYPE.PAGE);
    },
    nextPage: function() {
      var newPage;
      newPage = this.get('currentPage') + 1;
      if (!!this.isValidPage(newPage)) {
        this.set('currentPage', newPage);
      }
      return this.update(this.REQUEST_TYPE.PAGE);
    },
    prevPage: function() {
      var newPage;
      newPage = this.get('currentPage') - 1;
      if (!!this.isValidPage(newPage)) {
        this.set('currentPage', newPage);
      }
      return this.update(this.REQUEST_TYPE.PAGE);
    },
    pagingInfo: (function() {
      return {
        pageSize: this.get('pageSize'),
        page: this.get('currentPage'),
        totalRows: this.get('totalRows'),
        totalPages: this.get('totalPages'),
        scrolling: this.get('scroll')
      };
    }).property('pageSize', 'currentPage', 'totalPages', 'totalRows'),
    updatePagingInfo: function(info) {
      this.set('_totalRows', info.totalRows);
      return this.set('_page', info.page);
    }
  });

}).call(this);



/**
* @class Tent.Data.Sorter
* Adds sorting support
*/


(function() {

  Tent.Data.Sorter = Ember.Mixin.create({
    columnFilters: {},
    sortingInfo: {},
    init: function() {
      this._super();
      return this.REQUEST_TYPE.SORT = 'sorting';
    },
    /**
    	* @method sort Sort the collection according to the sort fields provided
    	* @param {Object} sortFields An object defining the fields and sort order
    */

    sort: function(args) {
      this.set('sortingInfo', args);
      return this.update(this.REQUEST_TYPE.SORT);
    },
    getSortingInfo: function() {
      return this.get('sortingInfo');
    }
  });

}).call(this);


(function() {

  Tent.Data.ColumnInfo = Ember.Mixin.create({
    init: function() {
      this._super();
      return this.set('columnInfo', {
        titles: {},
        widths: {},
        order: {},
        hidden: {}
      });
    }
  });

}).call(this);



/**
* @class Tent.Data.Filter
* Adds filtering support
*/


(function() {

  Tent.Data.Filter = Ember.Mixin.create({
    defaultFiltering: {
      selectedFilter: 'default',
      availableFilters: [
        {
          name: "default",
          label: Tent.I18n.loc('tent.filter.noFilter'),
          description: "",
          values: []
        }
      ]
    },
    init: function() {
      this.applyDefaultFilter();
      this._super();
      this.REQUEST_TYPE = this.REQUEST_TYPE || {};
      return this.REQUEST_TYPE.FILTER = 'filtering';
      /*@set('filteringInfo', 
      			selectedFilter: 'task2'
      			availableFilters: [
      				{
      					name: "task1"
      					label: "Task 1"
      					description: "Select the first task"
      					values: {
      						id: {field:"id", op: "equal", data: "5"}
      						title: {field:"title",op: "equal", data: "Task 1"}
      						duration: {field:"duration",op: "equal", data: "5"}
      						#percentcomplete: {field:"percentcomplete",op: "equal", data: "41"}
      						effortdriven: {field:"effortdriven",op: "equal", data: "-1"}
      						start: {field:"start",op: "equal", data: ""}
      						finish: {field:"finish",op: "equal", data: ""}
      						completed: {field:"completed",op: "equal", data: true}
      					}
      				},
      				{
      					name: "task2"
      					label: "Task 2"
      					description: "Select all tasks 50-59"
      					values: {
      						id: {field:"id",op: "equal", data: "5"}
      						title: {field:"title",op: "equal", data: "Task 2"}
      					}
      				},
      				{
      					name: "task3"
      					label: "Task 3"
      					description: "Select all tasks 50-59"
      					values: {
      						id: {field:"id",op: "equal", data: "5"}
      					}
      				}
      			])
      */

    },
    ensureFilterAvailable: function() {
      if (!(this.get('selectedFilter') != null)) {
        return this.set('filteringInfo', {
          selectedFilter: 'default',
          availableFilters: [
            {
              name: "default",
              label: Tent.I18n.loc('tent.filter.noFilter'),
              description: "",
              values: []
            }
          ]
        });
      }
    },
    selectedFilter: (function() {
      return this.getSelectedFilter();
    }).property('filteringInfo', 'filteringInfo.selectedFilter'),
    getSelectedFilter: function() {
      var filter, _i, _len, _ref;
      if ((this.get('filteringInfo') != null) && (this.get('filteringInfo.selectedFilter') != null)) {
        _ref = this.get('filteringInfo.availableFilters');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          filter = _ref[_i];
          if (filter.name === this.get('filteringInfo.selectedFilter')) {
            return filter;
          }
        }
      }
    },
    getSelectedFilterName: function() {
      var f;
      f = this.getSelectedFilter();
      return {
        name: f.name,
        label: f.label
      };
    },
    setSelectedFilter: function(name) {
      return this.set('filteringInfo.selectedFilter', name);
    },
    filterNames: (function() {
      return this.get('filteringInfo.availableFilters').map(function(item) {
        return {
          name: item.name,
          label: item.label
        };
      });
    }).property('filteringInfo.availableFilters', 'filteringInfo.availableFilters.@each'),
    updateCurrentFilter: function(currentFilter) {
      var filters, replacedExisting;
      replacedExisting = false;
      if (this.get('filteringInfo') != null) {
        filters = this.get('filteringInfo.availableFilters').map(function(item) {
          if (item.name === currentFilter.name) {
            if (item.label === currentFilter.label) {
              replacedExisting = true;
              return Ember.Object.create($.extend(true, {}, currentFilter));
            } else {
              currentFilter.name = currentFilter.label.split(" ").join('');
              return item;
            }
          } else {
            return item;
          }
        });
        this.get('filteringInfo.availableFilters').clear();
        this.get('filteringInfo.availableFilters').pushObjects(filters);
        if (!replacedExisting) {
          return this.addNewFilter(currentFilter);
        }
      }
    },
    doFilter: function(selectedFilter) {
      if (selectedFilter != null) {
        this.setSelectedFilter(selectedFilter.name);
        this.updateCurrentFilter(selectedFilter);
      }
      return this.update(this.REQUEST_TYPE.FILTER);
    },
    filterTrigger: function() {
      return this.doFilter();
    },
    getFilteringInfo: function() {
      return this.getSelectedFilter();
    },
    createBlankFilterFieldValue: function(columnName) {
      this.ensureFilterAvailable();
      return this.get('selectedFilter.values').pushObject({
        field: columnName,
        op: "",
        data: ""
      });
    },
    removeFilterFieldValue: function(value) {
      this.ensureFilterAvailable();
      if (this.get('selectedFilter.values').contains(value)) {
        return this.get('selectedFilter.values').removeObject(value);
      }
    },
    getFilterValueForColumn: function(columnName) {
      return this.get('selectedFilter.values').filter(function(value) {
        return value.field === columnName;
      });
    },
    filterableColumns: (function() {
      return this.get('columnsDescriptor').filter(function(column) {
        return column.filterable !== false;
      });
    }).property('columnsDescriptor'),
    saveFilter: function(filterDef) {
      this.updateCurrentFilter(filterDef);
      return this.saveUIState();
    },
    addNewFilter: function(filter) {
      filter.name = filter.name || filter.label.split(" ").join('');
      this.set('filteringInfo.selectedFilter', filter.name);
      return this.get('filteringInfo.availableFilters').push(Ember.copy(filter, true));
    },
    applyDefaultFilter: function() {
      return this.set('filteringInfo', $.extend({}, this.get('defaultFiltering')));
    }
  });

}).call(this);


(function() {

  Tent.Data.GroupingSupport = Ember.Mixin.create({
    groupingInfo: {},
    currentGroupPage: 1,
    currentGroupId: null,
    isShowingGroupsList: false,
    init: function() {
      this._super();
      return this.REQUEST_TYPE.GROUP = 'group';
    },
    goToGroupPage: function(page, groupingInfo) {
      if (groupingInfo != null) {
        this.set('groupingInfo', groupingInfo);
      }
      if (page != null) {
        this.set('groupingInfo.page', page);
        this.set('currentGroupPage', page);
      }
      this.set('groupingInfo.currentGroupId', null);
      return this.update(this.REQUEST_TYPE.GROUP);
    },
    setCurrentGroupId: function(id) {
      this.set('currentGroupId', id);
      return this.set('groupingInfo.currentGroupId', id);
    },
    getGroupingInfo: function() {
      return this.get('groupingInfo');
    },
    clearGrouping: function() {
      return this.set('groupingInfo', {
        columnName: null,
        type: null
      });
    }
  });

}).call(this);



/**
* @class Tent.Data.SearchSupport
* Adds full text search support
*/


(function() {

  Tent.Data.SearchSupport = Ember.Mixin.create({
    init: function() {
      this._super();
      return this.REQUEST_TYPE.SEARCH = 'searching';
    },
    /**
    	* @method search Perform a full-text search
    	* @param {String} searchText the text to use for the search
    */

    search: function(searchText) {
      this.set('searchingInfo', searchText);
      console.log('Adding full text search  [' + searchText + ']');
      return this.update(this.REQUEST_TYPE.SEARCH);
    },
    getSearchingInfo: function() {
      return this.get('searchingInfo');
    }
  });

}).call(this);



/**
* @class Tent.Data.ExportSupport
* Adds support for exporting
*/


(function() {

  Tent.Data.ExportSupport = Ember.Mixin.create({
    /**
    	* @method getURL Returns the URL hosting the export service
    	* @param {String} type The type of exported data to generate
    */

    getURL: function(type) {
      return '#';
    }
  });

}).call(this);



/*
This mixin allows UI state to be stored by the user, and restored automatically the next time the user uses
the same collection


The json data we expect is:

paging: {
  pageSize: 12
}
sorting: {
  field: 'title'
  asc: 'desc'
}
column: {
  titles: {
    duration: 'Time Elapsed'
  }
  widths: {
    id: 5
    title: 35
    duration: 10
    percentcomplete: 10
    effortdriven: 10
    start: 10
    finish: 10
    completed: 10
  }
  order: {
    id: 1
    title: 3
    duration: 2
    percentcomplete: 4
    effortdriven: 5
    start: 6
    finish: 7
    completed: 8
  }
  hidden: {
    start: true
    finish: true
  }
}
grouping: {
  columnName: 'duration'
  type: 'exact'
}
*/


(function() {

  Tent.Data.Customizable = Ember.Mixin.create({
    isCustomizable: true,
    /**
    * @property {Boolean} fetchPersonalizationsOnCreation Instruct the collection to load its personalizations from the 
    * server when it is instantiated.
    */

    fetchPersonalizationsOnCreation: true,
    personalizationCategory: 'collection',
    defaultName: Tent.I18n.loc('tent.jqGrid.saveUi.defaultName'),
    defaultPersonalization: {
      customizationName: Tent.I18n.loc('tent.jqGrid.saveUi.defaultName'),
      paging: {},
      sorting: {},
      columns: {
        titles: {},
        widths: {},
        order: {},
        hidden: {}
      },
      grouping: {},
      filtering: {
        availableFilters: []
      }
    },
    personalizations: [],
    personalizationType: null,
    personalizationGroup: null,
    personalizationSubCategory: (function() {
      var type;
      type = this.get('personalizationType');
      if (type != null) {
        return type;
      } else {
        return this.get('dataType');
      }
    }).property('dataType', 'personalizationType'),
    init: function() {
      this._super();
      this.set('customizationName', this.get('defaultName') || "");
      return this.set('personalizationsRecord', this.fetchPersonalizations());
    },
    personalizationsRecordDidChange: (function() {
      if (this.get('personalizationsRecord').toArray().length > 0) {
        return this.set('personalizations', this.get('personalizationsRecord').toArray());
      } else {
        return this.set('personalizations', []);
      }
    }).observes('personalizationsRecord', 'personalizationsRecord.@each'),
    personalizationWasAdded: (function() {
      return this.initializeFromCollectionPersonalizationName();
    }).observes('personalizations', 'personalizations.@each'),
    initializeFromCollectionPersonalizationName: function() {
      var settings;
      settings = this.getSettings();
      return this.updateCollectionWithNewPersonalizationValues(this.get('customizationName'), settings);
    },
    getSettings: function() {
      var personalization, settings;
      personalization = this.getSelectedPersonalization();
      if (personalization != null) {
        settings = personalization.get('settings');
      } else {
        settings = this.get('defaultPersonalization');
        settings.filtering = this.get('defaultFiltering');
      }
      return settings;
    },
    updateCollectionWithNewPersonalizationValues: function(name, settings) {
      this.set('customizationName', name);
      if (settings.paging != null) {
        this.set('pagingInfo', jQuery.extend(true, {}, settings.paging));
      }
      if (settings.sorting != null) {
        this.set('sortingInfo', jQuery.extend(true, {}, settings.sorting));
      }
      if (settings.filtering != null) {
        return this.set('filteringInfo', jQuery.extend(true, {}, settings.filtering));
      }
    },
    saveUIState: function(name) {
      var uiState;
      if (name != null) {
        name = name.trim();
        this.set('customizationName', name);
      }
      uiState = $.extend(true, {}, this.gatherGridData(this.get('customizationName')));
      this.savePersonalization(name, uiState);
      return this.addPersonalizationToCollection(name, uiState);
    },
    savePersonalization: function(name, uiState) {
      return this.set('newRecord', this.get('store').savePersonalization('collection', this.get('personalizationSubCategory'), name, uiState));
    },
    addPersonalizationToCollection: function(name, uiState) {
      var newRecord;
      newRecord = this.createPersonalizationRecordForClientSide(name, uiState);
      if (newRecord != null) {
        this.removeExistingCustomization(name);
        return this.get('personalizations').pushObject(newRecord);
      }
    },
    addReportToCollection: function(report) {
      return this.get('personalizations').pushObject(report);
    },
    saveReport: function(report, callback) {
      var newRecord, reportName, settings;
      reportName = report.get('name');
      this.updateCurrentFilter(this.get('selectedFilter'));
      settings = $.extend(true, {}, report.get('settings'), this.gatherGridData(reportName));
      return newRecord = this.get('store').savePersonalization('report', report.get('subcategory'), reportName, settings, callback, report.get('group'));
    },
    removeExistingCustomization: function(name) {
      var index, p, _i, _len, _ref;
      _ref = this.get('personalizations');
      for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
        p = _ref[index];
        if (p.get('name') === name) {
          this.get('personalizations').splice(index, 1);
          return;
        }
      }
    },
    createPersonalizationRecordForClientSide: function(name, uiState) {},
    gatherGridData: function(name) {
      var state;
      return state = $.extend({
        customizationName: name
      }, {
        paging: this.get('pagingInfo')
      }, {
        sorting: this.get('sortingInfo')
      }, {
        filtering: this.get('filteringInfo')
      }, {
        columns: this.get('columnInfo')
      }, {
        grouping: this.get('groupingInfo')
      });
    },
    fetchPersonalizations: function() {
      var q;
      q = {
        category: this.get('personalizationCategory'),
        subcategory: this.get('personalizationSubCategory').toString()
      };
      if (this.get('personalizationGroup') != null) {
        q.group = this.get('personalizationGroup');
      }
      return this.get('store').fetchPersonalizationsWithQuery(q);
    },
    isShowingDefault: (function() {
      return this.get('customizationName') === this.get('defaultName');
    }).property('customizationName'),
    getPersonalizationFromName: function(name) {
      var matches,
        _this = this;
      matches = this.get('personalizations').filter(function(item) {
        return item.get('name') === name;
      });
      if (matches.length > 0) {
        return matches[0];
      }
    },
    getSelectedPersonalization: function() {
      return this.getPersonalizationFromName(this.get('customizationName'));
    }
  });

}).call(this);


(function() {
  var __hasProp = {}.hasOwnProperty;
/**
  * @class Tent.Data.Collection
  * An object used to wrap an array of objects, with a facade for paging, sorting and filtering,
  */


  Tent.Data.Collection = Ember.ArrayController.extend(Tent.Data.Pager, Tent.Data.Sorter, Tent.Data.ColumnInfo, Tent.Data.Filter, Tent.Data.ExportSupport, Tent.Data.Customizable, Tent.Data.SearchSupport, Tent.Data.ExportSupport, Tent.Data.GroupingSupport, {
    content: null,
    dataType: null,
    data: [],
    serverPaging: false,
    liveStreaming: false,
    store: null,
    personalizable: true,
    isLoadable: false,
    REQUEST_TYPE: {
      'ALL': 'all'
    },
    init: function() {
      return this._super();
    },
    dataChanged: (function() {
      this.set('totals', this.get('gridTotalsData'));
      return this.set('content', this.get('gridData'));
    }).observes('modelData', 'modelData.totals'),
    gridData: (function() {
      var column, grid, item, model, _i, _j, _len, _len1, _ref, _ref1;
      grid = [];
      _ref = this.get('modelData');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        model = _ref[_i];
        item = {
          "id": model.get('id')
        };
        _ref1 = this.get('columnsDescriptor');
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          column = _ref1[_j];
          if (column.field) {
            item[column.field] = model.get(column.field);
          }
        }
        grid.push(item);
      }
      return grid;
    }).property('modelData'),
    gridTotalsData: (function() {
      var key, newKey, newRow, totals, totalsRow, value, _i, _len, _ref;
      totals = [];
      if (this.get('modelData.totals') != null) {
        _ref = this.get('modelData.totals');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          totalsRow = _ref[_i];
          newRow = {};
          for (key in totalsRow) {
            if (!__hasProp.call(totalsRow, key)) continue;
            value = totalsRow[key];
            newKey = key.split('_sum')[0];
            newRow[newKey] = value === false ? null : value;
          }
          totals.push(newRow);
        }
      }
      return totals;
    }).property('modelData.totals'),
    isLoaded: (function() {
      return this.get('modelData.isLoaded');
    }).property('modelData.isLoaded'),
    columnsDescriptor: (function() {
      return this.get('store').getColumnsForType(this.get('dataType'));
    }).property('dataType'),
    /**
    	*	@method getColumnByField Return a column given a fieldName
    	* 	@param {String} fieldName the field name of the column to be returned
    */

    getColumnByField: function(fieldName) {
      return this.get('columnsDescriptor').filter(function(item) {
        return item['name'] === fieldName;
      })[0];
    },
    update: function(requestType) {
      var query, response;
      if ((this.get('dataType') != null) && (this.get('store') != null)) {
        query = $.extend({}, {
          type: requestType
        }, {
          paging: this.get('pagingInfo')
        }, {
          sorting: this.getSortingInfo()
        }, {
          filtering: this.getFilteringInfo()
        }, {
          grouping: this.getGroupingInfo()
        }, {
          searching: this.getSearchingInfo()
        });
        response = this.get('store').findQuery(eval(this.get('dataType')), query);
        this.set('modelData', response.modelData);
        return this.updatePagingInfo(response.pagingInfo);
      }
    }
  });

}).call(this);


(function() {
}).call(this);


(function() {
}).call(this);
