#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://en.wikipedia.org/wiki/MPs_elected_in_the_Ghanaian_parliamentary_election,_2012',
  xpath: '//table[.//th[text()="Constituency"]]//tr[td]//td[2]//a[not(@class="new")]/@title',
).reject { |n| n.downcase.include? 'constituency' }

sparq = <<~SPARQL
  SELECT DISTINCT ?item WHERE {
    ?item p:P39 [ ps:P39/wdt:P279* wd:Q21290881 ; pq:P2937 ?term ] .
    ?term wdt:P571 ?term_start FILTER(YEAR(?term_start) >= 2013)
  }
SPARQL
ids = EveryPolitician::Wikidata.sparql(sparq)

EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { en: names })
