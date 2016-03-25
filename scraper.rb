#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://en.wikipedia.org/wiki/MPs_elected_in_the_Ghanaian_parliamentary_election,_2012',
  xpath: '//table[.//th[text()="Constituency"]]//tr[td]//td[2]//a[not(@class="new")]/@title',
).reject { |n| n.downcase.include? 'constituency' }
EveryPolitician::Wikidata.scrape_wikidata(names: { en: names }, output: false)
