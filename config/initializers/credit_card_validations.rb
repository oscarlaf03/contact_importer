
more_discover_prefixes =  (622126..622925).map(&:to_s)

CreditCardValidations.add_brand(:discover, {
  length: [16,17,18,18],
  prefixes: ['6011','644','646','647','648','649', '65',*more_discover_prefixes]
})
