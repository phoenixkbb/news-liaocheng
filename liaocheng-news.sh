#!/usr/bin/env bash
set -e

TMP=news.tmp
OUTPUT=news.json

rm -rf ${OUTPUT}
rm -rf ${TMP}

function fetch_json {
	curl --silent $1 | jq '.items[] | {title, date:.pubDate, link:.link, summary:.description} ' >> ${TMP}
}

fetch_json https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.google.com%2Fnews%2Frss%2Fsearch%2Fsection%2Fq%2F%25E4%25B8%25AD%25E5%259B%25BD%2520%25E5%25BE%25B7%25E5%259B%25BD%2F%25E4%25B8%25AD%25E5%259B%25BD%2520%25E5%25BE%25B7%25E5%259B%25BD%3Fhl%3Den%26ned%3Dus

fetch_json https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.google.com%2Fnews%2Frss%2Fsearch%2Fsection%2Fq%2F%25E5%25BE%25B7%25E5%259B%25BD%25E7%2594%259F%25E6%25B4%25BB%2F%25E5%25BE%25B7%25E5%259B%25BD%25E7%2594%259F%25E6%25B4%25BB%3Fhl%3Den%26ned%3Dus

fetch_json https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.google.com%2Fnews%2Frss%2Fsearch%2Fsection%2Fq%2F%25E5%25BE%25B7%25E5%259B%25BD%25E7%25BB%258F%25E6%25B5%258E%2F%25E5%25BE%25B7%25E5%259B%25BD%25E7%25BB%258F%25E6%25B5%258E%3Fhl%3Den%26ned%3Dus

cat ${TMP} | jq --slurp '.|unique_by(.date)|sort_by(.date)|reverse' > ${OUTPUT}

