# Uses Newspaper to grab the top google news article
# And turns the first paragraph into a blog post

import feedparser
import newspaper
from newspaper import Article
import time

d = feedparser.parse(
'https://news.google.com/news/feeds?output=rss&q=rats+rodents')
# The G news link 
longLink = d.entries[0]['link']
# To get the url for the article
link_url = longLink.split('url=', 1)[1]

# A couple of variables I use below
news_agency = link_url.split('.', 1)[1]
news_agency = news_agency.split('/', 1)[0]
today = (time.strftime("%Y-%m-%d"))

# all prerequisites in Newspaper
first_article = Article(url = str(link_url), language='en')
first_article.download()
first_article.parse()
first_article.nlp()
# Just a quick test print if I'm watching
print(first_article.summary)

# I have to turn everything into utf-8 because of encoding issues
# On the pi
blog_title = first_article.title.encode('utf-8')
blog_summary = first_article.summary.encode('utf-8')

# I define the first_paragraph as the first six sentences
first_paragraph = first_article.text.encode('utf-8')
sentences = 6
seperate_sentences = first_paragraph.split('.')
first_paragraph = '.'.join(seperate_sentences[:sentences])

# To put at the top
image = first_article.top_image.encode('utf-8')

# Now I write it out for the blog
f = open('/home/pi/Github/ratmaps/_posts/%s-Rat-News.md' % today,'w')
f.write('---\n')
f.write('layout: post\n')
f.write('title: ' + blog_title + '\n' )
f.write('---\n')

f.write('\n')
f.write('![image of rat from news source](' + image + ')\n')
f.write('\n')
f.write('According to ' + news_agency + ': \n' )
f.write('<blockquote>')
f.write(first_paragraph + '...\n')
f.write('</blockquote>')

f.write('\n')
f.write('[Read Article](' + link_url + ')\n')

f.close() 

