import feedparser
import newspaper

d = feedparser.parse('https://news.google.com/news/feeds?output=rss&q=rats+rodents')
longLink = d.entries[0]['link'] 
link_url = longLink[:longLink.rfind('url=')]

from newspaper import Article

first_article = Article(url = str(link_url), language='en')
first_article.download()
first_article.parse()
first_article.nlp()
print(first_article.summary)
