import feedparser
import newspaper

d = feedparser.parse(
'https://news.google.com/news/feeds?output=rss&q=rats+rodents')
longLink = d.entries[0]['link'] 
link_url = longLink.split('url=', 1)[1]
news_agency = link_url.split('.', 1)[1]
news_agency = news_agency.split('/', 1)[0]

from newspaper import Article

first_article = Article(url = str(link_url), language='en')
first_article.download()
first_article.parse()
first_article.nlp()
print(first_article.summary)
blog_title = first_article.title.encode('utf-8')
blog_summary = first_article.summary.encode('utf-8')
first_paragraph = first_article.text.encode('utf-8')
sentences = 4
seperate_sentences = first_paragraph.split('.')
first_paragraph = '.'.join(seperate_sentences[:sentences])
image = first_article.top_image.encode('utf-8')

f = open('myfile.md','w')
f.write('---\n')
f.write('layout: post\n')
f.write('title: ' + blog_title + '\n' )
f.write('---\n')

f.write('\n')
f.write('![image of rat from news source](' + image + ')\n')
f.write('\n')
f.write('According to ' + news_agency + ': \n' )
f.write('> ' + first_paragraph + '\n')
f.write('(...Read Article)[' + link_url + ']\n')

f.close() 

